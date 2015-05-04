From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon,  4 May 2015 22:08:49 +0200
Subject: [PATCH v2 4/5] ARM: dts: dove: Add proper support for Compulab
 CM-A510/SBC-A510
In-Reply-To: <1430770130-7833-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1430770130-7833-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1430770130-7833-5-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Existing dts file for Compulab CM-A510 was very limited due to missing
hardware. Now that we actually found somebody with that board, properly
rework it to provide a CoM/SoM include and a board file for Compulab's
SBC-A510.

Both the CM-A510 SoM and the SBC-A510 can be configured with different
options, so we only enable a minimum set of options. The actual board
configuration will have to be set by either the bootloader or user.

Although functionally not required, repeat even disabled nodes again
to increse their visibility in the dtsi/dts files.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Tested-by: Gabriel Dobato <dobatog@gmail.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Gabriel Dobato <dobatog@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/dove-cm-a510.dts  |  38 -------
 arch/arm/boot/dts/dove-cm-a510.dtsi | 195 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dove-sbc-a510.dts | 182 +++++++++++++++++++++++++++++++++
 3 files changed, 377 insertions(+), 38 deletions(-)
 delete mode 100644 arch/arm/boot/dts/dove-cm-a510.dts
 create mode 100644 arch/arm/boot/dts/dove-cm-a510.dtsi
 create mode 100644 arch/arm/boot/dts/dove-sbc-a510.dts

