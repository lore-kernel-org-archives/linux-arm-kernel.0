From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu, 16 Feb 2017 21:50:37 +1300
Subject: [PATCH v3 3/6] ARM: dts: Use armada-370-xp as a base for
 armada-xp-98dx3236
In-Reply-To: <20170216085041.28337-1-chris.packham@alliedtelesis.co.nz>
References: <20170216085041.28337-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170216085041.28337-4-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell datasheets refer to the integrated CPU as "Armada-XP". In
reality there are a number of differences to the actual Armada-XP so
rather than including armada-xp.dtsi and disabling many of the IP
blocks. Include armada-370-xp.dtsi and add the required nodes.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v2:
    - Update root compatible strings in armada-xp-98dx3336.dtsi,
      armada-xp-98dx4251.dtsi, armada-xp-db-dxbc2.dts and
      armada-xp-db-xc3-24g4xg.dts
    Changes in v3:
    - none

 arch/arm/boot/dts/armada-xp-98dx3236.dtsi     | 194 ++++++++++++++++++++------
 arch/arm/boot/dts/armada-xp-98dx3336.dtsi     |   2 +-
 arch/arm/boot/dts/armada-xp-98dx4251.dtsi     |   2 +-
 arch/arm/boot/dts/armada-xp-db-dxbc2.dts      |   2 +-
 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts |   2 +-
 5 files changed, 155 insertions(+), 47 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
index 7eaa7da84770..5e7245524d46 100644
--- a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
+++ b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
@@ -45,11 +45,14 @@
  * common to all Armada XP SoCs.
  */
 
