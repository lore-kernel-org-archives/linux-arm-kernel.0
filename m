From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 21 Nov 2012 17:08:14 -0200
Subject: [PATCH] ARM: dts: mx27: Fix the AIPI bus for FEC
Message-ID: <1353524894-20123-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FEC controller is connected to AIPI2 bus.

Also fix the AIPI1 address range.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx27-3ds.dts            |    8 ++++----
 arch/arm/boot/dts/imx27-phytec-phycore.dts |    9 +++++++--
 arch/arm/boot/dts/imx27.dtsi               |   12 +++++++++++-
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/imx27-3ds.dts b/arch/arm/boot/dts/imx27-3ds.dts
index 0a8978a..b1a6df2 100644
--- a/arch/arm/boot/dts/imx27-3ds.dts
+++ b/arch/arm/boot/dts/imx27-3ds.dts
@@ -21,8 +21,7 @@
 	};
 
 	soc {
-		aipi at 10000000 { /* aipi */
-
+		aipi at 10000000 { /* aipi1 */
 			wdog at 10002000 {
 				status = "okay";
 			};
@@ -31,11 +30,12 @@
 				fsl,uart-has-rtscts;
 				status = "okay";
 			};
+		};
 
-			fec at 1002b000 {
+		aipi at 10020000 { /* aipi2 */
+			ethernet at 1002b000 {
 				status = "okay";
 			};
 		};
 	};
-
 };
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore.dts b/arch/arm/boot/dts/imx27-phytec-phycore.dts
index af50469..c36c402 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore.dts
@@ -21,8 +21,7 @@
 	};
 
 	soc {
-		aipi at 10000000 { /* aipi */
-
+		aipi at 10000000 { /* aipi1 */
 			serial at 1000a000 {
 				fsl,uart-has-rtscts;
 				status = "okay";
@@ -60,6 +59,12 @@
 				};
 			};
 		};
+
+		aipi at 10020000 { /* aipi2 */
+			ethernet at 1002b000 {
+				status = "okay";
+			};
+		};
 	};
 
 	nor_flash at c0000000 {
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 3e54f14..7159b82 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -55,7 +55,7 @@
 			compatible = "fsl,aipi-bus", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			reg = <0x10000000 0x10000000>;
+			reg = <0x10000000 0x20000>;
 			ranges;
 
 			wdog at 10002000 {
@@ -211,6 +211,15 @@
 				status = "disabled";
 			};
 
+		};
+
+		aipi at 10020000 { /* AIPI2 */
+			compatible = "fsl,aipi-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x10020000 0x20000>;
+			ranges;
+
 			fec: ethernet at 1002b000 {
 				compatible = "fsl,imx27-fec";
 				reg = <0x1002b000 0x4000>;
@@ -218,6 +227,7 @@
 				status = "disabled";
 			};
 		};
+
 		nand at d8000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
1.7.9.5
