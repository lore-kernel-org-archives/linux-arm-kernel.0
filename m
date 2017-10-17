From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue, 17 Oct 2017 10:53:27 +0200
Subject: [PATCH 05/12] ARM: dts: imx6-tx6: improve ethernet related pinctrl
 setup
In-Reply-To: <1508230414-8090-1-git-send-email-LW@KARO-electronics.de>
References: <1508230414-8090-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1508230414-8090-6-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the PHY INT and RESET pins from hog section and put them into
their own pinctrl nodes referenced by the appropriate driver nodes.
Also, the MDIO pins are required for probing the Ethernet PHY, so they
must be configured by the FEC driver, not by the PHY driver. Move the
corresponding pinctrl settings from the PHY subnode to the FEC node.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6qdl-tx6.dtsi | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
index a50bf71..aa32956 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -1,5 +1,5 @@
 /*
- * Copyright 2014-2016 Lothar Wa?mann <LW@KARO-electronics.de>
+ * Copyright 2014-2017 Lothar Wa?mann <LW@KARO-electronics.de>
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPL or the X11 license, at your option. Note that this dual
@@ -241,7 +241,7 @@
 
 &fec {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet>;
+	pinctrl-0 = <&pinctrl_enet &pinctrl_enet_mdio &pinctrl_etnphy_rst>;
 	clocks = <&clks IMX6QDL_CLK_ENET>,
 		 <&clks IMX6QDL_CLK_ENET>,
 		 <&clks IMX6QDL_CLK_ENET_REF>,
@@ -261,7 +261,7 @@
 			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <0>;
 			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_enet_mdio>;
+			pinctrl-0 = <&pinctrl_etnphy_int>;
 			interrupts-extended = <&gpio7 1 IRQ_TYPE_EDGE_FALLING>;
 		};
 	};
@@ -334,8 +334,6 @@
 
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
-			MX6QDL_PAD_SD3_DAT2__GPIO7_IO06		0x1b0b1 /* ETN PHY RESET */
-			MX6QDL_PAD_SD3_DAT4__GPIO7_IO01		0x1b0b1 /* ETN PHY INT */
 			MX6QDL_PAD_EIM_A25__GPIO5_IO02		0x1b0b1 /* PWR BTN */
 		>;
 	};
@@ -453,12 +451,24 @@
 		>;
 	};
 
+	pinctrl_etnphy_int: etnphy-intgrp {
+		fsl,pins = <
+			MX6QDL_PAD_SD3_DAT4__GPIO7_IO01		0x1b0b1 /* ETN PHY INT */
+		>;
+	};
+
 	pinctrl_etnphy_power: etnphy-pwrgrp {
 		fsl,pins = <
 			MX6QDL_PAD_EIM_D20__GPIO3_IO20		0x1b0b1 /* ETN PHY POWER */
 		>;
 	};
 
+	pinctrl_etnphy_rst: etnphy-rstgrp {
+		fsl,pins = <
+			MX6QDL_PAD_SD3_DAT2__GPIO7_IO06		0x1b0b1 /* ETN PHY RESET */
+		>;
+	};
+
 	pinctrl_flexcan1: flexcan1grp {
 		fsl,pins = <
 			MX6QDL_PAD_GPIO_7__FLEXCAN1_TX		0x1b0b0
-- 
2.1.4
