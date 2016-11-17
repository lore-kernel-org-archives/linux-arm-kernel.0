From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Nov 2016 00:04:56 +0100
Subject: [PATCH v3 07/19] ARM: dts: armada-370-xp: Fixup devbus DT warning
In-Reply-To: <20161117230508.28539-1-gregory.clement@free-electrons.com>
References: <20161117230508.28539-1-gregory.clement@free-electrons.com>
Message-ID: <20161117230508.28539-8-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

devbus has a reg property so the unit name should contain an address.
Take the opportunity to use the node label instead of the full name.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi             | 15 ++++---
 arch/arm/boot/dts/armada-xp-db.dts               | 56 ++++++++++++------------
 arch/arm/boot/dts/armada-xp-gp.dts               | 56 ++++++++++++------------
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 56 ++++++++++++------------
 4 files changed, 94 insertions(+), 89 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index a4f9684def1c..d273142eafe3 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -86,7 +86,12 @@
 		pcie-mem-aperture = <0xf8000000 0x7e00000>;
 		pcie-io-aperture  = <0xffe00000 0x100000>;
 
-		devbus_bootcs: devbus-bootcs {
+		/* The following unit addresses (for devbus) are composed of
+		 * the target value (bit [40-47]), attributes value (bits
+		 * [32-39], and the address value in the window memory: [0-31].
+		 */
+
+		devbus_bootcs: devbus-bootcs at f00100010400 {
 			compatible = "marvell,mvebu-devbus";
 			reg = <MBUS_ID(0xf0, 0x01) 0x10400 0x8>;
 			ranges = <0 MBUS_ID(0x01, 0x2f) 0 0xffffffff>;
@@ -96,7 +101,7 @@
 			status = "disabled";
 		};
 
-		devbus_cs0: devbus-cs0 {
+		devbus_cs0: devbus-cs at f00100010408 {
 			compatible = "marvell,mvebu-devbus";
 			reg = <MBUS_ID(0xf0, 0x01) 0x10408 0x8>;
 			ranges = <0 MBUS_ID(0x01, 0x3e) 0 0xffffffff>;
@@ -106,7 +111,7 @@
 			status = "disabled";
 		};
 
-		devbus_cs1: devbus-cs1 {
+		devbus_cs1: devbus-cs at f00100010410 {
 			compatible = "marvell,mvebu-devbus";
 			reg = <MBUS_ID(0xf0, 0x01) 0x10410 0x8>;
 			ranges = <0 MBUS_ID(0x01, 0x3d) 0 0xffffffff>;
@@ -116,7 +121,7 @@
 			status = "disabled";
 		};
 
-		devbus_cs2: devbus-cs2 {
+		devbus_cs2: devbus-cs at f00100010448 {
 			compatible = "marvell,mvebu-devbus";
 			reg = <MBUS_ID(0xf0, 0x01) 0x10418 0x8>;
 			ranges = <0 MBUS_ID(0x01, 0x3b) 0 0xffffffff>;
@@ -126,7 +131,7 @@
 			status = "disabled";
 		};
 
-		devbus_cs3: devbus-cs3 {
+		devbus_cs3: devbus-cs at f00100010420 {
 			compatible = "marvell,mvebu-devbus";
 			reg = <MBUS_ID(0xf0, 0x01) 0x10420 0x8>;
 			ranges = <0 MBUS_ID(0x01, 0x37) 0 0xffffffff>;
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index 665c81ff98db..9e3bb3d7b4dc 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -80,34 +80,6 @@
 			  MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000
 			  MBUS_ID(0x0c, 0x04) 0 0 0xf1200000 0x100000>;
 
-		devbus-bootcs {
-			status = "okay";
-
-			/* Device Bus parameters are required */
-
-			/* Read parameters */
-			devbus,bus-width    = <16>;
-			devbus,turn-off-ps  = <60000>;
-			devbus,badr-skew-ps = <0>;
-			devbus,acc-first-ps = <124000>;
-			devbus,acc-next-ps  = <248000>;
-			devbus,rd-setup-ps  = <0>;
-			devbus,rd-hold-ps   = <0>;
-
-			/* Write parameters */
-			devbus,sync-enable = <0>;
-			devbus,wr-high-ps  = <60000>;
-			devbus,wr-low-ps   = <60000>;
-			devbus,ale-wr-ps   = <60000>;
-
-			/* NOR 16 MiB */
-			nor at 0 {
-				compatible = "cfi-flash";
-				reg = <0 0x1000000>;
-				bank-width = <2>;
-			};
-		};
-
 		pcie-controller {
 			status = "okay";
 
@@ -248,6 +220,34 @@
 	};
 };
 
+&devbus_bootcs {
+	status = "okay";
+
+	/* Device Bus parameters are required */
+
+	/* Read parameters */
+	devbus,bus-width    = <16>;
+	devbus,turn-off-ps  = <60000>;
+	devbus,badr-skew-ps = <0>;
+	devbus,acc-first-ps = <124000>;
+	devbus,acc-next-ps  = <248000>;
+	devbus,rd-setup-ps  = <0>;
+	devbus,rd-hold-ps   = <0>;
+
+	/* Write parameters */
+	devbus,sync-enable = <0>;
+	devbus,wr-high-ps  = <60000>;
+	devbus,wr-low-ps   = <60000>;
+	devbus,ale-wr-ps   = <60000>;
+
+	/* NOR 16 MiB */
+	nor at 0 {
+		compatible = "cfi-flash";
+		reg = <0 0x1000000>;
+		bank-width = <2>;
+	};
+};
+
 &mdio {
 	phy0: ethernet-phy at 0 {
 		reg = <0>;
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 09c9cabdf67a..9918c7883a36 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -99,34 +99,6 @@
 			  MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000
 			  MBUS_ID(0x0c, 0x04) 0 0 0xf1200000 0x100000>;
 
-		devbus-bootcs {
-			status = "okay";
-
-			/* Device Bus parameters are required */
-
-			/* Read parameters */
-			devbus,bus-width    = <16>;
-			devbus,turn-off-ps  = <60000>;
-			devbus,badr-skew-ps = <0>;
-			devbus,acc-first-ps = <124000>;
-			devbus,acc-next-ps  = <248000>;
-			devbus,rd-setup-ps  = <0>;
-			devbus,rd-hold-ps   = <0>;
-
-			/* Write parameters */
-			devbus,sync-enable = <0>;
-			devbus,wr-high-ps  = <60000>;
-			devbus,wr-low-ps   = <60000>;
-			devbus,ale-wr-ps   = <60000>;
-
-			/* NOR 16 MiB */
-			nor at 0 {
-				compatible = "cfi-flash";
-				reg = <0 0x1000000>;
-				bank-width = <2>;
-			};
-		};
-
 		pcie-controller {
 			status = "okay";
 
@@ -233,6 +205,34 @@
 	};
 };
 
+&devbus_bootcs {
+	status = "okay";
+
+	/* Device Bus parameters are required */
+
+	/* Read parameters */
+	devbus,bus-width    = <16>;
+	devbus,turn-off-ps  = <60000>;
+	devbus,badr-skew-ps = <0>;
+	devbus,acc-first-ps = <124000>;
+	devbus,acc-next-ps  = <248000>;
+	devbus,rd-setup-ps  = <0>;
+	devbus,rd-hold-ps   = <0>;
+
+	/* Write parameters */
+	devbus,sync-enable = <0>;
+	devbus,wr-high-ps  = <60000>;
+	devbus,wr-low-ps   = <60000>;
+	devbus,ale-wr-ps   = <60000>;
+
+	/* NOR 16 MiB */
+	nor at 0 {
+		compatible = "cfi-flash";
+		reg = <0 0x1000000>;
+		bank-width = <2>;
+	};
+};
+
 &mdio {
 	phy0: ethernet-phy at 0 {
 		reg = <16>;
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index 2e2cd9353761..c8dd5a3bccb6 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -70,34 +70,6 @@
 			  MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000
 			  MBUS_ID(0x0c, 0x04) 0 0 0xd1200000 0x100000>;
 
-		devbus-bootcs {
-			status = "okay";
-
-			/* Device Bus parameters are required */
-
-			/* Read parameters */
-			devbus,bus-width    = <16>;
-			devbus,turn-off-ps  = <60000>;
-			devbus,badr-skew-ps = <0>;
-			devbus,acc-first-ps = <124000>;
-			devbus,acc-next-ps  = <248000>;
-			devbus,rd-setup-ps  = <0>;
-			devbus,rd-hold-ps   = <0>;
-
-			/* Write parameters */
-			devbus,sync-enable = <0>;
-			devbus,wr-high-ps  = <60000>;
-			devbus,wr-low-ps   = <60000>;
-			devbus,ale-wr-ps   = <60000>;
-
-			/* NOR 128 MiB */
-			nor at 0 {
-				compatible = "cfi-flash";
-				reg = <0 0x8000000>;
-				bank-width = <2>;
-			};
-		};
-
 		pcie-controller {
 			status = "okay";
 			/* Internal mini-PCIe connector */
@@ -222,6 +194,34 @@
 	};
 };
 
+&devbus_bootcs {
+	status = "okay";
+
+	/* Device Bus parameters are required */
+
+	/* Read parameters */
+	devbus,bus-width    = <16>;
+	devbus,turn-off-ps  = <60000>;
+	devbus,badr-skew-ps = <0>;
+	devbus,acc-first-ps = <124000>;
+	devbus,acc-next-ps  = <248000>;
+	devbus,rd-setup-ps  = <0>;
+	devbus,rd-hold-ps   = <0>;
+
+	/* Write parameters */
+	devbus,sync-enable = <0>;
+	devbus,wr-high-ps  = <60000>;
+	devbus,wr-low-ps   = <60000>;
+	devbus,ale-wr-ps   = <60000>;
+
+	/* NOR 128 MiB */
+	nor at 0 {
+		compatible = "cfi-flash";
+		reg = <0 0x8000000>;
+		bank-width = <2>;
+	};
+};
+
 &mdio {
 	phy0: ethernet-phy at 0 {
 		reg = <0>;
-- 
2.10.2