-#include "armada-xp.dtsi"
+#include "armada-370-xp.dtsi"
 
 / {
+	#address-cells = <2>;
+	#size-cells = <2>;
+
 	model = "Marvell 98DX3236 SoC";
-	compatible = "marvell,armadaxp-98dx3236", "marvell,armadaxp", "marvell,armada-370-xp";
+	compatible = "marvell,armadaxp-98dx3236", "marvell,armada-370-xp";
 
 	aliases {
 		gpio0 = &gpio0;
@@ -72,12 +75,19 @@
 	};
 
 	soc {
+		compatible = "marvell,armadaxp-mbus", "simple-bus";
+
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x1000000
 			  MBUS_ID(0x03, 0x00) 0 0 0xa8000000 0x4000000
 			  MBUS_ID(0x08, 0x00) 0 0 0xac000000 0x100000>;
 
+		bootrom {
+			compatible = "marvell,bootrom";
+			reg = <MBUS_ID(0x01, 0x1d) 0 0x100000>;
+		};
+
 		/*
 		 * 98DX3236 has 1 x1 PCIe unit Gen2.0
 		 */
@@ -117,31 +127,92 @@
 		};
 
 		internal-regs {
+			sdramc at 1400 {
+				compatible = "marvell,armada-xp-sdram-controller";
+				reg = <0x1400 0x500>;
+			};
+
+			L2: l2-cache at 8000 {
+				compatible = "marvell,aurora-system-cache";
+				reg = <0x08000 0x1000>;
+				cache-id-part = <0x100>;
+				cache-level = <2>;
+				cache-unified;
+				wt-override;
+			};
+
+			gpio0: gpio at 18100 {
+				compatible = "marvell,orion-gpio";
+				reg = <0x18100 0x40>;
+				ngpios = <32>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <82>, <83>, <84>, <85>;
+			};
+
+			/* does not exist */
+			gpio1: gpio at 18140 {
+				compatible = "marvell,orion-gpio";
+				reg = <0x18140 0x40>;
+				status = "disabled";
+			};
+
+			gpio2: gpio at 18180 { /* rework some properties */
+				compatible = "marvell,orion-gpio";
+				reg = <0x18180 0x40>;
+				ngpios = <1>; /* only gpio #32 */
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <87>;
+			};
+
+			systemc: system-controller at 18200 {
+				compatible = "marvell,armada-370-xp-system-controller";
+				reg = <0x18200 0x500>;
+			};
+
+			gateclk: clock-gating-control at 18220 {
+				compatible = "marvell,armada-xp-gating-clock";
+				reg = <0x18220 0x4>;
+				clocks = <&coreclk 0>;
+				#clock-cells = <1>;
+			};
+
 			coreclk: mvebu-sar at 18230 {
 				compatible = "marvell,mv98dx3236-core-clock";
+				reg = <0x18230 0x08>;
+				#clock-cells = <1>;
 			};
 
 			cpuclk: clock-complex at 18700 {
+				#clock-cells = <1>;
 				compatible = "marvell,mv98dx3236-cpu-clock";
+				reg = <0x18700 0x24>, <0x1c054 0x10>;
+				clocks = <&coreclk 1>;
 			};
 
 			corediv-clock at 18740 {
 				status = "disabled";
 			};
 
-			xor at 60900 {
-				status = "disabled";
+			cpu-config at 21000 {
+				compatible = "marvell,armada-xp-cpu-config";
+				reg = <0x21000 0x8>;
 			};
 
-			crypto at 90000 {
-				status = "disabled";
+			ethernet at 70000 {
+				compatible = "marvell,armada-xp-neta";
 			};
 
-			xor at f0900 {
-				status = "disabled";
+			ethernet at 74000 {
+				compatible = "marvell,armada-xp-neta";
 			};
 
-			xor at f0800 {
+			xor1: xor at f0800 {
 				compatible = "marvell,orion-xor";
 				reg = <0xf0800 0x100
 				       0xf0a00 0x100>;
@@ -161,37 +232,28 @@
 				};
 			};
 
-			gpio0: gpio at 18100 {
-				compatible = "marvell,orion-gpio";
-				reg = <0x18100 0x40>;
-				ngpios = <32>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				interrupts = <82>, <83>, <84>, <85>;
-			};
-
-			/* does not exist */
-			gpio1: gpio at 18140 {
-				compatible = "marvell,orion-gpio";
-				reg = <0x18140 0x40>;
-				status = "disabled";
+			nand: nand at d0000 {
+				clocks = <&dfx_coredivclk 0>;
 			};
 
-			gpio2: gpio at 18180 { /* rework some properties */
-				compatible = "marvell,orion-gpio";
-				reg = <0x18180 0x40>;
-				ngpios = <1>; /* only gpio #32 */
-				gpio-controller;
-				#gpio-cells = <2>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				interrupts = <87>;
-			};
+			xor0: xor at f0900 {
+				compatible = "marvell,orion-xor";
+				reg = <0xF0900 0x100
+				       0xF0B00 0x100>;
+				clocks = <&gateclk 28>;
+				status = "okay";
 
-			nand: nand at d0000 {
-				clocks = <&dfx_coredivclk 0>;
+				xor00 {
+					interrupts = <94>;
+					dmacap,memcpy;
+					dmacap,xor;
+				};
+				xor01 {
+					interrupts = <95>;
+					dmacap,memcpy;
+					dmacap,xor;
+					dmacap,memset;
+				};
 			};
 		};
 
@@ -225,6 +287,53 @@
 			};
 		};
 	};
+
+	clocks {
+		/* 25 MHz reference crystal */
+		refclk: oscillator {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <25000000>;
+		};
+	};
+};
+
+&i2c0 {
+	compatible = "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
+	reg = <0x11000 0x100>;
+};
+
+&i2c1 {
+	compatible = "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
+	reg = <0x11100 0x100>;
+};
+
+&mpic {
+	reg = <0x20a00 0x2d0>, <0x21070 0x58>;
+};
+
+&timer {
+	compatible = "marvell,armada-xp-timer";
+	clocks = <&coreclk 2>, <&refclk>;
+	clock-names = "nbclk", "fixed";
+};
+
+&watchdog {
+	compatible = "marvell,armada-xp-wdt";
+	clocks = <&coreclk 2>, <&refclk>;
+	clock-names = "nbclk", "fixed";
+};
+
+&cpurst {
+	reg = <0x20800 0x20>;
+};
+
+&usb0 {
+	clocks = <&gateclk 18>;
+};
+
+&usb1 {
+	clocks = <&gateclk 19>;
 };
 
 &pinctrl {
@@ -237,14 +346,13 @@
 	};
 };
 
-&sdio {
-	status = "disabled";
+&spi0 {
+	compatible = "marvell,armada-xp-spi", "marvell,orion-spi";
+	pinctrl-0 = <&spi0_pins>;
+	pinctrl-names = "default";
 };
 
-&crypto_sram0 {
+&sdio {
 	status = "disabled";
 };
 
-&crypto_sram1 {
-	status = "disabled";
-};
diff --git a/arch/arm/boot/dts/armada-xp-98dx3336.dtsi b/arch/arm/boot/dts/armada-xp-98dx3336.dtsi
index e1580afdc260..a0d81bd7312b 100644
--- a/arch/arm/boot/dts/armada-xp-98dx3336.dtsi
+++ b/arch/arm/boot/dts/armada-xp-98dx3336.dtsi
@@ -49,7 +49,7 @@
 
 / {
 	model = "Marvell 98DX3336 SoC";
-	compatible = "marvell,armadaxp-98dx3336", "marvell,armadaxp-98dx3236", "marvell,armadaxp", "marvell,armada-370-xp";
+	compatible = "marvell,armadaxp-98dx3336", "marvell,armadaxp-98dx3236", "marvell,armada-370-xp";
 
 	cpus {
 		cpu at 1 {
diff --git a/arch/arm/boot/dts/armada-xp-98dx4251.dtsi b/arch/arm/boot/dts/armada-xp-98dx4251.dtsi
index b9d9b269efb4..51de91b31a9d 100644
--- a/arch/arm/boot/dts/armada-xp-98dx4251.dtsi
+++ b/arch/arm/boot/dts/armada-xp-98dx4251.dtsi
@@ -49,7 +49,7 @@
 
 / {
 	model = "Marvell 98DX4251 SoC";
-	compatible = "marvell,armadaxp-98dx4251", "marvell,armadaxp-98dx3236", "marvell,armadaxp", "marvell,armada-370-xp";
+	compatible = "marvell,armadaxp-98dx4251", "marvell,armadaxp-98dx3236", "marvell,armada-370-xp";
 
 	cpus {
 		cpu at 1 {
diff --git a/arch/arm/boot/dts/armada-xp-db-dxbc2.dts b/arch/arm/boot/dts/armada-xp-db-dxbc2.dts
index 605d855b0147..f624894c2ab6 100644
--- a/arch/arm/boot/dts/armada-xp-db-dxbc2.dts
+++ b/arch/arm/boot/dts/armada-xp-db-dxbc2.dts
@@ -58,7 +58,7 @@
 
 / {
 	model = "Marvell Bobcat2 Evaluation Board";
-	compatible = "marvell,db-dxbc2", "marvell,armadaxp-98dx4251", "marvell,armadaxp", "marvell,armada-370-xp";
+	compatible = "marvell,db-dxbc2", "marvell,armadaxp-98dx4251", "marvell,armada-370-xp";
 
 	chosen {
 		bootargs = "console=ttyS0,115200 earlyprintk";
diff --git a/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts b/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
index 4e07cb6ed800..06fce35d7491 100644
--- a/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
+++ b/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
@@ -58,7 +58,7 @@
 
 / {
 	model = "DB-XC3-24G4XG";
-	compatible = "marvell,db-xc3-24g4xg", "marvell,armadaxp-98dx3336", "marvell,armadaxp", "marvell,armada-370-xp";
+	compatible = "marvell,db-xc3-24g4xg", "marvell,armadaxp-98dx3336", "marvell,armada-370-xp";
 
 	chosen {
 		bootargs = "console=ttyS0,115200 earlyprintk";
-- 
2.11.0.24.ge6920cf
