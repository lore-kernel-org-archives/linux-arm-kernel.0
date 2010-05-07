From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 7 May 2010 01:35:04 +0100
Subject: [PATCH 8/8] Add support for backlight regulation on Acer n35
In-Reply-To: <4BE2C2FF.8020404@vscht.cz>
References: <4BE1EE8C.8040900@vscht.cz>
	<20100506012258.GZ6684@trinity.fluff.org>
	<4BE2C18E.6080207@vscht.cz> <4BE2C1D7.4030408@vscht.cz>
	<4BE2C224.7080907@vscht.cz> <4BE2C24C.9050008@vscht.cz>
	<4BE2C26E.2080508@vscht.cz> <4BE2C294.7030300@vscht.cz>
	<4BE2C2CC.2010003@vscht.cz> <4BE2C2FF.8020404@vscht.cz>
Message-ID: <20100507003504.GV2589@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 06, 2010 at 03:24:15PM +0200, Pinkava J. wrote:
> 

would a description here hurt?

 
> Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
> ---
>  arch/arm/mach-s3c2410/mach-n30.c |   57 ++++++++++++++++++++++++++++++++++++++
>  1 files changed, 57 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c2410/mach-n30.c b/arch/arm/mach-s3c2410/mach-n30.c
> index f25275e..4c37c71 100644
> --- a/arch/arm/mach-s3c2410/mach-n30.c
> +++ b/arch/arm/mach-s3c2410/mach-n30.c
> @@ -23,6 +23,7 @@
>  #include <linux/input.h>
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
> +#include <linux/pwm_backlight.h>
>  #include <linux/serial_core.h>
>  #include <linux/timer.h>
>  #include <linux/io.h>
> @@ -352,6 +353,60 @@ static struct s3c2410fb_mach_info n30_fb_info __initdata = {
>  	.lpcsel		= 0x06,
>  };
> 
> +static int n35_backlight_init(struct device *dev)
> +{
> +	gpio_request(S3C2410_GPB(0), "Backlight PWM");
> +	gpio_request(S3C2410_GPB(1), "Backlight power driver");
> +
> +	/* set GPIO as output for timer */
> +	s3c2410_gpio_setpin(S3C2410_GPB(0), 0);
> +	s3c2410_gpio_pullup(S3C2410_GPB(0), 0);
> +	s3c2410_gpio_cfgpin(S3C2410_GPB(0), S3C2410_GPB0_TOUT0);
> +
> +	/* setup backlight power driving GPIO */
> +	s3c2410_gpio_pullup(S3C2410_GPB(1), 1);
> +	s3c2410_gpio_cfgpin(S3C2410_GPB(1), S3C2410_GPIO_OUTPUT);

I'm going to hold this one pending the merge of the gpio updates, since
these calls are going away.

> +	return 0;
> +}
> +
> +static int n35_backlight_notify(struct device *dev, int brightness)
> +{
> +	/* power off backlight, values less than 12 ar useless */
> +	s3c2410_gpio_setpin(S3C2410_GPB(1), brightness > 12 ? 1 : 0);
> +	return (brightness > 12 ? brightness : 0);
> +}

gpiolib calls here please.

> +static void n35_backlight_exit(struct device *dev)
> +{
> +	s3c2410_gpio_cfgpin(S3C2410_GPB(0), 1/*S3C2410_GPB0_OUTP*/);
we have constants for generic output...

> +	s3c2410_gpio_setpin(S3C2410_GPB(1), 0); /* co stim */
gpio_set_value().

> +	/* power off backlight */
> +	s3c2410_gpio_pullup(S3C2410_GPB(1), 0);
> +	gpio_free(S3C2410_GPB(1));
> +	gpio_free(S3C2410_GPB(0));
> +}
> +
> +static struct platform_pwm_backlight_data backlight_data = {
> +	.pwm_id         = 0,
> +	.max_brightness = 100,
> +	.dft_brightness = 50,
> +	/* tcnt = 0x31, FIXME: compute some nicer value */
> +	.pwm_period_ns  = 3*1000*1000,
> +	.init           = n35_backlight_init,
> +	.notify         = n35_backlight_notify,
> +	.exit           = n35_backlight_exit,
> +};
> +
> +static struct platform_device n35_backlight = {
> +	.name = "pwm-backlight",
> +	.dev  = {
> +		.parent = &s3c_device_timer[0].dev,
> +		.platform_data = &backlight_data,
> +	},
> +	.id   = -1,
> +};
> +
>  static void n30_sdi_set_power(unsigned char power_mode, unsigned short vdd)
>  {
>  	switch (power_mode) {
> @@ -395,6 +450,8 @@ static struct platform_device *n35_devices[] __initdata = {
>  	&s3c_device_rtc,
>  	&s3c_device_usbgadget,
>  	&s3c_device_sdi,
> +	&s3c_device_timer[0],
> +	&n35_backlight,
>  	&n35_button_device,
>  	&n35_blue_led,

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
