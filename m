From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 16 Nov 2018 15:31:10 +0530
Subject: [PATCH 1/6] ARM: dts: exynos: Add all CPUs in cooling maps
In-Reply-To: <cover.1542362000.git.viresh.kumar@linaro.org>
References: <cover.1542362000.git.viresh.kumar@linaro.org>
Message-ID: <24d8433f544046eda4d21e8c7133e3bab770b615.1542362000.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each CPU can (and does) participate in cooling down the system but the
DT only captures a handful of them, normally CPU0, in the cooling maps.
Things work by chance currently as under normal circumstances its the
first CPU of each cluster which is used by the operating systems to
probe the cooling devices. But as soon as this CPU ordering changes and
any other CPU is used to bring up the cooling device, we will start
seeing failures.

Also the DT is rather incomplete when we list only one CPU in the
cooling maps, as the hardware doesn't have any such limitations.

Update cooling maps to include all devices affected by individual trip
points.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/boot/dts/exynos3250-artik5.dtsi      |   6 +-
 arch/arm/boot/dts/exynos3250-monk.dts         |   6 +-
 arch/arm/boot/dts/exynos3250-rinato.dts       |   6 +-
 arch/arm/boot/dts/exynos4210-trats.dts        |   4 +-
 arch/arm/boot/dts/exynos4210.dtsi             |   2 +-
 .../boot/dts/exynos4412-itop-scp-core.dtsi    |   8 +-
 arch/arm/boot/dts/exynos4412-midas.dtsi       |   8 +-
 .../boot/dts/exynos4412-odroid-common.dtsi    |   8 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts     |  17 ++-
 arch/arm/boot/dts/exynos4412.dtsi             |   6 +-
 arch/arm/boot/dts/exynos5250.dtsi             |   7 +-
 arch/arm/boot/dts/exynos5422-odroidhc1.dts    | 106 +++++++++++-------
 .../boot/dts/exynos5422-odroidxu3-common.dtsi | 106 +++++++++++-------
 13 files changed, 177 insertions(+), 113 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250-artik5.dtsi b/arch/arm/boot/dts/exynos3250-artik5.dtsi
index 7c22cbf6f3d4..ace50e194a45 100644
--- a/arch/arm/boot/dts/exynos3250-artik5.dtsi
+++ b/arch/arm/boot/dts/exynos3250-artik5.dtsi
@@ -36,11 +36,13 @@
 			cooling-maps {
 				map0 {
 					/* Corresponds to 500MHz */
-					cooling-device = <&cpu0 5 5>;
+					cooling-device = <&cpu0 5 5>,
+							 <&cpu1 5 5>;
 				};
 				map1 {
 					/* Corresponds to 200MHz */
-					cooling-device = <&cpu0 8 8>;
+					cooling-device = <&cpu0 8 8>,
+							 <&cpu1 8 8>;
 				};
 			};
 		};
diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/dts/exynos3250-monk.dts
index 6ffedf4ed9f2..e25765500e99 100644
--- a/arch/arm/boot/dts/exynos3250-monk.dts
+++ b/arch/arm/boot/dts/exynos3250-monk.dts
@@ -121,11 +121,13 @@
 			cooling-maps {
 				map0 {
 					/* Correspond to 500MHz at freq_table */
-					cooling-device = <&cpu0 5 5>;
+					cooling-device = <&cpu0 5 5>,
+							 <&cpu1 5 5>;
 				};
 				map1 {
 					/* Correspond to 200MHz at freq_table */
-					cooling-device = <&cpu0 8 8>;
+					cooling-device = <&cpu0 8 8>,
+							 <&cpu1 8 8>;
 				};
 			};
 		};
diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 2a6b828c01b7..7479993755da 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -116,11 +116,13 @@
 			cooling-maps {
 				map0 {
 					/* Corresponds to 500MHz */
-					cooling-device = <&cpu0 5 5>;
+					cooling-device = <&cpu0 5 5>,
+							 <&cpu1 5 5>;
 				};
 				map1 {
 					/* Corresponds to 200MHz */
-					cooling-device = <&cpu0 8 8>;
+					cooling-device = <&cpu0 8 8>,
+							 <&cpu1 8 8>;
 				};
 			};
 		};
diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index f9bbc6315cd9..8dbc47d627a5 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -138,11 +138,11 @@
 			cooling-maps {
 				map0 {
 				     /* Corresponds to 800MHz at freq_table */
-				     cooling-device = <&cpu0 2 2>;
+				     cooling-device = <&cpu0 2 2>, <&cpu1 2 2>;
 				};
 				map1 {
 				     /* Corresponds to 200MHz at freq_table */
-				     cooling-device = <&cpu0 4 4>;
+				     cooling-device = <&cpu0 4 4>, <&cpu1 4 4>;
 			       };
 		       };
 		};
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index b6091c27f155..32ccb5fa14f1 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -51,7 +51,7 @@
 			#cooling-cells = <2>; /* min followed by max */
 		};
 
-		cpu at 901 {
+		cpu1: cpu at 901 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0x901>;
diff --git a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
index ab7affab7f1c..4ca05599ee2a 100644
--- a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
+++ b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
@@ -45,11 +45,15 @@
 			cooling-maps {
 				map0 {
 				     /* Corresponds to 800MHz at freq_table */
-				     cooling-device = <&cpu0 7 7>;
+				     cooling-device = <&cpu0 7 7>, <&cpu1 7 7>,
+						      <&cpu2 7 7>, <&cpu3 7 7>;
 				};
 				map1 {
 				     /* Corresponds to 200MHz at freq_table */
-				     cooling-device = <&cpu0 13 13>;
+				     cooling-device = <&cpu0 13 13>,
+						      <&cpu1 13 13>,
+						      <&cpu2 13 13>,
+						      <&cpu3 13 13>;
 			       };
 		       };
 		};
diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index aed2f2e2b0d1..4c15cb616cdf 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -267,11 +267,15 @@
 			cooling-maps {
 				map0 {
 				     /* Corresponds to 800MHz at freq_table */
-				     cooling-device = <&cpu0 7 7>;
+				     cooling-device = <&cpu0 7 7>, <&cpu1 7 7>,
+						      <&cpu2 7 7>, <&cpu3 7 7>;
 				};
 				map1 {
 				     /* Corresponds to 200MHz at freq_table */
-				     cooling-device = <&cpu0 13 13>;
+				     cooling-device = <&cpu0 13 13>,
+						      <&cpu1 13 13>,
+						      <&cpu2 13 13>,
+						      <&cpu3 13 13>;
 			       };
 		       };
 		};
diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 2caa3132f34e..3a9eb1e91c45 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -72,11 +72,15 @@
 			cooling-maps {
 				cooling_map0: map0 {
 				     /* Corresponds to 800MHz at freq_table */
-				     cooling-device = <&cpu0 7 7>;
+				     cooling-device = <&cpu0 7 7>, <&cpu1 7 7>,
+						      <&cpu2 7 7>, <&cpu3 7 7>;
 				};
 				cooling_map1: map1 {
 				     /* Corresponds to 200MHz at freq_table */
-				     cooling-device = <&cpu0 13 13>;
+				     cooling-device = <&cpu0 13 13>,
+						      <&cpu1 13 13>,
+						      <&cpu2 13 13>,
+						      <&cpu3 13 13>;
 			       };
 		       };
 		};
diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index 459919b65df8..d51d6978d413 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -45,24 +45,21 @@
 			cooling-maps {
 				map0 {
 				     trip = <&cpu_alert1>;
-				     cooling-device = <&cpu0 9 9>;
+				     cooling-device = <&cpu0 9 9>, <&cpu1 9 9>,
+						      <&cpu2 9 9>, <&cpu3 9 9>, <&fan0 1 2>;
 				};
 				map1 {
 				     trip = <&cpu_alert2>;
-				     cooling-device = <&cpu0 15 15>;
+				     cooling-device = <&cpu0 15 15>,
+						      <&cpu1 15 15>,
+						      <&cpu2 15 15>,
+						      <&cpu3 15 15>,
+						      <&fan0 2 3>;
 				};
 				map2 {
 				     trip = <&cpu_alert0>;
 				     cooling-device = <&fan0 0 1>;
 				};
-				map3 {
-				     trip = <&cpu_alert1>;
-				     cooling-device = <&fan0 1 2>;
-				};
-				map4 {
-				     trip = <&cpu_alert2>;
-				     cooling-device = <&fan0 2 3>;
-				};
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 51f72f0327e5..cd04bb4aea5f 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -45,7 +45,7 @@
 			#cooling-cells = <2>; /* min followed by max */
 		};
 
