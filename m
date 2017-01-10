From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Mon,  9 Jan 2017 23:35:55 -0800
Subject: [PATCH v6 2/2] ARM: dts: vf610-zii-dev: Add .dts file for rev. C
In-Reply-To: <20170110073555.12178-1-andrew.smirnov@gmail.com>
References: <20170110073555.12178-1-andrew.smirnov@gmail.com>
Message-ID: <20170110073555.12178-2-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add .dts file for rev. C of the board by factoring out commonalities
into a shared include file (vf610-zii-dev-rev-b-c.dtsi) and deriving
revision specific file from it (vf610-zii-dev-rev-b.dts and
vf610-zii-dev-reb-c.dts).

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Stefan Agner <stefan@agner.ch>
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: andrew at lunn.ch
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: cphealy at gmail.com
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

---

Changes since v3:

        - Added node for AT86RF233 chip on SPI0

Changes since v4:

	- Renamed switch0 at 0 and switch1 at 0 to just switch at 0 (switch ID
          is still retained in those nodes' labels)

	- Added spacing between children and properties of nodes

Changes since v5:

	- Patchset rebased on 4.10-rc3
	- Corrections to the license text


 arch/arm/boot/dts/Makefile                |   3 +-
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts | 315 +----------------------
 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts | 414 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/vf610-zii-dev.dtsi      | 383 +++++++++++++++++++++++++++
 4 files changed, 813 insertions(+), 302 deletions(-)
 create mode 100644 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
 create mode 100644 arch/arm/boot/dts/vf610-zii-dev.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7327250..2f8ccb2 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -458,7 +458,8 @@ dtb-$(CONFIG_SOC_VF610) += \
 	vf610-cosmic.dtb \
 	vf610m4-cosmic.dtb \
 	vf610-twr.dtb \
-	vf610-zii-dev-rev-b.dtb
+	vf610-zii-dev-rev-b.dtb \
+	vf610-zii-dev-rev-c.dtb
 dtb-$(CONFIG_ARCH_MXS) += \
 	imx23-evk.dtb \
 	imx23-olinuxino.dtb \
diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
index c8e11a5..3887c4a 100644
--- a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
+++ b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
@@ -43,32 +43,12 @@
  */
 
 /dts-v1/;
-#include "vf610.dtsi"
+#include "vf610-zii-dev.dtsi"
 
 / {
 	model = "ZII VF610 Development Board, Rev B";
 	compatible = "zii,vf610dev-b", "zii,vf610dev", "fsl,vf610";
 
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	memory {
-		reg = <0x80000000 0x20000000>;
-	};
-
-	gpio-leds {
-		compatible = "gpio-leds";
-		pinctrl-0 = <&pinctrl_leds_debug>;
-		pinctrl-names = "default";
-
-		debug {
-			label = "zii:green:debug1";
-			gpios = <&gpio2 10 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "heartbeat";
-		};
-	};
-
 	mdio-mux {
 		compatible = "mdio-mux-gpio";
 		pinctrl-0 = <&pinctrl_mdio_mux>;
@@ -86,7 +66,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			switch0: switch0 at 0 {
+			switch0: switch at 0 {
 				compatible = "marvell,mv88e6085";
 				pinctrl-0 = <&pinctrl_gpio_switch0>;
 				pinctrl-names = "default";
@@ -102,6 +82,7 @@
 				ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
+
 					port at 0 {
 						reg = <0>;
 						label = "lan0";
@@ -136,6 +117,7 @@
 						reg = <6>;
 						label = "cpu";
 						ethernet = <&fec1>;
+
 						fixed-link {
 							speed = <100>;
 							full-duplex;
@@ -169,7 +151,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			switch1: switch1 at 0 {
+			switch1: switch at 0 {
 				compatible = "marvell,mv88e6085";
 				pinctrl-0 = <&pinctrl_gpio_switch1>;
 				pinctrl-names = "default";
@@ -185,6 +167,7 @@
 				ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
+
 					port at 0 {
 						reg = <0>;
 						label = "lan3";
@@ -208,6 +191,7 @@
 						label = "dsa";
 						link = <&switch2port9>;
 						phy-mode = "rgmii-txid";
+
 						fixed-link {
 							speed = <1000>;
 							full-duplex;
@@ -228,16 +212,19 @@
 				mdio {
 					#address-cells = <1>;
 					#size-cells = <0>;
+
 					switch1phy0: switch1phy0 at 0 {
 						reg = <0>;
 						interrupt-parent = <&switch1>;
 						interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
 					};
+
 					switch1phy1: switch1phy0 at 1 {
 						reg = <1>;
 						interrupt-parent = <&switch1>;
 						interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
 					};
+
 					switch1phy2: switch1phy0 at 2 {
 						reg = <2>;
 						interrupt-parent = <&switch1>;
@@ -262,6 +249,7 @@
 				ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
+
 					port at 0 {
 						reg = <0>;
 						label = "lan6";
@@ -280,6 +268,7 @@
 					port at 3 {
 						reg = <3>;
 						label = "optical3";
+
 						fixed-link {
 							speed = <1000>;
 							full-duplex;
@@ -291,6 +280,7 @@
 					port at 4 {
 						reg = <4>;
 						label = "optical4";
+
 						fixed-link {
 							speed = <1000>;
 							full-duplex;
@@ -305,6 +295,7 @@
 						phy-mode = "rgmii-txid";
 						link = <&switch1port5
 							&switch0port5>;
+
 						fixed-link {
 							speed = <1000>;
 							full-duplex;
@@ -321,25 +312,6 @@
 		};
 	};
 
-	reg_vcc_3v3_mcu: regulator-vcc-3v3-mcu {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_3v3_mcu";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	usb0_vbus: regulator-usb0-vbus {
-		compatible = "regulator-fixed";
-		pinctrl-0 = <&pinctrl_usb_vbus>;
-		regulator-name = "usb_vbus";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		enable-active-high;
-		regulator-always-on;
-		regulator-boot-on;
-		gpio = <&gpio0 6 0>;
-	};
-
 	spi0 {
 		compatible = "spi-gpio";
 		pinctrl-0 = <&pinctrl_gpio_spi0>;
@@ -376,49 +348,6 @@
 	};
 };
 
-&adc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_adc0_ad5>;
-	vref-supply = <&reg_vcc_3v3_mcu>;
-	status = "okay";
-};
-
-&edma0 {
-	status = "okay";
-};
-
-&esdhc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_esdhc1>;
-	bus-width = <4>;
-	status = "okay";
-};
-
-&fec0 {
-	phy-mode = "rmii";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec0>;
-	status = "okay";
-};
-
-&fec1 {
-	phy-mode = "rmii";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec1>;
-	status = "okay";
-
-	fixed-link {
-		   speed = <100>;
-		   full-duplex;
-	};
-
-	mdio1: mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		status = "okay";
-	};
-};
-
 &i2c0 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
@@ -443,33 +372,6 @@
 		interrupt-parent = <&gpio2>;
 		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 	};
-
-	lm75 at 48 {
-		compatible = "national,lm75";
-		reg = <0x48>;
-	};
-
-	at24c04 at 50 {
-		compatible = "atmel,24c04";
-		reg = <0x50>;
-	};
-
-	at24c04 at 52 {
-		compatible = "atmel,24c04";
-		reg = <0x52>;
-	};
-
-	ds1682 at 6b {
-		compatible = "dallas,ds1682";
-		reg = <0x6b>;
-	};
-};
-
-&i2c1 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	status = "okay";
 };
 
 &i2c2 {
@@ -539,120 +441,8 @@
 	};
 };
 
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart0>;
-	status = "okay";
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	status = "okay";
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	status = "okay";
-};
-
-&usbdev0 {
-	disable-over-current;
-	vbus-supply = <&usb0_vbus>;
-	dr_mode = "host";
-	status = "okay";
-};
-
-&usbh1 {
-	disable-over-current;
-	status = "okay";
-};
-
-&usbmisc0 {
-	status = "okay";
-};
-
-&usbmisc1 {
-	status = "okay";
-};
-
-&usbphy0 {
-	status = "okay";
-};
-
-&usbphy1 {
-	status = "okay";
-};
 
 &iomuxc {
-	pinctrl_adc0_ad5: adc0ad5grp {
-		fsl,pins = <
-			VF610_PAD_PTC30__ADC0_SE5	0x00a1
-		>;
-	};
-
-	pinctrl_dspi0: dspi0grp {
-		fsl,pins = <
-			VF610_PAD_PTB18__DSPI0_CS1	0x1182
-			VF610_PAD_PTB19__DSPI0_CS0	0x1182
-			VF610_PAD_PTB20__DSPI0_SIN	0x1181
-			VF610_PAD_PTB21__DSPI0_SOUT	0x1182
-			VF610_PAD_PTB22__DSPI0_SCK	0x1182
-		>;
-	};
-
-	pinctrl_dspi2: dspi2grp {
-		fsl,pins = <
-			VF610_PAD_PTD31__DSPI2_CS1	0x1182
-			VF610_PAD_PTD30__DSPI2_CS0	0x1182
-			VF610_PAD_PTD29__DSPI2_SIN	0x1181
-			VF610_PAD_PTD28__DSPI2_SOUT	0x1182
-			VF610_PAD_PTD27__DSPI2_SCK	0x1182
-		>;
-	};
-
-	pinctrl_esdhc1: esdhc1grp {
-		fsl,pins = <
-			VF610_PAD_PTA24__ESDHC1_CLK	0x31ef
-			VF610_PAD_PTA25__ESDHC1_CMD	0x31ef
-			VF610_PAD_PTA26__ESDHC1_DAT0	0x31ef
-			VF610_PAD_PTA27__ESDHC1_DAT1	0x31ef
-			VF610_PAD_PTA28__ESDHC1_DATA2	0x31ef
-			VF610_PAD_PTA29__ESDHC1_DAT3	0x31ef
-			VF610_PAD_PTA7__GPIO_134	0x219d
-		>;
-	};
-
-	pinctrl_fec0: fec0grp {
-		fsl,pins = <
-			VF610_PAD_PTC0__ENET_RMII0_MDC	0x30d2
-			VF610_PAD_PTC1__ENET_RMII0_MDIO	0x30d3
-			VF610_PAD_PTC2__ENET_RMII0_CRS	0x30d1
-			VF610_PAD_PTC3__ENET_RMII0_RXD1	0x30d1
-			VF610_PAD_PTC4__ENET_RMII0_RXD0	0x30d1
-			VF610_PAD_PTC5__ENET_RMII0_RXER	0x30d1
-			VF610_PAD_PTC6__ENET_RMII0_TXD1	0x30d2
-			VF610_PAD_PTC7__ENET_RMII0_TXD0	0x30d2
-			VF610_PAD_PTC8__ENET_RMII0_TXEN	0x30d2
-		>;
-	};
-
-	pinctrl_fec1: fec1grp {
-		fsl,pins = <
-			VF610_PAD_PTA6__RMII_CLKIN		0x30d1
-			VF610_PAD_PTC9__ENET_RMII1_MDC		0x30d2
-			VF610_PAD_PTC10__ENET_RMII1_MDIO	0x30d3
-			VF610_PAD_PTC11__ENET_RMII1_CRS		0x30d1
-			VF610_PAD_PTC12__ENET_RMII1_RXD1	0x30d1
-			VF610_PAD_PTC13__ENET_RMII1_RXD0	0x30d1
-			VF610_PAD_PTC14__ENET_RMII1_RXER	0x30d1
-			VF610_PAD_PTC15__ENET_RMII1_TXD1	0x30d2
-			VF610_PAD_PTC16__ENET_RMII1_TXD0	0x30d2
-			VF610_PAD_PTC17__ENET_RMII1_TXEN	0x30d2
-		>;
-	};
-
 	pinctrl_gpio_e6185_eeprom_sel: pinctrl-gpio-e6185-eeprom-spi0 {
 		fsl,pins = <
 			VF610_PAD_PTE27__GPIO_132	0x33e2
@@ -681,39 +471,6 @@
 		>;
 	};
 
-	pinctrl_i2c_mux_reset: pinctrl-i2c-mux-reset {
-		fsl,pins = <
-			 VF610_PAD_PTE14__GPIO_119	0x31c2
-			 >;
-	};
-
-	pinctrl_i2c0: i2c0grp {
-		fsl,pins = <
-			VF610_PAD_PTB14__I2C0_SCL	0x37ff
-			VF610_PAD_PTB15__I2C0_SDA	0x37ff
-		>;
-	};
-
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			VF610_PAD_PTB16__I2C1_SCL	0x37ff
-			VF610_PAD_PTB17__I2C1_SDA	0x37ff
-		>;
-	};
-
-	pinctrl_i2c2: i2c2grp {
-		fsl,pins = <
-			VF610_PAD_PTA22__I2C2_SCL	0x37ff
-			VF610_PAD_PTA23__I2C2_SDA	0x37ff
-		>;
-	};
-
-	pinctrl_leds_debug: pinctrl-leds-debug {
-		fsl,pins = <
-			 VF610_PAD_PTD20__GPIO_74	0x31c2
-			 >;
-	};
-
 	pinctrl_mdio_mux: pinctrl-mdio-mux {
 		fsl,pins = <
 			VF610_PAD_PTA18__GPIO_8		0x31c2
@@ -728,48 +485,4 @@
 			VF610_PAD_PTB28__GPIO_98	0x219d
 		>;
 	};
-
-	pinctrl_qspi0: qspi0grp {
-		fsl,pins = <
-			VF610_PAD_PTD7__QSPI0_B_QSCK	0x31c3
-			VF610_PAD_PTD8__QSPI0_B_CS0	0x31ff
-			VF610_PAD_PTD9__QSPI0_B_DATA3	0x31c3
-			VF610_PAD_PTD10__QSPI0_B_DATA2	0x31c3
-			VF610_PAD_PTD11__QSPI0_B_DATA1	0x31c3
-			VF610_PAD_PTD12__QSPI0_B_DATA0	0x31c3
-		>;
-	};
-
-	pinctrl_uart0: uart0grp {
-		fsl,pins = <
-			VF610_PAD_PTB10__UART0_TX	0x21a2
-			VF610_PAD_PTB11__UART0_RX	0x21a1
-		>;
-	};
-
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <
-			VF610_PAD_PTB23__UART1_TX	0x21a2
-			VF610_PAD_PTB24__UART1_RX	0x21a1
-		>;
-	};
-
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <
-			VF610_PAD_PTD0__UART2_TX	0x21a2
-			VF610_PAD_PTD1__UART2_RX	0x21a1
-		>;
-	};
-
-	pinctrl_usb_vbus: pinctrl-usb-vbus {
-		fsl,pins = <
-			VF610_PAD_PTA16__GPIO_6	0x31c2
-		>;
-	};
-
-	pinctrl_usb0_host: usb0-host-grp {
-		fsl,pins = <
-			VF610_PAD_PTD6__GPIO_85		0x0062
-		>;
-	};
 };
diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts b/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
new file mode 100644
index 0000000..fbedb7b
--- /dev/null
+++ b/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
@@ -0,0 +1,414 @@
+/*
+ * Copyright (C) 2015, 2016 Zodiac Inflight Innovations
+ *
+ * Based on an original 'vf610-twr.dts' which is Copyright 2015,
+ * Freescale Semiconductor, Inc.
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
+ *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND,
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
+#include "vf610-zii-dev.dtsi"
+
+/ {
+	model = "ZII VF610 Development Board, Rev C";
+	compatible = "zii,vf610dev-c", "zii,vf610dev", "fsl,vf610";
+
+	mdio-mux {
+		compatible = "mdio-mux-gpio";
+		pinctrl-0 = <&pinctrl_mdio_mux>;
+		pinctrl-names = "default";
+		gpios = <&gpio0 8  GPIO_ACTIVE_HIGH
+			 &gpio0 9  GPIO_ACTIVE_HIGH
+			 &gpio0 25 GPIO_ACTIVE_HIGH>;
+		mdio-parent-bus = <&mdio1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mdio_mux_1: mdio at 1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			switch0: switch at 0 {
+				compatible = "marvell,mv88e6190";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0>;
+				dsa,member = <0 0>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port at 0 {
+						reg = <0>;
+						label = "cpu";
+						ethernet = <&fec1>;
+
+						fixed-link {
+							speed = <100>;
+							full-duplex;
+						};
+					};
+
+					port at 1 {
+						reg = <1>;
+						label = "lan1";
+					};
+
+					port at 2 {
+						reg = <2>;
+						label = "lan2";
+					};
+
+					port at 3 {
+						reg = <3>;
+						label = "lan3";
+					};
+
+					port at 4 {
+						reg = <4>;
+						label = "lan4";
+					};
+
+					switch0port10: port at 10 {
+						reg = <10>;
+						label = "dsa";
+						phy-mode = "xgmii";
+						link = <&switch1port10>;
+					};
+				};
+			};
+		};
+
+		mdio_mux_2: mdio at 2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			switch1: switch at 0 {
+				compatible = "marvell,mv88e6190";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0>;
+				dsa,member = <0 1>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port at 1 {
+						reg = <1>;
+						label = "lan5";
+					};
+
+					port at 2 {
+						reg = <2>;
+						label = "lan6";
+					};
+
+					port at 3 {
+						reg = <3>;
+						label = "lan7";
+					};
+
+					port at 4 {
+						reg = <4>;
+						label = "lan8";
+					};
+
+
+					switch1port10: port at 10 {
+						reg = <10>;
+						label = "dsa";
+						phy-mode = "xgmii";
+						link = <&switch0port10>;
+					};
+				};
+			};
+		};
+
+		mdio_mux_4: mdio at 4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+&dspi0 {
+	bus-num = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_dspi0>;
+	status = "okay";
+	spi-num-chipselects = <2>;
+
+	m25p128 at 0 {
+		compatible = "m25p128", "jedec,spi-nor";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+	};
+
+	atzb-rf-233 at 1 {
+		compatible = "atmel,at86rf233";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctr_atzb_rf_233>;
+
+		spi-max-frequency = <7500000>;
+		reg = <1>;
+		interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gpio3>;
+		xtal-trim = /bits/ 8 <0x06>;
+
+		sleep-gpio = <&gpio0 24 GPIO_ACTIVE_HIGH>;
+		reset-gpio = <&gpio6 10 GPIO_ACTIVE_HIGH>;
+
+		fsl,spi-cs-sck-delay = <180>;
+		fsl,spi-sck-cs-delay = <250>;
+	};
+};
+
+&i2c0 {
+	/*
+	 * U712
+	 *
+	 * Exposed signals:
+	 *    P1 - WE2_CMD
+	 *    P2 - WE2_CLK
+	 */
+	gpio5: pca9557 at 18 {
+		compatible = "nxp,pca9557";
+		reg = <0x18>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	/*
+	 * U121
+	 *
+	 * Exposed signals:
+	 *    I/O0  - ENET_SWR_EN
+	 *    I/O1  - ESW1_RESETn
+	 *    I/O2  - ARINC_RESET
+	 *    I/O3  - DD1_IO_RESET
+	 *    I/O4  - ESW2_RESETn
+	 *    I/O5  - ESW3_RESETn
+	 *    I/O6  - ESW4_RESETn
+	 *    I/O8  - TP909
+	 *    I/O9  - FEM_SEL
+	 *    I/O10 - WIFI_RESETn
+	 *    I/O11 - PHY_RSTn
+	 *    I/O12 - OPT1_SD
+	 *    I/O13 - OPT2_SD
+	 *    I/O14 - OPT1_TX_DIS
+	 *    I/O15 - OPT2_TX_DIS
+	 */
+	gpio6: sx1503 at 20 {
+		compatible = "semtech,sx1503q";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_sx1503_20>;
+		#gpio-cells = <2>;
+		#interrupt-cells = <2>;
+		reg = <0x20>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
+		gpio-controller;
+		interrupt-controller;
+
+		enet_swr_en {
+			gpio-hog;
+			gpios = <0 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "enet-swr-en";
+		};
+	};
+
+	/*
+	 * U715
+	 *
+	 * Exposed signals:
+	 *     IO0 - WE1_CLK
+	 *     IO1 - WE1_CMD
+	 */
+	gpio7: pca9554 at 22 {
+		compatible = "nxp,pca9554";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+	};
+};
+
+&i2c1 {
+	at24mac602 at 00 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+		read-only;
+	};
+};
+
+&i2c2 {
+	tca9548 at 70 {
+		compatible = "nxp,pca9548";
+		pinctrl-0 = <&pinctrl_i2c_mux_reset>;
+		pinctrl-names = "default";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x70>;
+		reset-gpios = <&gpio3 23 GPIO_ACTIVE_LOW>;
+
+		i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			sfp2: at24c04 at 50 {
+				compatible = "atmel,24c02";
+				reg = <0x50>;
+			};
+		};
+
+		i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+
+			sfp3: at24c04 at 50 {
+				compatible = "atmel,24c02";
+				reg = <0x50>;
+			};
+		};
+
+		i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	status = "okay";
+};
+
+&gpio0 {
+	eth0_intrp {
+		gpio-hog;
+		gpios = <23 GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "sx1503-irq";
+	};
+};
+
+&gpio3 {
+	eth0_intrp {
+		gpio-hog;
+		gpios = <2 GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "eth0-intrp";
+	};
+};
+
+&fec0 {
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+
+		ethernet-phy at 0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_fec0_phy_int>;
+
+			interrupt-parent = <&gpio3>;
+			interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+			reg = <0>;
+		};
+	};
+};
+
+&iomuxc {
+	pinctr_atzb_rf_233: pinctrl-atzb-rf-233 {
+		fsl,pins = <
+			VF610_PAD_PTB2__GPIO_24		0x31c2
+			VF610_PAD_PTE27__GPIO_132	0x33e2
+		>;
+	};
+
+
+	pinctrl_sx1503_20: pinctrl-sx1503-20 {
+		fsl,pins = <
+			VF610_PAD_PTB1__GPIO_23		0x219d
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			VF610_PAD_PTA20__UART3_TX	0x21a2
+			VF610_PAD_PTA21__UART3_RX	0x21a1
+		>;
+	};
+
+	pinctrl_mdio_mux: pinctrl-mdio-mux {
+		fsl,pins = <
+			VF610_PAD_PTA18__GPIO_8		0x31c2
+			VF610_PAD_PTA19__GPIO_9		0x31c2
+			VF610_PAD_PTB3__GPIO_25		0x31c2
+		>;
+	};
+
+	pinctrl_fec0_phy_int: pinctrl-fec0-phy-int {
+		fsl,pins = <
+			VF610_PAD_PTB28__GPIO_98	0x219d
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/vf610-zii-dev.dtsi b/arch/arm/boot/dts/vf610-zii-dev.dtsi
new file mode 100644
index 0000000..ca9e1bc
--- /dev/null
+++ b/arch/arm/boot/dts/vf610-zii-dev.dtsi
@@ -0,0 +1,383 @@
+/*
+ * Copyright (C) 2015, 2016 Zodiac Inflight Innovations
+ *
+ * Based on an original 'vf610-twr.dts' which is Copyright 2015,
+ * Freescale Semiconductor, Inc.
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
+ *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include "vf610.dtsi"
+
+/ {
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory {
+		reg = <0x80000000 0x20000000>;
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&pinctrl_leds_debug>;
+		pinctrl-names = "default";
+
+		debug {
+			label = "zii:green:debug1";
+			gpios = <&gpio2 10 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	reg_vcc_3v3_mcu: regulator-vcc-3v3-mcu {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v3_mcu";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	usb0_vbus: regulator-usb0-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-0 = <&pinctrl_usb_vbus>;
+		regulator-name = "usb_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+		gpio = <&gpio0 6 0>;
+	};
+};
+
+&adc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_ad5>;
+	vref-supply = <&reg_vcc_3v3_mcu>;
+	status = "okay";
+};
+
+&edma0 {
+	status = "okay";
+};
+
+&esdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc1>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&fec0 {
+	phy-mode = "rmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec0>;
+	status = "okay";
+};
+
+&fec1 {
+	phy-mode = "rmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1>;
+	status = "okay";
+
+	fixed-link {
+		   speed = <100>;
+		   full-duplex;
+	};
+
+	mdio1: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+	};
+};
+
+&i2c0 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c0>;
+	pinctrl-1 = <&pinctrl_i2c0_gpio>;
+	scl-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+
+	lm75 at 48 {
+		compatible = "national,lm75";
+		reg = <0x48>;
+	};
+
+	at24c04 at 50 {
+		compatible = "atmel,24c04";
+		reg = <0x50>;
+	};
+
+	at24c04 at 52 {
+		compatible = "atmel,24c04";
+		reg = <0x52>;
+	};
+
+	ds1682 at 6b {
+		compatible = "dallas,ds1682";
+		reg = <0x6b>;
+	};
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart0>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+&usbdev0 {
+	disable-over-current;
+	vbus-supply = <&usb0_vbus>;
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbh1 {
+	disable-over-current;
+	status = "okay";
+};
+
+&usbmisc0 {
+	status = "okay";
+};
+
+&usbmisc1 {
+	status = "okay";
+};
+
+&usbphy0 {
+	status = "okay";
+};
+
+&usbphy1 {
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_adc0_ad5: adc0ad5grp {
+		fsl,pins = <
+			VF610_PAD_PTC30__ADC0_SE5	0x00a1
+		>;
+	};
+
+	pinctrl_dspi0: dspi0grp {
+		fsl,pins = <
+			VF610_PAD_PTB18__DSPI0_CS1	0x1182
+			VF610_PAD_PTB19__DSPI0_CS0	0x1182
+			VF610_PAD_PTB20__DSPI0_SIN	0x1181
+			VF610_PAD_PTB21__DSPI0_SOUT	0x1182
+			VF610_PAD_PTB22__DSPI0_SCK	0x1182
+		>;
+	};
+
+	pinctrl_dspi2: dspi2grp {
+		fsl,pins = <
+			VF610_PAD_PTD31__DSPI2_CS1	0x1182
+			VF610_PAD_PTD30__DSPI2_CS0	0x1182
+			VF610_PAD_PTD29__DSPI2_SIN	0x1181
+			VF610_PAD_PTD28__DSPI2_SOUT	0x1182
+			VF610_PAD_PTD27__DSPI2_SCK	0x1182
+		>;
+	};
+
+	pinctrl_esdhc1: esdhc1grp {
+		fsl,pins = <
+			VF610_PAD_PTA24__ESDHC1_CLK	0x31ef
+			VF610_PAD_PTA25__ESDHC1_CMD	0x31ef
+			VF610_PAD_PTA26__ESDHC1_DAT0	0x31ef
+			VF610_PAD_PTA27__ESDHC1_DAT1	0x31ef
+			VF610_PAD_PTA28__ESDHC1_DATA2	0x31ef
+			VF610_PAD_PTA29__ESDHC1_DAT3	0x31ef
+			VF610_PAD_PTA7__GPIO_134	0x219d
+		>;
+	};
+
+	pinctrl_fec0: fec0grp {
+		fsl,pins = <
+			VF610_PAD_PTC0__ENET_RMII0_MDC	0x30d2
+			VF610_PAD_PTC1__ENET_RMII0_MDIO	0x30d3
+			VF610_PAD_PTC2__ENET_RMII0_CRS	0x30d1
+			VF610_PAD_PTC3__ENET_RMII0_RXD1	0x30d1
+			VF610_PAD_PTC4__ENET_RMII0_RXD0	0x30d1
+			VF610_PAD_PTC5__ENET_RMII0_RXER	0x30d1
+			VF610_PAD_PTC6__ENET_RMII0_TXD1	0x30d2
+			VF610_PAD_PTC7__ENET_RMII0_TXD0	0x30d2
+			VF610_PAD_PTC8__ENET_RMII0_TXEN	0x30d2
+		>;
+	};
+
+	pinctrl_fec1: fec1grp {
+		fsl,pins = <
+			VF610_PAD_PTA6__RMII_CLKIN		0x30d1
+			VF610_PAD_PTC9__ENET_RMII1_MDC		0x30d2
+			VF610_PAD_PTC10__ENET_RMII1_MDIO	0x30d3
+			VF610_PAD_PTC11__ENET_RMII1_CRS		0x30d1
+			VF610_PAD_PTC12__ENET_RMII1_RXD1	0x30d1
+			VF610_PAD_PTC13__ENET_RMII1_RXD0	0x30d1
+			VF610_PAD_PTC14__ENET_RMII1_RXER	0x30d1
+			VF610_PAD_PTC15__ENET_RMII1_TXD1	0x30d2
+			VF610_PAD_PTC16__ENET_RMII1_TXD0	0x30d2
+			VF610_PAD_PTC17__ENET_RMII1_TXEN	0x30d2
+		>;
+	};
+
+	pinctrl_gpio_spi0: pinctrl-gpio-spi0 {
+		fsl,pins = <
+			VF610_PAD_PTB22__GPIO_44	0x33e2
+			VF610_PAD_PTB21__GPIO_43	0x33e2
+			VF610_PAD_PTB20__GPIO_42	0x33e1
+			VF610_PAD_PTB19__GPIO_41	0x33e2
+			VF610_PAD_PTB18__GPIO_40	0x33e2
+		>;
+	};
+
+	pinctrl_i2c_mux_reset: pinctrl-i2c-mux-reset {
+		fsl,pins = <
+			 VF610_PAD_PTE14__GPIO_119	0x31c2
+			 >;
+	};
+
+	pinctrl_i2c0: i2c0grp {
+		fsl,pins = <
+			VF610_PAD_PTB14__I2C0_SCL	0x37ff
+			VF610_PAD_PTB15__I2C0_SDA	0x37ff
+		>;
+	};
+
+	pinctrl_i2c0_gpio: i2c0grp-gpio {
+		fsl,pins = <
+			VF610_PAD_PTB14__GPIO_36	0x31c2
+			VF610_PAD_PTB15__GPIO_37	0x31c2
+		>;
+	};
+
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			VF610_PAD_PTB16__I2C1_SCL	0x37ff
+			VF610_PAD_PTB17__I2C1_SDA	0x37ff
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			VF610_PAD_PTA22__I2C2_SCL	0x37ff
+			VF610_PAD_PTA23__I2C2_SDA	0x37ff
+		>;
+	};
+
+	pinctrl_leds_debug: pinctrl-leds-debug {
+		fsl,pins = <
+			 VF610_PAD_PTD20__GPIO_74	0x31c2
+			 >;
+	};
+
+	pinctrl_qspi0: qspi0grp {
+		fsl,pins = <
+			VF610_PAD_PTD7__QSPI0_B_QSCK	0x31c3
+			VF610_PAD_PTD8__QSPI0_B_CS0	0x31ff
+			VF610_PAD_PTD9__QSPI0_B_DATA3	0x31c3
+			VF610_PAD_PTD10__QSPI0_B_DATA2	0x31c3
+			VF610_PAD_PTD11__QSPI0_B_DATA1	0x31c3
+			VF610_PAD_PTD12__QSPI0_B_DATA0	0x31c3
+		>;
+	};
+
+	pinctrl_uart0: uart0grp {
+		fsl,pins = <
+			VF610_PAD_PTB10__UART0_TX	0x21a2
+			VF610_PAD_PTB11__UART0_RX	0x21a1
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			VF610_PAD_PTB23__UART1_TX	0x21a2
+			VF610_PAD_PTB24__UART1_RX	0x21a1
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			VF610_PAD_PTD0__UART2_TX	0x21a2
+			VF610_PAD_PTD1__UART2_RX	0x21a1
+		>;
+	};
+
+	pinctrl_usb_vbus: pinctrl-usb-vbus {
+		fsl,pins = <
+			VF610_PAD_PTA16__GPIO_6	0x31c2
+		>;
+	};
+
+	pinctrl_usb0_host: usb0-host-grp {
+		fsl,pins = <
+			VF610_PAD_PTD6__GPIO_85		0x0062
+		>;
+	};
+};
-- 
2.9.3
