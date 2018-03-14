From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 14 Mar 2018 17:36:26 -0300
Subject: [PATCH] ARM: dts: imx6qdl-wandboard: Let the codec control MCLK
 pinctrl
Message-ID: <1521059786-9177-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

sgtl5000 codec needs MCLK clock to be present so that it can
successfully read/write via I2C.

In the case of wandboard, MCLK is provided via
MX6QDL_PAD_GPIO_0__CCM_CLKO1 pad. 

Move the MCLK pinctrl from hog group to the codec group, so that the
codec clock can be present prior to reading the codec ID.

This avoids the following error that happens from time to time:

[    2.484443] sgtl5000 1-000a: Error reading chip id -6

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi | 1 -
 arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi | 1 -
 arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi | 1 -
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi       | 8 ++++++++
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi
index a320891..855dc6f 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi
@@ -17,7 +17,6 @@
 	imx6qdl-wandboard {
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_0__CCM_CLKO1		0x130b0		/* GPIO_0_CLKO */
 				MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x80000000	/* uSDHC1 CD */
 				MX6QDL_PAD_EIM_DA9__GPIO3_IO09		0x80000000	/* uSDHC3 CD */
 				MX6QDL_PAD_EIM_EB1__GPIO2_IO29		0x0f0b0		/* WL_REF_ON */
diff --git a/arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi
index 8d893a7..49a0a55 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi
@@ -17,7 +17,6 @@
 	imx6qdl-wandboard {
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_0__CCM_CLKO1		0x130b0		/* GPIO_0_CLKO */
 				MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x80000000	/* uSDHC1 CD */
 				MX6QDL_PAD_EIM_DA9__GPIO3_IO09		0x80000000	/* uSDHC3 CD */
 				MX6QDL_PAD_CSI0_DAT14__GPIO6_IO00	0x0f0b0		/* WIFI_ON (reset, active low) */
diff --git a/arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi
index 3a8a495..69d9c86 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi
@@ -147,7 +147,6 @@
 	imx6qdl-wandboard {
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_0__CCM_CLKO1     	0x130b0
 				MX6QDL_PAD_EIM_D22__USB_OTG_PWR		0x80000000	/* USB Power Enable */
 				MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x80000000	/* USDHC1 CD */
 				MX6QDL_PAD_EIM_DA9__GPIO3_IO09		0x80000000	/* uSDHC3 CD */
diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
index ed96d7b..6b0a86f 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -83,6 +83,8 @@
 	status = "okay";
 
 	codec: sgtl5000@a {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_mclk>;
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
 		clocks = <&clks IMX6QDL_CLK_CKO>;
@@ -142,6 +144,12 @@
 			>;
 		};
 
+		pinctrl_mclk: mclkgrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_0__CCM_CLKO1		0x130b0
+			>;
+		};
+
 		pinctrl_spdif: spdifgrp {
 			fsl,pins = <
 				MX6QDL_PAD_ENET_RXD0__SPDIF_OUT		0x1b0b0
-- 
2.7.4
