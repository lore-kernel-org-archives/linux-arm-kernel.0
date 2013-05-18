From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 19 May 2013 00:13:04 +0200
Subject: [PATCH] ARM: nomadik: add led and key for S8815
Message-ID: <1368915184-29657-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds device tree hunks for the LED and userbutton on the
USB S8815 board, and set up a heartbeat trigger on the LED and
an escape key on the user button. Alter the defconfig to enable
these standard DT-enabled GPIO drivers.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-s8815.dts | 22 ++++++++++++++++++++++
 arch/arm/configs/nhk8815_defconfig      |  6 ++++++
 arch/arm/mach-nomadik/cpu-8815.c        |  4 ++++
 3 files changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/ste-nomadik-s8815.dts b/arch/arm/boot/dts/ste-nomadik-s8815.dts
index b28fbf3..666945a 100644
--- a/arch/arm/boot/dts/ste-nomadik-s8815.dts
+++ b/arch/arm/boot/dts/ste-nomadik-s8815.dts
@@ -27,4 +27,26 @@
 			gpios = <&gpio3 16 0x1>;
 		};
 	};
+
+	/* The user LED on the board is set up to be used for heartbeat */
+	leds {
+		compatible = "gpio-leds";
+		user-led {
+			label = "user_led";
+			gpios = <&gpio0 2 0x1>;
+			default-state = "off";
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	/* User key mapped in as "escape" */
+	gpio-keys {
+		compatible = "gpio-keys";
+		user-button {
+			label = "user_button";
+			gpios = <&gpio0 3 0x1>;
+			linux,code = <1>; /* KEY_ESC */
+			gpio-key,wakeup;
+		};
+	};
 };
diff --git a/arch/arm/configs/nhk8815_defconfig b/arch/arm/configs/nhk8815_defconfig
index b01e763..35f8cf2 100644
--- a/arch/arm/configs/nhk8815_defconfig
+++ b/arch/arm/configs/nhk8815_defconfig
@@ -81,6 +81,7 @@ CONFIG_PPP_SYNC_TTY=m
 # CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
+CONFIG_KEYBOARD_GPIO=y
 # CONFIG_MOUSE_PS2 is not set
 # CONFIG_SERIO is not set
 # CONFIG_LEGACY_PTYS is not set
@@ -96,6 +97,11 @@ CONFIG_DEBUG_GPIO=y
 CONFIG_MMC=y
 CONFIG_MMC_CLKGATE=y
 CONFIG_MMC_ARMMMCI=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_PL031=y
 CONFIG_DMADEVICES=y
diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index 59f6ff5..1e0ec38 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -99,6 +99,10 @@ static unsigned long in_pullup[] = { PIN_INPUT_PULLUP };
 static struct pinctrl_map __initdata nhk8815_pinmap[] = {
 	PIN_MAP_MUX_GROUP_DEFAULT("uart0", "pinctrl-stn8815", "u0_a_1", "u0"),
 	PIN_MAP_MUX_GROUP_DEFAULT("uart1", "pinctrl-stn8815", "u1_a_1", "u1"),
+	/* User LED on S8815 */
+	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO2_C5", out_high),
+	/* User button on S8815 */
+	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO3_A4", in_nopull),
 	/* Hog in MMC/SD card mux */
 	PIN_MAP_MUX_GROUP_HOG_DEFAULT("pinctrl-stn8815", "mmcsd_a_1", "mmcsd"),
 	/* MCCLK */
-- 
1.8.1.4
