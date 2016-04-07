From: sr@denx.de (Stefan Roese)
Date: Thu,  7 Apr 2016 14:02:16 +0200
Subject: [PATCH 1/2] ARM: dts: mvebu: A37x/XP/38x/39x: Move SPI controller
 nodes into 'soc' node
Message-ID: <1460030537-10054-1-git-send-email-sr@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves all Armada 370/XP/38x/39x SPI controller nodes from the
'internal-regs' node down into the 'soc' node. This is in preparation
to enable the usage of the SPI direct access mode. A follow-up patch
will add the static MBus mappings for the SPI devices into the 'reg'
property of the SPI controller DT node.

By moving these SPI controller nodes, this patch also makes use of
the labels rather than keeping the tree structure.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedameon.net>
Cc: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/armada-370-db.dts                |  29 +++---
 .../dts/armada-370-seagate-personal-cloud.dtsi     |  40 ++++----
 arch/arm/boot/dts/armada-370-synology-ds213j.dts   | 112 ++++++++++-----------
 arch/arm/boot/dts/armada-370-xp.dtsi               |  40 ++++----
 arch/arm/boot/dts/armada-370.dtsi                  |  34 +++----
 arch/arm/boot/dts/armada-385-db-ap.dts             |  28 +++---
 arch/arm/boot/dts/armada-385-linksys.dtsi          |   9 +-
 arch/arm/boot/dts/armada-388-clearfog.dts          |  48 ++++-----
 arch/arm/boot/dts/armada-388-db.dts                |  25 ++---
 arch/arm/boot/dts/armada-388-gp.dts                |  30 +++---
 arch/arm/boot/dts/armada-388-rd.dts                |  25 ++---
 arch/arm/boot/dts/armada-38x.dtsi                  |  48 ++++-----
 arch/arm/boot/dts/armada-398-db.dts                |  48 ++++-----
 arch/arm/boot/dts/armada-39x.dtsi                  |  48 ++++-----
 arch/arm/boot/dts/armada-xp-axpwifiap.dts          |  24 ++---
 arch/arm/boot/dts/armada-xp-db.dts                 |  24 ++---
 arch/arm/boot/dts/armada-xp-gp.dts                 |  24 ++---
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts      |  24 ++---
 arch/arm/boot/dts/armada-xp-synology-ds414.dts     | 112 ++++++++++-----------
 arch/arm/boot/dts/armada-xp.dtsi                   |  27 +++--
 20 files changed, 398 insertions(+), 401 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index 2364fc5..033fa63 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -155,20 +155,6 @@
 				status = "okay";
 			};
 
-			spi0: spi at 10600 {
-				pinctrl-0 = <&spi0_pins2>;
-				pinctrl-names = "default";
-				status = "okay";
-
-				spi-flash at 0 {
-					#address-cells = <1>;
-					#size-cells = <1>;
-					compatible = "mx25l25635e", "jedec,spi-nor";
-					reg = <0>; /* Chip select 0 */
-					spi-max-frequency = <50000000>;
-				};
-			};
-
 			nand at d0000 {
 				status = "okay";
 				num-cs = <1>;
@@ -274,3 +260,18 @@
 		compatible = "linux,spdif-dir";
 	};
 };
+
+&spi0 {
+	pinctrl-0 = <&spi0_pins2>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	spi-flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "mx25l25635e", "jedec,spi-nor";
+		reg = <0>; /* Chip select 0 */
+		spi-max-frequency = <50000000>;
+	};
+};
+
diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
index 1aba08e..01cded3 100644
--- a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
+++ b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
@@ -68,26 +68,6 @@
 				phy-mode = "rgmii-id";
 			};
 
-			spi at 10600 {
-				status = "okay";
-				pinctrl-0 = <&spi0_pins2>;
-				pinctrl-names = "default";
-
-				spi-flash at 0 {
-					#address-cells = <1>;
-					#size-cells = <1>;
-					/* MX25L8006E */
-					compatible = "mxicy,mx25l8005", "jedec,spi-nor";
-					reg = <0>; /* Chip select 0 */
-					spi-max-frequency = <50000000>;
-
-					partition at 0 {
-						label = "u-boot";
-						reg = <0x0 0x100000>;
-					};
-				};
-			};
-
 			usb at 50000 {
 				status = "okay";
 			};
