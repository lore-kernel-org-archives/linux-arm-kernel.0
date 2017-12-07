From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Thu,  7 Dec 2017 21:18:09 +0100
Subject: [PATCH 07/12] ARM: dts: armada-375: use reworked NAND controller
 driver
In-Reply-To: <20171207201814.30411-1-miquel.raynal@free-electrons.com>
References: <20171207201814.30411-1-miquel.raynal@free-electrons.com>
Message-ID: <20171207201814.30411-8-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new bindings of the reworked Marvell NAND controller driver.
Also adapt the nand controller node organization to distinguish which
property is relevant for the controller, and which one is NAND chip
specific. Expose the partitions as a subnode of the NAND chip.

Remove the 'marvell,nand-enable-arbiter' property, not needed anymore
as the driver activates the arbiter by default for all boards (either
needed or harmless).

Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
---
 arch/arm/boot/dts/armada-375-db.dts | 50 ++++++++++++++++++++++---------------
 arch/arm/boot/dts/armada-375.dtsi   |  6 ++---
 2 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/arch/arm/boot/dts/armada-375-db.dts b/arch/arm/boot/dts/armada-375-db.dts
index bcdbb8ba1d65..d33cca4e315d 100644
--- a/arch/arm/boot/dts/armada-375-db.dts
+++ b/arch/arm/boot/dts/armada-375-db.dts
@@ -140,28 +140,38 @@
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
-
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
+
+	nand at 0 {
+		reg = <0>;
+		label = "pxa3xx_nand-0";
+		marvell,rb = <0>;
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
index 2cb1bcd30976..46471173c7c1 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -539,11 +539,11 @@
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
2.11.0
