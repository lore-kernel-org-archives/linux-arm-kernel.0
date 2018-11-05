From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 05 Nov 2018 17:25:41 +0000
Subject: [PATCH] arm64: dts: add support for Macchiatobin Single Shot board
Message-ID: <E1gJidB-0000XQ-Ua@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT support for the Macchiatobin Single Shot board from SolidRun,
which is similar to the Double Shot board, but does not have the
10G 3310 PHYs - the two ethernet ports are instead connected directly
to the SFP+ cages.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
If you'd like me to generate this patch with -C to better show the
changes in the .dtsi, please just ask.

 arch/arm64/boot/dts/marvell/Makefile               |   1 +
 .../dts/marvell/armada-8040-mcbin-singleshot.dts   |  29 ++
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts  | 333 +-------------------
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi | 346 +++++++++++++++++++++
 4 files changed, 380 insertions(+), 329 deletions(-)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-8040-mcbin-singleshot.dts
 create mode 100644 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi

diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index eca8bac6303a..2eff1f927471 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -6,4 +6,5 @@ dtb-$(CONFIG_ARCH_MVEBU) += armada-7040-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-clearfog-gt-8k.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-mcbin.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-mcbin-singleshot.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-8080-db.dtb
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin-singleshot.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin-singleshot.dts
new file mode 100644
index 000000000000..c3e18fd5bc27
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin-singleshot.dts
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2016 Marvell Technology Group Ltd.
+ *
+ * Device Tree file for MACCHIATOBin Armada 8040 community board platform
+ */
+
+#include "armada-8040-mcbin.dtsi"
+
+/ {
+	model = "Marvell 8040 MACCHIATOBin Single-shot";
+	compatible = "marvell,armada8040-mcbin-singleshot",
+			"marvell,armada8040-mcbin", "marvell,armada8040",
+			"marvell,armada-ap806-quad", "marvell,armada-ap806";
+};
+
+&cp0_eth0 {
+	status = "okay";
+	phy-mode = "10gbase-kr";
+	managed = "in-band-status";
+	sfp = <&sfp_eth0>;
+};
+
+&cp1_eth0 {
+	status = "okay";
+	phy-mode = "10gbase-kr";
+	managed = "in-band-status";
+	sfp = <&sfp_eth1>;
+};
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
index 56fa44860909..d06f5ab7ddab 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
@@ -5,226 +5,13 @@
  * Device Tree file for MACCHIATOBin Armada 8040 community board platform
  */
 