@@ -176,3 +156,23 @@
 		marvell,function = "gpio";
 	};
 };
+
+&spi0 {
+	status = "okay";
+	pinctrl-0 = <&spi0_pins2>;
+	pinctrl-names = "default";
+
+	spi-flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		/* MX25L8006E */
+		compatible = "mxicy,mx25l8005", "jedec,spi-nor";
+		reg = <0>; /* Chip select 0 */
+		spi-max-frequency = <50000000>;
+
+		partition at 0 {
+			label = "u-boot";
+			reg = <0x0 0x100000>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/armada-370-synology-ds213j.dts b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
index 8ca7a43..a9cc427 100644
--- a/arch/arm/boot/dts/armada-370-synology-ds213j.dts
+++ b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
@@ -87,62 +87,6 @@
 				status = "disabled";
 			};
 
-			spi0: spi at 10600 {
-				status = "okay";
-
-				spi-flash at 0 {
-					#address-cells = <1>;
-					#size-cells = <1>;
-					compatible = "micron,n25q064", "jedec,spi-nor";
-					reg = <0>; /* Chip select 0 */
-					spi-max-frequency = <20000000>;
-
-					/*
-					 * Warning!
-					 *
-					 * Synology u-boot uses its compiled-in environment
-					 * and it seems Synology did not care to change u-boot
-					 * default configuration in order to allow saving a
-					 * modified environment at a sensible location. So,
-					 * if you do a 'saveenv' under u-boot, your modified
-					 * environment will be saved at 1MB after the start
-					 * of the flash, i.e. in the middle of the uImage.
-					 * For that reason, it is strongly advised not to
-					 * change the default environment, unless you know
-					 * what you are doing.
-					 */
-					partition at 00000000 { /* u-boot */
-						label = "RedBoot";
-						reg = <0x00000000 0x000c0000>; /* 768KB */
-					};
-
-					partition at 000c0000 { /* uImage */
-						label = "zImage";
-						reg = <0x000c0000 0x002d0000>; /* 2880KB */
-					};
-
-					partition at 00390000 { /* uInitramfs */
-						label = "rd.gz";
-						reg = <0x00390000 0x00440000>; /* 4250KB */
-					};
-
-					partition at 007d0000 { /* MAC address and serial number */
-						label = "vendor";
-						reg = <0x007d0000 0x00010000>; /* 64KB */
-					};
-
-					partition at 007e0000 {
-						label = "RedBoot config";
-						reg = <0x007e0000 0x00010000>; /* 64KB */
-					};
-
-					partition at 007f0000 {
-						label = "FIS directory";
-						reg = <0x007f0000 0x00010000>; /* 64KB */
-					};
-				};
-			};
-
 			i2c at 11000 {
 				compatible = "marvell,mv64xxx-i2c";
 				pinctrl-0 = <&i2c0_pins>;
@@ -347,3 +291,59 @@
 		marvell,function = "gpio";
 	};
 };
