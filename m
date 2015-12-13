From: uri.mashiach@compulab.co.il (Uri Mashiach)
Date: Sun, 13 Dec 2015 10:55:39 +0200
Subject: [PATCH 5/5] ARM: dts: cm-t335: add support for bluetooth
In-Reply-To: <1449996939-13901-1-git-send-email-uri.mashiach@compulab.co.il>
References: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
 <1449996939-13901-1-git-send-email-uri.mashiach@compulab.co.il>
Message-ID: <1449996939-13901-6-git-send-email-uri.mashiach@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bluetooth HW is WLS1271 chip connected to UART1.

Device tree modifications:
- Pinmux for UART1.
- Pinmux for bluetooth enable GPIO.

Bluetooth enable GPIO is set to enable during startup by setting the
relevant pinmux pin to pull-up.

Signed-off-by: Uri Mashiach <uri.mashiach@compulab.co.il>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/boot/dts/am335x-cm-t335.dts | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
index ae2366e..42e9b66 100644
--- a/arch/arm/boot/dts/am335x-cm-t335.dts
+++ b/arch/arm/boot/dts/am335x-cm-t335.dts
@@ -50,7 +50,7 @@
 
 &am33xx_pinmux {
 	pinctrl-names = "default";
-	pinctrl-0 = <>;
+	pinctrl-0 = <&bluetooth_pins>;
 
 	i2c0_pins: pinmux_i2c0_pins {
 		pinctrl-single,pins = <
@@ -121,6 +121,19 @@
 		>;
 	};
 
+	uart1_pins: pinmux_uart1_pins {
+		pinctrl-single,pins = <
+			/* uart1_ctsn.uart1_ctsn */
+			AM33XX_IOPAD(0x978, PIN_INPUT | MUX_MODE0)
+			/* uart1_rtsn.uart1_rtsn */
+			AM33XX_IOPAD(0x97C, PIN_OUTPUT_PULLDOWN | MUX_MODE0)
+			/* uart1_rxd.uart1_rxd */
+			AM33XX_IOPAD(0x980, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* uart1_txd.uart1_txd */
+			AM33XX_IOPAD(0x984, PIN_OUTPUT_PULLDOWN | MUX_MODE0)
+		>;
+	};
+
 	ecap0_pins: pinmux_ecap0_pins {
 		pinctrl-single,pins = <
 			/* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out MODE0 */
@@ -209,6 +222,14 @@
 			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)
 		>;
 	};
+
+	/* wl1271 bluetooth */
+	bluetooth_pins: pinmux_bluetooth_pins {
+		pinctrl-single,pins = <
+			/* XDMA_EVENT_INTR0.gpio0_19 - bluetooth enable */
+			AM33XX_IOPAD(0x9b0, PIN_OUTPUT_PULLUP | MUX_MODE7)
+		>;
+	};
 };
 
 &uart0 {
@@ -218,6 +239,14 @@
 	status = "okay";
 };
 
+/* WLS1271 bluetooth */
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+
+status = "okay";
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins>;
-- 
2.5.0
