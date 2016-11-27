From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 27 Nov 2016 19:51:39 +0100
Subject: [PATCH] ARM: dts: mvebu: Add Armada 38x labels and clean up Turris
 Omnia
In-Reply-To: <1fc18002-0144-8300-1888-09f456860ef0@kleine-koenig.org>
References: <1fc18002-0144-8300-1888-09f456860ef0@kleine-koenig.org>
Message-ID: <1480272700-28888-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To more consistently reference nodes by label, add labels for sata,
usb2, sdhci and usb3 nodes.

Convert all other 38x boards for consistency. Add labels for nfc and rtc.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/armada-385-db-ap.dts             | 334 +++++++------
 arch/arm/boot/dts/armada-385-linksys-caiman.dts    |  98 ++--
 arch/arm/boot/dts/armada-385-linksys-cobra.dts     |  98 ++--
 arch/arm/boot/dts/armada-385-linksys.dtsi          | 294 ++++++-----
 arch/arm/boot/dts/armada-385-turris-omnia.dts      |  97 ++--
 arch/arm/boot/dts/armada-385.dtsi                  |  20 +-
 arch/arm/boot/dts/armada-388-clearfog.dts          | 550 ++++++++++-----------
 arch/arm/boot/dts/armada-388-db.dts                | 236 ++++-----
 arch/arm/boot/dts/armada-388-gp.dts                | 403 ++++++++-------
 arch/arm/boot/dts/armada-388-rd.dts                | 115 +++--
 arch/arm/boot/dts/armada-388.dtsi                  |  19 +-
 .../arm/boot/dts/armada-38x-solidrun-microsom.dtsi | 111 ++---
 arch/arm/boot/dts/armada-38x.dtsi                  |  16 +-
 13 files changed, 1170 insertions(+), 1221 deletions(-)

diff --git a/arch/arm/boot/dts/armada-385-db-ap.dts b/arch/arm/boot/dts/armada-385-db-ap.dts
index db5b9f6..9b67716 100644
--- a/arch/arm/boot/dts/armada-385-db-ap.dts
+++ b/arch/arm/boot/dts/armada-385-db-ap.dts
@@ -63,174 +63,6 @@
 			  MBUS_ID(0x09, 0x19) 0 0xf1100000 0x10000
 			  MBUS_ID(0x09, 0x15) 0 0xf1110000 0x10000
 			  MBUS_ID(0x0c, 0x04) 0 0xf1200000 0x100000>;
-
-		internal-regs {
-			i2c0: i2c at 11000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&i2c0_pins>;
-				status = "okay";
-
-				/*
-				 * This bus is wired to two EEPROM
-				 * sockets, one of which holding the
-				 * board ID used by the	bootloader.
-				 * Erasing this EEPROM's content will
-				 * brick the board.
-				 * Use this bus with caution.
-				 */
-			};
-
-			mdio at 72004 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&mdio_pins>;
-
-				phy0: ethernet-phy at 1 {
-					reg = <1>;
-				};
-
-				phy1: ethernet-phy at 4 {
-					reg = <4>;
-				};
-
-				phy2: ethernet-phy at 6 {
-					reg = <6>;
-				};
-			};
-
-			/* UART0 is exposed through the JP8 connector */
-			uart0: serial at 12000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&uart0_pins>;
-				status = "okay";
-			};
-
-			/*
-			 * UART1 is exposed through a FTDI chip
-			 * wired to the mini-USB connector
-			 */
-			uart1: serial at 12100 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&uart1_pins>;
-				status = "okay";
-			};
-
-			pinctrl at 18000 {
-				xhci0_vbus_pins: xhci0-vbus-pins {
-					marvell,pins = "mpp44";
-					marvell,function = "gpio";
-				};
-			};
-
-			/* CON3 */
-			ethernet at 30000 {
-				status = "okay";
-				phy = <&phy2>;
-				phy-mode = "sgmii";
-				buffer-manager = <&bm>;
-				bm,pool-long = <1>;
-				bm,pool-short = <3>;
-			};
-
-			/* CON2 */
-			ethernet at 34000 {
-				status = "okay";
-				phy = <&phy1>;
-				phy-mode = "sgmii";
-				buffer-manager = <&bm>;
-				bm,pool-long = <2>;
-				bm,pool-short = <3>;
-			};
-
-			usb at 58000 {
-				status = "okay";
-			};
-
-			/* CON4 */
-			ethernet at 70000 {
-				pinctrl-names = "default";
-
-				/*
-				 * The Reference Clock 0 is used to
-				 * provide a clock to the PHY
-				 */
-				pinctrl-0 = <&ge0_rgmii_pins>, <&ref_clk0_pins>;
-				status = "okay";
-				phy = <&phy0>;
-				phy-mode = "rgmii-id";
-				buffer-manager = <&bm>;
-				bm,pool-long = <0>;
-				bm,pool-short = <3>;
-			};
-
-			bm at c8000 {
-				status = "okay";
-			};
-
-			nfc: flash at d0000 {
-				status = "okay";
-				num-cs = <1>;
-				nand-ecc-strength = <4>;
-				nand-ecc-step-size = <512>;
-				marvell,nand-keep-config;
-				marvell,nand-enable-arbiter;
-				nand-on-flash-bbt;
-
-				partitions {
-					compatible = "fixed-partitions";
-					#address-cells = <1>;
-					#size-cells = <1>;
-
-					partition at 0 {
-						label = "U-Boot";
-						reg = <0x00000000 0x00800000>;
-						read-only;
-					};
-
-					partition at 800000 {
-						label = "uImage";
-						reg = <0x00800000 0x00400000>;
-						read-only;
-					};
-
-					partition at c00000 {
-						label = "Root";
-						reg = <0x00c00000 0x3f400000>;
-					};
-				};
-			};
-
-			usb3 at f0000 {
-				status = "okay";
-				usb-phy = <&usb3_phy>;
-			};
-		};
-
-		bm-bppi {
-			status = "okay";
-		};
-
-		pcie-controller {
-			status = "okay";
-
-			/*
-			 * The three PCIe units are accessible through
-			 * standard mini-PCIe slots on the board.
-			 */
-			pcie at 1,0 {
-				/* Port 0, Lane 0 */
-				status = "okay";
-			};
-
-			pcie at 2,0 {
-				/* Port 1, Lane 0 */
-				status = "okay";
-			};
-
-			pcie at 3,0 {
-				/* Port 2, Lane 0 */
-				status = "okay";
-			};
-		};
 	};
 
 	usb3_phy: usb3_phy {
@@ -250,6 +82,150 @@
 	};
 };
 
+&bm {
+	status = "okay";
+};
+
+&bm_bppi {
+	status = "okay";
+};
+
+&ehci {
+	status = "okay";
+};
+
+/* CON4 */
+&eth0 {
+	pinctrl-names = "default";
+
+	/*
+	 * The Reference Clock 0 is used to
+	 * provide a clock to the PHY
+	 */
+	pinctrl-0 = <&ge0_rgmii_pins>, <&ref_clk0_pins>;
+	status = "okay";
+	phy = <&phy0>;
+	phy-mode = "rgmii-id";
+	buffer-manager = <&bm>;
+	bm,pool-long = <0>;
+	bm,pool-short = <3>;
+};
+
+/* CON3 */
+&eth1 {
+	status = "okay";
+	phy = <&phy2>;
+	phy-mode = "sgmii";
+	buffer-manager = <&bm>;
+	bm,pool-long = <1>;
+	bm,pool-short = <3>;
+};
+
+/* CON2 */
+&eth2 {
+	status = "okay";
+	phy = <&phy1>;
+	phy-mode = "sgmii";
+	buffer-manager = <&bm>;
+	bm,pool-long = <2>;
+	bm,pool-short = <3>;
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	status = "okay";
+
+	/*
+	 * This bus is wired to two EEPROM
+	 * sockets, one of which holding the
+	 * board ID used by the	bootloader.
+	 * Erasing this EEPROM's content will
+	 * brick the board.
+	 * Use this bus with caution.
+	 */
+};
+
+&mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mdio_pins>;
+
+	phy0: ethernet-phy at 1 {
+		reg = <1>;
+	};
+
+	phy1: ethernet-phy at 4 {
+		reg = <4>;
+	};
+
+	phy2: ethernet-phy at 6 {
+		reg = <6>;
+	};
+};
+
+&nfc {
+	status = "okay";
+	num-cs = <1>;
+	nand-ecc-strength = <4>;
+	nand-ecc-step-size = <512>;
+	marvell,nand-keep-config;
+	marvell,nand-enable-arbiter;
+	nand-on-flash-bbt;
+
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition at 0 {
+			label = "U-Boot";
+			reg = <0x00000000 0x00800000>;
+			read-only;
+		};
+
+		partition at 800000 {
+			label = "uImage";
+			reg = <0x00800000 0x00400000>;
+			read-only;
+		};
+
+		partition at c00000 {
+			label = "Root";
+			reg = <0x00c00000 0x3f400000>;
+		};
+	};
+};
+
+&pcie {
+	status = "okay";
+};
+
+/*
+ * The three PCIe units are accessible through
+ * standard mini-PCIe slots on the board.
+ */
+&pcie1 {
+	/* Port 0, Lane 0 */
+	status = "okay";
+};
+
+&pcie2 {
+	/* Port 1, Lane 0 */
+	status = "okay";
+};
+
+&pcie3 {
+	/* Port 2, Lane 0 */
+	status = "okay";
+};
+
+&pinctrl {
+	xhci0_vbus_pins: xhci0-vbus-pins {
+		marvell,pins = "mpp44";
+		marvell,function = "gpio";
+	};
+};
+
 &spi1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi1_pins>;
