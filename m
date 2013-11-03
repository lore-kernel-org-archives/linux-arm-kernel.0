From: samuel.thibault@ens-lyon.org (Samuel Thibault)
Date: Sun, 3 Nov 2013 14:27:20 +0100
Subject: [next:master 23/358] undefined reference to `input_led_disconnect'
In-Reply-To: <20131103123621.GA9756@type.youpi.perso.aquilenet.fr>
References: <5275bf42.KMmrPUiia86VoRbL%fengguang.wu@intel.com>
 <20131103120853.GA1731@localhost>
 <20131103123621.GA9756@type.youpi.perso.aquilenet.fr>
Message-ID: <20131103132720.GA16764@type.youpi.perso.aquilenet.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Samuel Thibault, le Sun 03 Nov 2013 13:36:21 +0100, a ?crit :
> So in the end it would probably be simpler to just stuff leds.c along
> input.c in input.ko or built-in. CONFIG_INPUT_LEDS will thus become a
> bool.  I'm working on that now.

Here it is.  This replaces both
input-route-kbd-leds-through-the-generic-leds-layer-fix-fix.patch
input-route-kbd-leds-through-the-generic-leds-layer-fix-fix-fix.patch

(input-route-kbd-leds-through-the-generic-leds-layer-fix.patch is still
needed)

Samuel



Link input/leds.c along input/input.c instead of separate module

input.c needs to call leds.c and vice-versa, so it is simpler to stuff
them together. INPUT_LEDS thus now depends on LEDS_CLASS being available
enough for input.ko.

This also documents the new leds field.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

diff -u a/drivers/input/Makefile b/drivers/input/Makefile
--- a/drivers/input/Makefile
+++ b/drivers/input/Makefile
@@ -6,6 +6,9 @@
 
 obj-$(CONFIG_INPUT)		+= input-core.o
 input-core-y := input.o input-compat.o input-mt.o ff-core.o
+ifeq ($(CONFIG_INPUT_LEDS),y)
+input-core-y += leds.o
+endif
 
 obj-$(CONFIG_INPUT_FF_MEMLESS)	+= ff-memless.o
 obj-$(CONFIG_INPUT_POLLDEV)	+= input-polldev.o
@@ -16,7 +19,6 @@
 obj-$(CONFIG_INPUT_JOYDEV)	+= joydev.o
 obj-$(CONFIG_INPUT_EVDEV)	+= evdev.o
 obj-$(CONFIG_INPUT_EVBUG)	+= evbug.o
-obj-$(CONFIG_INPUT_LEDS)	+= leds.o
 
 obj-$(CONFIG_INPUT_KEYBOARD)	+= keyboard/
 obj-$(CONFIG_INPUT_MOUSE)	+= mouse/
diff -u a/drivers/input/Kconfig b/drivers/input/Kconfig
--- a/drivers/input/Kconfig
+++ b/drivers/input/Kconfig
@@ -179,8 +179,8 @@
 source "drivers/input/keyboard/Kconfig"
 
 config INPUT_LEDS
-	tristate "LED Support"
-	depends on LEDS_CLASS
+	bool "LED Support"
+	depends on LEDS_CLASS = INPUT || LEDS_CLASS = y
 	select LEDS_TRIGGERS
 	default y
 	help
diff -u a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -79,6 +79,7 @@
  * @led: reflects current state of device's LEDs
  * @snd: reflects current state of sound effects
  * @sw: reflects current state of device's switches
+ * @leds: leds objects for the device's LEDs
  * @open: this method is called when the very first user calls
  *	input_open_device(). The driver must prepare the device
  *	to start generating events (start polling thread,
