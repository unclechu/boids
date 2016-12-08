import Data.List
import Data.Function
import Boids
import Test.HUnit
import System.Exit

testIsWithinView :: Test
testIsWithinView  = TestCase (assertBool "Seeing a boid behind me" (not $ isWithinViewOf boid1 boid2))
    where boid1 = Boid { boidPosition = (0.0, 0.0)
                       , boidHeading = 0.0
                       , boidSteer = 0.0
                       }
          boid2 = Boid { boidPosition = (-10.0, 0.0)
                       , boidHeading = 0.0
                       , boidSteer = 0.0
                       }

testGetNearBoids :: Test
testGetNearBoids = TestCase (assertEqual "Got unexpected nearest boids" (sort $ map boidPosition nearestBoids) (sort $ map boidPosition actualResult))
    where pivotBoid = Boid { boidPosition = (388.46451, 289.70023)
                           , boidHeading = -pi / 2.0
                           , boidSteer = 0.0
                           }
          nearestBoids = [ Boid { boidPosition = (291.93515, 228.0032)
                                , boidHeading = 0.0
                                , boidSteer = 0.0
                                }
                         , Boid { boidPosition = (392.85715, 127.36221)
                                , boidHeading = 0.0
                                , boidSteer = 0.0
                                }
                         ]
          farthestBoids = [ Boid { boidPosition = (505.70178, 58.542339)
                               , boidHeading = 0.0
                               , boidSteer = 0.0
                               }

                        , Boid { boidPosition = (404.23859, 333.44159)
                               , boidHeading = 0.0
                               , boidSteer = 0.0
                               }

                        , Boid { boidPosition = (349.0011, 426.28027)
                               , boidHeading = 0.0
                               , boidSteer = 0.0
                               }
                        ]
          allBoids = nearestBoids ++ farthestBoids
          nearDistance = 203.03714
          actualResult = getNearbyBoids pivotBoid nearDistance allBoids

main :: IO Counts
main = do results <- runTestTT $ TestList [ TestLabel "Test filtering nearest boids" testGetNearBoids
                                          , TestLabel "Test isWithinViewOf" testIsWithinView]
          if (errors results + failures results == 0)
          then exitWith ExitSuccess
          else exitWith (ExitFailure 1)

