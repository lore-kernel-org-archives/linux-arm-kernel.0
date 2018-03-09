From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 09 Mar 2018 18:22:50 +0100
Subject: [PATCH v3 6/6] ARM: dts: exynos: Enable HDMI audio support on
 exynos5800-peach-pi
In-Reply-To: <20180309172250.23019-1-s.nawrocki@samsung.com>
References: <20180309172250.23019-1-s.nawrocki@samsung.com>
 <CGME20180309172450epcas1p2b845a521afbadc81da991330bdbc588c@epcas1p2.samsung.com>
Message-ID: <20180309172250.23019-6-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds new cpu, codec subnodes according to the updated
"google,snow-audio-max98091" DT bindings and the I2S clock tree
configuration so sound on the HDMI interface can be also supported.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
NOTE:
I couldn't test this patch as I have no access to Peach-pi Chromebook.
I think it shouldn't be applied unless someone actually tests it.

Changes since v1:
 - edited commit summary line.
---
 arch/arm/boot/dts/exynos5800-peach-pi.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 0029ec27819c..0a4766e0484e 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -14,6 +14,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/clock/maxim,max77802.h>
 #include <dt-bindings/regulator/maxim,max77802.h>
+#include <dt-bindings/sound/samsung-i2s.h>
 #include "exynos5800.dtsi"
 #include "exynos5420-cpus.dtsi"
 
@@ -89,6 +90,14 @@
 		samsung,model = "Peach-Pi-I2S-MAX98091";
 		samsung,i2s-controller = <&i2s0>;
 		samsung,audio-codec = <&max98091>;
+
+		cpu {
+			sound-dai = <&i2s0 0>;
+		};
+
+		codec {
+			sound-dai = <&max98091>, <&hdmi>;
+		};
 	};
 
 	usb300_vbus_reg: regulator-usb300 {
@@ -145,6 +154,11 @@
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
@@ -609,6 +623,7 @@
 		pinctrl-0 = <&max98091_irq>;
 		clocks = <&pmu_system_controller 0>;
 		clock-names = "mclk";
+		#sound-dai-cells = <0>;
 	};
 
 	light-sensor at 44 {
@@ -661,6 +676,8 @@
 };
 
 &i2s0 {
+	assigned-clocks = <&i2s0 CLK_I2S_RCLK_SRC>;
+	assigned-clock-parents = <&clock_audss EXYNOS_I2S_BUS>;
 	status = "okay";
 };
 
-- 
2.14.2