+
+&spi0 {
+	status = "okay";
+
+	spi-flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "micron,n25q064", "jedec,spi-nor";
+		reg = <0>; /* Chip select 0 */
+		spi-max-frequency = <20000000>;
+
+		/*
+		 * Warning!
+		 *
+		 * Synology u-boot uses its compiled-in environment
+		 * and it seems Synology did not care to change u-boot
+		 * default configuration in order to allow saving a
+		 * modified environment at a sensible location. So,
+		 * if you do a 'saveenv' under u-boot, your modified
+		 * environment will be saved at 1MB after the start
+		 * of the flash, i.e. in the middle of the uImage.
+		 * For that reason, it is strongly advised not to
+		 * change the default environment, unless you know
+		 * what you are doing.
+		 */
+		partition at 00000000 { /* u-boot */
+			label = "RedBoot";
+			reg = <0x00000000 0x000c0000>; /* 768KB */
+		};
+
+		partition at 000c0000 { /* uImage */
+			label = "zImage";
+			reg = <0x000c0000 0x002d0000>; /* 2880KB */
+		};
+
+		partition at 00390000 { /* uInitramfs */
+			label = "rd.gz";
+			reg = <0x00390000 0x00440000>; /* 4250KB */
+		};
+
+		partition at 007d0000 { /* MAC address and serial number */
+			label = "vendor";
+			reg = <0x007d0000 0x00010000>; /* 64KB */
+		};
+
+		partition at 007e0000 {
+			label = "RedBoot config";
+			reg = <0x007e0000 0x00010000>; /* 64KB */
+		};
+
+		partition at 007f0000 {
+			label = "FIS directory";
+			reg = <0x007f0000 0x00010000>; /* 64KB */
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index a718866..a0903cd 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -148,26 +148,6 @@
 				interrupts = <50>;
 			};
 
-			spi0: spi at 10600 {
-				reg = <0x10600 0x28>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				cell-index = <0>;
-				interrupts = <30>;
-				clocks = <&coreclk 0>;
-				status = "disabled";
-			};
-
-			spi1: spi at 10680 {
-				reg = <0x10680 0x28>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				cell-index = <1>;
-				interrupts = <92>;
-				clocks = <&coreclk 0>;
-				status = "disabled";
-			};
-
 			i2c0: i2c at 11000 {
 				compatible = "marvell,mv64xxx-i2c";
 				#address-cells = <1>;
@@ -320,6 +300,26 @@
 				status = "disabled";
 			};
 		};
+
+		spi0: spi at 10600 {
+			reg = <MBUS_ID(0xf0, 0x01) 0x10600 0x28>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+			interrupts = <30>;
+			clocks = <&coreclk 0>;
+			status = "disabled";
+		};
+
+		spi1: spi at 10680 {
+			reg = <MBUS_ID(0xf0, 0x01) 0x10680 0x28>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <1>;
+			interrupts = <92>;
+			clocks = <&coreclk 0>;
+			status = "disabled";
+		};
 	};
 
 	clocks {
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 3b06aa8..b425810 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -134,24 +134,6 @@
 				wt-override;
 			};
 
-			/*
-			 * Default SPI pinctrl setting, can be overwritten on
-			 * board level if a different configuration is used.
-			 */
-			spi0: spi at 10600 {
-				compatible = "marvell,armada-370-spi",
-						"marvell,orion-spi";
-				pinctrl-0 = <&spi0_pins1>;
-				pinctrl-names = "default";
-			};
-
-			spi1: spi at 10680 {
-				compatible = "marvell,armada-370-spi",
-						"marvell,orion-spi";
-				pinctrl-0 = <&spi1_pins>;
-				pinctrl-names = "default";
-			};
-
 			i2c0: i2c at 11000 {
 				reg = <0x11000 0x20>;
 			};
@@ -447,3 +429,19 @@
 		marvell,function = "ge1";
 	};
 };
+
+/*
+ * Default SPI pinctrl setting, can be overwritten on
+ * board level if a different configuration is used.
+ */
+&spi0 {
+	compatible = "marvell,armada-370-spi", "marvell,orion-spi";
+	pinctrl-0 = <&spi0_pins1>;
+	pinctrl-names = "default";
+};
+
+&spi1 {
+	compatible = "marvell,armada-370-spi", "marvell,orion-spi";
+	pinctrl-0 = <&spi1_pins>;
+	pinctrl-names = "default";
+};
diff --git a/arch/arm/boot/dts/armada-385-db-ap.dts b/arch/arm/boot/dts/armada-385-db-ap.dts
index 2d3fd6e..ca38200 100644
--- a/arch/arm/boot/dts/armada-385-db-ap.dts
+++ b/arch/arm/boot/dts/armada-385-db-ap.dts
@@ -65,20 +65,6 @@
 			  MBUS_ID(0x0c, 0x04) 0 0xf1200000 0x100000>;
 
 		internal-regs {
-			spi1: spi at 10680 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&spi1_pins>;
-				status = "okay";
-
-				spi-flash at 0 {
-					#address-cells = <1>;
-					#size-cells = <1>;
-					compatible = "st,m25p128", "jedec,spi-nor";
-					reg = <0>; /* Chip select 0 */
-					spi-max-frequency = <54000000>;
-				};
-			};
-
 			i2c0: i2c at 11000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&i2c0_pins>;