@@ -263,3 +239,25 @@
 		spi-max-frequency = <54000000>;
 	};
 };
+
+/* UART0 is exposed through the JP8 connector */
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
+	status = "okay";
+};
+
+/*
+ * UART1 is exposed through a FTDI chip
+ * wired to the mini-USB connector
+ */
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+	status = "okay";
+};
+
+&xhci0 {
+	status = "okay";
+	usb-phy = <&usb3_phy>;
+};
diff --git a/arch/arm/boot/dts/armada-385-linksys-caiman.dts b/arch/arm/boot/dts/armada-385-linksys-caiman.dts
index f3cee91..7869fec 100644
--- a/arch/arm/boot/dts/armada-385-linksys-caiman.dts
+++ b/arch/arm/boot/dts/armada-385-linksys-caiman.dts
@@ -44,71 +44,59 @@
 	model = "Linksys WRT1200AC";
 	compatible = "linksys,caiman", "linksys,armada385", "marvell,armada385",
 		     "marvell,armada380";
+};
 
-	soc {
-		internal-regs{
-			i2c at 11000 {
-
-				pca9635 at 68 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-					wan_amber at 0 {
-						label = "caiman:amber:wan";
-						reg = <0x0>;
-					};
+&pca9635 {
+	wan_amber at 0 {
+		label = "caiman:amber:wan";
+		reg = <0x0>;
+	};
 
-					wan_white at 1 {
-						label = "caiman:white:wan";
-						reg = <0x1>;
-					};
+	wan_white at 1 {
+		label = "caiman:white:wan";
+		reg = <0x1>;
+	};
 
-					wlan_2g at 2 {
-						label = "caiman:white:wlan_2g";
-						reg = <0x2>;
-					};
+	wlan_2g at 2 {
+		label = "caiman:white:wlan_2g";
+		reg = <0x2>;
+	};
 
-					wlan_5g at 3 {
-						label = "caiman:white:wlan_5g";
-						reg = <0x3>;
-					};
+	wlan_5g at 3 {
+		label = "caiman:white:wlan_5g";
+		reg = <0x3>;
+	};
 
-					usb2 at 5 {
-						label = "caiman:white:usb2";
-						reg = <0x5>;
-					};
+	usb2 at 5 {
+		label = "caiman:white:usb2";
+		reg = <0x5>;
+	};
 
-					usb3_1 at 6 {
-						label = "caiman:white:usb3_1";
-						reg = <0x6>;
-					};
+	usb3_1 at 6 {
+		label = "caiman:white:usb3_1";
+		reg = <0x6>;
+	};
 
-					usb3_2 at 7 {
-						label = "caiman:white:usb3_2";
-						reg = <0x7>;
-					};
+	usb3_2 at 7 {
+		label = "caiman:white:usb3_2";
+		reg = <0x7>;
+	};
 
-					wps_white at 8 {
-						label = "caiman:white:wps";
-						reg = <0x8>;
-					};
+	wps_white at 8 {
+		label = "caiman:white:wps";
+		reg = <0x8>;
+	};
 
-					wps_amber at 9 {
-						label = "caiman:amber:wps";
-						reg = <0x9>;
-					};
-				};
-			};
-		};
+	wps_amber at 9 {
+		label = "caiman:amber:wps";
+		reg = <0x9>;
 	};
+};
 
-	gpio-leds {
-		power {
-			label = "caiman:white:power";
-		};
+&power_led {
+	label = "caiman:white:power";
+};
 
-		sata {
-			label = "caiman:white:sata";
-		};
-	};
+&sata_led {
+	label = "caiman:white:sata";
 };
diff --git a/arch/arm/boot/dts/armada-385-linksys-cobra.dts b/arch/arm/boot/dts/armada-385-linksys-cobra.dts
index 1110718..94cdc09 100644
--- a/arch/arm/boot/dts/armada-385-linksys-cobra.dts
+++ b/arch/arm/boot/dts/armada-385-linksys-cobra.dts
@@ -44,71 +44,59 @@
 	model = "Linksys WRT1900ACv2";
 	compatible = "linksys,cobra", "linksys,armada385", "marvell,armada385",
 		     "marvell,armada380";
+};
 
-	soc {
-		internal-regs{
-			i2c at 11000 {
-
-				pca9635 at 68 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-					wan_amber at 0 {
-						label = "cobra:amber:wan";
-						reg = <0x0>;
-					};
+&pca9635 {
+	wan_amber at 0 {
+		label = "cobra:amber:wan";
+		reg = <0x0>;
+	};
 
-					wan_white at 1 {
-						label = "cobra:white:wan";
-						reg = <0x1>;
-					};
+	wan_white at 1 {
+		label = "cobra:white:wan";
+		reg = <0x1>;
+	};
 
-					wlan_2g at 2 {
-						label = "cobra:white:wlan_2g";
-						reg = <0x2>;
-					};
+	wlan_2g at 2 {
+		label = "cobra:white:wlan_2g";
+		reg = <0x2>;
+	};
 
-					wlan_5g at 3 {
-						label = "cobra:white:wlan_5g";
-						reg = <0x3>;
-					};
+	wlan_5g at 3 {
+		label = "cobra:white:wlan_5g";
+		reg = <0x3>;
+	};
 
-					usb2 at 5 {
-						label = "cobra:white:usb2";
-						reg = <0x5>;
-					};
+	usb2 at 5 {
+		label = "cobra:white:usb2";
+		reg = <0x5>;
+	};
 
-					usb3_1 at 6 {
-						label = "cobra:white:usb3_1";
-						reg = <0x6>;
-					};
+	usb3_1 at 6 {
+		label = "cobra:white:usb3_1";
+		reg = <0x6>;
+	};
 
-					usb3_2 at 7 {
-						label = "cobra:white:usb3_2";
-						reg = <0x7>;
-					};
+	usb3_2 at 7 {
+		label = "cobra:white:usb3_2";
+		reg = <0x7>;
+	};
 
-					wps_white at 8 {
-						label = "cobra:white:wps";
-						reg = <0x8>;
-					};
+	wps_white at 8 {
+		label = "cobra:white:wps";
+		reg = <0x8>;
+	};
 
-					wps_amber at 9 {
-						label = "cobra:amber:wps";
-						reg = <0x9>;
-					};
-				};
-			};
-		};
+	wps_amber at 9 {
+		label = "cobra:amber:wps";
+		reg = <0x9>;
 	};
+};
 
-	gpio-leds {
-		power {
-			label = "cobra:white:power";
-		};
+&power_led {
+	label = "cobra:white:power";
+};
 
-		sata {
-			label = "cobra:white:sata";
-		};
-	};
+&sata_led {
+	label = "cobra:white:sata";
 };
diff --git a/arch/arm/boot/dts/armada-385-linksys.dtsi b/arch/arm/boot/dts/armada-385-linksys.dtsi
index 8f0e508..67341e4 100644
--- a/arch/arm/boot/dts/armada-385-linksys.dtsi
+++ b/arch/arm/boot/dts/armada-385-linksys.dtsi
@@ -60,152 +60,6 @@
 			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x19) 0 0xf1100000 0x10000
 			  MBUS_ID(0x09, 0x15) 0 0xf1110000 0x10000>;
