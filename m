From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 6 Apr 2011 17:37:02 +0200
Subject: [PATCH 1/2] ARM: imx: use imx_add_gpio_keys to register
	"gpio-keys" devices
In-Reply-To: <1298912674-15153-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1298912674-15153-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20110406153702.GG13963@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 28, 2011 at 06:04:33PM +0100, Uwe Kleine-K?nig wrote:
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c |   15 +++------------
>  arch/arm/mach-imx/mach-imx27_visstrim_m10.c    |   14 +++-----------
>  arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c   |   15 +++------------
>  arch/arm/mach-mx3/mach-armadillo5x0.c          |   15 +++------------
>  arch/arm/mach-mx3/mach-pcm037_eet.c            |   15 +++------------
>  arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c   |   15 +++------------
In the meantime arch/arm/mach-imx/mach-vpr200.c got another static
struct platform_device registering a "gpio-keys" device.
So I will squash the diff below in the commit for my pull request to
Sascha.

(In case someone objects that registering "gpio-keys" devices isn't imx
specific, (s)he can have my full ack. It's already on my todo-list to
make this more generic. Still I think this patch makes sense.)

Best regards
Uwe


diff --git a/arch/arm/mach-imx/mach-vpr200.c b/arch/arm/mach-imx/mach-vpr200.c
index feaa465..84100c6 100644
--- a/arch/arm/mach-imx/mach-vpr200.c
+++ b/arch/arm/mach-imx/mach-vpr200.c
@@ -136,18 +136,12 @@ static struct gpio_keys_button vpr200_gpio_keys_table[] = {
 	{KEY_F9, GPIO_BUTTON8, 1, "vpr-keys: F9", 1, VPR_KEY_DEBOUNCE},
 };
 
-static struct gpio_keys_platform_data vpr200_gpio_keys_data = {
+static const struct gpio_keys_platform_data
+		vpr200_gpio_keys_data __initconst = {
 	.buttons = vpr200_gpio_keys_table,
 	.nbuttons = ARRAY_SIZE(vpr200_gpio_keys_table),
 };
 
-static struct platform_device vpr200_device_gpiokeys = {
-	.name = "gpio-keys",
-	.dev = {
-		.platform_data = &vpr200_gpio_keys_data,
-	}
-};
-
 static struct mc13xxx_platform_data vpr200_pmic = {
 	.flags = MC13XXX_USE_ADC | MC13XXX_USE_TOUCHSCREEN,
 };
@@ -261,7 +255,6 @@ static const struct mxc_usbh_platform_data usb_host_pdata __initconst = {
 
 static struct platform_device *devices[] __initdata = {
 	&vpr200_flash,
-	&vpr200_device_gpiokeys,
 };
 
 /*
@@ -273,6 +266,7 @@ static void __init vpr200_board_init(void)
 
 	imx35_add_fec(NULL);
 	imx35_add_imx2_wdt(NULL);
+	imx_add_gpio_keys(&vpr200_gpio_keys_data);
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
