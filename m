From: grinberg@compulab.co.il (Igor Grinberg)
Date: Mon, 07 Jan 2013 11:39:54 +0200
Subject: [PATCH 4/4] ALSA: pxa27x: rename pxa27x_assert_ac97()
In-Reply-To: <1357499640-13871-5-git-send-email-mikedunn@newsguy.com>
References: <1357499640-13871-1-git-send-email-mikedunn@newsguy.com>
 <1357499640-13871-5-git-send-email-mikedunn@newsguy.com>
Message-ID: <50EA97EA.4030807@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/06/13 21:14, Mike Dunn wrote:
> This patch does nothing functionally, it just gives the function a new name and
> modifies the prototype slightly in order to clarify what the function is doing
> (which is not necessarily asserting the reset).
> Some commentary also added.
> 
> Tested on a palm treo 680 machine.
> 
> Signed-off-by: Mike Dunn <mikedunn@newsguy.com>

This patch makes sense, but again raising your concern...
The gpio_direction_output(reset_gpio, 1) should be called after
the change to AF0.

> ---
> 
> checkpatch.pl issues a warning for this patch:
> 	      WARNING: externs should be avoided in .c files
> but I just want to rename the function.
> 
>  arch/arm/mach-pxa/pxa27x.c  |   29 +++++++++++++++++++----------
>  sound/arm/pxa2xx-ac97-lib.c |    8 ++++----
>  2 files changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
> index eea90fe..896bf94 100644
> --- a/arch/arm/mach-pxa/pxa27x.c
> +++ b/arch/arm/mach-pxa/pxa27x.c
> @@ -53,26 +53,35 @@ static unsigned long ac97_reset_config[] = {
>  	GPIO95_AC97_nRESET,
>  };
>  
> -void pxa27x_assert_ac97reset(int reset_gpio, int on)
> +void pxa27x_configure_ac97reset(int reset_mfp, bool to_gpio)
>  {
> +	/*
> +	 * This helper function is used to work around a bug in the pxa27x's
> +	 * ac97 controller during a warm reset.  The configuration of the
> +	 * reset_mfp is changed as follows:
> +	 * to_gpio == true: configured to generic output gpio and driven high
> +	 * to_gpio == false: configured to ac97 controller alt fn AC97_nRESET
> +	 */
> +
>  	/* set direction and level before switching from ac97 alt fn to gpio */
> -	if (on) {
> -		int ret = gpio_direction_output(reset_gpio, 1);
> +	if (to_gpio == true) {
> +		int ret = gpio_direction_output(reset_mfp, 1);
>  		if (ret) {
>  			pr_err("%s: gpio_direction_output failed: %d\n",
>  				__func__, ret);
>  			return;
>  		}
>  	}
> -	if (reset_gpio == 113)
> -		pxa2xx_mfp_config(on ? &ac97_reset_config[0] :
> -				       &ac97_reset_config[1], 1);
>  
> -	if (reset_gpio == 95)
> -		pxa2xx_mfp_config(on ? &ac97_reset_config[2] :
> -				       &ac97_reset_config[3], 1);
> +	if (reset_mfp == 113)
> +		pxa2xx_mfp_config(to_gpio ? &ac97_reset_config[0] :
> +				  &ac97_reset_config[1], 1);
> +
> +	if (reset_mfp == 95)
> +		pxa2xx_mfp_config(to_gpio ? &ac97_reset_config[2] :
> +				  &ac97_reset_config[3], 1);
>  }
> -EXPORT_SYMBOL_GPL(pxa27x_assert_ac97reset);
> +EXPORT_SYMBOL_GPL(pxa27x_configure_ac97reset);
>  
>  /* Crystal clock: 13MHz */
>  #define BASE_CLK	13000000
> diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
> index 416d2e3..fbac476 100644
> --- a/sound/arm/pxa2xx-ac97-lib.c
> +++ b/sound/arm/pxa2xx-ac97-lib.c
> @@ -34,7 +34,7 @@ static struct clk *ac97_clk;
>  static struct clk *ac97conf_clk;
>  static int reset_gpio;
>  
> -extern void pxa27x_assert_ac97reset(int reset_gpio, int on);
> +extern void pxa27x_configure_ac97reset(int reset_mfp, bool to_gpio);
>  
>  /*
>   * Beware PXA27x bugs:
> @@ -140,10 +140,10 @@ static inline void pxa_ac97_warm_pxa27x(void)
>  	gsr_bits = 0;
>  
>  	/* warm reset broken on Bulverde, so manually keep AC97 reset high */
> -	pxa27x_assert_ac97reset(reset_gpio, 1);
> +	pxa27x_configure_ac97reset(reset_gpio, true);
>  	udelay(10);
>  	GCR |= GCR_WARM_RST;
> -	pxa27x_assert_ac97reset(reset_gpio, 0);
> +	pxa27x_configure_ac97reset(reset_gpio, false);
>  	udelay(500);
>  }
>  
> @@ -351,7 +351,7 @@ int pxa2xx_ac97_hw_probe(struct platform_device *dev)
>  			       __func__, ret);
>  			goto err_conf;
>  		}
> -		pxa27x_assert_ac97reset(reset_gpio, 0);
> +		pxa27x_configure_ac97reset(reset_gpio, false);
>  		ac97conf_clk = clk_get(&dev->dev, "AC97CONFCLK");
>  		if (IS_ERR(ac97conf_clk)) {
>  			ret = PTR_ERR(ac97conf_clk);

-- 
Regards,
Igor.
