From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 13 Feb 2013 17:03:28 +0100
Subject: [PATCH 07/21] ARM: shmobile: kzm9g: reference: Register pinctrl
 mappings for I2C
In-Reply-To: <1360723497-23266-8-git-send-email-horms+renesas@verge.net.au>
References: <1360723497-23266-1-git-send-email-horms+renesas@verge.net.au>
 <1360723497-23266-8-git-send-email-horms+renesas@verge.net.au>
Message-ID: <3631209.BKvXQoUfHr@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Thanks you for the patch.

On Wednesday 13 February 2013 11:44:43 Simon Horman wrote:
> Replace the GPIO-based I2C pinmux configuration by pinctrl mappings.
> 
> This change is for the kzm9g reference DT implementation and
> is in keeping with a similar change for the default kzm9g implementation
> made by Laurent Pinchart.
> 
> This change also adds a sh73a0_pinmux_init() call to kzm_init()
> which was previously missing as it was not needed (or at least not
> needed in practice) for the minimal board configuration supplied
> by the reference DT implementation. The call to sh73a0_pinmux_init()
> will be removed by a subsequent patch to initialise pinmus using
> device tree.
> 
> Reported-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/mach-shmobile/board-kzm9g-reference.c |   12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c
> b/arch/arm/mach-shmobile/board-kzm9g-reference.c index 6a1222e..642bb7b
> 100644
> --- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
> +++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
> @@ -26,12 +26,18 @@
>  #include <linux/irq.h>
>  #include <linux/input.h>
>  #include <linux/of_platform.h>
> +#include <linux/pinctrl/machine.h>
>  #include <mach/sh73a0.h>
>  #include <mach/common.h>
>  #include <asm/hardware/cache-l2x0.h>
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> 
> +static const struct pinctrl_map kzm_pinctrl_map[] = {
> +	PIN_MAP_MUX_GROUP_DEFAULT("i2c-sh_mobile.3", "pfc-sh73a0",
> +				  "i2c3_1", "i2c3"),
> +};
> +
>  static void __init kzm_init(void)
>  {
>  	/* enable SCIFA4 */
> @@ -52,16 +58,14 @@ static void __init kzm_init(void)
>  	gpio_request(GPIO_FN_MMCD0_6_PU,	NULL);
>  	gpio_request(GPIO_FN_MMCD0_7_PU,	NULL);
> 
> -	/* I2C 3 */
> -	gpio_request(GPIO_FN_PORT27_I2C_SCL3, NULL);
> -	gpio_request(GPIO_FN_PORT28_I2C_SDA3, NULL);
> -
>  #ifdef CONFIG_CACHE_L2X0
>  	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
>  	l2x0_init(IOMEM(0xf0100000), 0x40460000, 0x82000fff);
>  #endif
> 
> +	sh73a0_pinmux_init();

You should initialize pinmuxing before using any of the GPIO functions, so 
this call should be moved near the top of kzm_init().

>  	sh73a0_add_standard_devices_dt();
> +	pinctrl_register_mappings(kzm_pinctrl_map, ARRAY_SIZE(kzm_pinctrl_map));

You should register mappings before initializing pinmuxing, otherwise the 
default configurations won't be applied as they won't be registered when the 
PFC device is registered. This call should thus be moved before the 
sh73a0_pinmux_init() call.

>  }
> 
>  static void kzm9g_restart(char mode, const char *cmd)
-- 
Regards,

Laurent Pinchart
