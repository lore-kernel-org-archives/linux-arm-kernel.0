From: uri.mashiach@compulab.co.il (Uri Mashiach)
Date: Wed, 23 Dec 2015 10:35:44 +0200
Subject: [PATCH 3/3] wlcore/wl12xx: spi: add wifi support to cm-t335
In-Reply-To: <1450859744-9948-1-git-send-email-uri.mashiach@compulab.co.il>
References: <1450859744-9948-1-git-send-email-uri.mashiach@compulab.co.il>
Message-ID: <1450859744-9948-4-git-send-email-uri.mashiach@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device tree modifications:
- Pinmux for SPI0 and WiFi GPIOs.
- SPI0 node with wlcore as a child node.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Uri Mashiach <uri.mashiach@compulab.co.il>
Acked-by: Igor Grinberg <grinberg@complab.co.il>
---
Prerequisites:
This patch applies on Tony's omap-for-v4.5/dt branch.

 arch/arm/boot/dts/am335x-cm-t335.dts | 58 +++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
index 42e9b66..41242a5 100644
--- a/arch/arm/boot/dts/am335x-cm-t335.dts
+++ b/arch/arm/boot/dts/am335x-cm-t335.dts
@@ -11,6 +11,7 @@
 /dts-v1/;
 
 #include "am33xx.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "CompuLab CM-T335";
@@ -40,6 +41,15 @@
 		regulator-max-microvolt = <3300000>;
 	};
 
+	/* Regulator for WiFi */
+	vwlan_fixed: fixedregulator at 2 {
+		compatible = "regulator-fixed";
+		regulator-name = "vwlan_fixed";
+		gpio = <&gpio0 20 GPIO_ACTIVE_HIGH>; /* gpio0_20 */
+		enable-active-high;
+		regulator-boot-off;
+	};
+
 	backlight {
 		compatible = "pwm-backlight";
 		pwms = <&ecap0 0 50000 0>;
@@ -50,7 +60,10 @@
 
 &am33xx_pinmux {
 	pinctrl-names = "default";
-	pinctrl-0 = <&bluetooth_pins>;
+	pinctrl-0 = <
+		  &bluetooth_pins
+		  &wifi_pins
+	>;
 
 	i2c0_pins: pinmux_i2c0_pins {
 		pinctrl-single,pins = <
@@ -223,6 +236,21 @@
 		>;
 	};
 
+	spi0_pins: pinmux_spi0_pins {
+		pinctrl-single,pins = <
+			/* spi0_sclk.spi0_sclk */
+			AM33XX_IOPAD(0x950, PIN_INPUT | MUX_MODE0)
+			/* spi0_d0.spi0_d0 */
+			AM33XX_IOPAD(0x954, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			/* spi0_d1.spi0_d1 */
+			AM33XX_IOPAD(0x958, PIN_INPUT | MUX_MODE0)
+			/* spi0_cs0.spi0_cs0 */
+			AM33XX_IOPAD(0x95C, PIN_OUTPUT | MUX_MODE0)
+			/* spi0_cs1.spi0_cs1 */
+			AM33XX_IOPAD(0x960, PIN_OUTPUT | MUX_MODE0)
+		>;
+	};
+
 	/* wl1271 bluetooth */
 	bluetooth_pins: pinmux_bluetooth_pins {
 		pinctrl-single,pins = <
@@ -230,6 +258,16 @@
 			AM33XX_IOPAD(0x9b0, PIN_OUTPUT_PULLUP | MUX_MODE7)
 		>;
 	};
+
+	/* wl1271 WiFi */
+	wifi_pins: pinmux_wifi_pins {
+		pinctrl-single,pins = <
+			/* EMU1.gpio3_8 - WiFi IRQ */
+			AM33XX_IOPAD(0x9e8, PIN_INPUT_PULLUP | MUX_MODE7)
+			/* XDMA_EVENT_INTR1.gpio0_20 - WiFi enable */
+			AM33XX_IOPAD(0x9b4, PIN_OUTPUT | MUX_MODE7)
+		>;
+	};
 };
 
 &uart0 {
@@ -394,3 +432,21 @@ status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
 };
+
+&spi0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins>;
+	ti,pindir-d0-out-d1-in = <1>;
+	/* WLS1271 WiFi */
+	wlcore: wlcore at 1 {
+		compatible = "ti,wl1271";
+		reg = <1>;
+		spi-max-frequency = <48000000>;
+		clock-xtal;
+		ref-clock-frequency = <38400000>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
+		vwlan-supply = <&vwlan_fixed>;
+	};
+};
-- 
2.5.0
