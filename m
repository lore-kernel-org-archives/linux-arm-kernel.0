From: premi@ti.com (Premi, Sanjeev)
Date: Thu, 26 May 2011 14:53:10 +0530
Subject: [PATCH 02/15] OMAP2PLUS: GPIO: Fix non-wakeup GPIO and rev_ids
In-Reply-To: <1306247094-25372-3-git-send-email-tarun.kanti@ti.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
	<1306247094-25372-3-git-send-email-tarun.kanti@ti.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D177FCC@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org 
> [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of 
> DebBarma, Tarun Kanti
> Sent: Tuesday, May 24, 2011 7:55 PM
> To: linux-omap at vger.kernel.org
> Cc: Hilman, Kevin; Shilimkar, Santosh; tony at atomide.com; 
> linux-arm-kernel at lists.infradead.org; Varadarajan, 
> Charulatha; Cousson, Benoit; Paul Walmsley
> Subject: [PATCH 02/15] OMAP2PLUS: GPIO: Fix non-wakeup GPIO 
> and rev_ids
> 
> From: Charulatha V <charu@ti.com>
> 
> Non-wakeup GPIOs are available only in OMAP2420 and OMAP3430. But
> the GPIO driver initializes the non-wakeup GPIO bits for OMAP24xx
> (bothe OMAP 2420 and 2430) & not for OMAP3 which is incorrect.
> 
> Fix the above by providing non-wakeup GPIO information through pdata
> specific to the SoC.
> 
> The GPIO rev id provided in the hwmod database is the same 
> for OMAP2420
> and OMAP2430. Change the GPIO rev ids in hwmod database as given below
> so that it can be used to identify OMAP2420 and OMAP2430.
> OMAP2420 - 0
> OMAP2430 - 1
> OMAP3    - 2
> OMAP4    - 3

[sp] Magic numbers should be avoided.
     Suggest using something like:
     #define GPIO_REV_2420	0
     #define GPIO_REV_2430	1
     #define GPIO_REV_34XX	2
     #define GPIO_REV_44xx	3

     We don't have to refer back to this comment while reading the code.
     I also believed that HWMODs were auto generated.
     Can the changes to structures in this patch recreated using current
     scripts?

~sanjeev

> 
> Signed-off-by: Charulatha V <charu@ti.com>
> Cc: Cousson, Benoit <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/gpio.c                 |   26 
> ++++++++++++++++++++++++--
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c |    2 +-
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    2 +-
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
>  arch/arm/plat-omap/include/plat/gpio.h     |    1 +
>  drivers/gpio/gpio_omap.c                   |   11 +++--------
>  6 files changed, 31 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
> index 0446bd1..6cd26b4 100644
> --- a/arch/arm/mach-omap2/gpio.c
> +++ b/arch/arm/mach-omap2/gpio.c
> @@ -56,6 +56,28 @@ static int omap2_gpio_dev_init(struct 
> omap_hwmod *oh, void *unused)
>  		return -ENOMEM;
>  	}
>  
> +	switch (oh->class->rev) {
> +	case 0:
> +		if (id == 1)
> +			/* non-wakeup GPIO pins for OMAP2420 Bank1 */
> +			pdata->non_wakeup_gpios = 0xe203ffc0;
> +		else if (id == 2)
> +			/* non-wakeup GPIO pins for OMAP2420 Bank2 */
> +			pdata->non_wakeup_gpios = 0x08700040;
> +		break;
> +	case 2:
> +		if (id == 2)
> +			/* non-wakeup GPIO pins for OMAP3 Bank2 */
> +			pdata->non_wakeup_gpios = 0x00000001;
> +		else if (id == 6)
> +			/* non-wakeup GPIO pins for OMAP3 Bank6 */
> +			pdata->non_wakeup_gpios = 0x08000000;
> +		break;

[sp] Where is the description on non-wakeup GPIOs in OMAP3?
     Here is text from AM37x TRM:
     [quote ...only relevant text]
     Each GPIO module provides 32 dedicated general-purpose pins with input
     and output capabilities; .... These pins can be configured for the
     following applications:
     - Data input (capture)/output (drive)
     - Keyboard interface with a debounce cell
     - Interrupt generation in ....
     - Wake-up request generation in idle mode
     [/quote]
     Otherwise, what are the GPIO2_WAKEUPENABLE (0x4905 0020) and
     GPIO6_WAKEUPENABLE (0x4905 8020) meant for?

> +	default:
> +		/* No non-wakeup GPIO pins for other SoCs */
> +		break;
> +	}
> +

~sanjeev

[snip]...[snip]