-
-		internal-regs {
-			i2c at 11000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&i2c0_pins>;
-				status = "okay";
-
-				tmp421 at 4c {
-					compatible = "ti,tmp421";
-					reg = <0x4c>;
-				};
-
-				pca9635 at 68 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					compatible = "nxp,pca9635";
-					reg = <0x68>;
-				};
-			};
-
-			/* J10: VCC, NC, RX, NC, TX, GND  */
-			serial at 12000 {
-				status = "okay";
-			};
-
-			ethernet at 70000 {
-				status = "okay";
-				phy-mode = "rgmii-id";
-				fixed-link {
-					speed = <1000>;
-					full-duplex;
-				};
-			};
-
-			ethernet at 34000 {
-				status = "okay";
-				phy-mode = "sgmii";
-				fixed-link {
-					speed = <1000>;
-					full-duplex;
-				};
-			};
-
-			mdio {
-				status = "okay";
-			};
-
-			sata at a8000 {
-				status = "okay";
-			};
-
-			/* USB part of the eSATA/USB 2.0 port */
-			usb at 58000 {
-				status = "okay";
-			};
-
-			usb3 at f8000 {
-				status = "okay";
-				usb-phy = <&usb3_phy>;
-			};
-
-			flash at d0000 {
-				status = "okay";
-				num-cs = <1>;
-				marvell,nand-keep-config;
-				marvell,nand-enable-arbiter;
-				nand-on-flash-bbt;
-
-				partition at 0 {
-					label = "u-boot";
-					reg = <0x0000000 0x200000>;  /* 2MB */
-					read-only;
-				};
-
-				partition at 100000 {
-					label = "u_env";
-					reg = <0x200000 0x40000>;    /* 256KB */
-				};
-
-				partition at 140000 {
-					label = "s_env";
-					reg = <0x240000 0x40000>;    /* 256KB */
-				};
-
-				partition at 900000 {
-					label = "devinfo";
-					reg = <0x900000 0x100000>;   /* 1MB */
-					read-only;
-				};
-
-				/* kernel1 overlaps with rootfs1 by design */
-				partition at a00000 {
-					label = "kernel1";
-					reg = <0xa00000 0x2800000>;  /* 40MB */
-				};
-
-				partition at 1000000 {
-					label = "rootfs1";
-					reg = <0x1000000 0x2200000>;  /* 34MB */
-				};
-
-				/* kernel2 overlaps with rootfs2 by design */
-				partition at 3200000 {
-					label = "kernel2";
-					reg = <0x3200000 0x2800000>; /* 40MB */
-				};
-
-				partition at 3800000 {
-					label = "rootfs2";
-					reg = <0x3800000 0x2200000>; /* 34MB */
-				};
-
-				/*
-				 * 38MB, last MB is for the BBT, not writable
-				 */
-				partition at 5a00000 {
-					label = "syscfg";
-					reg = <0x5a00000 0x2600000>;
-				};
-
-				/*
-				 * Unused area between "s_env" and "devinfo".
-				 * Moved here because otherwise the renumbered
-				 * partitions would break the bootloader
-				 * supplied bootargs
-				 */
-				partition at 180000 {
-					label = "unused_area";
-					reg = <0x280000 0x680000>;   /* 6.5MB */
-				};
-			};
-		};
-
-		pcie-controller {
-			status = "okay";
-
-			pcie at 1,0 {
-				/* Marvell 88W8864, 5GHz-only */
-				status = "okay";
-			};
-
-			pcie at 2,0 {
-				/* Marvell 88W8864, 2GHz-only */
-				status = "okay";
-			};
-		};
 	};
 
 	usb3_phy: usb3_phy {
@@ -249,12 +103,12 @@
 		pinctrl-0 = <&power_led_pin &sata_led_pin>;
 		pinctrl-names = "default";
 
-		power {
+		power_led: power {
 			gpios = <&gpio1 23 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
 		};
 
-		sata {
+		sata_led: sata {
 			gpios = <&gpio1 22 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
@@ -306,6 +160,140 @@
 	};
 };
 
+&ahci0 {
+	status = "okay";
+};
+
+/* USB part of the eSATA/USB 2.0 port */
+&ehci {
+	status = "okay";
+};
+
+&eth0 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
+};
+
+&eth2 {
+	status = "okay";
+	phy-mode = "sgmii";
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	status = "okay";
+
+	tmp421 at 4c {
+		compatible = "ti,tmp421";
+		reg = <0x4c>;
+	};
+
+	pca9635: pca9635 at 68 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "nxp,pca9635";
+		reg = <0x68>;
+	};
+};
+
+&mdio {
+	status = "okay";
+};
+
+&nfc {
+	status = "okay";
+	num-cs = <1>;
+	marvell,nand-keep-config;
+	marvell,nand-enable-arbiter;
+	nand-on-flash-bbt;
+
+	partition at 0 {
+		label = "u-boot";
+		reg = <0x0000000 0x200000>;  /* 2MB */
+		read-only;
+	};
+
+	partition at 100000 {
+		label = "u_env";
+		reg = <0x200000 0x40000>;    /* 256KB */
+	};
+
+	partition at 140000 {
+		label = "s_env";
+		reg = <0x240000 0x40000>;    /* 256KB */
+	};
+
+	partition at 900000 {
+		label = "devinfo";
+		reg = <0x900000 0x100000>;   /* 1MB */
+		read-only;
+	};
+
+	/* kernel1 overlaps with rootfs1 by design */
+	partition at a00000 {
+		label = "kernel1";
+		reg = <0xa00000 0x2800000>;  /* 40MB */
+	};
+
+	partition at 1000000 {
+		label = "rootfs1";
+		reg = <0x1000000 0x2200000>;  /* 34MB */
+	};
+
+	/* kernel2 overlaps with rootfs2 by design */
+	partition at 3200000 {
+		label = "kernel2";
+		reg = <0x3200000 0x2800000>; /* 40MB */
+	};
+
+	partition at 3800000 {
+		label = "rootfs2";
+		reg = <0x3800000 0x2200000>; /* 34MB */
+	};
+
+	/*
+	 * 38MB, last MB is for the BBT, not writable
+	 */
+	partition at 5a00000 {
+		label = "syscfg";
+		reg = <0x5a00000 0x2600000>;
+	};
+
+	/*
+	 * Unused area between "s_env" and "devinfo".
+	 * Moved here because otherwise the renumbered
+	 * partitions would break the bootloader
+	 * supplied bootargs
+	 */
+	partition at 180000 {
+		label = "unused_area";
+		reg = <0x280000 0x680000>;   /* 6.5MB */
+	};
+};
+
+&pcie {
+	status = "okay";
+};
+
+&pcie1 {
+	/* Marvell 88W8864, 5GHz-only */
+	status = "okay";
+};
+
+&pcie2 {
+	/* Marvell 88W8864, 2GHz-only */
+	status = "okay";
+};
+
 &pinctrl {
 	keys_pin: keys-pin {
 		marvell,pins = "mpp24", "mpp29";
@@ -331,3 +319,13 @@
 &spi0 {
 	status = "disabled";
 };
+
+/* J10: VCC, NC, RX, NC, TX, GND */
+&uart0 {
+	status = "okay";
+};
+
+&xhci1 {
+	status = "okay";
+	usb-phy = <&usb3_phy>;
+};
diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
index ab49acb..f53cb8b 100644
--- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
+++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
@@ -65,56 +65,17 @@
 			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x19) 0 0xf1100000 0x10000
 			  MBUS_ID(0x09, 0x15) 0 0xf1110000 0x10000>;
+	};
+};
 
-		internal-regs {
-
-			/* USB part of the PCIe2/USB 2.0 port */
-			usb at 58000 {
-				status = "okay";
-			};
-
-			sata at a8000 {
-				status = "okay";
-			};
-
-			sdhci at d8000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&sdhci_pins>;
-				status = "okay";
-
-				bus-width = <8>;
-				no-1-8-v;
-				non-removable;
-			};
-
-			usb3 at f0000 {
-				status = "okay";
-			};
-
-			usb3 at f8000 {
-				status = "okay";
-			};
-		};
-
-		pcie-controller {
-			status = "okay";
-
-			pcie at 1,0 {
-				/* Port 0, Lane 0 */
-				status = "okay";
-			};
-
-			pcie at 2,0 {
-				/* Port 1, Lane 0 */
-				status = "okay";
-			};
+/* PCIe0/mSATA port */
+&ahci0 {
+	status = "okay";
+};
 
-			pcie at 3,0 {
-				/* Port 2, Lane 0 */
-				status = "okay";
-			};
-		};
-	};
+/* USB part of the PCIe2/USB 2.0 port */
+&ehci {
+	status = "okay";
 };
 
 /* Connected to 88E6176 switch, port 6 */
@@ -276,6 +237,25 @@
 	/* Switch MV88E7176 at address 0x10 */
 };
 
