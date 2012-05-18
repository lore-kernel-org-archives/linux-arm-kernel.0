From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 18 May 2012 14:27:12 +0200
Subject: [PATCH 2/2] pcm038 lcdc support
In-Reply-To: <1337344032-25431-1-git-send-email-s.hauer@pengutronix.de>
References: <1337344032-25431-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1337344032-25431-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx27-phytec-phycore.dts |   39 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx27.dtsi               |    7 +++++
 arch/arm/mach-imx/clock-imx27.c            |    1 +
 3 files changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore.dts b/arch/arm/boot/dts/imx27-phytec-phycore.dts
index a51a08f..bdb7547 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore.dts
@@ -20,6 +20,41 @@
 		reg = <0x0 0x0>;
 	};
 
+	baseboard {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+                #size-cells = <1>;
+
+		display {
+			compatible = "fsl,imx-parallel-display";
+			edid = [00 ff ff ff ff ff ff 00 4c 2d 6c 03 36 32 49 4b
+				0f 13 01 03 80 37 22 a0 2a fe 21 a8 53 37 ae 24
+				11 50 54
+
+				/* est timings */
+				00 00 00
+
+				/* std timings */
+				00 00
+				00 00
+				00 00
+				00 00
+				00 00
+				00 00
+				00 00
+				00 00
+
+				/* detailed timings */
+				05 0D 20 A0 30 58 1C 20 28 20 14 00 26 57 21 00 00 1E
+				00 00 00 fd 00 32 4b 1b	51 11 00 0a 20 20 20 20 20 20
+				00 00 00 fc 00 53 79 6e 63 4d 61 73 74 65 72 0a 20 20
+				00 00 00 ff 00 48 39 58 53 34 30 30 34 34 32 0a 20 20
+				00 20];
+
+			crtc = <&lcdc 0>;
+		};
+	};
+
 	soc {
 		aipi at 10000000 { /* aipi */
 
@@ -46,6 +81,10 @@
 				status = "okay";
 			};
 
+			lcdc at 10021000 {
+				status = "okay";
+			};
+
 			i2c at 1001d000 {
 				clock-frequency = <400000>;
 				status = "okay";
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index bc5e7d5..eab9095 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -206,6 +206,13 @@
 				status = "disabled";
 			};
 
+			lcdc: lcdc at 10021000 {
+				compatible = "fsl,imx27-lcdc", "fsl,imx21-lcdc";
+				reg = <0x10021000 0x4000>;
+				interrupts = <61>;
+				status = "enabled";
+			};
+
 			fec: fec at 1002b000 {
 				compatible = "fsl,imx27-fec";
 				reg = <0x1002b000 0x4000>;
diff --git a/arch/arm/mach-imx/clock-imx27.c b/arch/arm/mach-imx/clock-imx27.c
index 98e04f5..a393483 100644
--- a/arch/arm/mach-imx/clock-imx27.c
+++ b/arch/arm/mach-imx/clock-imx27.c
@@ -646,6 +646,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("imx27-cspi.1", NULL, cspi2_clk)
 	_REGISTER_CLOCK("imx27-cspi.2", NULL, cspi3_clk)
 	_REGISTER_CLOCK("imx-fb.0", NULL, lcdc_clk)
+	_REGISTER_CLOCK("10021000.lcdc", NULL, lcdc_clk)
 	_REGISTER_CLOCK("mx2-camera.0", NULL, csi_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usb_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", usb_clk1)
-- 
1.7.10
