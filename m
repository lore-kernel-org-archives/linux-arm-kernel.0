From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue,  4 Jun 2013 13:07:09 +0200
Subject: [PATCH 2/8] ARM i.MX53: mba53: Add display support
In-Reply-To: <1370344035-7417-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1370344035-7417-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1370344035-7417-3-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

As the displays are optional and we have more than one, also
set the status of the parallel display and the ldb to disabled.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/imx53-mba53.dts | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/imx53-mba53.dts b/arch/arm/boot/dts/imx53-mba53.dts
index 1420fe5..6fa9a09 100644
--- a/arch/arm/boot/dts/imx53-mba53.dts
+++ b/arch/arm/boot/dts/imx53-mba53.dts
@@ -16,6 +16,38 @@
 / {
 	model = "TQ MBa53 starter kit";
 	compatible = "tq,mba53", "tq,tqma53", "fsl,imx53";
+
+	reg_backlight: fixed at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd-supply";
+		gpio = <&gpio2 5 0>;
+		startup-delay-us = <5000>;
+		enable-active-low;
+	};
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm2 0 50000 0 0>;
+		brightness-levels = <0 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100>;
+		default-brightness-level = <10>;
+		enable-gpios = <&gpio7 7 0>;
+		power-supply = <&reg_backlight>;
+	};
+
+	disp1: display at disp1 {
+		compatible = "fsl,imx-parallel-display";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_disp1_1>;
+		crtcs = <&ipu 1>;
+		interface-pix-fmt = "rgb24";
+		status = "disabled";
+	};
+};
+
+&ldb {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lvds1_1>;
+	status = "disabled";
 };
 
 &iomuxc {
-- 
1.8.2.rc2
