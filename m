From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 08 Jan 2013 10:36:11 +0200
Subject: [PATCH 2/3] ALSA: pxa27x: fix ac97 warm reset
In-Reply-To: <1357595714-13698-3-git-send-email-mikedunn@newsguy.com>
References: <1357595714-13698-1-git-send-email-mikedunn@newsguy.com>
 <1357595714-13698-3-git-send-email-mikedunn@newsguy.com>
Message-ID: <50EBDA7B.2020508@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/07/13 23:55, Mike Dunn wrote:
> This patch fixes some code that implements a work-around to a hardware bug in
> the ac97 controller on the pxa27x.  A bug in the controller's warm reset
> functionality requires that the mfp used by the controller as the AC97_nRESET
> line be temporarily reconfigured as a generic output gpio (AF0) and manually
> held high for the duration of the warm reset cycle.  This is what was done in
> the original code, but it was broken long ago by commit fb1bf8cd
>     ([ARM] pxa: introduce processor specific pxa27x_assert_ac97reset())
> which changed the mfp to a GPIO input instead of a high output.
> 
> The fix requires the ac97 controller to obtain the gpio via gpio_request_one(),
> with arguments that configure the gpio as an output initially driven high.
> 
> Tested on a palm treo 680 machine.  Reportedly, this broken code only prevents a
> warm reset on hardware that lacks a pull-up on the line, which appears to be the
> case for me.
> 
> Signed-off-by: Mike Dunn <mikedunn@newsguy.com>

Since I've participated in the patch development, please, add:

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>

Thanks!

> ---
>  arch/arm/mach-pxa/include/mach/mfp-pxa27x.h |    3 +++
>  arch/arm/mach-pxa/pxa27x.c                  |    4 ++--
>  sound/arm/pxa2xx-ac97-lib.c                 |   18 +++++++++++++++++-
>  3 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h b/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h
> index a611ad3..b6132aa 100644
> --- a/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h
> +++ b/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h
> @@ -463,6 +463,9 @@
>  	GPIO76_LCD_PCLK,	\
>  	GPIO77_LCD_BIAS
>  
> +/* these enable a work-around for a hw bug in pxa27x during ac97 warm reset */
> +#define GPIO113_AC97_nRESET_GPIO_HIGH MFP_CFG_OUT(GPIO113, AF0, DEFAULT)
> +#define GPIO95_AC97_nRESET_GPIO_HIGH MFP_CFG_OUT(GPIO95, AF0, DEFAULT)
>  
>  extern int keypad_set_wake(unsigned int on);
>  #endif /* __ASM_ARCH_MFP_PXA27X_H */
> diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
> index 8047ee0..616cb87 100644
> --- a/arch/arm/mach-pxa/pxa27x.c
> +++ b/arch/arm/mach-pxa/pxa27x.c
> @@ -47,9 +47,9 @@ void pxa27x_clear_otgph(void)
>  EXPORT_SYMBOL(pxa27x_clear_otgph);
>  
>  static unsigned long ac97_reset_config[] = {
> -	GPIO113_GPIO,
> +	GPIO113_AC97_nRESET_GPIO_HIGH,
>  	GPIO113_AC97_nRESET,
> -	GPIO95_GPIO,
> +	GPIO95_AC97_nRESET_GPIO_HIGH,
>  	GPIO95_AC97_nRESET,
>  };
>  
> diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
> index 1ecd0a66..fff7753 100644
> --- a/sound/arm/pxa2xx-ac97-lib.c
> +++ b/sound/arm/pxa2xx-ac97-lib.c
> @@ -18,6 +18,7 @@
>  #include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/io.h>
> +#include <linux/gpio.h>
>  
>  #include <sound/ac97_codec.h>
>  #include <sound/pxa2xx-lib.h>
> @@ -344,8 +345,21 @@ int pxa2xx_ac97_hw_probe(struct platform_device *dev)
>  	}
>  
>  	if (cpu_is_pxa27x()) {
> -		/* Use GPIO 113 as AC97 Reset on Bulverde */
> +		/*
> +		 * This gpio is needed for a work-around to a bug in the ac97
> +		 * controller during warm reset.  The direction and level is set
> +		 * here so that it is an output driven high when switching from
> +		 * AC97_nRESET alt function to generic gpio.
> +		 */
> +		ret = gpio_request_one(reset_gpio, GPIOF_OUT_INIT_HIGH,
> +				       "pxa27x ac97 reset");
> +		if (ret < 0) {
> +			pr_err("%s: gpio_request_one() failed: %d\n",
> +			       __func__, ret);
> +			goto err_conf;
> +		}
>  		pxa27x_assert_ac97reset(reset_gpio, 0);
> +
>  		ac97conf_clk = clk_get(&dev->dev, "AC97CONFCLK");
>  		if (IS_ERR(ac97conf_clk)) {
>  			ret = PTR_ERR(ac97conf_clk);
> @@ -388,6 +402,8 @@ EXPORT_SYMBOL_GPL(pxa2xx_ac97_hw_probe);
>  
>  void pxa2xx_ac97_hw_remove(struct platform_device *dev)
>  {
> +	if (cpu_is_pxa27x())
> +		gpio_free(reset_gpio);
>  	GCR |= GCR_ACLINK_OFF;
>  	free_irq(IRQ_AC97, NULL);
>  	if (ac97conf_clk) {

-- 
Regards,
Igor.
