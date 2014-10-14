From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Oct 2014 11:17:33 +0200
Subject: next build: 304 warnings 0 failures (next/next-20141013)
In-Reply-To: <20141014085432.GC2255@lahna.fi.intel.com>
References: <543b63d2.a479420a.486e.ffffb6e2@mx.google.com>
 <8786463.d9VIC5J1Iz@wuerfel> <20141014085432.GC2255@lahna.fi.intel.com>
Message-ID: <7136705.nXM3eChrM0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 October 2014 11:54:32 Mika Westerberg wrote:
> 
> Fenghua's build bot noticed this some time ago and it got fixed but
> looks like we forgot to merge the fix to the _DSD patch series.
> 
> Here it is again. Rafael, do you want to take this on top of the
> 'device-properties' -branch?
> 
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> Subject: [PATCH] leds: Move gpiod to be last member of struct gpio_led
> 
> Commit 8b0d4dc3d44 (leds: leds-gpio: Add support for GPIO descriptors)
> added a new member 'gpiod' to struct gpio_led to support GPIO descriptors.
> This is fine as long as board files use designated initializers but some
> fail to do so causing following build errors:
> 
>   arch/arm/mach-omap1/board-htcherald.c:296:2: warning: initialization makes pointer from integer without a cast [enabled by default]
>   arch/arm/mach-omap1/board-htcherald.c:296:2: warning: (near initialization for 'gpio_leds[0].gpiod') [enabled by default]
>   arch/arm/mach-omap1/board-htcherald.c:297:2: warning: initialization makes pointer from integer without a cast [enabled by default]
>   arch/arm/mach-omap1/board-htcherald.c:297:2: warning: (near initialization for 'gpio_leds[1].gpiod') [enabled by default]
> 
> To be on the safe side move the 'gpiod' member to be the last member of struct
> gpiod_led.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

Looks good to me. Should we also do the other patch to be on the safe side?
8<-------
Subject: [PATCH] ARM: OMAP1: htcherald: use named initializers for gpio-leds

A recent change to the gpio-leds driver broke the platform data definition
in the htcherald file:

arch/arm/mach-omap1/board-htcherald.c:296:2: warning: initialization makes pointer from integer without a cast [enabled by default]

The gpio-led driver is being changed to avoid that problem, but it would also
be good to make the board file use named initializers like every other one,
so it won't happen again.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index 35a2379b986f..259a54733e63 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -293,17 +293,18 @@ static struct platform_device herald_gpiokeys_device = {
 
 /* LEDs for the Herald.  These connect to the HTCPLD GPIO device. */
 static struct gpio_led gpio_leds[] = {
-	{"dpad",        NULL, HTCPLD_GPIO_LED_DPAD,        0, 0, LEDS_GPIO_DEFSTATE_OFF},
-	{"kbd",         NULL, HTCPLD_GPIO_LED_KBD,         0, 0, LEDS_GPIO_DEFSTATE_OFF},
-	{"vibrate",     NULL, HTCPLD_GPIO_LED_VIBRATE,     0, 0, LEDS_GPIO_DEFSTATE_OFF},
-	{"green_solid", NULL, HTCPLD_GPIO_LED_GREEN_SOLID, 0, 0, LEDS_GPIO_DEFSTATE_OFF},
-	{"green_flash", NULL, HTCPLD_GPIO_LED_GREEN_FLASH, 0, 0, LEDS_GPIO_DEFSTATE_OFF},
-	{"red_solid",   "mmc0", HTCPLD_GPIO_LED_RED_SOLID, 0, 0, LEDS_GPIO_DEFSTATE_OFF},
-	{"red_flash",   NULL, HTCPLD_GPIO_LED_RED_FLASH,   0, 0, LEDS_GPIO_DEFSTATE_OFF},
-	{"wifi",        NULL, HTCPLD_GPIO_LED_WIFI,        0, 0, LEDS_GPIO_DEFSTATE_OFF},
-	{"bt",          NULL, HTCPLD_GPIO_LED_BT,          0, 0, LEDS_GPIO_DEFSTATE_OFF},
-	{"caps",        NULL, HTCPLD_GPIO_LED_CAPS,        0, 0, LEDS_GPIO_DEFSTATE_OFF},
-	{"alt",         NULL, HTCPLD_GPIO_LED_ALT,         0, 0, LEDS_GPIO_DEFSTATE_OFF},
+	{ .name = "dpad",         .gpio = HTCPLD_GPIO_LED_DPAD, },
+	{ .name = "kbd",          .gpio = HTCPLD_GPIO_LED_KBD, },
+	{ .name = "vibrate",      .gpio = HTCPLD_GPIO_LED_VIBRATE, },
+	{ .name = "green_solid",  .gpio = HTCPLD_GPIO_LED_GREEN_SOLID, },
+	{ .name = "green_flash",  .gpio = HTCPLD_GPIO_LED_GREEN_FLASH, },
+	{ .name = "red_solid",	  .default_trigger = "mmc0",
+				  .gpio = HTCPLD_GPIO_LED_RED_SOLID, },
+	{ .name = "red_flash",    .gpio = HTCPLD_GPIO_LED_RED_FLASH, },
+	{ .name = "wifi",         .gpio = HTCPLD_GPIO_LED_WIFI, },
+	{ .name = "bt",           .gpio = HTCPLD_GPIO_LED_BT, },
+	{ .name = "caps",         .gpio = HTCPLD_GPIO_LED_CAPS, },
+	{ .name = "alt",          .gpio = HTCPLD_GPIO_LED_ALT, },
 };
 
 static struct gpio_led_platform_data gpio_leds_data = {