+&pcie {
+	status = "okay";
+};
+
+&pcie1 {
+	/* Port 0, Lane 0 */
+	status = "okay";
+};
+
+&pcie2 {
+	/* Port 1, Lane 0 */
+	status = "okay";
+};
+
+&pcie3 {
+	/* Port 2, Lane 0 */
+	status = "okay";
+};
+
 &pinctrl {
 	pcawan_pins: pcawan-pins {
 		marvell,pins = "mpp46";
@@ -293,6 +273,17 @@
 	};
 };
 
+/* eMMC */
+&sdhci {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhci_pins>;
+	status = "okay";
+
+	bus-width = <8>;
+	no-1-8-v;
+	non-removable;
+};
+
 &spi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi0_pins &spi0cs0_pins>;
@@ -338,3 +329,13 @@
 	pinctrl-0 = <&uart1_pins>;
 	status = "okay";
 };
+
+/* front USB port */
+&xhci0 {
+	status = "okay";
+};
+
+/* rear USB port */
+&xhci1 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/armada-385.dtsi b/arch/arm/boot/dts/armada-385.dtsi
index 8e67d2c..d3cd60c 100644
--- a/arch/arm/boot/dts/armada-385.dtsi
+++ b/arch/arm/boot/dts/armada-385.dtsi
@@ -70,13 +70,7 @@
 	};
 
 	soc {
-		internal-regs {
-			pinctrl at 18000 {
-				compatible = "marvell,mv88f6820-pinctrl";
-			};
-		};
-
-		pcie-controller {
+		pcie: pcie-controller {
 			compatible = "marvell,armada-370-pcie";
 			status = "disabled";
 			device_type = "pci";
@@ -106,7 +100,7 @@
 			 * configured in x4 by the bootloader, then
 			 * pcie at 4,0 is not available.
 			 */
-			pcie at 1,0 {
+			pcie1: pcie at 1,0 {
 				device_type = "pci";
 				assigned-addresses = <0x82000800 0 0x80000 0 0x2000>;
 				reg = <0x0800 0 0 0 0>;
@@ -124,7 +118,7 @@
 			};
 
 			/* x1 port */
-			pcie at 2,0 {
+			pcie2: pcie at 2,0 {
 				device_type = "pci";
 				assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
 				reg = <0x1000 0 0 0 0>;
@@ -142,7 +136,7 @@
 			};
 
 			/* x1 port */
-			pcie at 3,0 {
+			pcie3: pcie at 3,0 {
 				device_type = "pci";
 				assigned-addresses = <0x82000800 0 0x44000 0 0x2000>;
 				reg = <0x1800 0 0 0 0>;
@@ -163,7 +157,7 @@
 			 * x1 port only available when pcie at 1,0 is
 			 * configured as a x1 port
 			 */
-			pcie at 4,0 {
+			pcie4: pcie at 4,0 {
 				device_type = "pci";
 				assigned-addresses = <0x82000800 0 0x48000 0 0x2000>;
 				reg = <0x2000 0 0 0 0>;
@@ -182,3 +176,7 @@
 		};
 	};
 };
+
+&pinctrl {
+	compatible = "marvell,mv88f6820-pinctrl";
+};
diff --git a/arch/arm/boot/dts/armada-388-clearfog.dts b/arch/arm/boot/dts/armada-388-clearfog.dts
index 71ce201..98c622e 100644
--- a/arch/arm/boot/dts/armada-388-clearfog.dts
+++ b/arch/arm/boot/dts/armada-388-clearfog.dts
@@ -74,282 +74,6 @@
 		regulator-always-on;
 	};
 
-	soc {
-		internal-regs {
-			ethernet at 30000 {
-				phy-mode = "sgmii";
-				buffer-manager = <&bm>;
-				bm,pool-long = <2>;
-				bm,pool-short = <1>;
-				status = "okay";
-
-				fixed-link {
-					speed = <1000>;
-					full-duplex;
-				};
-			};
-
-			ethernet at 34000 {
-				phy-mode = "sgmii";
-				buffer-manager = <&bm>;
-				bm,pool-long = <3>;
-				bm,pool-short = <1>;
-				status = "okay";
-
-				fixed-link {
-					speed = <1000>;
-					full-duplex;
-				};
-			};
-
-			i2c at 11000 {
-				/* Is there anything on this? */
-				clock-frequency = <100000>;
-				pinctrl-0 = <&i2c0_pins>;
-				pinctrl-names = "default";
-				status = "okay";
-
-				/*
-				 * PCA9655 GPIO expander, up to 1MHz clock.
-				 *  0-CON3 CLKREQ#
-				 *  1-CON3 PERST#
-				 *  2-CON2 PERST#
-				 *  3-CON3 W_DISABLE
-				 *  4-CON2 CLKREQ#
-				 *  5-USB3 overcurrent
-				 *  6-USB3 power
-				 *  7-CON2 W_DISABLE
-				 *  8-JP4 P1
-				 *  9-JP4 P4
-				 * 10-JP4 P5
-				 * 11-m.2 DEVSLP
-				 * 12-SFP_LOS
-				 * 13-SFP_TX_FAULT
-				 * 14-SFP_TX_DISABLE
-				 * 15-SFP_MOD_DEF0
-				 */
-				expander0: gpio-expander at 20 {
-					/*
-					 * This is how it should be:
-					 * compatible = "onnn,pca9655",
-					 *	 "nxp,pca9555";
-					 * but you can't do this because of
-					 * the way I2C works.
-					 */
-					compatible = "nxp,pca9555";
-					gpio-controller;
-					#gpio-cells = <2>;
-					reg = <0x20>;
-
-					pcie1_0_clkreq {
-						gpio-hog;
-						gpios = <0 GPIO_ACTIVE_LOW>;
-						input;
-						line-name = "pcie1.0-clkreq";
-					};
-					pcie1_0_w_disable {
-						gpio-hog;
-						gpios = <3 GPIO_ACTIVE_LOW>;
-						output-low;
-						line-name = "pcie1.0-w-disable";
-					};
-					pcie2_0_clkreq {
-						gpio-hog;
-						gpios = <4 GPIO_ACTIVE_LOW>;
-						input;
-						line-name = "pcie2.0-clkreq";
-					};
-					pcie2_0_w_disable {
-						gpio-hog;
-						gpios = <7 GPIO_ACTIVE_LOW>;
-						output-low;
-						line-name = "pcie2.0-w-disable";
-					};
-					usb3_ilimit {
-						gpio-hog;
-						gpios = <5 GPIO_ACTIVE_LOW>;
-						input;
-						line-name = "usb3-current-limit";
-					};
-					usb3_power {
-						gpio-hog;
-						gpios = <6 GPIO_ACTIVE_HIGH>;
-						output-high;
-						line-name = "usb3-power";
-					};
-					m2_devslp {
-						gpio-hog;
-						gpios = <11 GPIO_ACTIVE_HIGH>;
-						output-low;
-						line-name = "m.2 devslp";
-					};
-					sfp_los {
-						/* SFP loss of signal */
-						gpio-hog;
-						gpios = <12 GPIO_ACTIVE_HIGH>;
-						input;
-						line-name = "sfp-los";
-					};
-					sfp_tx_fault {
-						/* SFP laser fault */
-						gpio-hog;
-						gpios = <13 GPIO_ACTIVE_HIGH>;
-						input;
-						line-name = "sfp-tx-fault";
-					};
-					sfp_tx_disable {
-						/* SFP transmit disable */
-						gpio-hog;
-						gpios = <14 GPIO_ACTIVE_HIGH>;
-						output-low;
-						line-name = "sfp-tx-disable";
-					};
-					sfp_mod_def0 {
-						/* SFP module present */
-						gpio-hog;
-						gpios = <15 GPIO_ACTIVE_LOW>;
-						input;
-						line-name = "sfp-mod-def0";
-					};
-				};
-
-				/* The MCP3021 is 100kHz clock only */
-				mikrobus_adc: mcp3021 at 4c {
-					compatible = "microchip,mcp3021";
-					reg = <0x4c>;
-				};
-
-				/* Also something at 0x64 */
-			};
-
-			i2c at 11100 {
-				/*
-				 * Routed to SFP, mikrobus, and PCIe.
-				 * SFP limits this to 100kHz, and requires
-				 *  an AT24C01A/02/04 with address pins tied
-				 *  low, which takes addresses 0x50 and 0x51.
-				 * Mikrobus doesn't specify beyond an I2C
-				 *  bus being present.
-				 * PCIe uses ARP to assign addresses, or
-				 *  0x63-0x64.
-				 */
-				clock-frequency = <100000>;
-				pinctrl-0 = <&clearfog_i2c1_pins>;
-				pinctrl-names = "default";
-				status = "okay";
-			};
-
-			pinctrl at 18000 {
-				clearfog_dsa0_clk_pins: clearfog-dsa0-clk-pins {
-					marvell,pins = "mpp46";
-					marvell,function = "ref";
-				};
-				clearfog_dsa0_pins: clearfog-dsa0-pins {
-					marvell,pins = "mpp23", "mpp41";
-					marvell,function = "gpio";
-				};
-				clearfog_i2c1_pins: i2c1-pins {
-					/* SFP, PCIe, mSATA, mikrobus */
-					marvell,pins = "mpp26", "mpp27";
-					marvell,function = "i2c1";
-				};
-				clearfog_sdhci_cd_pins: clearfog-sdhci-cd-pins {
-					marvell,pins = "mpp20";
-					marvell,function = "gpio";
-				};
-				clearfog_sdhci_pins: clearfog-sdhci-pins {
-					marvell,pins = "mpp21", "mpp28",
-						       "mpp37", "mpp38",
-						       "mpp39", "mpp40";
-					marvell,function = "sd0";
-				};
-				clearfog_spi1_cs_pins: spi1-cs-pins {
-					marvell,pins = "mpp55";
-					marvell,function = "spi1";
-				};
-				mikro_pins: mikro-pins {
-					/* int: mpp22 rst: mpp29 */
-					marvell,pins = "mpp22", "mpp29";
-					marvell,function = "gpio";
-				};
-				mikro_spi_pins: mikro-spi-pins {
-					marvell,pins = "mpp43";
-					marvell,function = "spi1";
-				};
-				mikro_uart_pins: mikro-uart-pins {
-					marvell,pins = "mpp24", "mpp25";
-					marvell,function = "ua1";
-				};
-				rear_button_pins: rear-button-pins {
-					marvell,pins = "mpp34";
-					marvell,function = "gpio";
-				};
-			};
-
-			sata at a8000 {
-				/* pinctrl? */
-				status = "okay";
-			};
-
-			sata at e0000 {
-				/* pinctrl? */
-				status = "okay";
-			};
-
-			sdhci at d8000 {
-				bus-width = <4>;
-				cd-gpios = <&gpio0 20 GPIO_ACTIVE_LOW>;
-				no-1-8-v;
-				pinctrl-0 = <&clearfog_sdhci_pins
-					     &clearfog_sdhci_cd_pins>;
-				pinctrl-names = "default";
-				status = "okay";
-				vmmc = <&reg_3p3v>;
-				wp-inverted;
-			};
-
-			serial at 12100 {
-				/* mikrobus uart */
-				pinctrl-0 = <&mikro_uart_pins>;
-				pinctrl-names = "default";
-				status = "okay";
-			};
-
-			usb at 58000 {
-				/* CON3, nearest  power. */
-				status = "okay";
-			};
-
-			usb3 at f0000 {
-				/* CON2, nearest CPU, USB2 only. */
-				status = "okay";
-			};
-
-			usb3 at f8000 {
-				/* CON7 */
-				status = "okay";
-			};
-		};
-
-		pcie-controller {
-			status = "okay";
-			/*
-			 * The two PCIe units are accessible through
-			 * the mini-PCIe connectors on the board.
-			 */
-			pcie at 2,0 {
-				/* Port 1, Lane 0. CON3, nearest power. */
-				reset-gpios = <&expander0 1 GPIO_ACTIVE_LOW>;
-				status = "okay";
-			};
-			pcie at 3,0 {
-				/* Port 2, Lane 0. CON2, nearest CPU. */
-				reset-gpios = <&expander0 2 GPIO_ACTIVE_LOW>;
-				status = "okay";
-			};
-		};
-	};
-
 	dsa at 0 {
 		compatible = "marvell,dsa";
 		dsa,ethernet = <&eth1>;
@@ -421,6 +145,263 @@
 	};
 };
 
+&ahci0 {
+	/* pinctrl? */
+	status = "okay";
+};
+
+&ahci1 {
+	/* pinctrl? */
+	status = "okay";
+};
+
+&ehci {
+	/* CON3, nearest  power. */
+	status = "okay";
+};
+
+&eth1 {
+	phy-mode = "sgmii";
+	buffer-manager = <&bm>;
+	bm,pool-long = <2>;
+	bm,pool-short = <1>;
+	status = "okay";
+
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
+};
+
+&eth2 {
+	phy-mode = "sgmii";
+	buffer-manager = <&bm>;
+	bm,pool-long = <3>;
+	bm,pool-short = <1>;
+	status = "okay";
+
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
+};
+
+&i2c0 {
+	/* Is there anything on this? */
+	clock-frequency = <100000>;
+	pinctrl-0 = <&i2c0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	/*
+	 * PCA9655 GPIO expander, up to 1MHz clock.
+	 *  0-CON3 CLKREQ#
+	 *  1-CON3 PERST#
+	 *  2-CON2 PERST#
+	 *  3-CON3 W_DISABLE
+	 *  4-CON2 CLKREQ#
+	 *  5-USB3 overcurrent
+	 *  6-USB3 power
+	 *  7-CON2 W_DISABLE
+	 *  8-JP4 P1
+	 *  9-JP4 P4
+	 * 10-JP4 P5
+	 * 11-m.2 DEVSLP
+	 * 12-SFP_LOS
+	 * 13-SFP_TX_FAULT
+	 * 14-SFP_TX_DISABLE
+	 * 15-SFP_MOD_DEF0
+	 */
+	expander0: gpio-expander at 20 {
+		/*
+		 * This is how it should be:
+		 * compatible = "onnn,pca9655",
+		 *	 "nxp,pca9555";
+		 * but you can't do this because of
+		 * the way I2C works.
+		 */
+		compatible = "nxp,pca9555";
+		gpio-controller;
+		#gpio-cells = <2>;
+		reg = <0x20>;
+
+		pcie1_0_clkreq {
+			gpio-hog;
+			gpios = <0 GPIO_ACTIVE_LOW>;
+			input;
+			line-name = "pcie1.0-clkreq";
+		};
+		pcie1_0_w_disable {
+			gpio-hog;
+			gpios = <3 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "pcie1.0-w-disable";
+		};
+		pcie2_0_clkreq {
+			gpio-hog;
+			gpios = <4 GPIO_ACTIVE_LOW>;
+			input;
+			line-name = "pcie2.0-clkreq";
+		};
+		pcie2_0_w_disable {
+			gpio-hog;
+			gpios = <7 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "pcie2.0-w-disable";
+		};
+		usb3_ilimit {
+			gpio-hog;
+			gpios = <5 GPIO_ACTIVE_LOW>;
+			input;
+			line-name = "usb3-current-limit";
+		};
+		usb3_power {
+			gpio-hog;
+			gpios = <6 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "usb3-power";
+		};
+		m2_devslp {
+			gpio-hog;
+			gpios = <11 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "m.2 devslp";
+		};
+		sfp_los {
+			/* SFP loss of signal */
+			gpio-hog;
+			gpios = <12 GPIO_ACTIVE_HIGH>;
+			input;
+			line-name = "sfp-los";
+		};
+		sfp_tx_fault {
+			/* SFP laser fault */
+			gpio-hog;
+			gpios = <13 GPIO_ACTIVE_HIGH>;
+			input;
+			line-name = "sfp-tx-fault";
+		};
+		sfp_tx_disable {
+			/* SFP transmit disable */
+			gpio-hog;
+			gpios = <14 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "sfp-tx-disable";
+		};
+		sfp_mod_def0 {
+			/* SFP module present */
+			gpio-hog;
+			gpios = <15 GPIO_ACTIVE_LOW>;
+			input;
+			line-name = "sfp-mod-def0";
+		};
+	};
+
+	/* The MCP3021 is 100kHz clock only */
+	mikrobus_adc: mcp3021 at 4c {
+		compatible = "microchip,mcp3021";
+		reg = <0x4c>;
+	};
+
+	/* Also something at 0x64 */
+};
+
+&i2c1 {
+	/*
+	 * Routed to SFP, mikrobus, and PCIe.
+	 * SFP limits this to 100kHz, and requires
+	 *  an AT24C01A/02/04 with address pins tied
+	 *  low, which takes addresses 0x50 and 0x51.
+	 * Mikrobus doesn't specify beyond an I2C
+	 *  bus being present.
+	 * PCIe uses ARP to assign addresses, or
+	 *  0x63-0x64.
+	 */
+	clock-frequency = <100000>;
+	pinctrl-0 = <&clearfog_i2c1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&pcie {
+	status = "okay";
+};
+
+/*
+ * The two PCIe units are accessible through
+ * the mini-PCIe connectors on the board.
+ */
+&pcie2 {
+	/* Port 1, Lane 0. CON3, nearest power. */
+	reset-gpios = <&expander0 1 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&pcie3 {
+	/* Port 2, Lane 0. CON2, nearest CPU. */
+	reset-gpios = <&expander0 2 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&pinctrl {
+	clearfog_dsa0_clk_pins: clearfog-dsa0-clk-pins {
+		marvell,pins = "mpp46";
+		marvell,function = "ref";
+	};
+	clearfog_dsa0_pins: clearfog-dsa0-pins {
+		marvell,pins = "mpp23", "mpp41";
+		marvell,function = "gpio";
+	};
+	clearfog_i2c1_pins: i2c1-pins {
+		/* SFP, PCIe, mSATA, mikrobus */
+		marvell,pins = "mpp26", "mpp27";
+		marvell,function = "i2c1";
+	};
+	clearfog_sdhci_cd_pins: clearfog-sdhci-cd-pins {
+		marvell,pins = "mpp20";
+		marvell,function = "gpio";
+	};
+	clearfog_sdhci_pins: clearfog-sdhci-pins {
+		marvell,pins = "mpp21", "mpp28",
+			       "mpp37", "mpp38",
+			       "mpp39", "mpp40";
+		marvell,function = "sd0";
+	};
+	clearfog_spi1_cs_pins: spi1-cs-pins {
+		marvell,pins = "mpp55";
+		marvell,function = "spi1";
+	};
+	mikro_pins: mikro-pins {
+		/* int: mpp22 rst: mpp29 */
+		marvell,pins = "mpp22", "mpp29";
+		marvell,function = "gpio";
+	};
+	mikro_spi_pins: mikro-spi-pins {
+		marvell,pins = "mpp43";
+		marvell,function = "spi1";
+	};
+	mikro_uart_pins: mikro-uart-pins {
+		marvell,pins = "mpp24", "mpp25";
+		marvell,function = "ua1";
+	};
+	rear_button_pins: rear-button-pins {
+		marvell,pins = "mpp34";
+		marvell,function = "gpio";
+	};
+};
+
+&sdhci {
+	bus-width = <4>;
+	cd-gpios = <&gpio0 20 GPIO_ACTIVE_LOW>;
+	no-1-8-v;
+	pinctrl-0 = <&clearfog_sdhci_pins
+		     &clearfog_sdhci_cd_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+	vmmc = <&reg_3p3v>;
+	wp-inverted;
+};
+
 &spi1 {
 	/*
 	 * We don't seem to have the W25Q32 on the
@@ -444,3 +425,20 @@
 		status = "disabled";
 	};
 };
+
+&uart1 {
+	/* mikrobus uart */
+	pinctrl-0 = <&mikro_uart_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&xhci0 {
+	/* CON2, nearest CPU, USB2 only. */
+	status = "okay";
+};
+
+&xhci1 {
+	/* CON7 */
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/armada-388-db.dts b/arch/arm/boot/dts/armada-388-db.dts
index de26c76..b676bf1 100644
--- a/arch/arm/boot/dts/armada-388-db.dts
+++ b/arch/arm/boot/dts/armada-388-db.dts
@@ -68,128 +68,117 @@
 			  MBUS_ID(0x09, 0x19) 0 0xf1100000 0x10000
 			  MBUS_ID(0x09, 0x15) 0 0xf1110000 0x10000
 			  MBUS_ID(0x0c, 0x04) 0 0xf1200000 0x100000>;
+	};
+};
+
+&ahci0 {
+	status = "okay";
+};
+
+&ahci1 {
+	status = "okay";
+};
+
+&bm {
+	status = "okay";
+};
+
+&bm_bppi {
+	status = "okay";
+};
+
+&ehci {
+	status = "ok";
+};
+
+&eth0 {
+	status = "okay";
+	phy = <&phy0>;
+	phy-mode = "rgmii-id";
+	buffer-manager = <&bm>;
+	bm,pool-long = <0>;
+	bm,pool-short = <1>;
+};
+
+&eth1 {
+	status = "okay";
+	phy = <&phy1>;
+	phy-mode = "rgmii-id";
+	buffer-manager = <&bm>;
+	bm,pool-long = <2>;
+	bm,pool-short = <3>;
+};
+
+&i2c0 {
+	status = "okay";
+	clock-frequency = <100000>;
+};
+
+&i2c1 {
+	status = "okay";
+	clock-frequency = <100000>;
+};
+
+&mdio {
+	phy0: ethernet-phy at 0 {
+		reg = <0>;
+	};
 
-		internal-regs {
-			i2c at 11000 {
-				status = "okay";
-				clock-frequency = <100000>;
-			};
-
-			i2c at 11100 {
-				status = "okay";
-				clock-frequency = <100000>;
-			};
-
-			serial at 12000 {
-				status = "okay";
-			};
-
-			ethernet at 30000 {
-				status = "okay";
-				phy = <&phy1>;
-				phy-mode = "rgmii-id";
-				buffer-manager = <&bm>;
-				bm,pool-long = <2>;
-				bm,pool-short = <3>;
-			};
-
-			usb at 58000 {
-				status = "ok";
-			};
-
-			ethernet at 70000 {
-				status = "okay";
-				phy = <&phy0>;
-				phy-mode = "rgmii-id";
-				buffer-manager = <&bm>;
-				bm,pool-long = <0>;
-				bm,pool-short = <1>;
-			};
-
-			mdio at 72004 {
-				phy0: ethernet-phy at 0 {
-					reg = <0>;
-				};
-
-				phy1: ethernet-phy at 1 {
-					reg = <1>;
-				};
-			};
-
-			sata at a8000 {
-				status = "okay";
-			};
-
-			sata at e0000 {
-				status = "okay";
-			};
-
-			bm at c8000 {
-				status = "okay";
-			};
-
-			flash at d0000 {
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
-			sdhci at d8000 {
-				broken-cd;
-				wp-inverted;
-				bus-width = <8>;
-				status = "okay";
-				no-1-8-v;
-			};
-
-			usb3 at f0000 {
-				status = "okay";
-			};
-
-			usb3 at f8000 {
-				status = "okay";
-			};
-		};
-
-		bm-bppi {
-			status = "okay";
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
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
 	};
 };
 
+&nfc {
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
+&pcie {
+	status = "okay";
+};
+
+/*
+ * The two PCIe units are accessible through
+ * standard PCIe slots on the board.
+ */
+&pcie1 {
+	/* Port 0, Lane 0 */
+	status = "okay";
+};
+
+&pcie2 {
+	/* Port 1, Lane 0 */
+	status = "okay";
+};
+
+
+&sdhci {
+	broken-cd;
+	wp-inverted;
+	bus-width = <8>;
+	status = "okay";
+	no-1-8-v;
+};
+
 &spi0 {
 	status = "okay";
 
@@ -202,3 +191,14 @@
 	};
 };
 
+&uart0 {
+	status = "okay";
+};
+
+&xhci0 {
+	status = "okay";
+};
+
+&xhci1 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
index 895fa6c..89dd124 100644
--- a/arch/arm/boot/dts/armada-388-gp.dts
+++ b/arch/arm/boot/dts/armada-388-gp.dts
@@ -63,208 +63,6 @@
 			  MBUS_ID(0x09, 0x15) 0 0xf1110000 0x10000
 			  MBUS_ID(0x0c, 0x04) 0 0xf1200000 0x100000>;
 
-		internal-regs {
-			i2c at 11000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&i2c0_pins>;
-				status = "okay";
-				clock-frequency = <100000>;
-
-				expander0: pca9555 at 20 {
-					compatible = "nxp,pca9555";
-					pinctrl-names = "default";
-					pinctrl-0 = <&pca0_pins>;
-					interrupt-parent = <&gpio0>;
-					interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
-					gpio-controller;
-					#gpio-cells = <2>;
-					interrupt-controller;
-					#interrupt-cells = <2>;
-					reg = <0x20>;
-				};
-
-				expander1: pca9555 at 21 {
-					compatible = "nxp,pca9555";
-					pinctrl-names = "default";
-					interrupt-parent = <&gpio0>;
-					interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
-					gpio-controller;
-					#gpio-cells = <2>;
-					interrupt-controller;
-					#interrupt-cells = <2>;
-					reg = <0x21>;
-				};
-
-				eeprom at 57 {
-					compatible = "atmel,24c64";
-					reg = <0x57>;
-				};
-			};
-
-			serial at 12000 {
-				/*
-				 * Exported on the micro USB connector CON16
-				 * through an FTDI
-				 */
-
-				pinctrl-names = "default";
-				pinctrl-0 = <&uart0_pins>;
-				status = "okay";
-			};
-
-			/* GE1 CON15 */
-			ethernet at 30000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&ge1_rgmii_pins>;
-				status = "okay";
-				phy = <&phy1>;
-				phy-mode = "rgmii-id";
-				buffer-manager = <&bm>;
-				bm,pool-long = <2>;
-				bm,pool-short = <3>;
-			};
-
-			/* CON4 */
-			usb at 58000 {
-				vcc-supply = <&reg_usb2_0_vbus>;
-				status = "okay";
-			};
-
-			/* GE0 CON1 */
-			ethernet at 70000 {
-				pinctrl-names = "default";
-				/*
-				 * The Reference Clock 0 is used to provide a
-				 * clock to the PHY
-				 */
-				pinctrl-0 = <&ge0_rgmii_pins>, <&ref_clk0_pins>;
-				status = "okay";
-				phy = <&phy0>;
-				phy-mode = "rgmii-id";
-				buffer-manager = <&bm>;
-				bm,pool-long = <0>;
-				bm,pool-short = <1>;
-			};
-
-
-			mdio at 72004 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&mdio_pins>;
-
-				phy0: ethernet-phy at 1 {
-					reg = <1>;
-				};
-
-				phy1: ethernet-phy at 0 {
-					reg = <0>;
-				};
-			};
-
-			sata at a8000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&sata0_pins>, <&sata1_pins>;
-				status = "okay";
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				sata0: sata-port at 0 {
-					reg = <0>;
-					target-supply = <&reg_5v_sata0>;
-				};
-
-				sata1: sata-port at 1 {
-					reg = <1>;
-					target-supply = <&reg_5v_sata1>;
-				};
-			};
-
-			bm at c8000 {
-				status = "okay";
-			};
-
-			sata at e0000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&sata2_pins>, <&sata3_pins>;
-				status = "okay";
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				sata2: sata-port at 0 {
-					reg = <0>;
-					target-supply = <&reg_5v_sata2>;
-				};
-
-				sata3: sata-port at 1 {
-					reg = <1>;
-					target-supply = <&reg_5v_sata3>;
-				};
-			};
-
-			sdhci at d8000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&sdhci_pins>;
-				no-1-8-v;
-				/*
-				 * A388-GP board v1.5 and higher replace
-				 * hitherto card detection method based on GPIO
-				 * with the one using DAT3 pin. As they are
-				 * incompatible, software-based polling is
-				 * enabled with 'broken-cd' property. For boards
-				 * older than v1.5 it can be replaced with:
-				 * 'cd-gpios = <&expander0 5 GPIO_ACTIVE_LOW>;',
-				 * whereas for the newer ones following can be
-				 * used instead:
-				 * 'dat3-cd;'
-				 * 'cd-inverted;'
-				 */
-				broken-cd;
-				wp-inverted;
-				bus-width = <8>;
-				status = "okay";
-			};
-
-			/* CON5 */
-			usb3 at f0000 {
-				usb-phy = <&usb2_1_phy>;
-				status = "okay";
-			};
-
-			/* CON7 */
-			usb3 at f8000 {
-				usb-phy = <&usb3_phy>;
-				status = "okay";
-			};
-		};
-
-		bm-bppi {
-			status = "okay";
-		};
-
-		pcie-controller {
-			status = "okay";
-			/*
-			 * One PCIe units is accessible through
-			 * standard PCIe slot on the board.
-			 */
-			pcie at 1,0 {
-				/* Port 0, Lane 0 */
-				status = "okay";
-			};
-
-			/*
-			 * The two other PCIe units are accessible
-			 * through mini PCIe slot on the board.
-			 */
-			pcie at 2,0 {
-				/* Port 1, Lane 0 */
-				status = "okay";
-			};
-			pcie at 3,0 {
-				/* Port 2, Lane 0 */
-				status = "okay";
-			};
-		};
-
 		gpio-fan {
 			compatible = "gpio-fan";
 			gpios = <&expander1 3 GPIO_ACTIVE_HIGH>;
@@ -412,6 +210,161 @@
 	};
 };
 
+&ahci0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sata0_pins>, <&sata1_pins>;
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	sata0: sata-port at 0 {
+		reg = <0>;
+		target-supply = <&reg_5v_sata0>;
+	};
+
+	sata1: sata-port at 1 {
+		reg = <1>;
+		target-supply = <&reg_5v_sata1>;
+	};
+};
+
+&ahci1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sata2_pins>, <&sata3_pins>;
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	sata2: sata-port at 0 {
+		reg = <0>;
+		target-supply = <&reg_5v_sata2>;
+	};
+
+	sata3: sata-port at 1 {
+		reg = <1>;
+		target-supply = <&reg_5v_sata3>;
+	};
+};
+
+&bm {
+	status = "okay";
+};
+
+&bm_bppi {
+	status = "okay";
+};
+
+/* CON4 */
+&ehci {
+	vcc-supply = <&reg_usb2_0_vbus>;
+	status = "okay";
+};
+
+/* GE0 CON1 */
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
+	buffer-manager = <&bm>;
+	bm,pool-long = <0>;
+	bm,pool-short = <1>;
+};
+
+/* GE1 CON15 */
+&eth1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ge1_rgmii_pins>;
+	status = "okay";
+	phy = <&phy1>;
+	phy-mode = "rgmii-id";
+	buffer-manager = <&bm>;
+	bm,pool-long = <2>;
+	bm,pool-short = <3>;
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	status = "okay";
+	clock-frequency = <100000>;
+
+	expander0: pca9555 at 20 {
+		compatible = "nxp,pca9555";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pca0_pins>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		reg = <0x20>;
+	};
+
+	expander1: pca9555 at 21 {
+		compatible = "nxp,pca9555";
+		pinctrl-names = "default";
+		interrupt-parent = <&gpio0>;
+		interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		reg = <0x21>;
+	};
+
+	eeprom at 57 {
+		compatible = "atmel,24c64";
+		reg = <0x57>;
+	};
+};
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
+&pcie {
+	status = "okay";
+};
+
+/*
+ * One PCIe units is accessible through
+ * standard PCIe slot on the board.
+ */
+&pcie1 {
+	/* Port 0, Lane 0 */
+	status = "okay";
+};
+
+/*
+ * The two other PCIe units are accessible
+ * through mini PCIe slot on the board.
+ */
+&pcie2 {
+	/* Port 1, Lane 0 */
+	status = "okay";
+};
+
+&pcie3 {
+	/* Port 2, Lane 0 */
+	status = "okay";
+};
+
 &pinctrl {
 	pca0_pins: pca0_pins {
 		marvell,pins = "mpp18";
@@ -419,6 +372,29 @@
 	};
 };
 
