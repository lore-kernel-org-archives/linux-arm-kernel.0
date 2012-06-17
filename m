From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 17 Jun 2012 10:51:21 -0300
Subject: [PATCH v2] ARM: mx23: Add initial support for olinuxino board
Message-ID: <1339941081-2592-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

mx23-olinuxino is a low cost board designed by Olimex.

It has the following features:

- Freescale iMX233 ARM926J processor at 454MHz
-64 MB RAM
-SD-card connector
-TV PAL/NTSC video output
-2 USB High Speed Hosts
-Ethernet 100 Mbit
-Stereo Audio Input
-Stereo Headphones Audio Output

More information at:
http://www.olimex.com/dev/imx233-olinuxino-maxi.html

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Drop "fsl,imx23-olinuxino" from mach-mxs.c

 Documentation/devicetree/bindings/arm/fsl.txt |    4 ++
 arch/arm/boot/dts/imx23-olinuxino.dts         |   45 +++++++++++++++++++++++++
 arch/arm/boot/dts/imx23.dtsi                  |   14 ++++++++
 3 files changed, 63 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx23-olinuxino.dts

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index ac9e751..ca2bc1c 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -5,6 +5,10 @@ i.MX23 Evaluation Kit
 Required root node properties:
     - compatible = "fsl,imx23-evk", "fsl,imx23";
 
+i.MX23 Olinuxino Low Cost Board
+Required root node properties:
+    - compatible = "fsl,imx23-olinuxino", "fsl,imx23";
+
 i.MX28 Evaluation Kit
 Required root node properties:
     - compatible = "fsl,imx28-evk", "fsl,imx28";
diff --git a/arch/arm/boot/dts/imx23-olinuxino.dts b/arch/arm/boot/dts/imx23-olinuxino.dts
new file mode 100644
index 0000000..3c56010
--- /dev/null
+++ b/arch/arm/boot/dts/imx23-olinuxino.dts
@@ -0,0 +1,44 @@
+/*
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ *
+ * Author: Fabio Estevam <fabio.estevam@freescale.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+/include/ "imx23.dtsi"
+
+/ {
+	model = "i.MX23 Olinuxino Low Cost Board";
+	compatible = "fsl,imx23-olinuxino", "fsl,imx23";
+
+	memory {
+		reg = <0x40000000 0x08000000>;
+	};
+
+	apb at 80000000 {
+		apbh at 80000000 {
+			ssp0: ssp at 80010000 {
+				compatible = "fsl,imx23-mmc";
+				pinctrl-names = "default";
+				pinctrl-0 = <&mmc0_4bit_pins_a &mmc0_sck_cfg>;
+				bus-width = <4>;
+				status = "okay";
+			};
+		};
+
+		apbx at 80040000 {
+			duart: serial at 80070000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&duart_pins_a>;
+				status = "okay";
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 8c5f999..89044f0 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -134,6 +134,20 @@
 					fsl,pinmux-ids = <0x2010 0x2060>;
 					fsl,pull-up = <0>;
 				};
+
+				mmc0_4bit_pins_a: mmc0-4bit at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <0x2000 0x2020 0x2030
+						0x2040 0x2050>;
+					fsl,drive-strength = <1>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <1>;
+				};
+
+				mmc0_sck_cfg: mmc0_sck_cfg {
+					fsl,pinmux-ids = <0x2010>;
+					fsl,pull-up = <0>;
+				};
 			};
 
 			digctl at 8001c000 {
-- 
1.7.1
