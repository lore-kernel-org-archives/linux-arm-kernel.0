From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 18 Aug 2015 10:09:00 +0200
Subject: [PATCH 09/10] ARM: marvell: use new bindings for existing crypto
 devices
In-Reply-To: <1439885341-14644-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1439885341-14644-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1439885341-14644-10-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new bindings split the crypto and sram node in two separate devices.
Modify the existing crypto nodes to match the new representation.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/dove.dtsi     | 15 ++++++++++++---
 arch/arm/boot/dts/kirkwood.dtsi | 29 +++++++++++++++++++----------
 arch/arm/boot/dts/orion5x.dtsi  | 22 +++++++++++++++-------
 3 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 1791216..9bb3131 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -264,11 +264,12 @@
 
 			crypto: crypto-engine at 30000 {
 				compatible = "marvell,orion-crypto";
-				reg = <0x30000 0x10000>,
-				      <0xffffe000 0x800>;
-				reg-names = "regs", "sram";
+				reg = <0x30000 0x10000>;
+				reg-names = "regs";
 				interrupts = <31>;
 				clocks = <&gate_clk 15>;
+				marvell,crypto-srams = <&crypto_sram>;
+				marvell,crypto-sram-size = <0x800>;
 				status = "okay";
 			};
 
@@ -767,6 +768,14 @@
 				interrupts = <47>;
 				status = "disabled";
 			};
+
+			crypto_sram: sa-sram at ffffe000 {
+				compatible = "mmio-sram";
+				reg = <0xffffe000 0x800>;
+				clocks = <&gate_clk 15>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 464f09a..c5f913b 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -40,16 +40,6 @@
 		pcie-mem-aperture = <0xe0000000 0x10000000>; /* 256 MiB memory space */
 		pcie-io-aperture  = <0xf2000000 0x100000>;   /*   1 MiB    I/O space */
 
-		cesa: crypto at 0301 {
-			compatible = "marvell,orion-crypto";
-			reg = <MBUS_ID(0xf0, 0x01) 0x30000 0x10000>,
-			      <MBUS_ID(0x03, 0x01) 0 0x800>;
-			reg-names = "regs", "sram";
-			interrupts = <22>;
-			clocks = <&gate_clk 17>;
-			status = "okay";
-		};
-
 		nand: nand at 012f {
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -65,6 +55,14 @@
 			pinctrl-names = "default";
 			status = "disabled";
 		};
+
+		crypto_sram: sa-sram at 0301 {
+			compatible = "mmio-sram";
+			reg = <MBUS_ID(0x03, 0x01) 0x0 0x800>;
+			clocks = <&gate_clk 17>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
 	};
 
 	ocp at f1000000 {
@@ -252,6 +250,17 @@
 			status = "okay";
 		};
 
+		cesa: crypto at 30000 {
+			compatible = "marvell,orion-crypto";
+			reg = <0x30000 0x10000>;
+			reg-names = "regs";
+			interrupts = <22>;
+			clocks = <&gate_clk 17>;
+			marvell,crypto-srams = <&crypto_sram>;
+			marvell,crypto-sram-size = <0x800>;
+			status = "okay";
+		};
+
 		usb0: ehci at 50000 {
 			compatible = "marvell,orion-ehci";
 			reg = <0x50000 0x1000>;
diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/orion5x.dtsi
index 75cd01b..e1b6d2a 100644
--- a/arch/arm/boot/dts/orion5x.dtsi
+++ b/arch/arm/boot/dts/orion5x.dtsi
@@ -212,6 +212,16 @@
 				status = "disabled";
 			};
 
+			cesa: crypto at 90000 {
+				compatible = "marvell,orion-crypto";
+				reg = <0x90000 0x10000>;
+				reg-names = "regs";
+				interrupts = <28>;
+				marvell,crypto-srams = <&crypto_sram>;
+				marvell,crypto-sram-size = <0x800>;
+				status = "okay";
+			};
+
 			ehci1: ehci at a0000 {
 				compatible = "marvell,orion-ehci";
 				reg = <0xa0000 0x1000>;
@@ -220,13 +230,11 @@
 			};
 		};
 
-		cesa: crypto at 90000 {
-			compatible = "marvell,orion-crypto";
-			reg = <MBUS_ID(0xf0, 0x01) 0x90000 0x10000>,
-			      <MBUS_ID(0x09, 0x00) 0x0 0x800>;
-			reg-names = "regs", "sram";
-			interrupts = <28>;
-			status = "okay";
+		crypto_sram: sa-sram {
+			compatible = "mmio-sram";
+			reg = <MBUS_ID(0x09, 0x00) 0x0 0x800>;
+			#address-cells = <1>;
+			#size-cells = <1>;
 		};
 	};
 };
-- 
1.9.1