-		cpu at a01 {
+		cpu1: cpu at a01 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0xA01>;
@@ -55,7 +55,7 @@
 			#cooling-cells = <2>; /* min followed by max */
 		};
 
-		cpu at a02 {
+		cpu2: cpu at a02 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0xA02>;
@@ -65,7 +65,7 @@
 			#cooling-cells = <2>; /* min followed by max */
 		};
 
-		cpu at a03 {
+		cpu3: cpu at a03 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0xA03>;
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 5044f754e6e5..80986b97dfe5 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -59,7 +59,7 @@
 			operating-points-v2 = <&cpu0_opp_table>;
 			#cooling-cells = <2>; /* min followed by max */
 		};
-		cpu at 1 {
+		cpu1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <1>;
@@ -1087,11 +1087,12 @@
 			cooling-maps {
 				map0 {
 				     /* Corresponds to 800MHz at freq_table */
-				     cooling-device = <&cpu0 9 9>;
+				     cooling-device = <&cpu0 9 9>, <&cpu1 9 9>;
 				};
 				map1 {
 				     /* Corresponds to 200MHz at freq_table */
-				     cooling-device = <&cpu0 15 15>;
+				     cooling-device = <&cpu0 15 15>,
+						      <&cpu1 15 15>;
 			       };
 		       };
 		};
diff --git a/arch/arm/boot/dts/exynos5422-odroidhc1.dts b/arch/arm/boot/dts/exynos5422-odroidhc1.dts
index 8f332be143f7..d271e7548826 100644
--- a/arch/arm/boot/dts/exynos5422-odroidhc1.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidhc1.dts
@@ -56,24 +56,30 @@
 				 */
 				map0 {
 					trip = <&cpu0_alert0>;
-					cooling-device = <&cpu0 0 2>;
-				};
-				map1 {
-					trip = <&cpu0_alert0>;
-					cooling-device = <&cpu4 0 2>;
+					cooling-device = <&cpu0 0 2>,
+							 <&cpu1 0 2>,
+							 <&cpu2 0 2>,
+							 <&cpu3 0 2>,
+							 <&cpu4 0 2>,
+							 <&cpu5 0 2>,
+							 <&cpu6 0 2>,
+							 <&cpu7 0 2>;
 				};
 				/*
 				 * When reaching cpu0_alert1, reduce CPU
 				 * further, down to 600 MHz (12 steps for big,
 				 * 7 steps for LITTLE).
 				 */
-				map2 {
-					trip = <&cpu0_alert1>;
-					cooling-device = <&cpu0 3 7>;
-				};
-				map3 {
+				map1 {
 					trip = <&cpu0_alert1>;
-					cooling-device = <&cpu4 3 12>;
+					cooling-device = <&cpu0 3 7>,
+							 <&cpu1 3 7>,
+							 <&cpu2 3 7>,
+							 <&cpu3 3 7>,
+							 <&cpu4 3 12>,
+							 <&cpu5 3 12>,
+							 <&cpu6 3 12>,
+							 <&cpu7 3 12>;
 				};
 			};
 		};
@@ -99,19 +105,25 @@
 			cooling-maps {
 				map0 {
 					trip = <&cpu1_alert0>;
-					cooling-device = <&cpu0 0 2>;
+					cooling-device = <&cpu0 0 2>,
+							 <&cpu1 0 2>,
+							 <&cpu2 0 2>,
+							 <&cpu3 0 2>,
+							 <&cpu4 0 2>,
+							 <&cpu5 0 2>,
+							 <&cpu6 0 2>,
+							 <&cpu7 0 2>;
 				};
 				map1 {
-					trip = <&cpu1_alert0>;
-					cooling-device = <&cpu4 0 2>;
-				};
-				map2 {
-					trip = <&cpu1_alert1>;
-					cooling-device = <&cpu0 3 7>;
-				};
-				map3 {
 					trip = <&cpu1_alert1>;
-					cooling-device = <&cpu4 3 12>;
+					cooling-device = <&cpu0 3 7>,
+							 <&cpu1 3 7>,
+							 <&cpu2 3 7>,
+							 <&cpu3 3 7>,
+							 <&cpu4 3 12>,
+							 <&cpu5 3 12>,
+							 <&cpu6 3 12>,
+							 <&cpu7 3 12>;
 				};
 			};
 		};