+&sdhci {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhci_pins>;
+	no-1-8-v;
+	/*
+	 * A388-GP board v1.5 and higher replace
+	 * hitherto card detection method based on GPIO
+	 * with the one using DAT3 pin. As they are
+	 * incompatible, software-based polling is
+	 * enabled with 'broken-cd' property. For boards
+	 * older than v1.5 it can be replaced with:
+	 * 'cd-gpios = <&expander0 5 GPIO_ACTIVE_LOW>;',
+	 * whereas for the newer ones following can be
+	 * used instead:
+	 * 'dat3-cd;'
+	 * 'cd-inverted;'
+	 */
+	broken-cd;
+	wp-inverted;
+	bus-width = <8>;
+	status = "okay";
+};
+
 &spi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi0_pins>;
@@ -433,3 +409,26 @@
 		m25p,fast-read;
 	};
 };
+
+&uart0 {
+	/*
+	 * Exported on the micro USB connector CON16
+	 * through an FTDI
+	 */
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
+	status = "okay";
+};
+
+/* CON5 */
+&xhci0 {
+	usb-phy = <&usb2_1_phy>;
+	status = "okay";
+};
+
+/* CON7 */
+&xhci1 {
+	usb-phy = <&usb3_phy>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/armada-388-rd.dts b/arch/arm/boot/dts/armada-388-rd.dts
index dd3462dd..60c9065 100644
--- a/arch/arm/boot/dts/armada-388-rd.dts
+++ b/arch/arm/boot/dts/armada-388-rd.dts
@@ -68,69 +68,59 @@
 			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x19) 0 0xf1100000 0x10000
 			  MBUS_ID(0x09, 0x15) 0 0xf1110000 0x10000>;
