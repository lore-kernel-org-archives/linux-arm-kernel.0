From: marek.behun@nic.cz (=?UTF-8?q?Marek=20Beh=C3=BAn?=)
Date: Thu,  9 Aug 2018 04:20:37 +0200
Subject: [PATCH v2 7/7] ARM64: dts: marvell: Add DTS file for Turris Mox
In-Reply-To: <20180809022037.12001-1-marek.behun@nic.cz>
References: <20180809022037.12001-1-marek.behun@nic.cz>
Message-ID: <20180809022037.12001-8-marek.behun@nic.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds basic support for the Turris Mox board from CZ.NIC.

Turris Mox is as modular router based on the Armada 3720 SOC (same as
EspressoBin).

The basic module can be extended by different modules.
When those modules are connected, U-Boot shall patch this basic
device-tree with nodes corresponding to those modules.

Signed-off-by: Marek Behun <marek.behun@nic.cz>
---
 .../arm/marvell/armada-3720-turris-mox.txt         |   6 +
 MAINTAINERS                                        |   1 +
 arch/arm64/boot/dts/marvell/Makefile               |   1 +
 .../boot/dts/marvell/armada-3720-turris-mox.dts    | 229 +++++++++++++++++++++
 4 files changed, 237 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-3720-turris-mox.txt
 create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-3720-turris-mox.txt b/Documentation/devicetree/bindings/arm/marvell/armada-3720-turris-mox.txt
new file mode 100644
index 000000000000..408fc07a9bbf
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-3720-turris-mox.txt
@@ -0,0 +1,6 @@
+CZ.NIC's Turris Mox SOHO router Device Tree Bindings
+----------------------------------------------------
+
+Required root node property:
+
+compatible: must contain "cznic,turris-mox"
diff --git a/MAINTAINERS b/MAINTAINERS
index 33ee36910b1c..cb9ffbf6dd6e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1382,6 +1382,7 @@ ARM/CZ.NIC TURRIS MOX SUPPORT
 M:	Marek Behun <marek.behun@nic.cz>
 W:	http://mox.turris.cz
 S:	Maintained
+F:	arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
 F:	include/mfd/moxtet.h
 F:	drivers/gpio/gpio-moxtet.c
 F:	drivers/mfd/moxtet.c
diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index ea9d49f2a911..1dd89d1bf8ad 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -2,6 +2,7 @@
 # Mvebu SoC Family
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-turris-mox.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-7040-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-mcbin.dtb
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
new file mode 100644
index 000000000000..dd9de3388c1e
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0+ or X11
+/*
+ * Device Tree file for CZ.NIC Turris Mox Board
+ * 2018 by Marek Behun <marek.behun@nic.cz>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include "armada-372x.dtsi"
+
+/ {
+	model = "CZ.NIC Turris Mox Board";
+	compatible = "cznic,turris-mox", "marvell,armada3720",
+		     "marvell,armada3710";
+
+	aliases {
+		spi0 = &spi0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory at 0 {
+		device_type = "memory";
+		reg = <0x00000000 0x00000000 0x00000000 0x20000000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		red {
+			gpios = <&gpiosb 21 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		button at 0 {
+			label = "reset";
+			linux,code = <BTN_MISC>;
+			gpios = <&gpiosb 20 GPIO_ACTIVE_LOW>;
+			debounce-interval = <60>;
+		};
+	};
+
+	exp_usb3_vbus: usb3-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb3-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		regulator-always-on;
+		gpio = <&gpiosb 0 GPIO_ACTIVE_HIGH>;
+	};
+
+	usb3_phy: usb3-phy {
+		compatible = "usb-nop-xceiv";
+		vcc-supply = <&exp_usb3_vbus>;
+	};
+
+	vsdc_reg: regulator at 1 {
+		compatible = "regulator-gpio";
+		regulator-name = "vsdc";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+
+		gpios = <&gpiosb 23 GPIO_ACTIVE_HIGH>;
+		gpios-states = <0>;
+		states = <1800000 0x1
+			  3300000 0x0>;
+		enable-active-high;
+	};
+
+	vsdio_reg: regulator at 2 {
+		compatible = "regulator-gpio";
+		regulator-name = "vsdio";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+
+		gpios = <&gpiosb 22 GPIO_ACTIVE_HIGH>;
+		gpios-states = <0>;
+		states = <1800000 0x1
+			  3300000 0x0>;
+		enable-active-high;
+	};
+};
+
+&pinctrl_nb {
+	spi_cs1_pins: spi-cs1-pins {
+		groups = "spi_cs1";
+		function = "spi";
+	};
+
+	sdio0_pins: sdio0-pins {
+		groups = "sdio0";
+		function = "sdio";
+	};
+};
+
+&pinctrl_sb {
+	sdio_sb_pins: sdio-sb-pins {
+		groups = "sdio_sb";
+		function = "sdio";
+	};
+
+	smi_pins: smi-pins {
+		groups = "smi";
+		function = "smi";
+	};
+
+	pcie_pins: pcie1-pins {
+		groups = "pcie1";
+		function = "gpio";
+	};
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+	status = "okay";
+
+	rtc at 6f {
+		compatible = "microchip,mcp7940x";
+		reg = <0x6f>;
+	};
+};
+
+&pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_pins>;
+	status = "okay";
+	max-link-speed = <2>;
+
+	/* this shall be enabled by u-boot if the PCIe module is present */
+	status = "disabled";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&eth0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii_pins>;
+	phy-mode = "rgmii-id";
+	phy = <&phy1>;
+	status = "okay";
+};
+
+&mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&smi_pins>;
+	status = "okay";
+
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
+	};
+};
+
+&sdhci0 {
+	wp-inverted;
+	bus-width = <4>;
+	cd-gpios = <&gpionb 10 GPIO_ACTIVE_HIGH>;
+	vqmmc-supply = <&vsdc_reg>;
+	marvell,pad-type = "sd";
+	status = "okay";
+};
+
+&sdhci1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdio0_pins &sdio_sb_pins>;
+	non-removable;
+	bus-width = <4>;
+	marvell,pad-type = "sd";
+	vqmmc-supply = <&vsdio_reg>;
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_quad_pins &spi_cs1_pins>;
+
+	spi-flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <2000000>;
+
+		partition at 0 {
+			label = "u-boot";
+			reg = <0x0 0x3f0000>;
+		};
+
+		partition at 3f0000 {
+			label = "u-boot-env";
+			reg = <0x180000 0x10000>;
+		};
+
+		partition at 400000 {
+			label = "Rescue system";
+			reg = <0x190000 0x670000>;
+		};
+	};
+
+	moxtet at 1 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "cznic,moxtet";
+		reg = <1>;
+		spi-max-frequency = <1000000>;
+		spi-cpol;
+		spi-cpha;
+	};
+};
+
+&usb3 {
+	status = "okay";
+	usb-phy = <&usb3_phy>;
+};
-- 
2.16.4
