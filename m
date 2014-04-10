From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 Apr 2014 16:47:15 -0700
Subject: [PATCH 07/11] ARM: dts: Enable N900 keybaord sleep leds by default
In-Reply-To: <1397173639-29587-1-git-send-email-tony@atomide.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
Message-ID: <1397173639-29587-8-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On N900 there are nice LEDs that show the state of the
sys_clkreq and sys_off_mode pins.

These LEDs go low when the system enters deeper idle
states. The left LED shows the state of the sys_clkreq
pin, and goes off during retention idle. The right LED
shows the state of sys_off_mode pin and both go off
during off idle.

As N900 is a battery operated device, these LEDs should
be off most of the time. So let's enable them by default
so we can make sure the system is mostly idle.

This allows the maintainers to also immediately test
patches for PM regressions by looking at the LEDs,
which certainly makes my life easier.

The LED can naturally be disabled during runtime with:

# echo none > /sys/class/leds/debug::sleep/trigger

Note that we don't currently have support for omap3
errata 1.158 that remuxes GPIO pins to INPUT_PULLUP |
MUX_MODE7 for the duration of idle. This means that the
GPIO pins set high will go down during off idle. In this
case it does not matter as the sys_off_mode goes down
too, but there's still a slim chance of false off idle
LED signals. If in doubt, false LED signals can be
verified by the sys_off_mode or vdd_core values.

Also note that to allow the UARTs to autoidle, the
following needs to be run on N900 to enable off idle:

#!/bin/sh
uarts=$(find /sys/class/tty/ttyO*/device/power/ -type d)
for uart in $uarts; do
	echo 3000 > $uart/autosuspend_delay_ms
done

uarts=$(find /sys/class/tty/ttyO*/power/ -type d)
for uart in $uarts; do
	echo enabled > $uart/wakeup
	echo auto > $uart/control
done

echo 1 > /sys/kernel/debug/pm_debug/enable_off_mode

For retention idle, change the above to set 0 to
enable_off_mode.

Also note that without the twl4030 PM scripts the actual
voltage scaling won't happen for off idle so we only get
voltage scaling over I2C4 for retention idle. I'll do
some device tree patches for those also a bit later on.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Pali Roh?r <pali.rohar@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap3-n900.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 0bf40c9..0d34201 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -21,6 +21,17 @@
 		};
 	};
 
+        leds {
+                compatible = "gpio-leds";
+                heartbeat {
+                        label = "debug::sleep";
+                        gpios = <&gpio6 2 GPIO_ACTIVE_HIGH>;  /* gpio162 */
+                        linux,default-trigger = "default-on";
+			pinctrl-names = "default";
+			pinctrl-0 = <&debug_leds>;
+                };
+        };
+
 	memory {
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB */
@@ -114,6 +125,12 @@
 		>;
 	};
 
+	debug_leds: pinmux_debug_led_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2198, PIN_OUTPUT | MUX_MODE4)	/* mcbsp1_clkx.gpio_162 */
+		>;
+	};
+
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
 			0x114 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk */
-- 
1.8.1.1