-#include "armada-8040.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
+#include "armada-8040-mcbin.dtsi"
 
 / {
-	model = "Marvell 8040 MACCHIATOBin";
-	compatible = "marvell,armada8040-mcbin", "marvell,armada8040",
+	model = "Marvell 8040 MACCHIATOBin Double-shot";
+	compatible = "marvell,armada8040-mcbin-doubleshot",
+			"marvell,armada8040-mcbin", "marvell,armada8040",
 			"marvell,armada-ap806-quad", "marvell,armada-ap806";
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	memory at 0 {
-		device_type = "memory";
-		reg = <0x0 0x0 0x0 0x80000000>;
-	};
-
-	aliases {
-		ethernet0 = &cp0_eth0;
-		ethernet1 = &cp1_eth0;
-		ethernet2 = &cp1_eth1;
-		ethernet3 = &cp1_eth2;
-	};
-
-	/* Regulator labels correspond with schematics */
-	v_3_3: regulator-3-3v {
-		compatible = "regulator-fixed";
-		regulator-name = "v_3_3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-		status = "okay";
-	};
-
-	v_vddo_h: regulator-1-8v {
-		compatible = "regulator-fixed";
-		regulator-name = "v_vddo_h";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-always-on;
-		status = "okay";
-	};
-
-	v_5v0_usb3_hst_vbus: regulator-usb3-vbus0 {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&cp0_gpio2 15 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&cp0_xhci_vbus_pins>;
-		regulator-name = "v_5v0_usb3_hst_vbus";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		status = "okay";
-	};
-
-	usb3h0_phy: usb3_phy0 {
-		compatible = "usb-nop-xceiv";
-		vcc-supply = <&v_5v0_usb3_hst_vbus>;
-	};
-
-	sfp_eth0: sfp-eth0 {
-		/* CON15,16 - CPM lane 4 */
-		compatible = "sff,sfp";
-		i2c-bus = <&sfpp0_i2c>;
-		los-gpio = <&cp1_gpio1 28 GPIO_ACTIVE_HIGH>;
-		mod-def0-gpio = <&cp1_gpio1 27 GPIO_ACTIVE_LOW>;
-		tx-disable-gpio = <&cp1_gpio1 29 GPIO_ACTIVE_HIGH>;
-		tx-fault-gpio  = <&cp1_gpio1 26 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&cp1_sfpp0_pins>;
-	};
-
-	sfp_eth1: sfp-eth1 {
-		/* CON17,18 - CPS lane 4 */
-		compatible = "sff,sfp";
-		i2c-bus = <&sfpp1_i2c>;
-		los-gpio = <&cp1_gpio1 8 GPIO_ACTIVE_HIGH>;
-		mod-def0-gpio = <&cp1_gpio1 11 GPIO_ACTIVE_LOW>;
-		tx-disable-gpio = <&cp1_gpio1 10 GPIO_ACTIVE_HIGH>;
-		tx-fault-gpio = <&cp0_gpio2 30 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&cp1_sfpp1_pins &cp0_sfpp1_pins>;
-	};
-
-	sfp_eth3: sfp-eth3 {
-		/* CON13,14 - CPS lane 5 */
-		compatible = "sff,sfp";
-		i2c-bus = <&sfp_1g_i2c>;
-		los-gpio = <&cp0_gpio2 22 GPIO_ACTIVE_HIGH>;
-		mod-def0-gpio = <&cp0_gpio2 21 GPIO_ACTIVE_LOW>;
-		tx-disable-gpio = <&cp1_gpio1 24 GPIO_ACTIVE_HIGH>;
-		tx-fault-gpio = <&cp0_gpio2 19 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&cp0_sfp_1g_pins &cp1_sfp_1g_pins>;
-	};
-};
-
-&uart0 {
-	status = "okay";
-	pinctrl-0 = <&uart0_pins>;
-	pinctrl-names = "default";
-};
-
-&ap_sdhci0 {
-	bus-width = <8>;
-	/*
-	 * Not stable in HS modes - phy needs "more calibration", so add
-	 * the "slow-mode" and disable SDR104, SDR50 and DDR50 modes.
-	 */
-	marvell,xenon-phy-slow-mode;
-	no-1-8-v;
-	no-sd;
-	no-sdio;
-	non-removable;
-	status = "okay";
-	vqmmc-supply = <&v_vddo_h>;
-};
-
-&cp0_i2c0 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&cp0_i2c0_pins>;
-	status = "okay";
-};
-
-&cp0_i2c1 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&cp0_i2c1_pins>;
-	status = "okay";
-
-	i2c-switch at 70 {
-		compatible = "nxp,pca9548";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x70>;
-
-		sfpp0_i2c: i2c at 0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-		};
-		sfpp1_i2c: i2c at 1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
-		};
-		sfp_1g_i2c: i2c at 2 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <2>;
-		};
-	};
-};
-
-/* J25 UART header */
-&cp0_uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&cp0_uart1_pins>;
-	status = "okay";
-};
-
-&cp0_mdio {
-	pinctrl-names = "default";
-	pinctrl-0 = <&cp0_ge_mdio_pins>;
-	status = "okay";
-
-	ge_phy: ethernet-phy at 0 {
-		reg = <0>;
-	};
-};
-
-&cp0_pcie0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&cp0_pcie_pins>;
-	num-lanes = <4>;
-	num-viewport = <8>;
-	reset-gpio = <&cp0_gpio1 20 GPIO_ACTIVE_LOW>;
-	status = "okay";
-};
-
-&cp0_pinctrl {
-	cp0_ge_mdio_pins: ge-mdio-pins {
-		marvell,pins = "mpp32", "mpp34";
-		marvell,function = "ge";
-	};
-	cp0_i2c1_pins: i2c1-pins {
-		marvell,pins = "mpp35", "mpp36";
-		marvell,function = "i2c1";
-	};
-	cp0_i2c0_pins: i2c0-pins {
-		marvell,pins = "mpp37", "mpp38";
-		marvell,function = "i2c0";
-	};
-	cp0_uart1_pins: uart1-pins {
-		marvell,pins = "mpp40", "mpp41";
-		marvell,function = "uart1";
-	};
-	cp0_xhci_vbus_pins: xhci0-vbus-pins {
-		marvell,pins = "mpp47";
-		marvell,function = "gpio";
-	};
-	cp0_sfp_1g_pins: sfp-1g-pins {
-		marvell,pins = "mpp51", "mpp53", "mpp54";
-		marvell,function = "gpio";
-	};
-	cp0_pcie_pins: pcie-pins {
-		marvell,pins = "mpp52";
-		marvell,function = "gpio";
-	};
-	cp0_sdhci_pins: sdhci-pins {
-		marvell,pins = "mpp55", "mpp56", "mpp57", "mpp58", "mpp59",
-			       "mpp60", "mpp61";
-		marvell,function = "sdio";
-	};
-	cp0_sfpp1_pins: sfpp1-pins {
-		marvell,pins = "mpp62";
-		marvell,function = "gpio";
-	};
 };
 
 &cp0_xmdio {
@@ -243,46 +30,11 @@
 	};
 };
 