@@ -239,3 +225,17 @@
 		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
 	};
 };
+
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_pins>;
+	status = "okay";
+
+	spi-flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "st,m25p128", "jedec,spi-nor";
+		reg = <0>; /* Chip select 0 */
+		spi-max-frequency = <54000000>;
+	};
+};
diff --git a/arch/arm/boot/dts/armada-385-linksys.dtsi b/arch/arm/boot/dts/armada-385-linksys.dtsi
index 3710755..af60cd3 100644
--- a/arch/arm/boot/dts/armada-385-linksys.dtsi
+++ b/arch/arm/boot/dts/armada-385-linksys.dtsi
@@ -62,11 +62,6 @@
 			  MBUS_ID(0x09, 0x05) 0 0xf1110000 0x10000>;
 
 		internal-regs {
-
-			spi at 10600 {
-				status = "disabled";
-			};
-
 			i2c at 11000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&i2c0_pins>;
@@ -332,3 +327,7 @@
 		marvell,function = "gpio";
 	};
 };
+
+&spi0 {
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/armada-388-clearfog.dts b/arch/arm/boot/dts/armada-388-clearfog.dts
index c60206e..fbeaebb 100644
--- a/arch/arm/boot/dts/armada-388-clearfog.dts
+++ b/arch/arm/boot/dts/armada-388-clearfog.dts
@@ -331,30 +331,6 @@
 				status = "okay";
 			};
 
-			spi at 10680 {
-				/*
-				 * We don't seem to have the W25Q32 on the
-				 * A1 Rev 2.0 boards, so disable SPI.
-				 * CS0: W25Q32 (doesn't appear to be present)
-				 * CS1:
-				 * CS2: mikrobus
-				 */
-				pinctrl-0 = <&spi1_pins
-					     &clearfog_spi1_cs_pins
-					     &mikro_spi_pins>;
-				pinctrl-names = "default";
-				status = "okay";
-
-				spi-flash at 0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					compatible = "w25q32", "jedec,spi-nor";
-					reg = <0>; /* Chip select 0 */
-					spi-max-frequency = <3000000>;
-					status = "disabled";
-				};
-			};
-
 			usb at 58000 {
 				/* CON3, nearest  power. */
 				status = "okay";
@@ -460,3 +436,27 @@
 		};
 	};
 };
+
+&spi1 {
+	/*
+	 * We don't seem to have the W25Q32 on the
+	 * A1 Rev 2.0 boards, so disable SPI.
+	 * CS0: W25Q32 (doesn't appear to be present)
+	 * CS1:
+	 * CS2: mikrobus
+	 */
+	pinctrl-0 = <&spi1_pins
+		     &clearfog_spi1_cs_pins
+		     &mikro_spi_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	spi-flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "w25q32", "jedec,spi-nor";
+		reg = <0>; /* Chip select 0 */
+		spi-max-frequency = <3000000>;
+		status = "disabled";
+	};
+};
diff --git a/arch/arm/boot/dts/armada-388-db.dts b/arch/arm/boot/dts/armada-388-db.dts
index ea93ed7..de26c76 100644
--- a/arch/arm/boot/dts/armada-388-db.dts
+++ b/arch/arm/boot/dts/armada-388-db.dts
@@ -70,18 +70,6 @@
 			  MBUS_ID(0x0c, 0x04) 0 0xf1200000 0x100000>;
 
 		internal-regs {
-			spi at 10600 {
-				status = "okay";
-
-				spi-flash at 0 {
-					#address-cells = <1>;
-					#size-cells = <1>;
-					compatible = "w25q32", "jedec,spi-nor";
-					reg = <0>; /* Chip select 0 */
-					spi-max-frequency = <108000000>;
-				};
-			};
-
 			i2c at 11000 {
 				status = "okay";
 				clock-frequency = <100000>;
@@ -201,3 +189,16 @@
 		};
 	};
 };
