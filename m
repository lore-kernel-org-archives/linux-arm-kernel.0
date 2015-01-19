From: kaloz@openwrt.org (Imre Kaloz)
Date: Mon, 19 Jan 2015 18:15:01 +0100
Subject: [PATCHv2] mvebu: add Linksys WRT1900AC (Mamba) support
Message-ID: <1421687701-5667-1-git-send-email-kaloz@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Linksys WRT1900AC (Mamba) is a router that has

- 2 mini-PCIe slots with Marvell 88W8864 radios
- 1 USB 3.0 port
- 1 USB 2.0/eSATAp port
- 2 Ethernet interfaces connected to a 88E6172 switch (1x WAN + 4x LAN)
- 128MB NAND flash
- 256MB RAM

Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
---
Changes since v1:
  * add dual license
  * lower SPI speed to meet the chip's maximum
  * pinctrl cleanups based on Andrew Lunn's suggestions
---
 arch/arm/boot/dts/armada-xp-mamba.dts | 273 ++++++++++++++++++++++++++++++++++
 1 file changed, 273 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-xp-mamba.dts

diff --git a/arch/arm/boot/dts/armada-xp-mamba.dts b/arch/arm/boot/dts/armada-xp-mamba.dts
new file mode 100644
index 0000000..e368d18
--- /dev/null
+++ b/arch/arm/boot/dts/armada-xp-mamba.dts
@@ -0,0 +1,273 @@
+/*
+ * Device Tree file for the Linksys WRT1900AC (Mamba).
+ *
+ * Note: this board is shipped with a new generation boot loader that
+ * remaps internal registers at 0xf1000000. Therefore, if earlyprintk
+ * is used, the CONFIG_DEBUG_MVEBU_UART_ALTERNATE option should be
+ * used.
+ *
+ * Copyright (C) 2014 Imre Kaloz <kaloz@openwrt.org>
+ *
+ * Based on armada-xp-axpwifiap.dts:
+ *
+ *     Copyright (C) 2013 Marvell
+ *
+ *     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is licensed under the terms of the GNU General Public
+ *     License version 2.  This program is licensed "as is" without
+ *     any warranty of any kind, whether express or implied.
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
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include "armada-xp-mv78230.dtsi"
+
+/ {
+	model = "Linksys WRT1900AC (Mamba)";
+	compatible = "linksys,mamba", "marvell,armadaxp-mv78230",
+		     "marvell,armadaxp", "marvell,armada-370-xp";
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+		stdout-path = &uart0;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x00000000 0x00000000 0x10000000>; /* 256MB */
+	};
+
+	soc {
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
+			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000>;
+
+		pcie-controller {
+			status = "okay";
+
+			/* Etron EJ168 USB 3.0 controller */
+			pcie at 1,0 {
+				/* Port 0, Lane 0 */
+				status = "okay";
+			};
+
+			/* First mini-PCIe port */
+			pcie at 2,0 {
+				/* Port 0, Lane 1 */
+				status = "okay";
+			};
+
+			/* Second mini-PCIe port */
+			pcie at 3,0 {
+				/* Port 0, Lane 3 */
+				status = "okay";
+			};
+		};
+
+		internal-regs {
+			serial at 12000 {
+				status = "okay";
+			};
+
+			sata at a0000 {
+				nr-ports = <1>;
+				status = "okay";
+			};
+
+			ethernet at 70000 {
+				pinctrl-0 = <&ge0_rgmii_pins>;
+				pinctrl-names = "default";
+				status = "okay";
+				phy-mode = "rgmii-id";
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+
+			ethernet at 74000 {
+				pinctrl-0 = <&ge1_rgmii_pins>;
+				pinctrl-names = "default";
+				status = "okay";
+				phy-mode = "rgmii-id";
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+
+			/* USB part of the eSATA/USB 2.0 port */
+			usb at 50000 {
+				status = "okay";
+			};
+
+			i2c at 11000 {
+				status = "okay";
+				clock-frequency = <100000>;
+
+				tmp421 at 4c {
+					compatible = "ti,tmp421";
+					reg = <0x4c>;
+				};
+			};
+
+			nand at d0000 {
+				status = "okay";
+				num-cs = <1>;
+				marvell,nand-keep-config;
+				marvell,nand-enable-arbiter;
+				nand-on-flash-bbt;
+				nand-ecc-strength = <4>;
+				nand-ecc-step-size = <512>;
+
+				partition at 0 {
+					label = "u-boot";
+					reg = <0x0000000 0x100000>;  /* 1MB */
+					read-only;
+				};
+
+				partition at 100000 {
+					label = "u_env";
+					reg = <0x100000 0x40000>;    /* 256KB */
+				};
+
+				partition at 140000 {
+					label = "s_env";
+					reg = <0x140000 0x40000>;    /* 256KB */
+				};
+
+				partition at 900000 {
+					label = "devinfo";
+					reg = <0x900000 0x100000>;    /* 1MB */
+					read-only;
+				};
+
+				partition at a00000 {
+					label = "kernel1";
+					reg = <0xa00000 0x2800000>;    /* 3MB + rootfs1 */
+				};
+
+				partition at d00000 {
+					label = "rootfs1";
+					reg = <0xd00000 0x2500000>;    /* 37MB */
+				};
+
+				partition at 3200000 {
+					label = "kernel2";
+					reg = <0x3200000 0x2800000>;    /* 3MB + rootfs2 */
+				};
+
+				partition at 3500000 {
+					label = "rootfs2";
+					reg = <0x3500000 0x2500000>;    /* 37MB */
+				};
+
+				/* Last MB is for the BBT, i.e. not writable */
+				partition at 5a00000 {
+					label = "syscfg";
+					reg = <0x5a00000 0x2600000>;    /* 38MB */
+				};
+			};
+
+			spi0: spi at 10600 {
+				status = "okay";
+
+				spi-flash at 0 {
+					#address-cells = <1>;
+					#size-cells = <1>;
+					compatible = "everspin,mr25h256";
+					reg = <0>; /* Chip select 0 */
+					spi-max-frequency = <40000000>;
+				};
+			};
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&keys_pin>;
+		pinctrl-names = "default";
+
+		button at 1 {
+			label = "WPS";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;
+		};
+
+		button at 2 {
+			label = "Factory Reset Button";
+			linux,code = <KEY_RESTART>;
+			gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&power_led_pin>;
+		pinctrl-names = "default";
+
+		power {
+			label = "mamba:white:power";
+			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+	};
+
+	gpio_fan {
+		/* SUNON HA4010V4-0000-C99 */
+		compatible = "gpio-fan";
+		gpios = <&gpio0 24 0>;
+
+		gpio-fan,speed-map = <0    0
+				      4500 1>;
+	};
+};
+
+&pinctrl {
+
+	keys_pin: keys-pin {
+		marvell,pins = "mpp32", "mpp33";
+		marvell,function = "gpio";
+	};
+
+	power_led_pin: power-led-pin {
+		marvell,pins = "mpp40";
+		marvell,function = "gpio";
+	};
+
+	gpio_fan_pin: gpio-fan-pin {
+		marvell,pins = "mpp24";
+		marvell,function = "gpio";
+	};
+};
-- 
2.1.0