@@ -137,19 +149,25 @@
 			cooling-maps {
 				map0 {
 					trip = <&cpu2_alert0>;
-					cooling-device = <&cpu0 0 2>;
+					cooling-device = <&cpu0 0 2>,
+							 <&cpu1 0 2>,
+							 <&cpu2 0 2>,
+							 <&cpu3 0 2>,
+							 <&cpu4 0 2>,
+							 <&cpu5 0 2>,
+							 <&cpu6 0 2>,
+							 <&cpu7 0 2>;
 				};
 				map1 {
-					trip = <&cpu2_alert0>;
-					cooling-device = <&cpu4 0 2>;
-				};
-				map2 {
-					trip = <&cpu2_alert1>;
-					cooling-device = <&cpu0 3 7>;
-				};
-				map3 {
 					trip = <&cpu2_alert1>;
-					cooling-device = <&cpu4 3 12>;
+					cooling-device = <&cpu0 3 7>,
+							 <&cpu1 3 7>,
+							 <&cpu2 3 7>,
+							 <&cpu3 3 7>,
+							 <&cpu4 3 12>,
+							 <&cpu5 3 12>,
+							 <&cpu6 3 12>,
+							 <&cpu7 3 12>;
 				};
 			};
 		};
@@ -175,19 +193,25 @@
 			cooling-maps {
 				map0 {
 					trip = <&cpu3_alert0>;
-					cooling-device = <&cpu0 0 2>;
+					cooling-device = <&cpu0 0 2>,
+							 <&cpu1 0 2>,
+							 <&cpu2 0 2>,
+							 <&cpu3 0 2>,
+							 <&cpu4 0 2>,
+							 <&cpu5 0 2>,
+							 <&cpu6 0 2>,
+							 <&cpu7 0 2>;
 				};
 				map1 {
-					trip = <&cpu3_alert0>;
-					cooling-device = <&cpu4 0 2>;
-				};
-				map2 {
-					trip = <&cpu3_alert1>;
-					cooling-device = <&cpu0 3 7>;
-				};
-				map3 {
 					trip = <&cpu3_alert1>;
-					cooling-device = <&cpu4 3 12>;
+					cooling-device = <&cpu0 3 7>,
+							 <&cpu1 3 7>,
+							 <&cpu2 3 7>,
+							 <&cpu3 3 7>,
+							 <&cpu4 3 12>,
+							 <&cpu5 3 12>,
+							 <&cpu6 3 12>,
+							 <&cpu7 3 12>;
 				};
 			};
 		};
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index e522edb2bb82..f1d55f51c8c3 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -113,24 +113,30 @@
 				 */
 				map3 {
 					trip = <&cpu0_alert3>;
-					cooling-device = <&cpu0 0 2>;
-				};
-				map4 {
-					trip = <&cpu0_alert3>;
-					cooling-device = <&cpu4 0 2>;
+					cooling-device = <&cpu0 0 2>,
+							 <&cpu1 0 2>,
+							 <&cpu2 0 2>,
+							 <&cpu3 0 2>,
+							 <&cpu4 0 2>,
+							 <&cpu5 0 2>,
+							 <&cpu6 0 2>,
+							 <&cpu7 0 2>;
 				};
 				/*
 				 * When reaching cpu0_alert4, reduce CPU
 				 * further, down to 600 MHz (12 steps for big,
 				 * 7 steps for LITTLE).
 				 */
