From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 31 May 2011 08:37:24 +0200
Subject: [PATCH 2/3] ARM: mx5: convert to new leds-gpio registration helper
In-Reply-To: <20110531052032.GA32080@S2100-06.ap.freescale.net>
References: <1306609503-31746-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1306609503-31746-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110531052032.GA32080@S2100-06.ap.freescale.net>
Message-ID: <20110531063723.GR9907@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Tue, May 31, 2011 at 01:20:33PM +0800, Shawn Guo wrote:
> On Sat, May 28, 2011 at 09:05:02PM +0200, Uwe Kleine-K?nig wrote:
> > This gets rid of per machine struct platform_device definitions and allows
> > to move the platform data and led definition to .init.rodata.
> > 
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  arch/arm/mach-mx5/Kconfig                    |    4 ++++
> >  arch/arm/mach-mx5/board-mx51_efikamx.c       |   15 ++++-----------
> >  arch/arm/mach-mx5/board-mx51_efikasb.c       |   16 ++++------------
> >  arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c |   18 +++---------------
> >  arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c |   19 ++++---------------
> >  5 files changed, 19 insertions(+), 53 deletions(-)
> > 
> I'm building Sascha's imx-for-3.0 tree where this patch got applied,
> and seeing the following.
> 
>   CC      arch/arm/mach-mx5/board-mx51_efikamx.o
> arch/arm/mach-mx5/board-mx51_efikamx.c: In function ?mx51_efikamx_init?:
> arch/arm/mach-mx5/board-mx51_efikamx.c:241:3: error: assignment of read-only location ?mx51_efikamx_leds[2]?
> arch/arm/mach-mx5/board-mx51_efikamx.c:244:2: error: implicit declaration of function ?gpio_leds_register_device?
huh, Sascha, can you please squash the following into the patch you
applied. (Or should I create a proper patch such that you don't need to
rebase?)

diff --git a/arch/arm/mach-mx5/board-mx51_efikamx.c b/arch/arm/mach-mx5/board-mx51_efikamx.c
index f38fb63..2400f6d 100644
--- a/arch/arm/mach-mx5/board-mx51_efikamx.c
+++ b/arch/arm/mach-mx5/board-mx51_efikamx.c
@@ -139,7 +139,7 @@ static void __init mx51_efikamx_board_id(void)
 	}
 }
 
-static const struct gpio_led mx51_efikamx_leds[] __initconst = {
+static struct gpio_led mx51_efikamx_leds[] __initdata = {
 	{
 		.name = "efikamx:green",
 		.default_trigger = "default-on",
@@ -241,7 +241,7 @@ static void __init mx51_efikamx_init(void)
 		mx51_efikamx_leds[2].default_trigger = "mmc1";
 	}
 
-	gpio_leds_register_device(&mx51_efikamx_leds_data);
+	gpio_led_register_device(-1, &mx51_efikamx_leds_data);
 	imx_add_gpio_keys(&mx51_efikamx_powerkey_data);
 
 	if (system_rev == 0x11) {
diff --git a/arch/arm/mach-mx5/board-mx51_efikasb.c b/arch/arm/mach-mx5/board-mx51_efikasb.c
index dbf9d92..28d6896 100644
--- a/arch/arm/mach-mx5/board-mx51_efikasb.c
+++ b/arch/arm/mach-mx5/board-mx51_efikasb.c
@@ -249,7 +249,7 @@ static void __init efikasb_board_init(void)
 	mx51_efikasb_usb();
 	imx51_add_sdhci_esdhc_imx(1, NULL);
 
-	gpio_leds_register_device(-1, &mx51_efikasb_leds_data);
+	gpio_led_register_device(-1, &mx51_efikasb_leds_data);
 	imx_add_gpio_keys(&mx51_efikasb_keys_data);
 }
 
Hhhhm, I was pretty sure I build tested that patch, it seems I did not.

Thanks Shawn for noticing.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
