From: me@kylehuey.com (Kyle Huey)
Date: Tue, 16 Jun 2015 14:29:10 -0700
Subject: [PATCH v3] ARM: tegra124: pmu support
Message-ID: <1434490150-7071-1-git-send-email-khuey@kylehuey.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies the device tree for tegra124 based devices to enable the Cortex A15 PMU.  The interrupt numbers are taken from NVIDIA TRM DP-06905-001_v03p.  This patch was tested on a Jetson TK1.

Updated for proper ordering and to add interrupt-affinity values.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 13cc7ca..de07d7e 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -913,41 +913,50 @@
 		nvidia,xcvr-hsslew = <12>;
 		status = "disabled";
 	};
 
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu at 0 {
+		A15_0: cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0>;
 		};
 
-		cpu at 1 {
+		A15_1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <1>;
 		};
 
-		cpu at 2 {
+		A15_2: cpu at 2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <2>;
 		};
 
-		cpu at 3 {
+		A15_3: cpu at 3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <3>;
 		};
 	};
 
+	pmu {
+		compatible = "arm,cortex-a15-pmu";
+		interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&A15_0>, <&A15_1>, <&A15_2>, <&A15_3>;
+	};
+
 	thermal-zones {
 		cpu {
 			polling-delay-passive = <1000>;
 			polling-delay = <1000>;
 
 			thermal-sensors =
 				<&soctherm TEGRA124_SOCTHERM_SENSOR_CPU>;
 		};
-- 
1.9.1
