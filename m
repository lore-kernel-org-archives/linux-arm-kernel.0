From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Wed, 25 Apr 2018 16:48:02 +0200
Subject: [PATCH v2 4/4] ARM: dts: armada-39x: update NAND node with new
 bindings
In-Reply-To: <20180425144802.15998-1-miquel.raynal@bootlin.com>
References: <20180425144802.15998-1-miquel.raynal@bootlin.com>
Message-ID: <20180425144802.15998-5-miquel.raynal@bootlin.com>
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
 arch/arm/boot/dts/armada-390-db.dts | 66 +++++++++++++++++----------------
 arch/arm/boot/dts/armada-395-gp.dts | 74 +++++++++++++++++++------------------
 arch/arm/boot/dts/armada-398-db.dts | 60 +++++++++++++++++-------------
 arch/arm/boot/dts/armada-39x.dtsi   |  6 +--
 4 files changed, 112 insertions(+), 94 deletions(-)

diff --git a/arch/arm/boot/dts/armada-390-db.dts b/arch/arm/boot/dts/armada-390-db.dts
index 1b2362e4c831..0e29474ae9a2 100644
--- a/arch/arm/boot/dts/armada-390-db.dts
+++ b/arch/arm/boot/dts/armada-390-db.dts
@@ -49,37 +49,6 @@
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
@@ -136,3 +105,38 @@
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
+		nand-rb = <0>;
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
index 2a9de192b423..6dd9e9077f84 100644
--- a/arch/arm/boot/dts/armada-395-gp.dts
+++ b/arch/arm/boot/dts/armada-395-gp.dts
@@ -57,41 +57,6 @@
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
@@ -130,3 +95,42 @@
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
index 2337f24784f7..fc28308e5bc5 100644
--- a/arch/arm/boot/dts/armada-398-db.dts
+++ b/arch/arm/boot/dts/armada-398-db.dts
@@ -51,31 +51,6 @@
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
@@ -122,3 +97,38 @@
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
+		nand-rb = <0>;
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
index c1737c0a8325..f0c949831efb 100644
--- a/arch/arm/boot/dts/armada-39x.dtsi
+++ b/arch/arm/boot/dts/armada-39x.dtsi
@@ -367,11 +367,11 @@
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
2.14.1
