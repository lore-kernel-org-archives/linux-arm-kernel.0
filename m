From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 16 Mar 2017 07:27:19 -0700
Subject: [PATCH v3] ARM: dts: imx: add Gateworks Ventana GW5904 support
In-Reply-To: <1489178411-6559-1-git-send-emai -tharvey@gateworks.com>
References: <1489178411-6559-1-git-send-emai -tharvey@gateworks.com>
Message-ID: <1489674440-14432-1-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Gateworks Ventana GW5904 is a single-board computer based on the NXP
IMX6 SoC with the following features:
 * IMX6 DualLite Soc (supports IMX6S,IMX6DL,IMX6Q)
 * 2048MB DDR3 DRAM (4x64bit) (options up to 4GiB)
 * 8GB eMMC
 * Gateworks System Controller:
  - hardware watchdog
  - hardware monitor
  - pushbutton controller
  - EEPROM storage
  - power control
 * JTAG programmable
 * 1x miniPCIe socket (with PCIe, USB)
 * 1x miniPCIe socket (USB)
 * 1x M.2 socket (USB, 2x SIM)
 * Inertial Module (LSM9DS1 9DOF: 3x acc, 3x rate, 3x mag)
 * GPS (optional uBlox EVA-M8M)
 * Application headers:
  - 2x RS232 UART (TX/RX/CTS/RTS)
  - 8x TTL GPIO (3x configurable as PWM)
  - 1x LVDS display 3D+C with i2c touch and PWM backlight
 * MV88E6176 GbE Switch (uplink to IMX FEC)
 * Front panel connectors:
  - 1x user programmable LED
  - 1x configurable user pushbutton
  - 1x USB OTG
  - 4x GbE LAN

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v3:
 - update license of dts files
 - fix node name of switch
 - use generic node names
 - dropped leading zero in unit-addr of i2c devs

v2:
 - updated switch to latest dsa bindings
 - update to GPL/X11 dual license
 - use stdout-path instead of bootargs
 - sort devices under i2c by address
 - fix node/label name on touchscreen node
 - removed unnecessary status okay for pps node
 - removed unnecessary container node in iomuxc
 - replaced deprecated fsl,uart-has-rtscts with uart-has-rtscts
---
 arch/arm/boot/dts/Makefile            |   2 +
 arch/arm/boot/dts/imx6dl-gw5904.dts   |  55 +++
 arch/arm/boot/dts/imx6q-gw5904.dts    |  59 ++++
 arch/arm/boot/dts/imx6qdl-gw5904.dtsi | 641 ++++++++++++++++++++++++++++++++++
 4 files changed, 757 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-gw5904.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw5904.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw5904.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ccecd79..7843b65 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -352,6 +352,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-gw551x.dtb \
 	imx6dl-gw552x.dtb \
 	imx6dl-gw553x.dtb \
+	imx6dl-gw5904.dtb \
 	imx6dl-hummingboard.dtb \
 	imx6dl-icore.dtb \
 	imx6dl-icore-rqs.dtb \
@@ -395,6 +396,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-gw551x.dtb \
 	imx6q-gw552x.dtb \
 	imx6q-gw553x.dtb \
+	imx6q-gw5904.dtb \
 	imx6q-h100.dtb \
 	imx6q-hummingboard.dtb \
 	imx6q-icore.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-gw5904.dts b/arch/arm/boot/dts/imx6dl-gw5904.dts
