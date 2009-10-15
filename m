From: utx@penguin.cz (Stanislav Brabec)
Date: Thu, 15 Oct 2009 23:47:32 +0200
Subject: spitz: add gpio button support (fixes regression)
In-Reply-To: <20091015212024.GC15898@elf.ucw.cz>
References: <20091006074635.GA2775@ucw.cz>
	<1254829732.3546.35.camel@utx.utx.cz>
	<20091007085806.GB28807@elf.ucw.cz>
	<1254914991.4213.80.camel@hammer.suse.cz>
	<20091007120643.GA17069@rakim.wolfsonmicro.main>
	<f17812d70910070727x47b2a22h8e9f9304740d5abf@mail.gmail.com>
	<20091006200933.GA1606@ucw.cz> <1255641385.3985.55.camel@utx.utx.cz>
	<20091015212024.GC15898@elf.ucw.cz>
Message-ID: <1255643252.3985.63.camel@utx.utx.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pavel Machek wrote:
>Well, resume is hit by second regression.
>
>Suspend key.... I restored it to the level of functionality in
>2.6.31 :-).

> > +		.type	= EV_KEY,
> > +		.code	= KEY_SUSPEND,

I guess it should be EV_PWR. Then it will at least go to suspend.

Here is a patch with just this change. Also changing .desc to
"On/Off" (the text on the case).

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index ee8d603..c690522 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
+#include <linux/gpio_keys.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
 #include <linux/mtd/physmap.h>
@@ -375,6 +376,43 @@ static struct platform_device spitzkbd_device = {
 };
 
 
+static struct gpio_keys_button spitz_gpio_keys[] = {
+	{
+		.type	= EV_PWR,
+		.code	= KEY_SUSPEND,
+		.gpio	= SPITZ_GPIO_ON_KEY,
+		.desc	= "On/Off",
+		.wakeup	= 1,
+	},
+	/* Two buttons detecting the LID state */
+	{
+		.type	= EV_SW,
+		.code	= 0,
+		.gpio	= SPITZ_GPIO_SWA,
+		.desc	= "Lid SWA",
+	},
+	{
+		.type	= EV_SW,
+		.code	= 1,
+		.gpio	= SPITZ_GPIO_SWB,
+		.desc	= "Lid SWB",
+	},
+};
+
+static struct gpio_keys_platform_data spitz_gpio_keys_platform_data = {
+	.buttons	= spitz_gpio_keys,
+	.nbuttons	= ARRAY_SIZE(spitz_gpio_keys),
+};
+
+static struct platform_device spitz_gpio_keys_device = {
+	.name	= "gpio-keys",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &spitz_gpio_keys_platform_data,
+	},
+};
+
+
 /*
  * Spitz LEDs
  */
@@ -689,6 +727,7 @@ static struct platform_device sharpsl_rom_device = {
 static struct platform_device *devices[] __initdata = {
 	&spitzscoop_device,
 	&spitzkbd_device,
+	&spitz_gpio_keys_device,
 	&spitzled_device,
 	&sharpsl_nand_device,
 	&sharpsl_rom_device,



________________________________________________________________________
Stanislav Brabec
http://www.penguin.cz/~utx
