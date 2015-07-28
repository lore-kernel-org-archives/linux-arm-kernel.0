From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Wed, 29 Jul 2015 01:50:00 +0800
Subject: [PATCH v2 1/1] ARM: dts: imx7d: enable snvs rtc,
 onoffkey and power off
Message-ID: <1438105800-6255-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

Change SNVS rtc to syscon interface.
Enable onoff key and power off function.

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
Change from v1 to v2.
 - default enable snvs_poweroff
 - wakeup -> wakeup_source

 arch/arm/boot/dts/imx7d.dtsi | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 9014b80..b738ce0 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -525,17 +525,31 @@
 			};
 
 			snvs: snvs at 30370000 {
-				compatible = "fsl,sec-v4.0-mon", "simple-bus";
-				#address-cells = <1>;
-				#size-cells = <1>;
-				ranges = <0 0x30370000 0x10000>;
+				compatible = "fsl,sec-v4.0-mon", "syscon", "simple-mfd";
+				reg = <0x30370000 0x10000>;
 
-				snvs-rtc-lp at 34 {
+				snvs_rtc: snvs-rtc-lp {
 					compatible = "fsl,sec-v4.0-mon-rtc-lp";
-					reg = <0x34 0x58>;
+					regmap = <&snvs>;
+					offset = <0x34>;
 					interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
 						     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 				};
+
+				snvs_poweroff: snvs-poweroff {
+					compatible = "syscon-poweroff";
+					regmap = <&snvs>;
+					offset = <0x38>;
+					mask = <0x60>;
+				};
+
+				snvs_pwrkey: snvs-powerkey {
+					compatible = "fsl,sec-v4.0-pwrkey";
+					regmap = <&snvs>;
+					interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+					linux,keycode = <KEY_POWER>;
+					wakeup-source;
+				};
 			};
 
 			clks: ccm at 30380000 {
-- 
1.9.1