+
+&spi0 {
+	status = "okay";
+
+	spi-flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "w25q32", "jedec,spi-nor";
+		reg = <0>; /* Chip select 0 */
+		spi-max-frequency = <108000000>;
+	};
+};
+
diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
index fd75e5e9..895fa6c 100644
--- a/arch/arm/boot/dts/armada-388-gp.dts
+++ b/arch/arm/boot/dts/armada-388-gp.dts
@@ -64,21 +64,6 @@
 			  MBUS_ID(0x0c, 0x04) 0 0xf1200000 0x100000>;
 
 		internal-regs {
-			spi at 10600 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&spi0_pins>;
-				status = "okay";
-
-				spi-flash at 0 {
-					#address-cells = <1>;
-					#size-cells = <1>;
-					compatible = "st,m25p128", "jedec,spi-nor";
-					reg = <0>; /* Chip select 0 */
-					spi-max-frequency = <50000000>;
-					m25p,fast-read;
-				};
-			};
-
 			i2c at 11000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&i2c0_pins>;
@@ -433,3 +418,18 @@
 		marvell,function = "gpio";
 	};
 };
+
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins>;
+	status = "okay";
+
+	spi-flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "st,m25p128", "jedec,spi-nor";
+		reg = <0>; /* Chip select 0 */
+		spi-max-frequency = <50000000>;
+		m25p,fast-read;
+	};
+};
diff --git a/arch/arm/boot/dts/armada-388-rd.dts b/arch/arm/boot/dts/armada-388-rd.dts
index 853f973..dd3462dd 100644
--- a/arch/arm/boot/dts/armada-388-rd.dts
+++ b/arch/arm/boot/dts/armada-388-rd.dts
@@ -70,18 +70,6 @@
 			  MBUS_ID(0x09, 0x15) 0 0xf1110000 0x10000>;
 
 		internal-regs {
-			spi at 10600 {
-				status = "okay";
-
-				spi-flash at 0 {
-					#address-cells = <1>;
-					#size-cells = <1>;
-					compatible = "st,m25p128", "jedec,spi-nor";
-					reg = <0>; /* Chip select 0 */
-					spi-max-frequency = <108000000>;
-				};
-			};
-
 			i2c at 11000 {
 				status = "okay";
 				clock-frequency = <100000>;
@@ -142,3 +130,16 @@
 		};
 	};
 };
+
+&spi0 {
+	status = "okay";
+
+	spi-flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "st,m25p128", "jedec,spi-nor";
+		reg = <0>; /* Chip select 0 */
+		spi-max-frequency = <108000000>;
+	};
+};
+
diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 3312be6..c065ecd 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -170,30 +170,6 @@
 				      <0xc100 0x100>;
 			};
 
-			spi0: spi at 10600 {
-				compatible = "marvell,armada-380-spi",
-						"marvell,orion-spi";
-				reg = <0x10600 0x50>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				cell-index = <0>;
-				interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&coreclk 0>;
-				status = "disabled";
-			};
-
-			spi1: spi at 10680 {
-				compatible = "marvell,armada-380-spi",
-						"marvell,orion-spi";
-				reg = <0x10680 0x50>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				cell-index = <1>;
-				interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&coreclk 0>;
-				status = "disabled";
-			};
-
 			i2c0: i2c at 11000 {
 				compatible = "marvell,mv64xxx-i2c";
 				reg = <0x11000 0x20>;
@@ -649,6 +625,30 @@
 			no-memory-wc;
 			status = "disabled";
 		};