+	};
+};
+
+&eth0 {
+	status = "okay";
+	phy = <&phy1>;
+	phy-mode = "rgmii-id";
+};
+
+&eth1 {
+	status = "okay";
+	phy = <&phy0>;
+	phy-mode = "rgmii-id";
+};
 
-		internal-regs {
-			i2c at 11000 {
-				status = "okay";
-				clock-frequency = <100000>;
-			};
-
-			sdhci at d8000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&sdhci_pins>;
-				broken-cd;
-				no-1-8-v;
-				wp-inverted;
-				bus-width = <8>;
-				status = "okay";
-			};
-
-			serial at 12000 {
-				status = "okay";
-			};
-
-			ethernet at 30000 {
-				status = "okay";
-				phy = <&phy0>;
-				phy-mode = "rgmii-id";
-			};
-
-			ethernet at 70000 {
-				status = "okay";
-				phy = <&phy1>;
-				phy-mode = "rgmii-id";
-			};
-
-
-			mdio at 72004 {
-				phy0: ethernet-phy at 0 {
-					reg = <0>;
-				};
-
-				phy1: ethernet-phy at 1 {
-					reg = <1>;
-				};
-			};
-
-			usb3 at f0000 {
-				status = "okay";
-			};
-		};
-
-		pcie-controller {
-			status = "okay";
-			/*
-			 * One PCIe units is accessible through
-			 * standard PCIe slot on the board.
-			 */
-			pcie at 1,0 {
-				/* Port 0, Lane 0 */
-				status = "okay";
-			};
-		};
+&i2c0 {
+	status = "okay";
+	clock-frequency = <100000>;
+};
+
+&mdio {
+	phy0: ethernet-phy at 0 {
+		reg = <0>;
+	};
+
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
 	};
 };
 
