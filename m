From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 08 Mar 2018 17:29:04 +0100
Subject: [PATCH] ARM: dts: Enable HDMI audio support on exynos5420-peach-pit
References: <CGME20180308162916epcas1p4bec3b6702b1f49f2313b04e713313d92@epcas1p4.samsung.com>
Message-ID: <20180308162904.632-1-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds new cpu, codec subnodes according to the updated
"google,snow-audio-max98090" DT bindings and the I2S clock tree
configuration so sound on the HDMI interface can also be supported.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/boot/dts/exynos5420-peach-pit.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 5a76ed77dda1..244f0091c21f 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -11,6 +11,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/clock/maxim,max77802.h>
 #include <dt-bindings/regulator/maxim,max77802.h>
+#include <dt-bindings/sound/samsung-i2s.h>
 #include "exynos5420.dtsi"
 #include "exynos5420-cpus.dtsi"
 
@@ -86,6 +87,14 @@
 		samsung,model = "Peach-Pit-I2S-MAX98090";
 		samsung,i2s-controller = <&i2s0>;
 		samsung,audio-codec = <&max98090>;
+
+		cpu {
+			sound-dai = <&i2s0 0>;
+		};
+
+		codec {
+			sound-dai = <&max98090>, <&hdmi>;
+		};
 	};
 
 	usb300_vbus_reg: regulator-usb300 {
@@ -142,6 +151,11 @@
 	vdd-supply = <&ldo9_reg>;
 };
 
+&clock_audss {
+	assigned-clocks = <&clock_audss EXYNOS_MOUT_AUDSS>;
+	assigned-clock-parents = <&clock CLK_FOUT_EPLL>;
+};
+
 &cpu0 {
 	cpu-supply = <&buck2_reg>;
 };
@@ -606,6 +620,7 @@
 		pinctrl-0 = <&max98090_irq>;
 		clocks = <&pmu_system_controller 0>;
 		clock-names = "mclk";
+		#sound-dai-cells = <0>;
 	};
 
 	light-sensor at 44 {
@@ -690,6 +705,8 @@
 };
 
 &i2s0 {
+	assigned-clocks = <&i2s0 CLK_I2S_RCLK_SRC>;
+	assigned-clock-parents = <&clock_audss EXYNOS_I2S_BUS>;
 	status = "okay";
 };
 
-- 
2.14.2
