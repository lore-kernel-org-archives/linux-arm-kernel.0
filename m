From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Thu, 16 Mar 2017 06:53:19 +0100
Subject: [PATCH v2] ARM: dts: mvebu: linksys: enable buffer manager support
Message-ID: <20170316055320.7929-1-ralph.sennhauser@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add appropriate properties to devices in the Linksys WRT AC Series for the
mvneta driver to use hardware buffer management.

Also update "soc" ranges property and set the status of bm and bm-bppi
to "okay" (SRAM).

Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
---

v1 -> v2:
	Use independent pools for short (suggested by Gregory Clement)


 arch/arm/boot/dts/armada-385-linksys.dtsi     | 17 ++++++++++++++++-
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts | 17 ++++++++++++++++-
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-385-linksys.dtsi b/arch/arm/boot/dts/armada-385-linksys.dtsi
index df47bf1..aa0d225 100644
--- a/arch/arm/boot/dts/armada-385-linksys.dtsi
+++ b/arch/arm/boot/dts/armada-385-linksys.dtsi
@@ -59,7 +59,8 @@
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x19) 0 0xf1100000 0x10000
-			  MBUS_ID(0x09, 0x15) 0 0xf1110000 0x10000>;
+			  MBUS_ID(0x09, 0x15) 0 0xf1110000 0x10000
+			  MBUS_ID(0x0c, 0x04) 0 0xf1200000 0x100000>;
 
 		internal-regs {
 			i2c at 11000 {
@@ -88,6 +89,9 @@
 			ethernet at 70000 {
 				status = "okay";
 				phy-mode = "rgmii-id";
+				buffer-manager = <&bm>;
+				bm,pool-long = <2>;
+				bm,pool-short = <3>;
 				fixed-link {
 					speed = <1000>;
 					full-duplex;
@@ -97,6 +101,9 @@
 			ethernet at 34000 {
 				status = "okay";
 				phy-mode = "sgmii";
+				buffer-manager = <&bm>;
+				bm,pool-long = <0>;
+				bm,pool-short = <1>;
 				fixed-link {
 					speed = <1000>;
 					full-duplex;
@@ -159,6 +166,10 @@
 				status = "okay";
 			};
 
+			bm at c8000 {
+				status = "okay";
+			};
+
 			/* USB part of the eSATA/USB 2.0 port */
 			usb at 58000 {
 				status = "okay";
@@ -241,6 +252,10 @@
 			};
 		};
 
+		bm-bppi {
+			status = "okay";
+		};
+
 		pcie-controller {
 			status = "okay";
 
diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
index 3744ba3..9efcf59 100644
--- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
@@ -71,7 +71,8 @@
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
-			  MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000>;
+			  MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000
+			  MBUS_ID(0x0c, 0x04) 0 0 0xf1200000 0x100000>;
 
 		internal-regs {
 
@@ -95,6 +96,9 @@
 				pinctrl-names = "default";
 				status = "okay";
 				phy-mode = "rgmii-id";
+				buffer-manager = <&bm>;
+				bm,pool-long = <0>;
+				bm,pool-short = <1>;
 				fixed-link {
 					speed = <1000>;
 					full-duplex;
@@ -106,6 +110,9 @@
 				pinctrl-names = "default";
 				status = "okay";
 				phy-mode = "rgmii-id";
+				buffer-manager = <&bm>;
+				bm,pool-long = <2>;
+				bm,pool-short = <3>;
 				fixed-link {
 					speed = <1000>;
 					full-duplex;
@@ -186,6 +193,10 @@
 				};
 			};
 
+			bm at c8000 {
+				status = "okay";
+			};
+
 			nand at d0000 {
 				status = "okay";
 				num-cs = <1>;
@@ -259,6 +270,10 @@
 				};
 			};
 		};
+
+		bm-bppi {
+			status = "okay";
+		};
 	};
 
 	gpio_keys {
-- 
2.10.2