+&pcie {
+	status = "okay";
+};
+
+/*
+ * One PCIe units is accessible through
+ * standard PCIe slot on the board.
+ */
+&pcie1 {
+	/* Port 0, Lane 0 */
+	status = "okay";
+};
+
+&sdhci {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhci_pins>;
+	broken-cd;
+	no-1-8-v;
+	wp-inverted;
+	bus-width = <8>;
+	status = "okay";
+};
+
 &spi0 {
 	status = "okay";
 
@@ -143,3 +133,10 @@
 	};
 };
 
+&uart0 {
+	status = "okay";
+};
+
+&xhci0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/armada-388.dtsi b/arch/arm/boot/dts/armada-388.dtsi
index 564fa59..1a7fc5d 100644
--- a/arch/arm/boot/dts/armada-388.dtsi
+++ b/arch/arm/boot/dts/armada-388.dtsi
@@ -50,21 +50,8 @@
 	model = "Marvell Armada 388 family SoC";
 	compatible = "marvell,armada388", "marvell,armada385",
 		"marvell,armada380";
+};
 
-	soc {
-		internal-regs {
-			pinctrl at 18000 {
-				compatible = "marvell,mv88f6828-pinctrl";
-			};
-
-			sata at e0000 {
-				compatible = "marvell,armada-380-ahci";
-				reg = <0xe0000 0x2000>;
-				interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&gateclk 30>;
-				status = "disabled";
-			};
-
-		};
-	};
+&pinctrl {
+	compatible = "marvell,mv88f6828-pinctrl";
 };