diff --git a/arch/arm/boot/dts/dove-cm-a510.dts b/arch/arm/boot/dts/dove-cm-a510.dts
deleted file mode 100644
index 50c0d6904497..000000000000
--- a/arch/arm/boot/dts/dove-cm-a510.dts
+++ /dev/null
@@ -1,38 +0,0 @@
-/dts-v1/;
-
-#include "dove.dtsi"
-
-/ {
-	model = "Compulab CM-A510";
-	compatible = "compulab,cm-a510", "marvell,dove";
-
-	memory {
-		device_type = "memory";
-		reg = <0x00000000 0x40000000>;
-	};
-
-	chosen {
-		bootargs = "console=ttyS0,115200n8 earlyprintk";
-	};
-};
-
-&uart0 { status = "okay"; };
-&uart1 { status = "okay"; };
-&sdio0 { status = "okay"; };
-&sdio1 { status = "okay"; };
-&sata0 { status = "okay"; };
-
-&spi0 {
-	status = "okay";
-
-	/* spi0.0: 4M Flash Winbond W25Q32BV */
-	spi-flash at 0 {
-		compatible = "st,w25q32";
-		spi-max-frequency = <20000000>;
-		reg = <0>;
-	};
-};
-
-&i2c0 {
-	  status = "okay";
-};
diff --git a/arch/arm/boot/dts/dove-cm-a510.dtsi b/arch/arm/boot/dts/dove-cm-a510.dtsi
new file mode 100644
index 000000000000..59b4056b478f
--- /dev/null
+++ b/arch/arm/boot/dts/dove-cm-a510.dtsi
@@ -0,0 +1,195 @@
+/*
+ * Device Tree include for Compulab CM-A510 System-on-Module
+ *
+ * Copyright (C) 2015, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; version 2 of the
+ *     License.
+ *
+ *     This file is distributed in the hope that it will be useful
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/*
+ * The CM-A510 comes with several optional components:
+ *
+ * Memory options:
+ *  D512: 512M
+ *  D1024: 1G
+ *
+ * NAND options:
+ *  N512: 512M NAND
+ *
+ * Ethernet options:
+ *  E1: PHY RTL8211D on internal GbE (SMI address 0x03)
+ *  E2: Additional ethernet NIC RTL8111D on PCIe1
+ *
+ * Audio options:
+ *  A: TI TLV320AIC23b audio codec (I2C address 0x1a)
+ *
+ * Touchscreen options:
+ *  I: TI TSC2046 touchscreen controller (on SPI1)
+ *
+ * USB options:
+ *  U2: 2 dual-role USB2.0 ports
+ *  U4: 2 additional USB2.0 host ports (via USB1)
+ *
+ * WiFi options:
+ *  W: Broadcom BCM4319 802.11b/g/n (USI WM-N-BM-01 on SDIO1)
+ *
+ * GPIOs used on CM-A510:
+ *   1 GbE PHY reset (active low)
+ *   3 WakeUp
+ *   8 PowerOff (active low)
+ *  13 Touchscreen pen irq (active low)
+ *  65 System LED (active high)
+ *  69 USB Hub reset (active low)
+ *  70 WLAN reset (active low)
+ *  71 WLAN regulator (active high)
+ */
+
+#include "dove.dtsi"
+
+/ {
+	model = "Compulab CM-A510";
+	compatible = "compulab,cm-a510", "marvell,dove";
+
+	/*
+	 * Set the minimum memory size here and let the
+	 * bootloader set the real size.
+	 */
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		/* Set upper NAND data bit to GPO */
+		pinctrl-0 = <&pmx_nand_gpo>;
+		pinctrl-names = "default";
+
+		system {
+			label = "cm-a510:system:green";
+			gpios = <&gpio2 1 GPIO_ACTIVE_HIGH>;
+			default-state = "keep";
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		wifi_power: regulator at 1 {
+			compatible = "regulator-fixed";
+			regulator-name = "WiFi Power";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio2 7 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+/* Optional RTL8211D GbE PHY on SMI address 0x03 */
+&ethphy {
+	reg = <3>;
+	status = "disabled";
+};
+
+&i2c0 {
+	/* Optional TI TLV320AIC23b audio codec */
+	opt_audio: audio at 1a {
+		compatible = "ti,tlv320aic23";
+		reg = <0x1a>;
+		status = "disabled";
+	};
+};
+
+/* Optional RTL8111D GbE NIC on PCIe1 */
+&pcie { status = "disabled"; };
+
+&pcie1 {
+	pinctrl-0 = <&pmx_pcie1_clkreq>;
+	pinctrl-names = "default";
+	status = "disabled";
+};
+
+&pinctrl {
+	pmx_uart2: pmx-uart2 {
+		marvell,pins = "mpp14", "mpp15";
+		marvell,function = "uart2";
+	};
+};
+
+/* Optional Broadcom BCM4319 802.11b/g/n WiFi module */
+&sdio1 {
+	non-removable;
+	vmmc-supply = <&wifi_power>;
+	reset-gpio = <&gpio2 6 GPIO_ACTIVE_LOW>;
+	status = "disabled";
+};
+
+&spi0 {
+	status = "okay";
+
+	/* 1M Flash Winbond W25Q80BL */
+	flash at 0 {
+		compatible = "winbond,w25q80";
+		spi-max-frequency = <80000000>;
+		reg = <0>;
+	};
+};
+
+&spi1 {
+	pinctrl-0 = <&pmx_spi1_20_23>;
+	pinctrl-names = "default";
+	status = "disabled";
+
+	/* Optional TI TSC2046 touchscreen controller */
+	opt_touch: touchscreen at 0 {
+		compatible = "ti,tsc2046";
+		spi-max-frequency = <2500000>;
+		reg = <0>;
+		pinctrl-0 = <&pmx_gpio_13>;
+		pinctrl-names = "default";
+		interrupts-extended = <&gpio0 13 IRQ_TYPE_EDGE_FALLING>;
+	};
+};
+
+&uart2 {
+	pinctrl-0 = <&pmx_uart2>;
+	pinctrl-names = "default";
+};
diff --git a/arch/arm/boot/dts/dove-sbc-a510.dts b/arch/arm/boot/dts/dove-sbc-a510.dts
new file mode 100644
index 000000000000..288e707dea99
--- /dev/null
+++ b/arch/arm/boot/dts/dove-sbc-a510.dts
@@ -0,0 +1,182 @@
+/*
+ * Device Tree file for Compulab SBC-A510 Single Board Computer
+ *
+ * Copyright (C) 2015, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; version 2 of the
+ *     License.
+ *
+ *     This file is distributed in the hope that it will be useful
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/*
+ * SBC-A510 comprises a PCA9555 I2C GPIO expander its GPIO lines connected to
+ *
+ * 0.0 USB0 VBUS_EN (active high)
+ * 0.1 USB0 VBUS_GOOD
+ * 0.2 DVI transmitter TI TFP410 MSEN
+ * 0.3 DVI transmitter TI TFP410 PD# (active low power down)
+ * 0.4 LVDS transmitter DS90C365 PD# (active low power down)
+ * 0.5 LCD nRST (active low reset)
+ * 0.6 PCIe0 nRST (active low reset)
+ * 0.7 mini-PCIe slot W_DISABLE#
+ *
+ * 1.0 MMC WP
+ * 1.1 Camera Input FPC FLASH_STB and P21.5
+ * 1.2 Camera Input FPC WE        and P21.22
+ * 1.3 MMC VCC_EN (active high)   and P21.7
+ * 1.4 Camera Input FPC AFTR_RST  and P21.17
+ * 1.5 Camera Input FPC OE        and P21.19
+ * 1.6 Camera Input FPC SNPSHT    and P21.6
+ * 1.7 Camera Input FPC SHTR      and P21.10
+ */
+
+/dts-v1/;
+
+#include "dove-cm-a510.dtsi"
+
+/ {
+	model = "Compulab SBC-A510";
+	compatible = "compulab,sbc-a510", "compulab,cm-a510", "marvell,dove";
+
+	chosen {
+		stdout-path = &uart0;
+	};
+
+	regulators {
+		usb0_power: regulator at 2 {
+			compatible = "regulator-fixed";
+			regulator-name = "USB Power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio_ext 0 GPIO_ACTIVE_HIGH>;
+		};
+
+		mmc_power: regulator at 3 {
+			compatible = "regulator-fixed";
+			regulator-name = "MMC Power";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio_ext 13 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+/* Ethernet0 depends on CM-A510 option E1 */
+&mdio { status = "disabled"; };
+&eth { status = "disabled"; };
+&ethphy { status = "disabled"; };
+
+/*
+ * USB port 0 can be powered and monitored by I2C GPIO expander:
+ *  VBUS_ENABLE on GPIO0, VBUS_GOOD on GPIO1
+ */
+&ehci0 {
+	status = "okay";
+	vbus-supply = <&usb0_power>;
+};
+
+/* USB port 1 (and ports 2, 3 if CM-A510 has U4 option) */
+&ehci1 { status = "okay"; };
+
+/*
+ * I2C bus layout:
+ * i2c0:
+ *  - Audio Codec, 0x1a (option from CM-A510)
+ *  - DVI transmitter TI TFP410, 0x39
+ *  - HDMI/DVI DDC channel
+ * i2c1:
+ *  - GPIO expander, NXP PCA9555, 0x20
+ *  - VGA DDC channel
+ */
+&i2c {
+	pinctrl-0 = <&pmx_i2c1>;
+	pinctrl-names = "default";
+};
+
+&i2c0 {
+	/* TI TFP410 DVI transmitter */
+	dvi: video at 39 {
+		compatible = "ti,tfp410";
+		reg = <0x39>;
+		powerdown-gpio = <&gpio_ext 3 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+
+	/* NXP PCA9555 GPIO expander */
+	gpio_ext: gpio at 20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		#gpio-cells = <2>;
+	};
+};
+
+&pcie { status = "okay"; };
+
+/*
+ * PCIe0 can be configured by Jumper E1 to be either connected to
+ * a mini-PCIe slot or a Pericom PI7C9X111 PCIe-to-PCI bridge.
+ */
+&pcie0 {
+	status = "okay";
+	pinctrl-0 = <&pmx_pcie0_clkreq>;
+	pinctrl-names = "default";
+	reset-gpios = <&gpio_ext 6 GPIO_ACTIVE_LOW>;
+};
+
+/* Ethernet1 depends on CM-A510 option E2 */
+&pcie1 { status = "disabled"; };
+
+/* SATA connector */
+&sata0 { status = "okay"; };
+
+/*
+ * SDIO0 is connected to a MMC/SD/SDIO socket, I2C GPIO expander has
+ *  VCC_MMC_ENABLE on GPIO13, MMC_WP on GPIO10
+ */
+&sdio0 {
+	vmmc-supply = <&mmc_power>;
+	wp-gpios = <&gpio_ext 10 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+/* UART0 on RS232 mini-connector */
+&uart0 { status = "okay"; };
+/* UART2 on pin headers */
+&uart2 { status = "okay"; };
-- 
2.1.0
