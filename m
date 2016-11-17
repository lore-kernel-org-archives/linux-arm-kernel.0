From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Nov 2016 00:08:19 +0100
Subject: [PATCH v3 02/13] ARM: dts: armada-375: Use the node labels
In-Reply-To: <20161117230830.31047-1-gregory.clement@free-electrons.com>
References: <20161117230830.31047-1-gregory.clement@free-electrons.com>
Message-ID: <20161117230830.31047-3-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the node label when possible. As a result it flattens the device tree

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-375-db.dts | 269 ++++++++++++++++++------------------
 1 file changed, 136 insertions(+), 133 deletions(-)

diff --git a/arch/arm/boot/dts/armada-375-db.dts b/arch/arm/boot/dts/armada-375-db.dts
index cded5f0a262d..b33a674088ed 100644
--- a/arch/arm/boot/dts/armada-375-db.dts
+++ b/arch/arm/boot/dts/armada-375-db.dts
@@ -69,138 +69,141 @@
 			  MBUS_ID(0x09, 0x09) 0 0xf1100000 0x10000
 			  MBUS_ID(0x09, 0x05) 0 0xf1110000 0x10000>;
 
-		internal-regs {
-			spi at 10600 {
-				pinctrl-0 = <&spi0_pins>;
-				pinctrl-names = "default";
-				/*
-				 * SPI conflicts with NAND, so we disable it
-				 * here, and select NAND as the enabled device
-				 * by default.
-				 */
-				status = "disabled";
-
-				spi-flash at 0 {
-					#address-cells = <1>;
-					#size-cells = <1>;
-					compatible = "n25q128a13", "jedec,spi-nor";
-					reg = <0>; /* Chip select 0 */
-					spi-max-frequency = <108000000>;
-				};
-			};
-
-			i2c at 11000 {
-				status = "okay";
-				clock-frequency = <100000>;
-				pinctrl-0 = <&i2c0_pins>;
-				pinctrl-names = "default";
-			};
-
-			i2c at 11100 {
-				status = "okay";
-				clock-frequency = <100000>;
-				pinctrl-0 = <&i2c1_pins>;
-				pinctrl-names = "default";
-			};
-
-			serial at 12000 {
-				status = "okay";
-			};
-
-			pinctrl {
-				sdio_st_pins: sdio-st-pins {
-					marvell,pins = "mpp44", "mpp45";
-					marvell,function = "gpio";
-				};
-			};
-
-			sata at a0000 {
-				status = "okay";
-				nr-ports = <2>;
-			};
-
-			nand: nand at d0000 {
-				pinctrl-0 = <&nand_pins>;
-				pinctrl-names = "default";
-				status = "okay";
-				num-cs = <1>;
-				marvell,nand-keep-config;
-				marvell,nand-enable-arbiter;
-				nand-on-flash-bbt;
-				nand-ecc-strength = <4>;
-				nand-ecc-step-size = <512>;
-
-				partition at 0 {
-					label = "U-Boot";
-					reg = <0 0x800000>;
-				};
-				partition at 800000 {
-					label = "Linux";
-					reg = <0x800000 0x800000>;
-				};
-				partition at 1000000 {
-					label = "Filesystem";
-					reg = <0x1000000 0x3f000000>;
-				};
-			};
-
-			usb at 54000 {
-				status = "okay";
-			};
-
-			usb3 at 58000 {
-				status = "okay";
-			};
-
-			mvsdio at d4000 {
-				pinctrl-0 = <&sdio_pins &sdio_st_pins>;
-				pinctrl-names = "default";
-				status = "okay";
-				cd-gpios = <&gpio1 12 GPIO_ACTIVE_HIGH>;
-				wp-gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
-			};
-
-			mdio {
-				phy0: ethernet-phy at 0 {
-					reg = <0>;
-				};
-
-				phy3: ethernet-phy at 3 {
-					reg = <3>;
-				};
-			};
-
-			ethernet at f0000 {
-				status = "okay";
-
-				eth0 at c4000 {
-					status = "okay";
-					phy = <&phy0>;
-					phy-mode = "rgmii-id";
-				};
-
-				eth1 at c5000 {
-					status = "okay";
-					phy = <&phy3>;
-					phy-mode = "gmii";
-				};
-			};
-		};
-
-		pcie-controller {
-			status = "okay";
-			/*
-			 * The two PCIe units are accessible through
-			 * standard PCIe slots on the board.
-			 */
-			pcie at 1,0 {
-				/* Port 0, Lane 0 */
-				status = "okay";
-			};
-			pcie at 2,0 {
-				/* Port 1, Lane 0 */
-				status = "okay";
-			};
-		};
 	};
 };
+&pciec {
+	status = "okay";
+};
+
+/*
+ * The two PCIe units are accessible through
+ * standard PCIe slots on the board.
+ */
+&pcie0 {
+	/* Port 0, Lane 0 */
+	status = "okay";
+};
+
+&pcie1 {
+	/* Port 1, Lane 0 */
+	status = "okay";
+};
+
+
+&spi0 {
+	pinctrl-0 = <&spi0_pins>;
+	pinctrl-names = "default";
+
+	/*
+	 * SPI conflicts with NAND, so we disable it here, and
+	 * select NAND as the enabled device by default.
+	 */
+
+	status = "disabled";
+
+	spi-flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "n25q128a13", "jedec,spi-nor";
+		reg = <0>; /* Chip select 0 */
+		spi-max-frequency = <108000000>;
+	};
+};
+
+&i2c0 {
+	status = "okay";
+	clock-frequency = <100000>;
+	pinctrl-0 = <&i2c0_pins>;
+	pinctrl-names = "default";
+};
+
+&i2c1 {
+	status = "okay";
+	clock-frequency = <100000>;
+	pinctrl-0 = <&i2c1_pins>;
+	pinctrl-names = "default";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&pinctrl {
+	sdio_st_pins: sdio-st-pins {
+		marvell,pins = "mpp44", "mpp45";
+		marvell,function = "gpio";
+	};
+};
+
+&sata {
+	status = "okay";
+	nr-ports = <2>;
+};
+
+&nand {
+	pinctrl-0 = <&nand_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+	num-cs = <1>;
+	marvell,nand-keep-config;
+	marvell,nand-enable-arbiter;
+	nand-on-flash-bbt;
+	nand-ecc-strength = <4>;
+	nand-ecc-step-size = <512>;
+
+	partition at 0 {
+		label = "U-Boot";
+		reg = <0 0x800000>;
+	};
+	partition at 800000 {
+		label = "Linux";
+		reg = <0x800000 0x800000>;
+	};
+	partition at 1000000 {
+		label = "Filesystem";
+		reg = <0x1000000 0x3f000000>;
+	};
+};
+
+&usb1 {
+	status = "okay";
+};
+
+&usb2 {
+	status = "okay";
+};
+
+&sdio {
+	pinctrl-0 = <&sdio_pins &sdio_st_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+	cd-gpios = <&gpio1 12 GPIO_ACTIVE_HIGH>;
+	wp-gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
+};
+
+&mdio {
+	phy0: ethernet-phy at 0 {
+		reg = <0>;
+	};
+
+	phy3: ethernet-phy at 3 {
+		reg = <3>;
+	};
+};
+
+&ethernet {
+	status = "okay";
+};
+
+
+&eth0 {
+	status = "okay";
+	phy = <&phy0>;
+	phy-mode = "rgmii-id";
+};
+
+&eth1 {
+	status = "okay";
+	phy = <&phy3>;
+	phy-mode = "gmii";
+};
-- 
2.10.2