-&cp0_ethernet {
-	status = "okay";
-};
-
 &cp0_eth0 {
 	status = "okay";
 	/* Network PHY */
 	phy = <&phy0>;
 	phy-mode = "10gbase-kr";
-	/* Generic PHY, providing serdes lanes */
-	phys = <&cp0_comphy4 0>;
-};
-
-&cp0_sata0 {
-	/* CPM Lane 0 - U29 */
-	status = "okay";
-};
-
-&cp0_sdhci0 {
-	/* U6 */
-	broken-cd;
-	bus-width = <4>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&cp0_sdhci_pins>;
-	status = "okay";
-	vqmmc-supply = <&v_3_3>;
-};
-
-&cp0_usb3_0 {
-	/* J38? - USB2.0 only */
-	status = "okay";
-};
-
-&cp0_usb3_1 {
-	/* J38? - USB2.0 only */
-	status = "okay";
-};
-
-&cp1_ethernet {
-	status = "okay";
 };
 
 &cp1_eth0 {
@@ -290,81 +42,4 @@
 	/* Network PHY */
 	phy = <&phy8>;
 	phy-mode = "10gbase-kr";
-	/* Generic PHY, providing serdes lanes */
-	phys = <&cp1_comphy4 0>;
-};
-
-&cp1_eth1 {
-	/* CPS Lane 0 - J5 (Gigabit RJ45) */
-	status = "okay";
-	/* Network PHY */
-	phy = <&ge_phy>;
-	phy-mode = "sgmii";
-	/* Generic PHY, providing serdes lanes */
-	phys = <&cp1_comphy0 1>;
-};
-
-&cp1_eth2 {
-	/* CPS Lane 5 */
-	status = "okay";
-	/* Network PHY */
-	phy-mode = "2500base-x";
-	managed = "in-band-status";
-	/* Generic PHY, providing serdes lanes */
-	phys = <&cp1_comphy5 2>;
-	sfp = <&sfp_eth3>;
-};
-
-&cp1_pinctrl {
-	cp1_sfpp1_pins: sfpp1-pins {
-		marvell,pins = "mpp8", "mpp10", "mpp11";
-		marvell,function = "gpio";
-	};
-	cp1_spi1_pins: spi1-pins {
-		marvell,pins = "mpp12", "mpp13", "mpp14", "mpp15", "mpp16";
-		marvell,function = "spi1";
-	};
-	cp1_uart0_pins: uart0-pins {
-		marvell,pins = "mpp6", "mpp7";
-		marvell,function = "uart0";
-	};
-	cp1_sfp_1g_pins: sfp-1g-pins {
-		marvell,pins = "mpp24";
-		marvell,function = "gpio";
-	};
-	cp1_sfpp0_pins: sfpp0-pins {
-		marvell,pins = "mpp26", "mpp27", "mpp28", "mpp29";
-		marvell,function = "gpio";
-	};
-};
-
-/* J27 UART header */
-&cp1_uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&cp1_uart0_pins>;
-	status = "okay";
-};
-
-&cp1_sata0 {
-	/* CPS Lane 1 - U32 */
-	/* CPS Lane 3 - U31 */
-	status = "okay";
-};
-
-&cp1_spi1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&cp1_spi1_pins>;
-	status = "okay";
-
-	spi-flash at 0 {
-		compatible = "st,w25q32";
-		spi-max-frequency = <50000000>;
-		reg = <0>;
-	};
-};
-
-&cp1_usb3_0 {
-	/* CPS Lane 2 - CON7 */
-	usb-phy = <&usb3h0_phy>;
-	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
new file mode 100644
index 000000000000..29ea7e81ec4c
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2016 Marvell Technology Group Ltd.
+ *
+ * Device Tree file for MACCHIATOBin Armada 8040 community board platform
+ */
+
+#include "armada-8040.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Marvell 8040 MACCHIATOBin";
+	compatible = "marvell,armada8040-mcbin", "marvell,armada8040",
+			"marvell,armada-ap806-quad", "marvell,armada-ap806";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory at 0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+
+	aliases {
+		ethernet0 = &cp0_eth0;
+		ethernet1 = &cp1_eth0;
+		ethernet2 = &cp1_eth1;
+		ethernet3 = &cp1_eth2;
+	};
+
+	/* Regulator labels correspond with schematics */
+	v_3_3: regulator-3-3v {
+		compatible = "regulator-fixed";
+		regulator-name = "v_3_3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		status = "okay";
+	};
+
+	v_vddo_h: regulator-1-8v {
+		compatible = "regulator-fixed";
+		regulator-name = "v_vddo_h";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		status = "okay";
+	};
+
+	v_5v0_usb3_hst_vbus: regulator-usb3-vbus0 {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&cp0_gpio2 15 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cp0_xhci_vbus_pins>;
+		regulator-name = "v_5v0_usb3_hst_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		status = "okay";
+	};
+
+	usb3h0_phy: usb3_phy0 {
+		compatible = "usb-nop-xceiv";
+		vcc-supply = <&v_5v0_usb3_hst_vbus>;
+	};
+
+	sfp_eth0: sfp-eth0 {
+		/* CON15,16 - CPM lane 4 */
+		compatible = "sff,sfp";
+		i2c-bus = <&sfpp0_i2c>;
+		los-gpio = <&cp1_gpio1 28 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpio = <&cp1_gpio1 27 GPIO_ACTIVE_LOW>;
+		tx-disable-gpio = <&cp1_gpio1 29 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpio  = <&cp1_gpio1 26 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cp1_sfpp0_pins>;
+	};
+
+	sfp_eth1: sfp-eth1 {
+		/* CON17,18 - CPS lane 4 */
+		compatible = "sff,sfp";
+		i2c-bus = <&sfpp1_i2c>;
+		los-gpio = <&cp1_gpio1 8 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpio = <&cp1_gpio1 11 GPIO_ACTIVE_LOW>;
+		tx-disable-gpio = <&cp1_gpio1 10 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpio = <&cp0_gpio2 30 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cp1_sfpp1_pins &cp0_sfpp1_pins>;
+	};
+
+	sfp_eth3: sfp-eth3 {
+		/* CON13,14 - CPS lane 5 */
+		compatible = "sff,sfp";
+		i2c-bus = <&sfp_1g_i2c>;
+		los-gpio = <&cp0_gpio2 22 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpio = <&cp0_gpio2 21 GPIO_ACTIVE_LOW>;
+		tx-disable-gpio = <&cp1_gpio1 24 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpio = <&cp0_gpio2 19 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cp0_sfp_1g_pins &cp1_sfp_1g_pins>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+	pinctrl-0 = <&uart0_pins>;
+	pinctrl-names = "default";
+};
+
+&ap_sdhci0 {
+	bus-width = <8>;
+	/*
+	 * Not stable in HS modes - phy needs "more calibration", so add
+	 * the "slow-mode" and disable SDR104, SDR50 and DDR50 modes.
+	 */
+	marvell,xenon-phy-slow-mode;
+	no-1-8-v;
+	no-sd;
+	no-sdio;
+	non-removable;
+	status = "okay";
+	vqmmc-supply = <&v_vddo_h>;
+};
+
+&cp0_i2c0 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_i2c0_pins>;
+	status = "okay";
+};
+
+&cp0_i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_i2c1_pins>;
+	status = "okay";
+
+	i2c-switch at 70 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x70>;
+
+		sfpp0_i2c: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+		sfpp1_i2c: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+		sfp_1g_i2c: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+	};
+};
+
+/* J25 UART header */
+&cp0_uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_uart1_pins>;
+	status = "okay";
+};
+
+&cp0_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_ge_mdio_pins>;
+	status = "okay";
+
+	ge_phy: ethernet-phy at 0 {
+		reg = <0>;
+	};
+};
+
+&cp0_pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_pcie_pins>;
+	num-lanes = <4>;
+	num-viewport = <8>;
+	reset-gpio = <&cp0_gpio1 20 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&cp0_pinctrl {
+	cp0_ge_mdio_pins: ge-mdio-pins {
+		marvell,pins = "mpp32", "mpp34";
+		marvell,function = "ge";
+	};
+	cp0_i2c1_pins: i2c1-pins {
+		marvell,pins = "mpp35", "mpp36";
+		marvell,function = "i2c1";
+	};
+	cp0_i2c0_pins: i2c0-pins {
+		marvell,pins = "mpp37", "mpp38";
+		marvell,function = "i2c0";
+	};
+	cp0_uart1_pins: uart1-pins {
+		marvell,pins = "mpp40", "mpp41";
+		marvell,function = "uart1";
+	};
+	cp0_xhci_vbus_pins: xhci0-vbus-pins {
+		marvell,pins = "mpp47";
+		marvell,function = "gpio";
+	};
+	cp0_sfp_1g_pins: sfp-1g-pins {
+		marvell,pins = "mpp51", "mpp53", "mpp54";
+		marvell,function = "gpio";
+	};
+	cp0_pcie_pins: pcie-pins {
+		marvell,pins = "mpp52";
+		marvell,function = "gpio";
+	};
+	cp0_sdhci_pins: sdhci-pins {
+		marvell,pins = "mpp55", "mpp56", "mpp57", "mpp58", "mpp59",
+			       "mpp60", "mpp61";
+		marvell,function = "sdio";
+	};
+	cp0_sfpp1_pins: sfpp1-pins {
+		marvell,pins = "mpp62";
+		marvell,function = "gpio";
+	};
+};
+
+&cp0_ethernet {
+	status = "okay";
+};
+
+&cp0_eth0 {
+	/* Generic PHY, providing serdes lanes */
+	phys = <&cp0_comphy4 0>;
+};
+
+&cp0_sata0 {
+	/* CPM Lane 0 - U29 */
+	status = "okay";
+};
+
+&cp0_sdhci0 {
+	/* U6 */
+	broken-cd;
+	bus-width = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_sdhci_pins>;
+	status = "okay";
+	vqmmc-supply = <&v_3_3>;
+};
+
+&cp0_usb3_0 {
+	/* J38? - USB2.0 only */
+	status = "okay";
+};
+
+&cp0_usb3_1 {
+	/* J38? - USB2.0 only */
+	status = "okay";
+};
+
+&cp1_ethernet {
+	status = "okay";
+};
+
+&cp1_eth0 {
+	/* Generic PHY, providing serdes lanes */
+	phys = <&cp1_comphy4 0>;
+};
+
+&cp1_eth1 {
+	/* CPS Lane 0 - J5 (Gigabit RJ45) */
+	status = "okay";
+	/* Network PHY */
+	phy = <&ge_phy>;
+	phy-mode = "sgmii";
+	/* Generic PHY, providing serdes lanes */
+	phys = <&cp1_comphy0 1>;
+};
+
+&cp1_eth2 {
+	/* CPS Lane 5 */
+	status = "okay";
+	/* Network PHY */
+	phy-mode = "2500base-x";
+	managed = "in-band-status";
+	/* Generic PHY, providing serdes lanes */
+	phys = <&cp1_comphy5 2>;
+	sfp = <&sfp_eth3>;
+};
+
+&cp1_pinctrl {
+	cp1_sfpp1_pins: sfpp1-pins {
+		marvell,pins = "mpp8", "mpp10", "mpp11";
+		marvell,function = "gpio";
+	};
+	cp1_spi1_pins: spi1-pins {
+		marvell,pins = "mpp12", "mpp13", "mpp14", "mpp15", "mpp16";
+		marvell,function = "spi1";
+	};
+	cp1_uart0_pins: uart0-pins {
+		marvell,pins = "mpp6", "mpp7";
+		marvell,function = "uart0";
+	};
+	cp1_sfp_1g_pins: sfp-1g-pins {
+		marvell,pins = "mpp24";
+		marvell,function = "gpio";
+	};
+	cp1_sfpp0_pins: sfpp0-pins {
+		marvell,pins = "mpp26", "mpp27", "mpp28", "mpp29";
+		marvell,function = "gpio";
+	};
+};
+
+/* J27 UART header */
+&cp1_uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp1_uart0_pins>;
+	status = "okay";
+};
+
+&cp1_sata0 {
+	/* CPS Lane 1 - U32 */
+	/* CPS Lane 3 - U31 */
+	status = "okay";
+};
+
+&cp1_spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp1_spi1_pins>;
+	status = "okay";
+
+	spi-flash at 0 {
+		compatible = "st,w25q32";
+		spi-max-frequency = <50000000>;
+		reg = <0>;
+	};
+};
+
+&cp1_usb3_0 {
+	/* CPS Lane 2 - CON7 */
+	usb-phy = <&usb3h0_phy>;
+	status = "okay";
+};
-- 
2.7.4
