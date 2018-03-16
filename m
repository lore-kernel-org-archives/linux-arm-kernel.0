From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:53:08 +0100
Subject: [PATCH 49/52] ARM: dts: stout: Initial r8a7790 Stout board support
In-Reply-To: <cover.1521208546.git.horms+renesas@verge.net.au>
References: <cover.1521208546.git.horms+renesas@verge.net.au>
Message-ID: <31d65fe0760bbb4a30fded7d051146c1bc7b3915.1521208546.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marek Vasut <marek.vasut@gmail.com>

Stout base board support making use of 1 GiB of memory,
the Renesas H2 r8a7790 SoC with the SCIFA0 serial port
and CA15 with ARM architected timer.

Furthermore, this device tree contains entries for:
  - 4x LEDs
  - SDHI SD/MMC controller
  - Display unit with HDMI output
  - SH fast ethernet controller
  - QSPI controller with S25FL512S attached to it
  - I2C controller with DA9210 and DA 9063 PMICs

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile          |   1 +
 arch/arm/boot/dts/r8a7790-stout.dts | 363 ++++++++++++++++++++++++++++++++++++
 2 files changed, 364 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7790-stout.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ade7a38543dc..2b6dfeea1dba 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -784,6 +784,7 @@ dtb-$(CONFIG_ARCH_RENESAS) += \
 	r8a7778-bockw.dtb \
 	r8a7779-marzen.dtb \
 	r8a7790-lager.dtb \
+	r8a7790-stout.dtb \
 	r8a7791-koelsch.dtb \
 	r8a7791-porter.dtb \
 	r8a7792-blanche.dtb \