+
+		spi0: spi at 10600 {
+			compatible = "marvell,armada-380-spi",
+					"marvell,orion-spi";
+			reg = <MBUS_ID(0xf0, 0x01) 0x10600 0x50>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&coreclk 0>;
+			status = "disabled";
+		};
+
+		spi1: spi at 10680 {
+			compatible = "marvell,armada-380-spi",
+					"marvell,orion-spi";
+			reg = <MBUS_ID(0xf0, 0x01) 0x10680 0x50>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <1>;
+			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&coreclk 0>;
+			status = "disabled";
+		};
 	};
 
 	clocks {
diff --git a/arch/arm/boot/dts/armada-398-db.dts b/arch/arm/boot/dts/armada-398-db.dts
index 788c3ba..c5f14a7 100644
--- a/arch/arm/boot/dts/armada-398-db.dts
+++ b/arch/arm/boot/dts/armada-398-db.dts
@@ -65,30 +65,6 @@
 			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000>;
 
 		internal-regs {
-			spi at 10680 {
-				status = "okay";
-				pinctrl-0 = <&spi1_pins>;
-				pinctrl-names = "default";
-
-				spi-flash at 0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					compatible = "n25q128a13", "jedec,spi-nor";
-					reg = <0>;
-					spi-max-frequency = <108000000>;
-
-					partition at 0 {
-						label = "U-Boot";
-						reg = <0 0x400000>;
-					};
-
-					partition at 400000 {
-						label = "Filesystem";
-						reg = <0x400000 0x1000000>;
-					};
-				};
-			};
-
 			i2c at 11000 {
 				pinctrl-0 = <&i2c0_pins>;
 				pinctrl-names = "default";
@@ -151,3 +127,27 @@
 		};
 	};
 };
+
+&spi1 {
+	status = "okay";
+	pinctrl-0 = <&spi1_pins>;
+	pinctrl-names = "default";
+
+	spi-flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "n25q128a13", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <108000000>;
+
+		partition at 0 {
+			label = "U-Boot";
+			reg = <0 0x400000>;
+		};
+
+		partition at 400000 {
+			label = "Filesystem";
+			reg = <0x400000 0x1000000>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/armada-39x.dtsi b/arch/arm/boot/dts/armada-39x.dtsi
index dc6efd3..251a2b6 100644
--- a/arch/arm/boot/dts/armada-39x.dtsi
+++ b/arch/arm/boot/dts/armada-39x.dtsi
@@ -131,30 +131,6 @@
 				      <0xc100 0x100>;
 			};
 
-			spi0: spi at 10600 {
-				compatible = "marvell,armada-390-spi",
-						"marvell,orion-spi";
-				reg = <0x10600 0x50>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				cell-index = <0>;
-				interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&coreclk 0>;
-				status = "disabled";
-			};
-
-			spi1: spi at 10680 {
-				compatible = "marvell,armada-390-spi",
-						"marvell,orion-spi";
-				reg = <0x10680 0x50>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				cell-index = <1>;
-				interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&coreclk 0>;
-				status = "disabled";
-			};
-
 			i2c0: i2c at 11000 {
 				compatible = "marvell,mv64xxx-i2c";
 				reg = <0x11000 0x20>;
@@ -501,6 +477,30 @@
 				status = "disabled";
 			};
 		};
+
+		spi0: spi at 10600 {
+			compatible = "marvell,armada-390-spi",
+					"marvell,orion-spi";
+			reg = <MBUS_ID(0xf0, 0x01) 0x10600 0x50>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&coreclk 0>;
+			status = "disabled";
+		};
+
+		spi1: spi at 10680 {
+			compatible = "marvell,armada-390-spi",
+					"marvell,orion-spi";
+			reg = <MBUS_ID(0xf0, 0x01) 0x10680 0x50>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <1>;
+			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&coreclk 0>;
+			status = "disabled";
+		};
 	};
 
 	clocks {
diff --git a/arch/arm/boot/dts/armada-xp-axpwifiap.dts b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
index 5c21b23..ce15271 100644
--- a/arch/arm/boot/dts/armada-xp-axpwifiap.dts
+++ b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
@@ -135,18 +135,6 @@
 				phy = <&phy1>;
 				phy-mode = "rgmii-id";
 			};
