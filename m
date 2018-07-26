From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu, 26 Jul 2018 16:02:57 +1200
Subject: [PATCH 4/4] ARM: dts: mvebu: Add device tree for db-88f6820-amc board
In-Reply-To: <20180726040257.22285-1-chris.packham@alliedtelesis.co.nz>
References: <20180726040257.22285-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20180726040257.22285-5-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This board is a plugin card for some of Marvell's switch development
kits. It's similar to the non-amc board except that it has no SATA
support.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/armada-385-db-88f6820-amc.dts    | 147 ++++++++++++++++++
 2 files changed, 148 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-385-db-88f6820-amc.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 37a3de760d40..e4212b7b7d9e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1126,6 +1126,7 @@ dtb-$(CONFIG_MACH_ARMADA_370) += \
 dtb-$(CONFIG_MACH_ARMADA_375) += \
 	armada-375-db.dtb
 dtb-$(CONFIG_MACH_ARMADA_38X) += \
+	armada-385-db-88f6820-amc.dtb \
 	armada-385-db-ap.dtb \
 	armada-385-linksys-caiman.dtb \
 	armada-385-linksys-cobra.dtb \
diff --git a/arch/arm/boot/dts/armada-385-db-88f6820-amc.dts b/arch/arm/boot/dts/armada-385-db-88f6820-amc.dts
new file mode 100644
index 000000000000..d87614057e3f
--- /dev/null
+++ b/arch/arm/boot/dts/armada-385-db-88f6820-amc.dts
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Device Tree file for Marvell Armada 385 AMC board
+ * (DB-88F6820-AMC)
+ *
+ * Copyright (C) 2017 Allied Telesis Labs
+ */
+
+/dts-v1/;
+#include "armada-385.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Marvell Armada 385 AMC";
+	compatible = "marvell,a385-db-amc", "marvell,armada385", "marvell,armada380";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	aliases {
+		ethernet0 = &eth0;
+		ethernet1 = &eth1;
+		spi1 = &spi1;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x80000000>; /* 2GB */
+	};
+
+	soc {
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
+			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000>;
+	};
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	status = "okay";
+};
+
+&uart0 {
+	/*
+	 * Exported on the micro USB connector CON3
+	 * through an FTDI
+	 */
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
+	status = "okay";
+};
+
+
+&eth0 {
+	pinctrl-names = "default";
+	/*
+	 * The Reference Clock 0 is used to provide a
+	 * clock to the PHY
+	 */
+	pinctrl-0 = <&ge0_rgmii_pins>, <&ref_clk0_pins>;
+	status = "okay";
+	phy = <&phy0>;
+	phy-mode = "rgmii-id";
+};
+
+&eth2 {
+	status = "okay";
+	phy = <&phy1>;
+	phy-mode = "sgmii";
+};
+
+&usb0 {
+	status = "okay";
+};
+
+
+
+&mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mdio_pins>;
+
+	phy0: ethernet-phy at 1 {
+		reg = <1>;
+	};
+
+	phy1: ethernet-phy at 0 {
+		reg = <0>;
+	};
+};
+
+&nand_controller {
+	status = "okay";
+
+	nand at 0 {
+		reg = <0>;
+		label = "pxa3xx_nand-0";
+		nand-rb = <0>;
+		nand-on-flash-bbt;
+		nand-ecc-strength = <4>;
+		nand-ecc-step-size = <512>;
+
+		partition at user {
+			reg = <0x00000000 0x40000000>;
+			label = "user";
+		};
+	};
+};
+
+&pciec {
+	status = "okay";
+};
+
+&pcie1 {
+	/* Port 0, Lane 0 */
+	status = "okay";
+};
+
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_pins>;
+	status = "okay";
+
+	spi-flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>; /* Chip select 0 */
+		spi-max-frequency = <50000000>;
+		m25p,fast-read;
+
+		partition at u-boot {
+			reg = <0x00000000 0x00100000>;
+			label = "u-boot";
+		};
+		partition at u-boot-env {
+			reg = <0x00100000 0x00040000>;
+			label = "u-boot-env";
+		};
+	};
+};
+
+&refclk {
+	clock-frequency = <20000000>;
+};
-- 
2.18.0