diff --git a/arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi b/arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi
index 8c98422..b97eae3 100644
--- a/arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi
+++ b/arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi
@@ -60,69 +60,66 @@
 			  MBUS_ID(0x09, 0x19) 0 0xf1100000 0x10000
 			  MBUS_ID(0x09, 0x15) 0 0xf1110000 0x10000
 			  MBUS_ID(0x0c, 0x04) 0 0xf1200000 0x100000>;
+	};
+};
 
-		internal-regs {
-			ethernet at 70000 {
-				pinctrl-0 = <&ge0_rgmii_pins>;
-				pinctrl-names = "default";
-				phy = <&phy_dedicated>;
-				phy-mode = "rgmii-id";
-				buffer-manager = <&bm>;
-				bm,pool-long = <0>;
-				bm,pool-short = <1>;
-				status = "okay";
-			};
-
-			mdio at 72004 {
-				/*
-				 * Add the phy clock here, so the phy can be
-				 * accessed to read its IDs prior to binding
-				 * with the driver.
-				 */
-				pinctrl-0 = <&mdio_pins &microsom_phy_clk_pins>;
-				pinctrl-names = "default";
+&bm {
+	status = "okay";
+};
 
-				phy_dedicated: ethernet-phy at 0 {
-					/*
-					 * Annoyingly, the marvell phy driver
-					 * configures the LED register, rather
-					 * than preserving reset-loaded setting.
-					 * We undo that rubbish here.
-					 */
-					marvell,reg-init = <3 16 0 0x101e>;
-					reg = <0>;
-				};
-			};
+&bm_bppi {
+	status = "okay";
+};
 
-			pinctrl at 18000 {
-				microsom_phy_clk_pins: microsom-phy-clk-pins {
-					marvell,pins = "mpp45";
-					marvell,function = "ref";
-				};
-			};
+&eth0 {
+	pinctrl-0 = <&ge0_rgmii_pins>;
+	pinctrl-names = "default";
+	phy = <&phy_dedicated>;
+	phy-mode = "rgmii-id";
+	buffer-manager = <&bm>;
+	bm,pool-long = <0>;
+	bm,pool-short = <1>;
+	status = "okay";
+};
 
-			rtc at a3800 {
-				/*
-				 * If the rtc doesn't work, run "date reset"
-				 * twice in u-boot.
-				 */
-				status = "okay";
-			};
+&mdio {
+	/*
+	 * Add the phy clock here, so the phy can be
+	 * accessed to read its IDs prior to binding
+	 * with the driver.
+	 */
+	pinctrl-0 = <&mdio_pins &microsom_phy_clk_pins>;
+	pinctrl-names = "default";
 
-			serial at 12000 {
-				pinctrl-0 = <&uart0_pins>;
-				pinctrl-names = "default";
-				status = "okay";
-			};
+	phy_dedicated: ethernet-phy at 0 {
+		/*
+		 * Annoyingly, the marvell phy driver
+		 * configures the LED register, rather
+		 * than preserving reset-loaded setting.
+		 * We undo that rubbish here.
+		 */
+		marvell,reg-init = <3 16 0 0x101e>;
+		reg = <0>;
+	};
+};
 
-			bm at c8000 {
-				status = "okay";
-			};
-		};
+&pinctrl {
+	microsom_phy_clk_pins: microsom-phy-clk-pins {
+		marvell,pins = "mpp45";
+		marvell,function = "ref";
+	};
+};
 
-		bm-bppi {
-			status = "okay";
-		};
+&rtc {
+	/*
+	 * If the rtc doesn't work, run "date reset"
+	 * twice in u-boot.
+	 */
+	status = "okay";
+};
 
-	};
+&uart0 {
+	pinctrl-0 = <&uart0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
 };
diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 7450e9f..25303b1 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -451,7 +451,7 @@
 				status = "disabled";
 			};
 
-			usb at 58000 {
+			ehci: usb at 58000 {
 				compatible = "marvell,orion-ehci";
 				reg = <0x58000 0x500>;
 				interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
@@ -522,14 +522,14 @@
 				marvell,crypto-sram-size = <0x800>;
 			};
 
-			rtc at a3800 {
+			rtc: rtc at a3800 {
 				compatible = "marvell,armada-380-rtc";
 				reg = <0xa3800 0x20>, <0x184a0 0x0c>;
 				reg-names = "rtc", "rtc-soc";
 				interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
-			sata at a8000 {
+			ahci0: sata at a8000 {
 				compatible = "marvell,armada-380-ahci";
 				reg = <0xa8000 0x2000>;
 				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
@@ -545,7 +545,7 @@
 				status = "disabled";
 			};
 
-			sata at e0000 {
+			ahci1: sata at e0000 {
 				compatible = "marvell,armada-380-ahci";
 				reg = <0xe0000 0x2000>;
 				interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
@@ -567,7 +567,7 @@
 				status = "okay";
 			};
 
-			flash at d0000 {
+			nfc: flash at d0000 {
 				compatible = "marvell,armada370-nand";
 				reg = <0xd0000 0x54>;
 				#address-cells = <1>;
@@ -577,7 +577,7 @@
 				status = "disabled";
 			};
 
-			sdhci at d8000 {
+			sdhci: sdhci at d8000 {
 				compatible = "marvell,armada-380-sdhci";
 				reg-names = "sdhci", "mbus", "conf-sdio3";
 				reg = <0xd8000 0x1000>,
@@ -589,7 +589,7 @@
 				status = "disabled";
 			};
 
-			usb3 at f0000 {
+			xhci0: usb3 at f0000 {
 				compatible = "marvell,armada-380-xhci";
 				reg = <0xf0000 0x4000>,<0xf4000 0x4000>;
 				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
@@ -597,7 +597,7 @@
 				status = "disabled";
 			};
 
-			usb3 at f8000 {
+			xhci1: usb3 at f8000 {
 				compatible = "marvell,armada-380-xhci";
 				reg = <0xf8000 0x4000>,<0xfc000 0x4000>;
 				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.6.6
