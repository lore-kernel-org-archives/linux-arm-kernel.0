From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Wed, 14 Sep 2016 12:05:03 +0530
Subject: [PATCH v1 1/3] ARM: dts: imx6qdl-apalis: Do not rely on DDC I2C bus
 bitbang for HDMI
Message-ID: <9d2c17aa2e00e6ff4349a53de8247860d2382607.1473833908.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the use of DDC I2C bus bitbang to support reading of EDID
and rely on support from internal HDMI I2C master controller instead.
As a result remove the device tree property ddc-i2c-bus.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
Hello,

This patch is tested with the following patch applied
https://patchwork.kernel.org/patch/9296883/

and is based on the suggestions from Vladimir
https://lkml.org/lkml/2016/8/29/322

This and following two patches are based on top of shawn's
for-next branch.

Regards,
Sanchayan.
---
 arch/arm/boot/dts/imx6q-apalis-ixora.dts |  6 ------
 arch/arm/boot/dts/imx6qdl-apalis.dtsi    | 25 +++++++++----------------
 2 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
index 207b85b..d99979e 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
@@ -55,7 +55,6 @@
 		     "fsl,imx6q";
 
 	aliases {
-		i2c0 = &i2cddc;
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
 		i2c3 = &i2c3;
@@ -186,11 +185,6 @@
 };
 
 &hdmi {
-	ddc-i2c-bus = <&i2cddc>;
-	status = "okay";
-};
-
-&i2cddc {
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 99e323b..8c67dd8 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -53,18 +53,6 @@
 		status = "disabled";
 	};
 
-	/* DDC_I2C: I2C2_SDA/SCL on MXM3 205/207 */
-	i2cddc: i2c at 0 {
-		compatible = "i2c-gpio";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_i2c_ddc>;
-		gpios = <&gpio3 16 GPIO_ACTIVE_HIGH /* sda */
-			 &gpio2 30 GPIO_ACTIVE_HIGH /* scl */
-			>;
-		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
-		status = "disabled";
-	};
-
 	reg_1p8v: regulator-1p8v {
 		compatible = "regulator-fixed";
 		regulator-name = "1P8V";
@@ -209,6 +197,12 @@
 	};
 };
 
+&hdmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hdmi_ddc>;
+	status = "disabled";
+};
+
 /*
  * GEN1_I2C: I2C1_SDA/SCL on MXM3 209/211 (e.g. RTC on carrier
  * board)
@@ -633,11 +627,10 @@
 		>;
 	};
 
-	pinctrl_i2c_ddc: gpioi2cddcgrp {
+	pinctrl_hdmi_ddc: hdmiddcgrp {
 		fsl,pins = <
-			/* DDC bitbang */
-			MX6QDL_PAD_EIM_EB2__GPIO2_IO30 0x1b0b0
-			MX6QDL_PAD_EIM_D16__GPIO3_IO16 0x1b0b0
+			MX6QDL_PAD_EIM_EB2__HDMI_TX_DDC_SCL 0x4001b8b1
+			MX6QDL_PAD_EIM_D16__HDMI_TX_DDC_SDA 0x4001b8b1
 		>;
 	};
 
-- 
2.9.3
