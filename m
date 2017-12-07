From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Thu,  7 Dec 2017 21:18:11 +0100
Subject: [PATCH 09/12] ARM: dts: armada-39x: use reworked NAND controller
 driver
In-Reply-To: <20171207201814.30411-1-miquel.raynal@free-electrons.com>
References: <20171207201814.30411-1-miquel.raynal@free-electrons.com>
Message-ID: <20171207201814.30411-10-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new bindings of the reworked Marvell NAND controller driver.
Also adapt the nand controller node organization to distinguish which
property is relevant for the controller, and which one is NAND chip
specific. Expose the partitions as a subnode of the NAND chip.

Remove the 'marvell,nand-enable-arbiter' property, not needed anymore as
the driver activates the arbiter by default for all boards (either
needed or harmless).

Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
---
 arch/arm/boot/dts/armada-390-db.dts | 66 +++++++++++++++++----------------
 arch/arm/boot/dts/armada-395-gp.dts | 74 +++++++++++++++++++------------------
 arch/arm/boot/dts/armada-398-db.dts | 60 +++++++++++++++++-------------
 arch/arm/boot/dts/armada-39x.dtsi   |  6 +--
 4 files changed, 112 insertions(+), 94 deletions(-)

diff --git a/arch/arm/boot/dts/armada-390-db.dts b/arch/arm/boot/dts/armada-390-db.dts
index c718a5242595..2135a48cd385 100644
--- a/arch/arm/boot/dts/armada-390-db.dts
+++ b/arch/arm/boot/dts/armada-390-db.dts
@@ -86,37 +86,6 @@
 				status = "okay";
 			};
 
-			flash at d0000 {
-				status = "okay";
-				pinctrl-0 = <&nand_pins>;
-				pinctrl-names = "default";
-				num-cs = <1>;
-				marvell,nand-keep-config;
-				marvell,nand-enable-arbiter;
-				nand-on-flash-bbt;
-				nand-ecc-strength = <8>;
-				nand-ecc-step-size = <512>;
-
-				partitions {
-					compatible = "fixed-partitions";
-					#address-cells = <1>;
-					#size-cells = <1>;
-
-					partition at 0 {
-						label = "U-Boot";
-						reg = <0 0x800000>;
-					};
-					partition at 800000 {
-						label = "Linux";
-						reg = <0x800000 0x800000>;
-					};
-					partition at 1000000 {
-						label = "Filesystem";
-						reg = <0x1000000 0x3f000000>;
-					};
-				};
-			};
-
 			/* CON98 */
 			usb3 at f8000 {
 				status = "okay";
@@ -173,3 +142,38 @@
 		};
 	};
 };
+
+&nand_controller {
+	status = "okay";
+	pinctrl-0 = <&nand_pins>;
+	pinctrl-names = "default";
+
+	nand at 0 {
+		reg = <0>;
+		label = "pxa3xx_nand-0";
+		marvell,rb = <0>;
+		marvell,nand-keep-config;
+		nand-on-flash-bbt;
+		nand-ecc-strength = <8>;
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
+	};
+};
diff --git a/arch/arm/boot/dts/armada-395-gp.dts b/arch/arm/boot/dts/armada-395-gp.dts
index ef491b524fd6..d3422f77d057 100644
--- a/arch/arm/boot/dts/armada-395-gp.dts
+++ b/arch/arm/boot/dts/armada-395-gp.dts
@@ -88,41 +88,6 @@
 				status = "okay";
 			};
 
-			flash at d0000 {
-				status = "okay";
-				pinctrl-0 = <&nand_pins>;
-				pinctrl-names = "default";
-				num-cs = <1>;
-				marvell,nand-keep-config;
-				marvell,nand-enable-arbiter;
-				nand-on-flash-bbt;
-				nand-ecc-strength = <4>;
-				nand-ecc-step-size = <512>;
-
-				partitions {
-					compatible = "fixed-partitions";
-					#address-cells = <1>;
-					#size-cells = <1>;
-
-					partition at 0 {
-						label = "U-Boot";
-						reg = <0x00000000 0x00600000>;
-						read-only;
-					};
-
-					partition at 800000 {
-						label = "uImage";
-						reg = <0x00600000 0x00400000>;
-						read-only;
-					};
-
-					partition at 1000000 {
-						label = "Root";
-						reg = <0x00a00000 0x3f600000>;
-					};
-				};
-			};
-
 			/* CON18 */
 			sdhci at d8000 {
 				clock-frequency = <200000000>;
@@ -161,3 +126,42 @@
 		};
 	};
 };
+
+&nand_controller {
+	status = "okay";
+	pinctrl-0 = <&nand_pins>;
+	pinctrl-names = "default";
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
+				reg = <0x00000000 0x00600000>;
+				read-only;
+			};
+
+			partition at 800000 {
+				label = "uImage";
+				reg = <0x00600000 0x00400000>;
+				read-only;
+			};
+
+			partition at 1000000 {
+				label = "Root";
+				reg = <0x00a00000 0x3f600000>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/armada-398-db.dts b/arch/arm/boot/dts/armada-398-db.dts
index f0e0379f7619..e73e5e453fd7 100644
--- a/arch/arm/boot/dts/armada-398-db.dts
+++ b/arch/arm/boot/dts/armada-398-db.dts
@@ -88,31 +88,6 @@
 				status = "okay";
 			};
 
-			flash at d0000 {
-				status = "okay";
-				pinctrl-0 = <&nand_pins>;
-				pinctrl-names = "default";
-				num-cs = <1>;
-				marvell,nand-keep-config;
-				marvell,nand-enable-arbiter;
-				nand-on-flash-bbt;
-				nand-ecc-strength = <8>;
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
 			usb3 at f8000 {
 				status = "okay";
 			};
@@ -159,3 +134,38 @@
 		};
 	};
 };
+
+&nand_controller {
+	status = "okay";
+	pinctrl-0 = <&nand_pins>;
+	pinctrl-names = "default";
+
+	nand at 0 {
+		reg = <0>;
+		label = "pxa3xx_nand-0";
+		marvell,rb = <0>;
+		marvell,nand-keep-config;
+		nand-on-flash-bbt;
+		nand-ecc-strength = <8>;
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
+	};
+};
diff --git a/arch/arm/boot/dts/armada-39x.dtsi b/arch/arm/boot/dts/armada-39x.dtsi
index 5218bd2a248d..a8322de3f0b3 100644
--- a/arch/arm/boot/dts/armada-39x.dtsi
+++ b/arch/arm/boot/dts/armada-39x.dtsi
@@ -404,11 +404,11 @@
 				interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
-			flash at d0000 {
-				compatible = "marvell,armada370-nand";
+			nand_controller: nand-controller at d0000 {
+				compatible = "marvell,armada370-nand-controller";
 				reg = <0xd0000 0x54>;
 				#address-cells = <1>;
-				#size-cells = <1>;
+				#size-cells = <0>;
 				interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&coredivclk 0>;
 				status = "disabled";
-- 
2.11.0
