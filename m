From: stefan@agner.ch (Stefan Agner)
Date: Wed, 12 Sep 2018 11:32:22 -0700
Subject: [PATCH v2 8/8] ARM: dts: imx6qdl-apalis: add GPIO I2C node for DDC
In-Reply-To: <20180912183222.25414-1-stefan@agner.ch>
References: <20180912183222.25414-1-stefan@agner.ch>
Message-ID: <20180912183222.25414-9-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the DDC signals are controlled by the DWC HDMI I2C
master to be used for HDMI (DVI on the Apalis Evaluation Board).
However, the Apalis Evaluation board also allows to route the Apalis
DDC I2C to the LVDS or the VGA connector. By default, the signal
is routed to DVI (HDMI), and therefor the current default settings
are sensible.

To ease customization and to prepare for carrier boards with other
needs, add a GPIO I2C DDC node.

E.g. to reroute the Apalis DDC to the VGA connector on the Apalis
Evaluation Board, the following changes can be used:

vga {
	...
	ddc-i2c-bus = <&i2cddc>;
};

&hdmi {
	/delete-property/ pinctrl-0;
};

&i2cddc {
	status = "okay";
};

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx6qdl-apalis.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index e8d0407e3e18..8340391796df 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -61,6 +61,18 @@
 		status = "disabled";
 	};
 
+	/* DDC_I2C: I2C2_SDA/SCL on MXM3 205/207 */
+	i2cddc: i2c at 0 {
+		compatible = "i2c-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c_ddc>;
+		gpios = <&gpio3 16 GPIO_ACTIVE_HIGH /* sda */
+			 &gpio2 30 GPIO_ACTIVE_HIGH /* scl */
+			>;
+		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
+		status = "disabled";
+	};
+
 	reg_module_3v3: regulator-module-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "+V3.3";
@@ -688,6 +700,14 @@
 		>;
 	};
 
+	pinctrl_i2c_ddc: gpioi2cddcgrp {
+		fsl,pins = <
+			/* DDC bitbang */
+			MX6QDL_PAD_EIM_EB2__GPIO2_IO30 0x1b0b0
+			MX6QDL_PAD_EIM_D16__GPIO3_IO16 0x1b0b0
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA 0x4001b8b1
-- 
2.18.0
