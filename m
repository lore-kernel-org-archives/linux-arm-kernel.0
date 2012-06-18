From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 18 Jun 2012 10:45:29 -0300
Subject: [PATCH v3] ARM: mx23: Add initial support for olinuxino board
Message-ID: <1340027129-8407-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
Changes since v2:
- Add an olimex.txt file
- Change the compatible board string to 'olimex,imx23-olinuxino'
- Keep the board entry in imx23_dt_compat
Changes since v1:
- Drop "fsl,imx23-olinuxino" from mach-mxs.c
 Documentation/devicetree/bindings/arm/olimex.txt |    6 +++
 arch/arm/boot/dts/imx23-olinuxino.dts            |   44 ++++++++++++++++++++++
 arch/arm/boot/dts/imx23.dtsi                     |   14 +++++++
 arch/arm/mach-mxs/mach-mxs.c                     |    1 +
 4 files changed, 65 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/olimex.txt
 create mode 100644 arch/arm/boot/dts/imx23-olinuxino.dts

diff --git a/Documentation/devicetree/bindings/arm/olimex.txt b/Documentation/devicetree/bindings/arm/olimex.txt
new file mode 100644
index 0000000..007fb5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/olimex.txt
@@ -0,0 +1,6 @@
+Olimex i.MX Platforms Device Tree Bindings
+------------------------------------------
+
+i.MX23 Olinuxino Low Cost Board
+Required root node properties:
+    - compatible = "olimex,imx23-olinuxino", "fsl,imx23";
diff --git a/arch/arm/boot/dts/imx23-olinuxino.dts b/arch/arm/boot/dts/imx23-olinuxino.dts
new file mode 100644
index 0000000..7abdd40
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
+	compatible = "olimex,imx23-olinuxino", "fsl,imx23";
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
index 8c5f999..6fc3f54 100644
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
diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 8cac94b..a321753 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -92,6 +92,7 @@ static void __init mxs_machine_init(void)
 
 static const char *imx23_dt_compat[] __initdata = {
 	"fsl,imx23-evk",
+	"fsl,imx23-olinuxino",
 	"fsl,imx23",
 	NULL,
 };
-- 
1.7.1
