From: vanessa.maegima@nxp.com (Vanessa Maegima)
Date: Mon, 18 Jul 2016 13:25:10 -0300
Subject: [PATCH] ARM: dts: imx6ul-pico-hobbit: Add Wifi support
Message-ID: <1468859110-5686-1-git-send-email-vanessa.maegima@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx6ul-pico-hobbit has a bcm4343 wifi chip connected to usdhc2 port.

Add support for it.

Signed-off-by: Vanessa Maegima <vanessa.maegima@nxp.com>
---
 arch/arm/boot/dts/imx6ul-pico-hobbit.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-pico-hobbit.dts b/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
index 8ce1fec..89f8bf8 100644
--- a/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
+++ b/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
@@ -100,6 +100,18 @@
 		gpio = <&gpio1 6 0>;
 	};
 
+	reg_brcm: brcm-reg {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio4 8 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_brcm_reg>;
+		regulator-name = "brcm_reg";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <200000>;
+	};
+
 	sound {
 		compatible = "fsl,imx-audio-sgtl5000";
 		model = "imx6ul-sgtl5000";
@@ -325,12 +337,21 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc2>;
 	no-1-8-v;
+	non-removable;
 	keep-power-in-suspend;
 	wakeup-source;
+	vmmc-supply = <&reg_brcm>;
 	status = "okay";
 };
 
 &iomuxc {
+	pinctrl_brcm_reg: brcmreggrp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_DATA06__GPIO4_IO08	0x10b0	/* WL_REG_ON */
+			MX6UL_PAD_NAND_DATA04__GPIO4_IO06	0x10b0	/* WL_HOST_WAKE */
+		>;
+	};
+
 	pinctrl_enet2: enet2grp {
 		fsl,pins = <
 			MX6UL_PAD_ENET1_TX_DATA1__ENET2_MDIO	0x1b0b0
-- 
2.7.4
