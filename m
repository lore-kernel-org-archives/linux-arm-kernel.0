From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 16 Nov 2010 20:45:37 +0100
Subject: [PATCH 1/5] mx51: Add PWM resources
In-Reply-To: <544192.7336.qm@web51008.mail.re2.yahoo.com>
References: <544192.7336.qm@web51008.mail.re2.yahoo.com>
Message-ID: <20101116194537.GT8942@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Fabio,

On Tue, Nov 16, 2010 at 10:36:05AM -0800, Fabio Estevam wrote:
> Add PWM resources.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> ---
>  arch/arm/mach-mx5/devices.c |???50 +++++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-mx5/devices.h |? ? 2 +
I'm currently trying to get rid of the devices.c files and allocate the
devices dynamically.  Can you please use the same approach?
I already have plat-mxc/devices/platform-mxc_pwm.c in my tree.  I'm
trying to post my patches later today and check with Sascha how to
integrate it (that probably only tomorrow).

>  2 files changed, 52 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/devices.c b/arch/arm/mach-mx5/devices.c
> index 4c7be87..ec36c3e 100644
> --- a/arch/arm/mach-mx5/devices.c
> +++ b/arch/arm/mach-mx5/devices.c
> @@ -131,6 +131,56 @@ struct platform_device mxc_keypad_device = {
>  ??? .resource = mxc_kpp_resources,
>  };
>  
> +static struct resource mxc_pwm0_resources[] = {
> +??? {
> +??? ??? .start = MX51_PWM1_BASE_ADDR,
> +??? ??? .end = MX51_PWM1_BASE_ADDR + 0x14,
I think you need at least 0x17 here, as the last (32 bit wide) register
starts at 0x14.  When checking the memory map in the reference manual
the blocks reserved for pwm have a size of 16 KiB.  So I'd prefer SZ_16K
here.

> +??? ??? .flags = IORESOURCE_MEM,
> +??? },
> +??? {
> +??? ??? .start = MX51_MXC_INT_PWM1,
> +??? ??? .end = MX51_MXC_INT_PWM1,
> +??? ??? .flags = IORESOURCE_IRQ,
> +??? },
> +};
> +
> +struct platform_device mxc_pwm0_device = {
> +??? .name = "mxc_pwm",
> +??? .id = 0,
> +??? .num_resources = ARRAY_SIZE(mxc_pwm0_resources),
> +??? .resource = mxc_pwm0_resources,
> +};
> +
> +static struct resource mxc_pwm1_resources[] = {
> +??? {
> +??? ??? .start = MX51_PWM2_BASE_ADDR,
> +??? ??? .end = MX51_PWM2_BASE_ADDR + 0x14,
> +??? ??? .flags = IORESOURCE_MEM,
> +??? },
> +??? {
> +??? ??? .start = MX51_MXC_INT_PWM2,
> +??? ??? .end = MX51_MXC_INT_PWM2,
> +??? ??? .flags = IORESOURCE_IRQ,
> +??? },
> +};
> +
> +struct platform_device mxc_pwm1_device = {
> +??? .name = "mxc_pwm",
> +??? .id = 1,
> +??? .num_resources = ARRAY_SIZE(mxc_pwm1_resources),
> +??? .resource = mxc_pwm1_resources,
> +};
> +
> +struct platform_device mxc_pwm0_backlight_device = {
> +??? .name = "pwm-backlight",
> +??? .id = 0,
> +};
> +
> +struct platform_device mxc_pwm1_backlight_device = {
> +??? .name = "pwm-backlight",
> +??? .id = 1,
> +};
> +
>  static struct mxc_gpio_port mxc_gpio_ports[] = {
>  ??? {
>  ??? ??? .chip.label = "gpio-0",
> diff --git a/arch/arm/mach-mx5/devices.h b/arch/arm/mach-mx5/devices.h
> index af1d07c..71a9fe9 100644
> --- a/arch/arm/mach-mx5/devices.h
> +++ b/arch/arm/mach-mx5/devices.h
> @@ -4,3 +4,5 @@ extern struct platform_device mxc_usbdr_udc_device;
>  extern struct platform_device mxc_wdt;
>  extern struct platform_device mxc_hsi2c_device;
>  extern struct platform_device mxc_keypad_device;
> +extern struct platform_device mxc_pwm0_device;
> +extern struct platform_device mxc_pwm0_backlight_device;
Not that it matters much because I want these allocated dynamically, but
you forgot the pwm1 devices here.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