-				map5 {
-					trip = <&cpu0_alert4>;
-					cooling-device = <&cpu0 3 7>;
-				};
-				map6 {
+				map4 {
 					trip = <&cpu0_alert4>;
-					cooling-device = <&cpu4 3 12>;
+					cooling-device = <&cpu0 3 7>,
+							 <&cpu1 3 7>,
+							 <&cpu2 3 7>,
+							 <&cpu3 3 7>,
+							 <&cpu4 3 12>,
+							 <&cpu5 3 12>,
+							 <&cpu6 3 12>,
+							 <&cpu7 3 12>;
 				};
 			};
 		};
@@ -185,19 +191,25 @@
 				};
 				map3 {
 					trip = <&cpu1_alert3>;
-					cooling-device = <&cpu0 0 2>;
+					cooling-device = <&cpu0 0 2>,
+							 <&cpu1 0 2>,
+							 <&cpu2 0 2>,
+							 <&cpu3 0 2>,
+							 <&cpu4 0 2>,
+							 <&cpu5 0 2>,
+							 <&cpu6 0 2>,
+							 <&cpu7 0 2>;
 				};
 				map4 {
-					trip = <&cpu1_alert3>;
-					cooling-device = <&cpu4 0 2>;
-				};
-				map5 {
-					trip = <&cpu1_alert4>;
-					cooling-device = <&cpu0 3 7>;
-				};
-				map6 {
 					trip = <&cpu1_alert4>;
-					cooling-device = <&cpu4 3 12>;
+					cooling-device = <&cpu0 3 7>,
+							 <&cpu1 3 7>,
+							 <&cpu2 3 7>,
+							 <&cpu3 3 7>,
+							 <&cpu4 3 12>,
+							 <&cpu5 3 12>,
+							 <&cpu6 3 12>,
+							 <&cpu7 3 12>;
 				};
 			};
 		};
@@ -252,19 +264,25 @@
 				};
 				map3 {
 					trip = <&cpu2_alert3>;
-					cooling-device = <&cpu0 0 2>;
+					cooling-device = <&cpu0 0 2>,
+							 <&cpu1 0 2>,
+							 <&cpu2 0 2>,
+							 <&cpu3 0 2>,
+							 <&cpu4 0 2>,
+							 <&cpu5 0 2>,
+							 <&cpu6 0 2>,
+							 <&cpu7 0 2>;
 				};
 				map4 {
-					trip = <&cpu2_alert3>;
-					cooling-device = <&cpu4 0 2>;
-				};
-				map5 {
-					trip = <&cpu2_alert4>;
-					cooling-device = <&cpu0 3 7>;
-				};
-				map6 {
 					trip = <&cpu2_alert4>;
-					cooling-device = <&cpu4 3 12>;
+					cooling-device = <&cpu0 3 7>,
+							 <&cpu1 3 7>,
+							 <&cpu2 3 7>,
+							 <&cpu3 3 7>,
+							 <&cpu4 3 12>,
+							 <&cpu5 3 12>,
+							 <&cpu6 3 12>,
+							 <&cpu7 3 12>;
 				};
 			};
 		};
@@ -319,19 +337,25 @@
 				};
 				map3 {
 					trip = <&cpu3_alert3>;
-					cooling-device = <&cpu0 0 2>;
+					cooling-device = <&cpu0 0 2>,
+							 <&cpu1 0 2>,
+							 <&cpu2 0 2>,
+							 <&cpu3 0 2>,
+							 <&cpu4 0 2>,
+							 <&cpu5 0 2>,
+							 <&cpu6 0 2>,
+							 <&cpu7 0 2>;
 				};
 				map4 {
-					trip = <&cpu3_alert3>;
-					cooling-device = <&cpu4 0 2>;
-				};
-				map5 {
-					trip = <&cpu3_alert4>;
-					cooling-device = <&cpu0 3 7>;
-				};
-				map6 {
 					trip = <&cpu3_alert4>;
-					cooling-device = <&cpu4 3 12>;
+					cooling-device = <&cpu0 3 7>,
+							 <&cpu1 3 7>,
+							 <&cpu2 3 7>,
+							 <&cpu3 3 7>,
+							 <&cpu4 3 12>,
+							 <&cpu5 3 12>,
+							 <&cpu6 3 12>,
+							 <&cpu7 3 12>;
 				};
 			};
 		};
-- 
2.19.1.568.g152ad8e3369a
