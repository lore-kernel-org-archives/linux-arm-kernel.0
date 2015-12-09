From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 09 Dec 2015 17:36:03 +0100
Subject: [PATCH] ARM: pxa: mark ezx structures as __maybe_unused
Message-ID: <7455848.ygDvrz6r6S@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ezx platform contains multiple machine descriptors, but not all
of them use all of the data structures, and it's possible to disable
all of the machines, which produces some harmless warnings:

mach-pxa/ezx.c:53:26: warning: 'ezx_pwm_lookup' defined but not used [-Wunused-variable]
mach-pxa/ezx.c:86:31: warning: 'ezx_fb_info_1' defined but not used [-Wunused-variable]
mach-pxa/ezx.c:107:31: warning: 'ezx_fb_info_2' defined but not used [-Wunused-variable]
mach-pxa/ezx.c:113:32: warning: 'ezx_devices' defined but not used [-Wunused-variable]
mach-pxa/ezx.c:117:22: warning: 'ezx_pin_config' defined but not used [-Wunused-variable]

This marks all those structures as __maybe_unused to avoid the warnings.
Obviously a configuration that contains the ezx platform but no specific
model is a bit silly, but it should not cause compile-time warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
index b61b7971b54f..391ba898b971 100644
--- a/arch/arm/mach-pxa/ezx.c
+++ b/arch/arm/mach-pxa/ezx.c
@@ -50,7 +50,7 @@
 #define GPIO19_GEN1_CAM_RST		19
 #define GPIO28_GEN2_CAM_RST		28
 
-static struct pwm_lookup ezx_pwm_lookup[] = {
+static struct pwm_lookup ezx_pwm_lookup[] __maybe_unused = {
 	PWM_LOOKUP("pxa27x-pwm.0", 0, "pwm-backlight.0", NULL, 78700,
 		   PWM_POLARITY_NORMAL),
 };
@@ -83,7 +83,7 @@ static struct pxafb_mode_info mode_ezx_old = {
 	.sync			= 0,
 };
 
-static struct pxafb_mach_info ezx_fb_info_1 = {
+static struct pxafb_mach_info ezx_fb_info_1 __maybe_unused = {
 	.modes		= &mode_ezx_old,
 	.num_modes	= 1,
 	.lcd_conn	= LCD_COLOR_TFT_16BPP,
@@ -104,17 +104,17 @@ static struct pxafb_mode_info mode_72r89803y01 = {
 	.sync			= 0,
 };
 
-static struct pxafb_mach_info ezx_fb_info_2 = {
+static struct pxafb_mach_info ezx_fb_info_2 __maybe_unused = {
 	.modes		= &mode_72r89803y01,
 	.num_modes	= 1,
 	.lcd_conn	= LCD_COLOR_TFT_18BPP,
 };
 
-static struct platform_device *ezx_devices[] __initdata = {
+static struct platform_device *ezx_devices[] __initdata __maybe_unused = {
 	&ezx_backlight_device,
 };
 
-static unsigned long ezx_pin_config[] __initdata = {
+static unsigned long ezx_pin_config[] __initdata __maybe_unused = {
 	/* PWM backlight */
 	GPIO16_PWM0_OUT,
 