-
-			spi0: spi at 10600 {
-				status = "okay";
-
-				spi-flash at 0 {
-					#address-cells = <1>;
-					#size-cells = <1>;
-					compatible = "n25q128a13", "jedec,spi-nor";
-					reg = <0>; /* Chip select 0 */
-					spi-max-frequency = <108000000>;
-				};
-			};
 		};
 	};
 
@@ -179,3 +167,15 @@
 		marvell,function = "gpio";
 	};
 };
+
+&spi0 {
+	status = "okay";
+
+	spi-flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "n25q128a13", "jedec,spi-nor";
+		reg = <0>; /* Chip select 0 */
+		spi-max-frequency = <108000000>;
+	};
+};
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index 62422a9..075120b 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -231,18 +231,6 @@
 				status = "okay";
 			};
 
-			spi0: spi at 10600 {
-				status = "okay";
-
-				spi-flash at 0 {
-					#address-cells = <1>;
-					#size-cells = <1>;
-					compatible = "m25p64", "jedec,spi-nor";
-					reg = <0>; /* Chip select 0 */
-					spi-max-frequency = <20000000>;
-				};
-			};
-
 			nand at d0000 {
 				status = "okay";
 				num-cs = <1>;
@@ -277,3 +265,15 @@
 		};
 	};
 };
+
+&spi0 {
+	status = "okay";
+
+	spi-flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "m25p64", "jedec,spi-nor";
+		reg = <0>; /* Chip select 0 */
+		spi-max-frequency = <20000000>;
+	};
+};
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 061f423..190e4ec 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -232,18 +232,6 @@
 				status = "okay";
 			};
 
-			spi0: spi at 10600 {
-				status = "okay";
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
 			bm at c0000 {
 				status = "okay";
 			};
@@ -262,3 +250,15 @@
 		};
 	};
 };
+
+&spi0 {
+	status = "okay";
+
+	spi-flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "n25q128a13", "jedec,spi-nor";
+		reg = <0>; /* Chip select 0 */
+		spi-max-frequency = <108000000>;
+	};
+};
diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
index b89e6cf..11ad9a8 100644
--- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
@@ -279,18 +279,6 @@
 					reg = <0x180000 0x780000>;   /* 7.5MB */
 				};
 			};
-
-			spi0: spi at 10600 {
-				status = "okay";
-
-				spi-flash at 0 {
-					#address-cells = <1>;
-					#size-cells = <1>;
-					compatible = "everspin,mr25h256";
-					reg = <0>; /* Chip select 0 */
-					spi-max-frequency = <40000000>;
-				};
-			};
 		};
 	};
 
@@ -398,3 +386,15 @@
 		marvell,function = "gpio";
 	};
 };
+
+&spi0 {
+	status = "okay";
+
+	spi-flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "everspin,mr25h256";
+		reg = <0>; /* Chip select 0 */
+		spi-max-frequency = <40000000>;
+	};
+};
diff --git a/arch/arm/boot/dts/armada-xp-synology-ds414.dts b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
index d17dab0..ae28673 100644
--- a/arch/arm/boot/dts/armada-xp-synology-ds414.dts
+++ b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
@@ -110,62 +110,6 @@
 				status = "disabled";
 			};
 
