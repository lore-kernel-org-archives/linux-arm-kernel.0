From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  7 Aug 2015 17:22:35 +0200
Subject: [PATCH 3/3] ARM: dts: sun6i: Columbus: Add i2c controller for
 communicating with the LCD
In-Reply-To: <1438960955-6551-1-git-send-email-hdegoede@redhat.com>
References: <1438960955-6551-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1438960955-6551-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Colombus development kit uses an optional 2048x1536 edp panel using
an anx9804 parallel lcd to edp convertor. The anx9804 chip is controlled
via an i2c bus which is connected to 2 regular gpio pins.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun6i-a31-colombus.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31-colombus.dts b/arch/arm/boot/dts/sun6i-a31-colombus.dts
index 0d0b6f2..0e51249 100644
--- a/arch/arm/boot/dts/sun6i-a31-colombus.dts
+++ b/arch/arm/boot/dts/sun6i-a31-colombus.dts
@@ -60,6 +60,16 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	i2c_lcd: i2c at 0 {
+		/* The lcd panel i2c interface is hooked up via gpios */
+		compatible = "i2c-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c_lcd_pins>;
+		gpios = <&pio 0 23 GPIO_ACTIVE_HIGH>, /* PA23, sda */
+			<&pio 0 24 GPIO_ACTIVE_HIGH>; /* PA24, scl */
+		i2c-gpio,delay-us = <5>;
+	};
 };
 
 &ehci1 {
@@ -124,6 +134,13 @@
 		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
+
+	i2c_lcd_pins: i2c_lcd_pin at 0 {
+		allwinner,pins = "PA23", "PA24";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+	};
 };
 
 &reg_usb2_vbus {
-- 
2.4.3
