From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Thu, 21 Aug 2014 13:17:20 +0300
Subject: [PATCH v5 2/4] ARM: tegra: Add soctherm and thermal zones to Tegra124
 device tree
In-Reply-To: <1408616242-21009-1-git-send-email-mperttunen@nvidia.com>
References: <1408616242-21009-1-git-send-email-mperttunen@nvidia.com>
Message-ID: <1408616242-21009-3-git-send-email-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the soctherm thermal sensing and management unit to the
Tegra124 device tree along with the four thermal zones corresponding
to the four thermal sensors provided by soctherm.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
v5: reordered nodes

 arch/arm/boot/dts/tegra124.dtsi | 47 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 3cb1548..a7608a4 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -3,6 +3,7 @@
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra-xusb.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/thermal/tegra124-soctherm.h>
 
 #include "skeleton.dtsi"
 
@@ -610,6 +611,18 @@
 		status = "disabled";
 	};
 
+	soctherm: thermal-sensor at 0,700e2000 {
+		compatible = "nvidia,tegra124-soctherm";
+		reg = <0x0 0x700e2000 0x0 0x1000>;
+		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA124_CLK_TSENSOR>,
+			<&tegra_car TEGRA124_CLK_SOC_THERM>;
+		clock-names = "tsensor", "soctherm";
+		resets = <&tegra_car 78>;
+		reset-names = "soctherm";
+		#thermal-sensor-cells = <1>;
+	};
+
 	ahub at 0,70300000 {
 		compatible = "nvidia,tegra124-ahub";
 		reg = <0x0 0x70300000 0x0 0x200>,
@@ -851,6 +864,40 @@
 		};
 	};
 
+	thermal-zones {
+		cpu {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+
+			thermal-sensors =
+				<&soctherm TEGRA124_SOCTHERM_SENSOR_CPU>;
+		};
+
+		mem {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+
+			thermal-sensors =
+				<&soctherm TEGRA124_SOCTHERM_SENSOR_MEM>;
+		};
+
+		gpu {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+
+			thermal-sensors =
+				<&soctherm TEGRA124_SOCTHERM_SENSOR_GPU>;
+		};
+
+		pllx {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+
+			thermal-sensors =
+				<&soctherm TEGRA124_SOCTHERM_SENSOR_PLLX>;
+		};
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <GIC_PPI 13
-- 
1.8.1.5
