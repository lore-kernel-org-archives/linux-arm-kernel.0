From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Wed, 25 Apr 2018 16:48:00 +0200
Subject: [PATCH v2 2/4] ARM: dts: armada-375: update NAND node with new
 bindings
In-Reply-To: <20180425144802.15998-1-miquel.raynal@bootlin.com>
References: <20180425144802.15998-1-miquel.raynal@bootlin.com>
Message-ID: <20180425144802.15998-3-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new bindings of the Marvell NAND controller driver. Also adapt
the NAND controller node organization to distinguish which property is
relevant for the controller, and which one is NAND chip specific. Expose
the partitions as a subnode of the NAND chip.

Remove the 'marvell,nand-enable-arbiter' property, not needed anymore
as the new driver activates the arbiter by default for all boards which
is either needed or harmless.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm/boot/dts/armada-375-db.dts | 48 ++++++++++++++++++++++---------------
 arch/arm/boot/dts/armada-375.dtsi   |  6 ++---
 2 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/armada-375-db.dts b/arch/arm/boot/dts/armada-375-db.dts
index e4ecd7e75644..0e679465cbb5 100644
--- a/arch/arm/boot/dts/armada-375-db.dts
+++ b/arch/arm/boot/dts/armada-375-db.dts
@@ -103,28 +103,38 @@
 	nr-ports = <2>;
 };
 
-&nand {
+&nand_controller {
+	status = "okay";
 	pinctrl-0 = <&nand_pins>;
 	pinctrl-names = "default";
-	status = "okay";
-	num-cs = <1>;
-	marvell,nand-keep-config;
-	marvell,nand-enable-arbiter;
-	nand-on-flash-bbt;
-	nand-ecc-strength = <4>;
-	nand-ecc-step-size = <512>;
 
-	partition at 0 {
-		label = "U-Boot";
-		reg = <0 0x800000>;
-	};
-	partition at 800000 {
-		label = "Linux";
-		reg = <0x800000 0x800000>;
-	};
-	partition at 1000000 {
-		label = "Filesystem";
-		reg = <0x1000000 0x3f000000>;
+	nand at 0 {
+		reg = <0>;
+		label = "pxa3xx_nand-0";
+		nand-rb = <0>;
+		marvell,nand-keep-config;
+		nand-on-flash-bbt;
+		nand-ecc-strength = <4>;
+		nand-ecc-step-size = <512>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition at 0 {
+				label = "U-Boot";
+				reg = <0 0x800000>;
+			};
+			partition at 800000 {
+				label = "Linux";
+				reg = <0x800000 0x800000>;
+			};
+			partition at 1000000 {
+				label = "Filesystem";
+				reg = <0x1000000 0x3f000000>;
+			};
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index 53ead6f26a0e..2932a29ae272 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -502,11 +502,11 @@
 				status = "disabled";
 			};
 
-			nand: nand at d0000 {
-				compatible = "marvell,armada370-nand";
+			nand_controller: nand-controller at d0000 {
+				compatible = "marvell,armada370-nand-controller";
 				reg = <0xd0000 0x54>;
 				#address-cells = <1>;
-				#size-cells = <1>;
+				#size-cells = <0>;
 				interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gateclk 11>;
 				status = "disabled";
-- 
2.14.1
