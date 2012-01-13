From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Fri, 13 Jan 2012 08:27:07 +0200
Subject: [PATCH 04/11] ep93xx: Configure GPIO ports in core code
In-Reply-To: <1326251676-7593-5-git-send-email-rmallon@gmail.com>
References: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
 <1326251676-7593-5-git-send-email-rmallon@gmail.com>
Message-ID: <20120113062707.GA4147@mwesterb-mobl.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2012 at 02:14:29PM +1100, Ryan Mallon wrote:
> Move the pinmux setting of the EP93xx GPIOs to the core code. This
> removes the need for the GPIO driver to have access to the system
> controller registers.
> 
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Mika Westerberg <mika.westerberg@iki.fi>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Ryan Mallon <rmallon@gmail.com>
> ---
>  arch/arm/mach-ep93xx/core.c |    7 +++++++
>  drivers/gpio/gpio-ep93xx.c  |    7 -------
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
> index dcb10c2..978c5a6 100644
> --- a/arch/arm/mach-ep93xx/core.c
> +++ b/arch/arm/mach-ep93xx/core.c
> @@ -896,6 +896,13 @@ void __init ep93xx_init_devices(void)
>  	/* Disallow access to MaverickCrunch initially */
>  	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_CPENA);
>  
> +	/* Default all ports to GPIO */
> +	ep93xx_devcfg_set_bits(EP93XX_SYSCON_DEVCFG_KEYS |
> +			       EP93XX_SYSCON_DEVCFG_GONK |
> +			       EP93XX_SYSCON_DEVCFG_EONIDE |
> +			       EP93XX_SYSCON_DEVCFG_GONIDE |
> +			       EP93XX_SYSCON_DEVCFG_HONIDE);
> +

Doesn't this now change the behaviour? Now you unconditionally mux the pins
whereas before they were only muxed if we had GPIO driver enabled.

>  	/* Get the GPIO working early, other devices need it */
>  	platform_device_register(&ep93xx_gpio_device);
>  
> diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
> index 1c0fc37..4ca5642 100644
> --- a/drivers/gpio/gpio-ep93xx.c
> +++ b/drivers/gpio/gpio-ep93xx.c
> @@ -378,13 +378,6 @@ static int __devinit ep93xx_gpio_probe(struct platform_device *pdev)
>  	}
>  	ep93xx_gpio->mmio_base = mmio;
>  
> -	/* Default all ports to GPIO */
> -	ep93xx_devcfg_set_bits(EP93XX_SYSCON_DEVCFG_KEYS |
> -			       EP93XX_SYSCON_DEVCFG_GONK |
> -			       EP93XX_SYSCON_DEVCFG_EONIDE |
> -			       EP93XX_SYSCON_DEVCFG_GONIDE |
> -			       EP93XX_SYSCON_DEVCFG_HONIDE);
> -
>  	for (i = 0; i < ARRAY_SIZE(ep93xx_gpio_banks); i++) {
>  		struct bgpio_chip *bgc = &ep93xx_gpio->bgc[i];
>  		struct ep93xx_gpio_bank *bank = &ep93xx_gpio_banks[i];
> -- 
> 1.7.0.4
