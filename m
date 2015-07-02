From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 2 Jul 2015 17:06:24 +0300
Subject: [PATCH v2 09/20] ARM: DTS: am437x-gp-evm: Add gpio-hog for
 configuring the display/audio mux
In-Reply-To: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
References: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1435845995-19085-10-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO5_8 is used as a mux switch between LCD and HDMI displays. This mux
affects audio routing as well since in LCD mode HDMI audio is not possible
and when HDMI is selected analog audio is not working.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 84aa30c3235a..e2fb2713333d 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -83,17 +83,6 @@
 		compatible = "osddisplays,osd057T0559-34ts", "panel-dpi";
 		label = "lcd";
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&lcd_pins>;
-
-		/*
-		 * SelLCDorHDMI, LOW to select HDMI. This is not really the
-		 * panel's enable GPIO, but we don't have HDMI driver support nor
-		 * support to switch between two displays, so using this gpio as
-		 * panel's enable should be safe.
-		 */
-		enable-gpios = <&gpio5 8 GPIO_ACTIVE_HIGH>;
-
 		panel-timing {
 			clock-frequency = <33000000>;
 			hactive = <800>;
@@ -270,7 +259,7 @@
 		>;
 	};
 
-	lcd_pins: lcd_pins {
+	display_mux_pins: display_mux_pins {
 		pinctrl-single,pins = <
 			/* GPIO 5_8 to select LCD / HDMI */
 			0x238 (PIN_OUTPUT_PULLUP | MUX_MODE7)
@@ -558,8 +547,22 @@
 };
 
 &gpio5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&display_mux_pins>;
 	status = "okay";
 	ti,no-reset-on-init;
+
+	p8 {
+		/*
+		 * SelLCDorHDMI selects between display and audio paths:
+		 * Low: HDMI display with audio via HDMI
+		 * High: LCD display with analog audio via aic3111 codec
+		 */
+		gpio-hog;
+		gpios = <8 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "SelLCDorHDMI";
+	};
 };
 
 &mmc1 {
-- 
2.4.5
