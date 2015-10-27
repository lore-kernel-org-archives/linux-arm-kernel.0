From: uri.mashiach@compulab.co.il (Uri Mashiach)
Date: Tue, 27 Oct 2015 14:14:56 +0200
Subject: [PATCH 2/6] ARM: OMAP2+: dts: cm-t335: add basic support for I2C
In-Reply-To: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
References: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
Message-ID: <1445948100-16446-3-git-send-email-uri.mashiach@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ilya Ledvich <ilya@compulab.co.il>

Add pinmux configuration for I2C0 and I2C1 pins.
Add description for I2C0 bus, set clock frequency to 400kHz.
Add child nodes for 24c02 EEPROM and em3027 RTC on I2C0 bus.

Acked-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Ilya Ledvich <ilya@compulab.co.il>
Signed-off-by: Uri Mashiach <uri.mashiach@compulab.co.il>
---
 arch/arm/boot/dts/am335x-cm-t335.dts | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
index 197d5ce..39df3d2 100644
--- a/arch/arm/boot/dts/am335x-cm-t335.dts
+++ b/arch/arm/boot/dts/am335x-cm-t335.dts
@@ -37,6 +37,24 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <>;
 
+	i2c0_pins: pinmux_i2c0_pins {
+		pinctrl-single,pins = <
+			/* i2c0_sda.i2c0_sda */
+			0x188 (PIN_INPUT_PULLUP | MUX_MODE0)
+			/* i2c0_scl.i2c0_scl */
+			0x18c (PIN_INPUT_PULLUP | MUX_MODE0)
+		>;
+	};
+
+	i2c1_pins: pinmux_i2c1_pins {
+		pinctrl-single,pins = <
+			/* uart0_ctsn.i2c1_sda */
+			0x168 (PIN_INPUT_PULLUP | MUX_MODE2)
+			/* uart0_rtsn.i2c1_scl */
+			0x16c (PIN_INPUT_PULLUP | MUX_MODE2)
+		>;
+	};
+
 	gpio_led_pins: pinmux_gpio_led_pins {
 		pinctrl-single,pins = <
 			0x88 (PIN_OUTPUT | MUX_MODE7)	/* gpmc_csn3.gpio2_0 */
@@ -60,3 +78,22 @@
 	status = "okay";
 };
 
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+
+	status = "okay";
+	clock-frequency = <400000>;
+
+	eeprom: 24c02 at 50 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
+
+	ext_rtc: em3027 at 56 {
+		compatible = "emmicro,em3027";
+		reg = <0x56>;
+	};
+};
+
-- 
2.6.0
