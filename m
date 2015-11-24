From: uri.mashiach@compulab.co.il (Uri Mashiach)
Date: Tue, 24 Nov 2015 16:02:09 +0200
Subject: [PATCH v2 2/6] ARM: OMAP2+: dts: cm-t335: add basic support for I2C
In-Reply-To: <1448373733-5839-1-git-send-email-uri.mashiach@compulab.co.il>
References: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
 <1448373733-5839-1-git-send-email-uri.mashiach@compulab.co.il>
Message-ID: <1448373733-5839-3-git-send-email-uri.mashiach@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ilya Ledvich <ilya@compulab.co.il>

Add pinmux configuration for I2C0 and I2C1 pins.
Add description for I2C0 bus, set clock frequency to 400kHz.
Add child nodes for 24c02 EEPROM and em3027 RTC on I2C0 bus.

Signed-off-by: Ilya Ledvich <ilya@compulab.co.il>
Signed-off-by: Uri Mashiach <uri.mashiach@compulab.co.il>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---
v1 -> v2: integrate AM33XX_IOPAD macro in pinmux definitions

 arch/arm/boot/dts/am335x-cm-t335.dts | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
index 719658e..02b6679 100644
--- a/arch/arm/boot/dts/am335x-cm-t335.dts
+++ b/arch/arm/boot/dts/am335x-cm-t335.dts
@@ -37,6 +37,24 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <>;
 
+	i2c0_pins: pinmux_i2c0_pins {
+		pinctrl-single,pins = <
+			/* i2c0_sda.i2c0_sda */
+			AM33XX_IOPAD(0x988, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* i2c0_scl.i2c0_scl */
+			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLUP | MUX_MODE0)
+		>;
+	};
+
+	i2c1_pins: pinmux_i2c1_pins {
+		pinctrl-single,pins = <
+			/* uart0_ctsn.i2c1_sda */
+			AM33XX_IOPAD(0x968, PIN_INPUT_PULLUP | MUX_MODE2)
+			/* uart0_rtsn.i2c1_scl */
+			AM33XX_IOPAD(0x96c, PIN_INPUT_PULLUP | MUX_MODE2)
+		>;
+	};
+
 	gpio_led_pins: pinmux_gpio_led_pins {
 		pinctrl-single,pins = <
 			/* gpmc_csn3.gpio2_0 */
@@ -61,3 +79,22 @@
 	status = "okay";
 };
 
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+
+	status = "okay";
+	clock-frequency = <400000>;
+	/* CM-T335 board EEPROM */
+	eeprom: 24c02 at 50 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
+	/* Real Time Clock */
+	ext_rtc: em3027 at 56 {
+		compatible = "emmicro,em3027";
+		reg = <0x56>;
+	};
+};
+
-- 
2.5.0
