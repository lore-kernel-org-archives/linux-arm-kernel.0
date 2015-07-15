From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Wed, 15 Jul 2015 20:43:25 +0800
Subject: [PATCH 1/1] ARM: dts: imx6ul: add snvs rtc,
 powerkey and poweroff support
Message-ID: <1436964205-17873-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

Add snvs rtc, powerkey and poweroff support

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index dc0f5b4..f0cfc64 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -393,6 +393,33 @@
 				fsl,anatop = <&anatop>;
 			};
 
+			snvs: snvs at 020cc000 {
+				compatible = "fsl,sec-v4.0-mon", "syscon", "simple-mfd";
+				reg = <0x020cc000 0x4000>;
+
+				snvs_rtc: snvs-rtc-lp {
+					compatible = "fsl,sec-v4.0-mon-rtc-lp";
+					regmap = <&snvs>;
+					offset = <0x34>;
+					interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+				};
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
+					wakeup;
+				};
+			};
+
 			epit1: epit at 020d0000 {
 				reg = <0x020d0000 0x4000>;
 				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.9.1