new file mode 100644
index 0000000..9c6d3cd
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-gw5904.dts
@@ -0,0 +1,55 @@
+/*
+ * Copyright 2017 Gateworks Corporation
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of
+ *     the License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ *     You should have received a copy of the GNU General Public
+ *     License along with this file; if not, write to the Free
+ *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
+ *     MA 02110-1301 USA
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
+#include "imx6dl.dtsi"
+#include "imx6qdl-gw5904.dtsi"
+
+/ {
+	model = "Gateworks Ventana i.MX6 DualLite/Solo GW5904";
+	compatible = "gw,imx6dl-gw5904", "gw,ventana", "fsl,imx6dl";
+};
diff --git a/arch/arm/boot/dts/imx6q-gw5904.dts b/arch/arm/boot/dts/imx6q-gw5904.dts
new file mode 100644
index 0000000..ca1e2ae
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-gw5904.dts
@@ -0,0 +1,59 @@
+/*
+ * Copyright 2017 Gateworks Corporation
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of
+ *     the License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ *     You should have received a copy of the GNU General Public
+ *     License along with this file; if not, write to the Free
+ *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
+ *     MA 02110-1301 USA
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
+#include "imx6q.dtsi"
+#include "imx6qdl-gw5904.dtsi"
+
+/ {
+	model = "Gateworks Ventana i.MX6 Dual/Quad GW5904";
+	compatible = "gw,imx6q-gw5904", "gw,ventana", "fsl,imx6q";
+};
+
+&sata {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6qdl-gw5904.dtsi b/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
new file mode 100644
index 0000000..fd4b68b
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
@@ -0,0 +1,641 @@
+/*
+ * Copyright 2017 Gateworks Corporation
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of
+ *     the License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ *     You should have received a copy of the GNU General Public
+ *     License along with this file; if not, write to the Free
+ *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
+ *     MA 02110-1301 USA
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
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	/* these are used by bootloader for disabling nodes */
+	aliases {
+		led0 = &led0;
+		led1 = &led1;
+		led2 = &led2;
+		usb0 = &usbh1;
+		usb1 = &usbotg;
+	};
+
+	chosen {
+		stdout-path = &uart2;
+	};
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm4 0 5000000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <7>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
+
+		led0: user1 {
+			label = "user1";
+			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDG */
+			default-state = "on";
+			linux,default-trigger = "heartbeat";
+		};
+
+		led1: user2 {
+			label = "user2";
+			gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDR */
+			default-state = "off";
+		};
+
+		led2: user3 {
+			label = "user3";
+			gpios = <&gpio4 15 GPIO_ACTIVE_LOW>; /* MX6_LOCLED# */
+			default-state = "off";
+		};
+	};
+
+	memory {
+		reg = <0x10000000 0x40000000>;
+	};
+
+	pps {
+		compatible = "pps-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pps>;
+		gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
+	};
+
+	reg_1p0v: regulator-1p0v {
+		compatible = "regulator-fixed";
+		regulator-name = "1P0V";
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1000000>;
+		regulator-always-on;
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	reg_usb_h1_vbus: regulator-usb-h1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_h1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	reg_usb_otg_vbus: regulator-usb-otg-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&clks {
+	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
+			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
+	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL3_USB_OTG>,
+				 <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		switch at 0 {
+			compatible = "marvell,mv88e6085";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					label = "lan4";
+				};
+
+				port at 1 {
+					reg = <1>;
+					label = "lan3";
+				};
+
+				port at 2 {
+					reg = <2>;
+					label = "lan2";
+				};
+
+				port at 3 {
+					reg = <3>;
+					label = "lan1";
+				};
+
+				port at 5 {
+					reg = <5>;
+					label = "cpu";
+					ethernet = <&fec>;
+				};
+			};
+		};
+	};
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	pca9555: gpio at 23 {
+		compatible = "nxp,pca9555";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	eeprom1: eeprom at 50 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
+
+	eeprom2: eeprom at 51 {
+		compatible = "atmel,24c02";
+		reg = <0x51>;
+		pagesize = <16>;
+	};
+
+	eeprom3: eeprom at 52 {
+		compatible = "atmel,24c02";
+		reg = <0x52>;
+		pagesize = <16>;
+	};
+
+	eeprom4: eeprom at 53 {
+		compatible = "atmel,24c02";
+		reg = <0x53>;
+		pagesize = <16>;
+	};
+
+	dts1672: rtc at 68 {
+		compatible = "dallas,ds1672";
+		reg = <0x68>;
+	};
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	ltc3676: pmic at 3c {
+		compatible = "lltc,ltc3676";
+		reg = <0x3c>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
+
+		regulators {
+			/* VDD_SOC (1+R1/R2 = 1.635) */
+			reg_vdd_soc: sw1 {
+				regulator-name = "vddsoc";
+				regulator-min-microvolt = <674400>;
+				regulator-max-microvolt = <1308000>;
+				lltc,fb-voltage-divider = <127000 200000>;
+				regulator-ramp-delay = <7000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_1P8 (1+R1/R2 = 2.505): GbE switch */
+			reg_1p8v: sw2 {
+				regulator-name = "vdd1p8";
+				regulator-min-microvolt = <1033310>;
+				regulator-max-microvolt = <2004000>;
+				lltc,fb-voltage-divider = <301000 200000>;
+				regulator-ramp-delay = <7000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_ARM (1+R1/R2 = 1.635) */
+			reg_vdd_arm: sw3 {
+				regulator-name = "vddarm";
+				regulator-min-microvolt = <674400>;
+				regulator-max-microvolt = <1308000>;
+				lltc,fb-voltage-divider = <127000 200000>;
+				regulator-ramp-delay = <7000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_DDR (1+R1/R2 = 2.105) */
+			reg_vdd_ddr: sw4 {
+				regulator-name = "vddddr";
+				regulator-min-microvolt = <868310>;
+				regulator-max-microvolt = <1684000>;
+				lltc,fb-voltage-divider = <221000 200000>;
+				regulator-ramp-delay = <7000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_2P5 (1+R1/R2 = 3.435): PCIe/ENET-PHY */
+			reg_2p5v: ldo2 {
+				regulator-name = "vdd2p5";
+				regulator-min-microvolt = <2490375>;
+				regulator-max-microvolt = <2490375>;
+				lltc,fb-voltage-divider = <487000 200000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_HIGH (1+R1/R2 = 4.17) */
+			reg_3p0v: ldo4 {
+				regulator-name = "vdd3p0";
+				regulator-min-microvolt = <3023250>;
+				regulator-max-microvolt = <3023250>;
+				lltc,fb-voltage-divider = <634000 200000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	egalax_ts: touchscreen at 4 {
+		compatible = "eeti,egalax_ts";
+		reg = <0x04>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
+		wakeup-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&ldb {
+	status = "okay";
+
+	lvds-channel at 0 {
+		fsl,data-mapping = "spwg";
+		fsl,data-width = <18>;
+		status = "okay";
+
+		display-timings {
+			native-mode = <&timing0>;
+			timing0: hsd100pxn1 {
+				clock-frequency = <65000000>;
+				hactive = <1024>;
+				vactive = <768>;
+				hback-porch = <220>;
+				hfront-porch = <40>;
+				vback-porch = <21>;
+				vfront-porch = <7>;
+				hsync-len = <60>;
+				vsync-len = <10>;
+			};
+		};
+	};
+};
+
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie>;
+	reset-gpio = <&gpio1 0 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&pwm2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm2>; /* MX6_DIO1 */
+	status = "disabled";
+};
+
+&pwm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm3>; /* MX6_DIO2 */
+	status = "disabled";
+};
+
+&pwm4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm4>;
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
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	status = "okay";
+};
+
+&usbotg {
+	vbus-supply = <&reg_usb_otg_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	disable-over-current;
+	status = "okay";
+};
+
+&usbh1 {
+	vbus-supply = <&reg_usb_h1_vbus>;
+	status = "okay";
+};
+
+&usdhc3 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	non-removable;
+	vmmc-supply = <&reg_3p3v>;
+	keep-power-in-suspend;
+	status = "okay";
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+};
+
+&iomuxc {
+	pinctrl_enet: enetgrp {
+		fsl,pins = <
+			MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b030
+			MX6QDL_PAD_RGMII_RD0__RGMII_RD0		0x1b030
+			MX6QDL_PAD_RGMII_RD1__RGMII_RD1		0x1b030
+			MX6QDL_PAD_RGMII_RD2__RGMII_RD2		0x1b030
+			MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b030
+			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b030
+			MX6QDL_PAD_RGMII_TXC__RGMII_TXC		0x1b030
+			MX6QDL_PAD_RGMII_TD0__RGMII_TD0		0x1b030
+			MX6QDL_PAD_RGMII_TD1__RGMII_TD1		0x1b030
+			MX6QDL_PAD_RGMII_TD2__RGMII_TD2		0x1b030
+			MX6QDL_PAD_RGMII_TD3__RGMII_TD3		0x1b030
+			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b030
+			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x1b0b0
+			MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
+			MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
+			MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x4001b0a8
+			MX6QDL_PAD_ENET_TXD0__GPIO1_IO30	0x4001b0b0 /* PHY_RST# */
+		>;
+	};
+
+	pinctrl_gpio_leds: gpioledsgrp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL0__GPIO4_IO06		0x1b0b0
+			MX6QDL_PAD_KEY_ROW0__GPIO4_IO07		0x1b0b0
+			MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x1b0b0
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D21__I2C1_SCL		0x4001b8b1
+			MX6QDL_PAD_EIM_D28__I2C1_SDA		0x4001b8b1
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL3__I2C2_SCL		0x4001b8b1
+			MX6QDL_PAD_KEY_ROW3__I2C2_SDA		0x4001b8b1
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_3__I2C3_SCL		0x4001b8b1
+			MX6QDL_PAD_GPIO_6__I2C3_SDA		0x4001b8b1
+		>;
+	};
+
+	pinctrl_pcie: pciegrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_0__GPIO1_IO00	0x1b0b0 /* PCIE RST */
+		>;
+	};
+
+	pinctrl_pmic: pmicgrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_8__GPIO1_IO08	0x1b0b0 /* PMIC_IRQ# */
+		>;
+	};
+
+	pinctrl_pps: ppsgrp {
+		fsl,pins = <
+			MX6QDL_PAD_ENET_RXD1__GPIO1_IO26	0x1b0b1
+		>;
+	};
+
+	pinctrl_pwm2: pwm2grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD1_DAT2__PWM2_OUT		0x1b0b1
+		>;
+	};
+
+	pinctrl_pwm3: pwm3grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD1_DAT1__PWM3_OUT		0x1b0b1
+		>;
+	};
+
+	pinctrl_pwm4: pwm4grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD1_CMD__PWM4_OUT		0x1b0b1
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA	0x1b0b1
+			MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA	0x1b0b1
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD4_DAT7__UART2_TX_DATA	0x1b0b1
+			MX6QDL_PAD_SD4_DAT4__UART2_RX_DATA	0x1b0b1
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D23__UART3_CTS_B         0x1b0b1
+			MX6QDL_PAD_EIM_D24__UART3_TX_DATA       0x1b0b1
+			MX6QDL_PAD_EIM_D25__UART3_RX_DATA       0x1b0b1
+			MX6QDL_PAD_EIM_D31__UART3_RTS_B         0x1b0b1
+		>;
+	};
+
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT12__UART4_TX_DATA    0x1b0b1
+			MX6QDL_PAD_CSI0_DAT13__UART4_RX_DATA    0x1b0b1
+			MX6QDL_PAD_CSI0_DAT16__UART4_RTS_B      0x1b0b1
+			MX6QDL_PAD_CSI0_DAT17__UART4_CTS_B      0x1b0b1
+		>;
+	};
+
+	pinctrl_uart5: uart5grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL1__UART5_TX_DATA	0x1b0b1
+			MX6QDL_PAD_KEY_ROW1__UART5_RX_DATA	0x1b0b1
+		>;
+	};
+
+	pinctrl_usbotg: usbotggrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_1__USB_OTG_ID		0x17059
+			MX6QDL_PAD_EIM_D22__GPIO3_IO22		0x1b0b0 /* PWR_EN */
+			MX6QDL_PAD_KEY_COL4__GPIO4_IO14		0x1b0b0 /* OC */
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x17059
+			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x10059
+			MX6QDL_PAD_SD3_RST__SD3_RESET		0x10059
+			MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x17059
+			MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x17059
+			MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x17059
+			MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17059
+			MX6QDL_PAD_SD3_DAT4__SD3_DATA4		0x17059
+			MX6QDL_PAD_SD3_DAT5__SD3_DATA5		0x17059
+			MX6QDL_PAD_SD3_DAT6__SD3_DATA6		0x17059
+			MX6QDL_PAD_SD3_DAT7__SD3_DATA7		0x17059
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
+		fsl,pins = <
+			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170b9
+			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x100b9
+			MX6QDL_PAD_SD3_RST__SD3_RESET		0x100b9
+			MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x170b9
+			MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x170b9
+			MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x170b9
+			MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x170b9
+			MX6QDL_PAD_SD3_DAT4__SD3_DATA4		0x170b9
+			MX6QDL_PAD_SD3_DAT5__SD3_DATA5		0x170b9
+			MX6QDL_PAD_SD3_DAT6__SD3_DATA6		0x170b9
+			MX6QDL_PAD_SD3_DAT7__SD3_DATA7		0x170b9
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3grp200mhz {
+		fsl,pins = <
+			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170f9
+			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x100f9
+			MX6QDL_PAD_SD3_RST__SD3_RESET		0x100f9
+			MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x170f9
+			MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x170f9
+			MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x170f9
+			MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x170f9
+			MX6QDL_PAD_SD3_DAT4__SD3_DATA4		0x170f9
+			MX6QDL_PAD_SD3_DAT5__SD3_DATA5		0x170f9
+			MX6QDL_PAD_SD3_DAT6__SD3_DATA6		0x170f9
+			MX6QDL_PAD_SD3_DAT7__SD3_DATA7		0x170f9
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX6QDL_PAD_DISP0_DAT8__WDOG1_B		0x1b0b0
+		>;
+	};
+};
-- 
2.7.4