diff --git a/arch/arm/boot/dts/r8a7790-stout.dts b/arch/arm/boot/dts/r8a7790-stout.dts
new file mode 100644
index 000000000000..a13a92c26645
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7790-stout.dts
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the Stout board
+ *
+ * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
+ */
+
+/dts-v1/;
+#include "r8a7790.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "Stout";
+	compatible = "renesas,stout", "renesas,r8a7790";
+
+	aliases {
+		serial0 = &scifa0;
+	};
+
+	chosen {
+		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory at 40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x40000000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led1 {
+			gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
+		};
+		led2 {
+			gpios = <&gpio4 23 GPIO_ACTIVE_LOW>;
+		};
+		led3 {
+			gpios = <&gpio5 17 GPIO_ACTIVE_LOW>;
+		};
+		led5 {
+			gpios = <&gpio4 24 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	fixedregulator3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	vcc_sdhi0: regulator-vcc-sdhi0 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "SDHI0 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&gpio5 24 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	hdmi-out {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_out: endpoint {
+				remote-endpoint = <&adv7511_out>;
+			};
+		};
+	};
+
+	osc1_clk: osc1-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <148500000>;
+	};
+
+	osc4_clk: osc4-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <12000000>;
+	};
+};
+
+&du {
+	pinctrl-0 = <&du_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	clocks = <&cpg CPG_MOD 724>, <&cpg CPG_MOD 723>, <&cpg CPG_MOD 722>,
+		 <&cpg CPG_MOD 726>, <&cpg CPG_MOD 725>,
+		 <&osc1_clk>;
+	clock-names = "du.0", "du.1", "du.2", "lvds.0", "lvds.1", "dclkin.0";
+
+	ports {
+		port at 0 {
+			endpoint {
+				remote-endpoint = <&adv7511_in>;
+			};
+		};
+		port at 1 {
+			lvds_connector0: endpoint {
+			};
+		};
+		port at 2 {
+			lvds_connector1: endpoint {
+			};
+		};
+	};
+};
+
+&extal_clk {
+	clock-frequency = <20000000>;
+};
+
+&pfc {
+
+	pinctrl-0 = <&scif_clk_pins>;
+	pinctrl-names = "default";
+
+	du_pins: du {
+		groups = "du_rgb888", "du_sync_1", "du_clk_out_0";
+		function = "du";
+	};
+
+	scifa0_pins: scifa0 {
+		groups = "scifa0_data_b";
+		function = "scifa0";
+	};
+
+	scif_clk_pins: scif_clk {
+		groups = "scif_clk";
+		function = "scif_clk";
+	};
+
+	ether_pins: ether {
+		groups = "eth_link", "eth_mdio", "eth_rmii";
+		function = "eth";
+	};
+
+	phy1_pins: phy1 {
+		groups = "intc_irq1";
+		function = "intc";
+	};
+
+	sdhi0_pins: sd0 {
+		groups = "sdhi0_data4", "sdhi0_ctrl";
+		function = "sdhi0";
+		power-source = <3300>;
+	};
+
+	qspi_pins: qspi {
+		groups = "qspi_ctrl", "qspi_data4";
+		function = "qspi";
+	};
+
+	iic2_pins: iic2 {
+		groups = "iic2_b";
+		function = "iic2";
+	};
+
+	iic3_pins: iic3 {
+		groups = "iic3";
+		function = "iic3";
+	};
+
+	usb0_pins: usb0 {
+		groups = "usb0";
+		function = "usb0";
+	};
+};
+
+&ether {
+	pinctrl-0 = <&ether_pins &phy1_pins>;
+	pinctrl-names = "default";
+
+	phy-handle = <&phy1>;
+	renesas,ether-link-active-low;
+	status = "okay";
+
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
+		interrupt-parent = <&irqc0>;
+		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
+		micrel,led-mode = <1>;
+	};
+};
+
+&cmt0 {
+	status = "okay";
+};
+
+&qspi {
+	pinctrl-0 = <&qspi_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	flash: flash at 0 {
+		compatible = "spansion,s25fl512s", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <30000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+		spi-cpha;
+		spi-cpol;
+		m25p,fast-read;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition at 0 {
+				label = "loader";
+				reg = <0x00000000 0x00080000>;
+				read-only;
+			};
+			partition at 80000 {
+				label = "uboot";
+				reg = <0x00080000 0x00040000>;
+				read-only;
+			};
+			partition at c0000 {
+				label = "uboot-env";
+				reg = <0x000c0000 0x00040000>;
+				read-only;
+			};
+			partition at 100000 {
+				label = "flash";
+				reg = <0x00100000 0x03f00000>;
+			};
+		};
+	};
+};
+
+&scifa0 {
+	pinctrl-0 = <&scifa0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&scif_clk {
+	clock-frequency = <14745600>;
+};
+
+&sdhi0 {
+	pinctrl-0 = <&sdhi0_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&vcc_sdhi0>;
+	cd-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&cpu0 {
+	cpu0-supply = <&vdd_dvfs>;
+};
+
+&iic2	{
+	status = "okay";
+	pinctrl-0 = <&iic2_pins>;
+	pinctrl-names = "default";
+
+	clock-frequency = <100000>;
+
+	hdmi at 39 {
+		compatible = "adi,adv7511w";
+		reg = <0x39>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&osc4_clk>;
+		clock-names = "cec";
+
+		adi,input-depth = <8>;
+		adi,input-colorspace = "rgb";
+		adi,input-clock = "1x";
+		adi,input-style = <1>;
+		adi,input-justification = "evenly";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				adv7511_in: endpoint {
+					remote-endpoint = <&du_out_rgb>;
+				};
+			};
+
+			port at 1 {
+				reg = <1>;
+				adv7511_out: endpoint {
+					remote-endpoint = <&hdmi_con_out>;
+				};
+			};
+		};
+	};
+};
+
+&iic3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&iic3_pins>;
+	status = "okay";
+
+	pmic at 58 {
+		compatible = "dlg,da9063";
+		reg = <0x58>;
+		interrupt-parent = <&irqc0>;
+		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+
+		rtc {
+			compatible = "dlg,da9063-rtc";
+		};
+
+		wdt {
+			compatible = "dlg,da9063-watchdog";
+		};
+	};
+
+	vdd_dvfs: regulator at 68 {
+		compatible = "dlg,da9210";
+		reg = <0x68>;
+		interrupt-parent = <&irqc0>;
+		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	vdd: regulator at 70 {
+		compatible = "dlg,da9210";
+		reg = <0x70>;
+		interrupt-parent = <&irqc0>;
+		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
+&pci0 {
+	status = "okay";
+	pinctrl-0 = <&usb0_pins>;
+	pinctrl-names = "default";
+};
+
+&usbphy {
+	status = "okay";
+};
-- 
2.11.0
