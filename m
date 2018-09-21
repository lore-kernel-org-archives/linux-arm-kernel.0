From: willy.mh.wolff.ml@gmail.com (Willy Wolff)
Date: Fri, 21 Sep 2018 12:33:29 +0100
Subject: [PATCH] ARM: dts: exynos: ordering wrong order tmu_cpu on
 Odroid-XU3/4 thermal-zones definition
Message-ID: <20180921113329.tha5tfrsvdf7dtws@inc028000032.lancs.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to open a discussion about wrong order of tmu_cpu.

It seems that tmu_cpu1 correspond to cpu3, and tmu_cpu3 match cpu1.
Note, cpu{0|3} in dtsi correspond to cpu{3|7} in linux and are the big
cores.

By dependencis from exynos5422-odroidxu3-common.dtsi to
exynos5800.dtsi -> exynos5420.dtsi, I guess definitions of tmu_cpuX are
incorrect. However, changing the address, reg interrupts or clocks
would breack other boards depending on it. As I can't test other boards,
I've just overload the reference in the thermal-zones node.

To reproduce the problem, I provide two scripts:
== script_stress:

for i in 0 10 20 40 80; do
    echo $i
    taskset $i stress -t 10 -c 1
done;

== script_read_temp:

while true; do
    for i in 0 1 2 3 4; do
	echo $i
	cat /sys/devices/virtual/thermal/thermal_zone$i/temp
    done;
    sleep 1
    clear
done;

Signed-off-by: Willy Wolff <willy.mh.wolff@gmail.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 96e281c0a118..4512ffad2785 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -135,7 +135,8 @@
 			};
 		};
 		cpu1_thermal: cpu1-thermal {
-			thermal-sensors = <&tmu_cpu1 0>;
+			// thermal-sensors = <&tmu_cpu1 0>;
+			thermal-sensors = <&tmu_cpu3 0>;
 			polling-delay-passive = <250>;
 			polling-delay = <0>;
 			trips {
@@ -269,7 +270,8 @@
 			};
 		};
 		cpu3_thermal: cpu3-thermal {
-			thermal-sensors = <&tmu_cpu3 0>;
+			// thermal-sensors = <&tmu_cpu3 0>;
+			thermal-sensors = <&tmu_cpu1 0>;
 			polling-delay-passive = <250>;
 			polling-delay = <0>;
 			trips {
-- 
2.11.0
