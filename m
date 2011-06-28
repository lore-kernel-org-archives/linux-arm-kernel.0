From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 28 Jun 2011 16:50:11 +0300
Subject: [PATCH] OMAP: HSMMC: Fix GPIO muxing
In-Reply-To: <1309250759-18472-1-git-send-email-silesh@ti.com>
References: <1309250759-18472-1-git-send-email-silesh@ti.com>
Message-ID: <4E09DC13.3010304@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Silesh,

On 06/28/11 11:45, Silesh C V wrote:

> Use generic gpio call to check the validity of the gpio. Note that
> this includes gpio 0 also which was missing before.
>
> Signed-off-by: Silesh C V <silesh@ti.com>
> ---
>  arch/arm/mach-omap2/hsmmc.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
> index 66868c5..a9b45c7 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -13,6 +13,7 @@
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/delay.h>
> +#include <linux/gpio.h>
>  #include <mach/hardware.h>
>  #include <plat/mmc.h>
>  #include <plat/omap-pm.h>
> @@ -213,12 +214,10 @@ static int nop_mmc_set_power(struct device *dev, int slot, int power_on,
>  static inline void omap_hsmmc_mux(struct omap_mmc_platform_data *mmc_controller,
>  			int controller_nr)
>  {
> -	if ((mmc_controller->slots[0].switch_pin > 0) && \
> -		(mmc_controller->slots[0].switch_pin < OMAP_MAX_GPIO_LINES))
> +	if (gpio_is_valid(mmc_controller->slots[0].switch_pin))
>  		omap_mux_init_gpio(mmc_controller->slots[0].switch_pin,
>  					OMAP_PIN_INPUT_PULLUP);
> -	if ((mmc_controller->slots[0].gpio_wp > 0) && \
> -		(mmc_controller->slots[0].gpio_wp < OMAP_MAX_GPIO_LINES))
> +	if (gpio_is_valid(mmc_controller->slots[0].gpio_wp))
>  		omap_mux_init_gpio(mmc_controller->slots[0].gpio_wp,
>  					OMAP_PIN_INPUT_PULLUP);
>  	if (cpu_is_omap34xx()) {

IMHO, you should not separate the patches
(this one and OMAP: 4430SDP: Register the card detect GPIO properly),
because the 4430sdp fix should come before or together with this patch,
otherwise 4430sdp will be broken, once this patch is applied.

You can either make it a one patch or make it a single properly numbered series.

-- 
Regards,
Igor.
