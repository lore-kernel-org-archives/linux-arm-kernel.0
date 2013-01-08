From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 08 Jan 2013 10:36:52 +0200
Subject: [PATCH 3/3] ALSA: pxa27x: rename pxa27x_assert_ac97reset()
In-Reply-To: <1357595714-13698-4-git-send-email-mikedunn@newsguy.com>
References: <1357595714-13698-1-git-send-email-mikedunn@newsguy.com>
 <1357595714-13698-4-git-send-email-mikedunn@newsguy.com>
Message-ID: <50EBDAA4.3010105@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/07/13 23:55, Mike Dunn wrote:
> This patch does nothing functionally, it just gives the function a new name and
> modifies the prototype slightly in order to clarify what the function is doing
> (which is not necessarily asserting the reset).
> Some commentary also added.
> 
> Tested on a palm treo 680 machine.
> 
> Signed-off-by: Mike Dunn <mikedunn@newsguy.com>

Acked-by: Igor Grinberg <grinberg@compulab.co.il>

> ---
>  arch/arm/mach-pxa/pxa27x.c  |   20 ++++++++++++++------
>  sound/arm/pxa2xx-ac97-lib.c |    8 ++++----
>  2 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
> index 616cb87..69985b06 100644
> --- a/arch/arm/mach-pxa/pxa27x.c
> +++ b/arch/arm/mach-pxa/pxa27x.c
> @@ -53,17 +53,25 @@ static unsigned long ac97_reset_config[] = {
>  	GPIO95_AC97_nRESET,
>  };
>  
> -void pxa27x_assert_ac97reset(int reset_gpio, int on)
> +void pxa27x_configure_ac97reset(int reset_gpio, bool to_gpio)
>  {
> +	/*
> +	 * This helper function is used to work around a bug in the pxa27x's
> +	 * ac97 controller during a warm reset.  The configuration of the
> +	 * reset_gpio is changed as follows:
> +	 * to_gpio == true: configured to generic output gpio and driven high
> +	 * to_gpio == false: configured to ac97 controller alt fn AC97_nRESET
> +	 */
> +
>  	if (reset_gpio == 113)
> -		pxa2xx_mfp_config(on ? &ac97_reset_config[0] :
> -				       &ac97_reset_config[1], 1);
> +		pxa2xx_mfp_config(to_gpio ? &ac97_reset_config[0] :
> +				  &ac97_reset_config[1], 1);
>  
>  	if (reset_gpio == 95)
> -		pxa2xx_mfp_config(on ? &ac97_reset_config[2] :
> -				       &ac97_reset_config[3], 1);
> +		pxa2xx_mfp_config(to_gpio ? &ac97_reset_config[2] :
> +				  &ac97_reset_config[3], 1);
>  }
> -EXPORT_SYMBOL_GPL(pxa27x_assert_ac97reset);
> +EXPORT_SYMBOL_GPL(pxa27x_configure_ac97reset);
>  
>  /* Crystal clock: 13MHz */
>  #define BASE_CLK	13000000
> diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
> index fff7753..e6f4633 100644
> --- a/sound/arm/pxa2xx-ac97-lib.c
> +++ b/sound/arm/pxa2xx-ac97-lib.c
> @@ -34,7 +34,7 @@ static struct clk *ac97_clk;
>  static struct clk *ac97conf_clk;
>  static int reset_gpio;
>  
> -extern void pxa27x_assert_ac97reset(int reset_gpio, int on);
> +extern void pxa27x_configure_ac97reset(int reset_gpio, bool to_gpio);
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
> @@ -358,7 +358,7 @@ int pxa2xx_ac97_hw_probe(struct platform_device *dev)
>  			       __func__, ret);
>  			goto err_conf;
>  		}
> -		pxa27x_assert_ac97reset(reset_gpio, 0);
> +		pxa27x_configure_ac97reset(reset_gpio, false);
>  
>  		ac97conf_clk = clk_get(&dev->dev, "AC97CONFCLK");
>  		if (IS_ERR(ac97conf_clk)) {

-- 
Regards,
Igor.
