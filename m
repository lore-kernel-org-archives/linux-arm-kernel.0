From: horms@verge.net.au (Simon Horman)
Date: Wed, 9 Oct 2013 11:13:26 +0900
Subject: [PATCH 07/08] ARM: shmobile: Add Koelsch LED6, LED7 and LED8
 support
In-Reply-To: <20131008033959.20455.18632.sendpatchset@w520>
References: <20131008033851.20455.68845.sendpatchset@w520>
 <20131008033959.20455.18632.sendpatchset@w520>
Message-ID: <20131009021324.GH15065@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 12:39:59PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Enable Koelsch LEDs for GPIO output testing purpose.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Hi Magnus,

this patch does not seem to apply on top of renesas-devel-20131004.
Could you please rebase it and the following on top of
renesas-devel-20131004 or the latest devel tag?

Thanks

> ---
> 
>  arch/arm/mach-shmobile/board-koelsch.c |   27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> --- 0009/arch/arm/mach-shmobile/board-koelsch.c
> +++ work/arch/arm/mach-shmobile/board-koelsch.c	2013-10-07 13:48:52.000000000 +0900
> @@ -20,6 +20,8 @@
>   */
>  
>  #include <linux/kernel.h>
> +#include <linux/leds.h>
> +#include <linux/platform_data/gpio-rcar.h>
>  #include <linux/platform_device.h>
>  #include <mach/common.h>
>  #include <mach/r8a7791.h>
> @@ -27,11 +29,36 @@
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
>  
> +/* LEDS */
> +static struct gpio_led koelsch_leds[] = {
> +	{
> +		.name		= "led8",
> +		.gpio		= RCAR_GP_PIN(2, 21),
> +		.default_state	= LEDS_GPIO_DEFSTATE_ON,
> +	}, {
> +		.name		= "led7",
> +		.gpio		= RCAR_GP_PIN(2, 20),
> +		.default_state	= LEDS_GPIO_DEFSTATE_ON,
> +	}, {
> +		.name		= "led6",
> +		.gpio		= RCAR_GP_PIN(2, 19),
> +		.default_state	= LEDS_GPIO_DEFSTATE_ON,
> +	},
> +};
> +
> +static const struct gpio_led_platform_data koelsch_leds_pdata __initconst = {
> +	.leds		= koelsch_leds,
> +	.num_leds	= ARRAY_SIZE(koelsch_leds),
> +};
> +
>  static void __init koelsch_add_standard_devices(void)
>  {
>  	r8a7791_clock_init();
>  	r8a7791_pinmux_init();
>  	r8a7791_add_standard_devices();
> +	platform_device_register_data(&platform_bus, "leds-gpio", -1,
> +				      &koelsch_leds_pdata,
> +				      sizeof(koelsch_leds_pdata));
>  }
>  
>  static const char * const koelsch_boards_compat_dt[] __initconst = {
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
