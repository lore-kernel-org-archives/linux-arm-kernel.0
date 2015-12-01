From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Tue,  1 Dec 2015 20:03:16 +0200
Subject: [PATCH V2 14/19] ARM: dts: am57xx: sbc-am57x: add EEPROM support
In-Reply-To: <1448993001-19495-1-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
 <1448993001-19495-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1448993001-19495-15-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On-board EEPROM chip is used for storing a board production info.

Add carrier board EEPROM support (over I2C5 bus).

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---

  v2:

   * No fuctional changes
   * Reformat subject

 arch/arm/boot/dts/am57xx-sbc-am57x.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-sbc-am57x.dts b/arch/arm/boot/dts/am57xx-sbc-am57x.dts
index 17a1972..a3588ba 100644
--- a/arch/arm/boot/dts/am57xx-sbc-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-sbc-am57x.dts
@@ -43,6 +43,13 @@
 			DRA7XX_CORE_IOPAD(0x3680, PIN_INPUT_SLEW | MUX_MODE0) /* usb1_drvvbus */
 		>;
 	};
+
+	i2c5_pins_default: i2c5_pins_default {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x36b4, PIN_INPUT| MUX_MODE10)	/* mcasp1_axr0.i2c5_sda */
+			DRA7XX_CORE_IOPAD(0x36b8, PIN_INPUT| MUX_MODE10)	/* mcasp1_axr1.i2c5_scl */
+		>;
+	};
 };
 
 &uart3 {
@@ -70,3 +77,16 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb1_pins>;
 };
+
+&i2c5 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c5_pins_default>;
+	clock-frequency = <400000>;
+
+	eeprom_base: atmel at 50 {
+		compatible = "atmel,24c08";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
+};
-- 
1.9.1