-			spi0: spi at 10600 {
-				status = "okay";
-
-				spi-flash at 0 {
-					#address-cells = <1>;
-					#size-cells = <1>;
-					compatible = "micron,n25q064", "jedec,spi-nor";
-					reg = <0>; /* Chip select 0 */
-					spi-max-frequency = <20000000>;
-
-					/*
-					 * Warning!
-					 *
-					 * Synology u-boot uses its compiled-in environment
-					 * and it seems Synology did not care to change u-boot
-					 * default configuration in order to allow saving a
-					 * modified environment at a sensible location. So,
-					 * if you do a 'saveenv' under u-boot, your modified
-					 * environment will be saved at 1MB after the start
-					 * of the flash, i.e. in the middle of the uImage.
-					 * For that reason, it is strongly advised not to
-					 * change the default environment, unless you know
-					 * what you are doing.
-					 */
-					partition at 00000000 { /* u-boot */
-						label = "RedBoot";
-						reg = <0x00000000 0x000d0000>; /* 832KB */
-					};
-
-					partition at 000c0000 { /* uImage */
-						label = "zImage";
-						reg = <0x000d0000 0x002d0000>; /* 2880KB */
-					};
-
-					partition at 003a0000 { /* uInitramfs */
-						label = "rd.gz";
-						reg = <0x003a0000 0x00430000>; /* 4250KB */
-					};
-
-					partition at 007d0000 { /* MAC address and serial number */
-						label = "vendor";
-						reg = <0x007d0000 0x00010000>; /* 64KB */
-					};
-
-					partition at 007e0000 {
-						label = "RedBoot config";
-						reg = <0x007e0000 0x00010000>; /* 64KB */
-					};
-
-					partition at 007f0000 {
-						label = "FIS directory";
-						reg = <0x007f0000 0x00010000>; /* 64KB */
-					};
-				};
-			};
-
 			i2c at 11000 {
 				clock-frequency = <400000>;
 				status = "okay";
@@ -362,3 +306,59 @@
 		marvell,function = "gpio";
 	};
 };
+
+&spi0 {
+	status = "okay";
+
+	spi-flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "micron,n25q064", "jedec,spi-nor";
+		reg = <0>; /* Chip select 0 */
+		spi-max-frequency = <20000000>;
+
+		/*
+		 * Warning!
+		 *
+		 * Synology u-boot uses its compiled-in environment
+		 * and it seems Synology did not care to change u-boot
+		 * default configuration in order to allow saving a
+		 * modified environment at a sensible location. So,
+		 * if you do a 'saveenv' under u-boot, your modified
+		 * environment will be saved at 1MB after the start
+		 * of the flash, i.e. in the middle of the uImage.
+		 * For that reason, it is strongly advised not to
+		 * change the default environment, unless you know
+		 * what you are doing.
+		 */
+		partition at 00000000 { /* u-boot */
+			label = "RedBoot";
+			reg = <0x00000000 0x000d0000>; /* 832KB */
+		};
+
+		partition at 000c0000 { /* uImage */
+			label = "zImage";
+			reg = <0x000d0000 0x002d0000>; /* 2880KB */
+		};
+
+		partition at 003a0000 { /* uInitramfs */
+			label = "rd.gz";
+			reg = <0x003a0000 0x00430000>; /* 4250KB */
+		};
+
+		partition at 007d0000 { /* MAC address and serial number */
+			label = "vendor";
+			reg = <0x007d0000 0x00010000>; /* 64KB */
+		};
+
+		partition at 007e0000 {
+			label = "RedBoot config";
+			reg = <0x007e0000 0x00010000>; /* 64KB */
+		};
+
+		partition at 007f0000 {
+			label = "FIS directory";
+			reg = <0x007f0000 0x00010000>; /* 64KB */
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 4033790..4a5f99e 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -84,21 +84,6 @@
 				wt-override;
 			};
 
-			spi0: spi at 10600 {
-				compatible = "marvell,armada-xp-spi",
-						"marvell,orion-spi";
-				pinctrl-0 = <&spi0_pins>;
-				pinctrl-names = "default";
-			};
-
-			spi1: spi at 10680 {
-				compatible = "marvell,armada-xp-spi",
-						"marvell,orion-spi";
-				pinctrl-0 = <&spi1_pins>;
-				pinctrl-names = "default";
-			};
-
-
 			i2c0: i2c at 11000 {
 				compatible = "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
 				reg = <0x11000 0x100>;
@@ -380,3 +365,15 @@
 		marvell,function = "uart3";
 	};
 };
+
+&spi0 {
+	compatible = "marvell,armada-xp-spi", "marvell,orion-spi";
+	pinctrl-0 = <&spi0_pins>;
+	pinctrl-names = "default";
+};
+
+&spi1 {
+	compatible = "marvell,armada-xp-spi", "marvell,orion-spi";
+	pinctrl-0 = <&spi1_pins>;
+	pinctrl-names = "default";
+};
-- 
2.8.1
