From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Fri, 13 Oct 2017 12:43:02 +0200
Subject: [PATCH 6/7] ARM: dts: imx6ul: add support for TXUL modules on
 TXUL-Mainboard
In-Reply-To: <1507891383-15452-1-git-send-email-LW@KARO-electronics.de>
References: <1507891383-15452-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1507891383-15452-7-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add .dts files for the TXUL module variants TXUL-5010, TXUL-5011,
TXUL-8013 on the TXUL-Mainboard.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/Makefile                        |   6 +-
 arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dts      | 271 ----------------------
 arch/arm/boot/dts/imx6ul-txul-5010-mainboard.dts  |  48 ++++
 arch/arm/boot/dts/imx6ul-txul-5011-mainboard.dts  |  48 ++++
 arch/arm/boot/dts/imx6ul-txul-mainboard.dtsi      | 265 +++++++++++++++++++++
 arch/arm/boot/dts/imx6ull-txul-8013-mainboard.dts |  48 ++++
 6 files changed, 413 insertions(+), 273 deletions(-)
 delete mode 100644 arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-txul-5010-mainboard.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-txul-5011-mainboard.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-txul-mainboard.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-txul-8013-mainboard.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 6d25253..f61cee7 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -474,9 +474,11 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-pico-hobbit.dtb \
 	imx6ul-tx6ul-0010.dtb \
 	imx6ul-tx6ul-0011.dtb \
-	imx6ul-tx6ul-mainboard.dtb \
+	imx6ul-txul-5010-mainboard.dtb \
+	imx6ul-txul-5011-mainboard.dtb \
 	imx6ull-14x14-evk.dtb \
-	imx6ull-txul-8013.dtb
+	imx6ull-txul-8013.dtb \
+	imx6ull-txul-8013-mainboard.dtb
 dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-cl-som-imx7.dtb \
 	imx7d-colibri-eval-v3.dtb \
