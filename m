From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Wed, 25 Nov 2015 08:39:48 +0200
Subject: [PATCH 16/18] ARM: am57xx: sbc-am57x: dts: add LCD support
In-Reply-To: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1448433590-1399-17-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Startek-kd050c 800x480 LCD panel timings are described in
compulab-sb-som.dtsi.

Add appropriate DT endpoints to connect DPI output and LCD.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/boot/dts/am57xx-sbc-am57x.dts | 38 ++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-sbc-am57x.dts b/arch/arm/boot/dts/am57xx-sbc-am57x.dts
index 8b7c0b5..13555aa 100644
--- a/arch/arm/boot/dts/am57xx-sbc-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-sbc-am57x.dts
@@ -15,6 +15,10 @@
 / {
 	model = "CompuLab CL-SOM-AM57x on SB-SOM-AM57x";
 	compatible = "compulab,sbc-am57x", "compulab,cl-som-am57x", "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7";
+
+	aliases {
+		display0 = &lcd0;
+	};
 };
 
 &dra7_pmx_core {
@@ -51,6 +55,12 @@
 			DRA7XX_CORE_IOPAD(0x36b8, PIN_INPUT| MUX_MODE10)	/* mcasp1_axr1.i2c5_scl */
 		>;
 	};
+
+	lcd_pins_default: lcd_pins_default {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x3564, PIN_OUTPUT | MUX_MODE14)      /* vin2a_vsync0.gpio4_0 */
+		>;
+	};
 };
 
 &uart3 {
@@ -98,3 +108,31 @@
 		#gpio-cells = <2>;
 	};
 };
+
+&dss {
+	status = "ok";
+
+	vdda_video-supply = <&ldoln_reg>;
+
+	port {
+		dpi_lcd_out: endpoint at 0 {
+			remote-endpoint = <&lcd_in>;
+			data-lines = <24>;
+		};
+	};
+};
+
+&lcd0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&lcd_pins_default>;
+
+	enable-gpios = <&pca9555 14 GPIO_ACTIVE_HIGH
+			&gpio4 0 GPIO_ACTIVE_HIGH>;
+
+	port {
+		lcd_in: endpoint {
+			remote-endpoint = <&dpi_lcd_out>;
+			data-lines = <24>;
+		};
+	};
+};
-- 
1.9.1