diff --git a/arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dts b/arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dts
deleted file mode 100644
index 28d055e..0000000
--- a/arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dts
+++ /dev/null
@@ -1,271 +0,0 @@
-/*
- * Copyright 2015 Lothar Wa?mann <LW@KARO-electronics.de>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License
- *     version 2 as published by the Free Software Foundation.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
- */
-
-/dts-v1/;
-#include "imx6ul.dtsi"
-#include "imx6ul-tx6ul.dtsi"
-
-/ {
-	model = "Ka-Ro electronics TXUL-0010 Module on TXUL Mainboard";
-	compatible = "karo,imx6ul-tx6ul", "fsl,imx6ul";
-
-	aliases {
-		lcdif_24bit_pins_a = &pinctrl_disp0_3;
-		mmc0 = &usdhc1;
-		/delete-property/ mmc1;
-		serial2 = &uart3;
-		serial4 = &uart5;
-	};
-	/delete-node/ sound;
-};
-
-&can1 {
-	xceiver-supply = <&reg_3v3>;
-};
-
-&can2 {
-	xceiver-supply = <&reg_3v3>;
-};
-
-&ds1339 {
-	status = "disabled";
-};
-
-&fec1 {
-	pinctrl-0 = <&pinctrl_enet1 &pinctrl_etnphy0_rst>;
-	/delete-node/ mdio;
-};
-
-&fec2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet2 &pinctrl_enet2_mdio &pinctrl_etnphy1_rst>;
-	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio4 28 GPIO_ACTIVE_LOW>;
-	phy-supply = <&reg_3v3_etn>;
-	phy-handle = <&etnphy1>;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		etnphy0: ethernet-phy at 0 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <0>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_etnphy0_int>;
-			interrupt-parent = <&gpio5>;
-			interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
-			interrupts-extended = <&gpio5 5 IRQ_TYPE_EDGE_FALLING>;
-			status = "okay";
-		};
-
-		etnphy1: ethernet-phy at 2 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <2>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_etnphy1_int>;
-			interrupt-parent = <&gpio4>;
-			interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
-			interrupts-extended = <&gpio4 27 IRQ_TYPE_EDGE_FALLING>;
-			status = "okay";
-		};
-	};
-};
-
-&i2c_gpio {
-	status = "disabled";
-};
-
-&i2c2 {
-	/delete-node/ codec at 0a;
-	/delete-node/ touchscreen at 48;
-
-	rtc: mcp7940x at 6f {
-		compatible = "microchip,mcp7940x";
-		reg = <0x6f>;
-	};
-};
-
-&kpp {
-	status = "disabled";
-};
-
-&lcdif {
-	pinctrl-0 = <&pinctrl_disp0_3>;
-};
-
-&reg_usbotg_vbus{
-	status = "disabled";
-};
-
-&usdhc1 {
-	pinctrl-0 = <&pinctrl_usdhc1>;
-	non-removable;
-	/delete-property/ cd-gpios;
-	cap-sdio-irq;
-};
-
-&uart1 {
-	pinctrl-0 = <&pinctrl_uart1>;
-	/delete-property/ uart-has-rtscts;
-};
-
-&uart2 {
-	pinctrl-0 = <&pinctrl_uart2>;
-	/delete-property/ uart-has-rtscts;
-	status = "okay";
-};
-
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart3>;
-	status = "okay";
-};
-
-&uart4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart4>;
-	status = "okay";
-};
-
-&uart5 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart5>;
-	status = "okay";
-};
-
-&uart6 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart6>;
-	status = "okay";
-};
-
-&uart7 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart7>;
-	status = "okay";
-};
-
-&uart8 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart8>;
-	status = "disabled"; /* conflicts with LCDIF */
-};
-
-&iomuxc {
-	hoggrp {
-		fsl,pins = <
-			MX6UL_PAD_CSI_DATA01__GPIO4_IO22	0x0b0b0 /* WLAN_RESET */
-		>;
-	};
-
-	pinctrl_disp0_3: disp0grp-3 {
-		fsl,pins = <
-			MX6UL_PAD_LCD_CLK__LCDIF_CLK		0x10 /* LSCLK */
-			MX6UL_PAD_LCD_ENABLE__LCDIF_ENABLE	0x10 /* OE_ACD */
-			MX6UL_PAD_LCD_HSYNC__LCDIF_HSYNC	0x10 /* HSYNC */
-			MX6UL_PAD_LCD_VSYNC__LCDIF_VSYNC	0x10 /* VSYNC */
-			MX6UL_PAD_LCD_DATA02__LCDIF_DATA02	0x10
-			MX6UL_PAD_LCD_DATA03__LCDIF_DATA03	0x10
-			MX6UL_PAD_LCD_DATA04__LCDIF_DATA04	0x10
-			MX6UL_PAD_LCD_DATA05__LCDIF_DATA05	0x10
-			MX6UL_PAD_LCD_DATA06__LCDIF_DATA06	0x10
-			MX6UL_PAD_LCD_DATA07__LCDIF_DATA07	0x10
-			/* LCD_DATA08..09 not wired */
-			MX6UL_PAD_LCD_DATA10__LCDIF_DATA10	0x10
-			MX6UL_PAD_LCD_DATA11__LCDIF_DATA11	0x10
-			MX6UL_PAD_LCD_DATA12__LCDIF_DATA12	0x10
-			MX6UL_PAD_LCD_DATA13__LCDIF_DATA13	0x10
-			MX6UL_PAD_LCD_DATA14__LCDIF_DATA14	0x10
-			MX6UL_PAD_LCD_DATA15__LCDIF_DATA15	0x10
-			/* LCD_DATA16..17 not wired */
-			MX6UL_PAD_LCD_DATA18__LCDIF_DATA18	0x10
-			MX6UL_PAD_LCD_DATA19__LCDIF_DATA19	0x10
-			MX6UL_PAD_LCD_DATA20__LCDIF_DATA20	0x10
-			MX6UL_PAD_LCD_DATA21__LCDIF_DATA21	0x10
-			MX6UL_PAD_LCD_DATA22__LCDIF_DATA22	0x10
-			MX6UL_PAD_LCD_DATA23__LCDIF_DATA23	0x10
-		>;
-	};
-
-	pinctrl_enet2_mdio: enet2-mdiogrp {
-		fsl,pins = <
-			MX6UL_PAD_GPIO1_IO07__ENET2_MDC		0x0b0b0
-			MX6UL_PAD_GPIO1_IO06__ENET2_MDIO	0x1b0b0
-		>;
-	};
-
-	pinctrl_uart3: uart3grp {
-		fsl,pins = <
-			MX6UL_PAD_UART3_TX_DATA__UART3_DCE_TX	0x0b0b0
-			MX6UL_PAD_UART3_RX_DATA__UART3_DCE_RX	0x0b0b0
-		>;
-	};
-
-	pinctrl_uart4: uart4grp {
-		fsl,pins = <
-			MX6UL_PAD_UART4_TX_DATA__UART4_DCE_TX	0x0b0b0
-			MX6UL_PAD_UART4_RX_DATA__UART4_DCE_RX	0x0b0b0
-		>;
-	};
-
-	pinctrl_uart6: uart6grp {
-		fsl,pins = <
-			MX6UL_PAD_CSI_MCLK__UART6_DCE_TX	0x0b0b0
-			MX6UL_PAD_CSI_PIXCLK__UART6_DCE_RX	0x0b0b0
-		>;
-	};
-
-	pinctrl_uart7: uart7grp {
-		fsl,pins = <
-			MX6UL_PAD_LCD_DATA16__UART7_DCE_TX	0x0b0b0
-			MX6UL_PAD_LCD_DATA17__UART7_DCE_RX	0x0b0b0
-		>;
-	};
-
-	pinctrl_uart8: uart8grp {
-		fsl,pins = <
-			MX6UL_PAD_LCD_DATA20__UART8_DCE_TX	0x0b0b0
-			MX6UL_PAD_LCD_DATA21__UART8_DCE_RX	0x0b0b0
-		>;
-	};
-};
diff --git a/arch/arm/boot/dts/imx6ul-txul-5010-mainboard.dts b/arch/arm/boot/dts/imx6ul-txul-5010-mainboard.dts
new file mode 100644
index 0000000..b2d3a51
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-txul-5010-mainboard.dts
@@ -0,0 +1,48 @@
+/*
+ * Copyright 2017 Lothar Wa?mann <LW@KARO-electronics.de>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License
+ *     version 2 as published by the Free Software Foundation.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "imx6ul-tx6ul-0010.dts"
+#include "imx6ul-txul-mainboard.dtsi"
+
+/ {
+	model = "Ka-Ro electronics TXUL-5010/-0010 Module on TXUL Mainboard";
+};
diff --git a/arch/arm/boot/dts/imx6ul-txul-5011-mainboard.dts b/arch/arm/boot/dts/imx6ul-txul-5011-mainboard.dts
new file mode 100644
index 0000000..fbdea92
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-txul-5011-mainboard.dts
@@ -0,0 +1,48 @@
+/*
+ * Copyright 2017 Lothar Wa?mann <LW@KARO-electronics.de>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License
+ *     version 2 as published by the Free Software Foundation.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "imx6ul-tx6ul-0011.dts"
+#include "imx6ul-txul-mainboard.dtsi"
+
+/ {
+	model = "Ka-Ro electronics TXUL-5011/-0011 Module on TXUL Mainboard";
+};
diff --git a/arch/arm/boot/dts/imx6ul-txul-mainboard.dtsi b/arch/arm/boot/dts/imx6ul-txul-mainboard.dtsi
new file mode 100644
index 0000000..8bb986f
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-txul-mainboard.dtsi
@@ -0,0 +1,265 @@
+/*
+ * Copyright 2017 Lothar Wa?mann <LW@KARO-electronics.de>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License
+ *     version 2 as published by the Free Software Foundation.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/ {
+	aliases {
+		lcdif_24bit_pins_a = &pinctrl_disp0_3;
+		mmc0 = &usdhc1;
+		/delete-property/ mmc1;
+		serial2 = &uart3;
+		serial4 = &uart5;
+	};
+
+	/delete-node/ sound;
+};
+
+&can1 {
+	xceiver-supply = <&reg_3v3>;
+};
+
+&can2 {
+	xceiver-supply = <&reg_3v3>;
+};
+
+&ds1339 {
+	status = "disabled";
+};
+
+&fec1 {
+	pinctrl-0 = <&pinctrl_enet1 &pinctrl_etnphy0_rst>;
+	/delete-node/ mdio;
+};
+
+&fec2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet2 &pinctrl_enet2_mdio &pinctrl_etnphy1_rst>;
+	phy-mode = "rmii";
+	phy-reset-gpios = <&gpio4 28 GPIO_ACTIVE_LOW>;
+	phy-supply = <&reg_3v3_etn>;
+	phy-handle = <&etnphy1>;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		etnphy0: ethernet-phy at 0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_etnphy0_int>;
+			interrupt-parent = <&gpio5>;
+			interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+			interrupts-extended = <&gpio5 5 IRQ_TYPE_EDGE_FALLING>;
+			status = "okay";
+		};
+
+		etnphy1: ethernet-phy at 2 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <2>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_etnphy1_int>;
+			interrupt-parent = <&gpio4>;
+			interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
+			interrupts-extended = <&gpio4 27 IRQ_TYPE_EDGE_FALLING>;
+			status = "okay";
+		};
+	};
+};
+
+&i2c_gpio {
+	status = "disabled";
+};
+
+&i2c2 {
+	/delete-node/ codec at 0a;
+	/delete-node/ touchscreen at 48;
+
+	rtc: mcp7940x at 6f {
+		compatible = "microchip,mcp7940x";
+		reg = <0x6f>;
+	};
+};
+
+&kpp {
+	status = "disabled";
+};
+
+&lcdif {
+	pinctrl-0 = <&pinctrl_disp0_3>;
+};
+
+&reg_usbotg_vbus {
+	status = "disabled";
+};
+
+&usdhc1 {
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	non-removable;
+	/delete-property/ cd-gpios;
+	cap-sdio-irq;
+};
+
+&uart1 {
+	pinctrl-0 = <&pinctrl_uart1>;
+	/delete-property/ uart-has-rtscts;
+};
+
+&uart2 {
+	pinctrl-0 = <&pinctrl_uart2>;
+	/delete-property/ uart-has-rtscts;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+	status = "okay";
+};
+
+&uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	status = "okay";
+};
+
+&uart6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart6>;
+	status = "okay";
+};
+
+&uart7 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart7>;
+	status = "okay";
+};
+
+&uart8 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart8>;
+	status = "disabled"; /* conflicts with LCDIF */
+};
+
+&iomuxc {
+	hoggrp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_DATA01__GPIO4_IO22	0x0b0b0 /* WLAN_RESET */
+		>;
+	};
+
+	pinctrl_disp0_3: disp0grp-3 {
+		fsl,pins = <
+			MX6UL_PAD_LCD_CLK__LCDIF_CLK		0x10 /* LSCLK */
+			MX6UL_PAD_LCD_ENABLE__LCDIF_ENABLE	0x10 /* OE_ACD */
+			MX6UL_PAD_LCD_HSYNC__LCDIF_HSYNC	0x10 /* HSYNC */
+			MX6UL_PAD_LCD_VSYNC__LCDIF_VSYNC	0x10 /* VSYNC */
+			MX6UL_PAD_LCD_DATA02__LCDIF_DATA02	0x10
+			MX6UL_PAD_LCD_DATA03__LCDIF_DATA03	0x10
+			MX6UL_PAD_LCD_DATA04__LCDIF_DATA04	0x10
+			MX6UL_PAD_LCD_DATA05__LCDIF_DATA05	0x10
+			MX6UL_PAD_LCD_DATA06__LCDIF_DATA06	0x10
+			MX6UL_PAD_LCD_DATA07__LCDIF_DATA07	0x10
+			/* LCD_DATA08..09 not wired */
+			MX6UL_PAD_LCD_DATA10__LCDIF_DATA10	0x10
+			MX6UL_PAD_LCD_DATA11__LCDIF_DATA11	0x10
+			MX6UL_PAD_LCD_DATA12__LCDIF_DATA12	0x10
+			MX6UL_PAD_LCD_DATA13__LCDIF_DATA13	0x10
+			MX6UL_PAD_LCD_DATA14__LCDIF_DATA14	0x10
+			MX6UL_PAD_LCD_DATA15__LCDIF_DATA15	0x10
+			/* LCD_DATA16..17 not wired */
+			MX6UL_PAD_LCD_DATA18__LCDIF_DATA18	0x10
+			MX6UL_PAD_LCD_DATA19__LCDIF_DATA19	0x10
+			MX6UL_PAD_LCD_DATA20__LCDIF_DATA20	0x10
+			MX6UL_PAD_LCD_DATA21__LCDIF_DATA21	0x10
+			MX6UL_PAD_LCD_DATA22__LCDIF_DATA22	0x10
+			MX6UL_PAD_LCD_DATA23__LCDIF_DATA23	0x10
+		>;
+	};
+
+	pinctrl_enet2_mdio: enet2-mdiogrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO07__ENET2_MDC		0x0b0b0
+			MX6UL_PAD_GPIO1_IO06__ENET2_MDIO	0x1b0b0
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX6UL_PAD_UART3_TX_DATA__UART3_DCE_TX	0x0b0b0
+			MX6UL_PAD_UART3_RX_DATA__UART3_DCE_RX	0x0b0b0
+		>;
+	};
+
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <
+			MX6UL_PAD_UART4_TX_DATA__UART4_DCE_TX	0x0b0b0
+			MX6UL_PAD_UART4_RX_DATA__UART4_DCE_RX	0x0b0b0
+		>;
+	};
+
+	pinctrl_uart6: uart6grp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_MCLK__UART6_DCE_TX	0x0b0b0
+			MX6UL_PAD_CSI_PIXCLK__UART6_DCE_RX	0x0b0b0
+		>;
+	};
+
+	pinctrl_uart7: uart7grp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_DATA16__UART7_DCE_TX	0x0b0b0
+			MX6UL_PAD_LCD_DATA17__UART7_DCE_RX	0x0b0b0
+		>;
+	};
+
+	pinctrl_uart8: uart8grp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_DATA20__UART8_DCE_TX	0x0b0b0
+			MX6UL_PAD_LCD_DATA21__UART8_DCE_RX	0x0b0b0
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6ull-txul-8013-mainboard.dts b/arch/arm/boot/dts/imx6ull-txul-8013-mainboard.dts
new file mode 100644
index 0000000..34d42e5
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-txul-8013-mainboard.dts
@@ -0,0 +1,48 @@
+/*
+ * Copyright 2017 Lothar Wa?mann <LW@KARO-electronics.de>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License
+ *     version 2 as published by the Free Software Foundation.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "imx6ull-txul-8013.dts"
+#include "imx6ul-txul-mainboard.dtsi"
+
+/ {
+	model = "Ka-Ro electronics TXUL-8013 Module on TXUL Mainboard";
+};
-- 
2.1.4
