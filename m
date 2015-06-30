From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 30 Jun 2015 12:38:15 +0300
Subject: [PATCH 7/7] pinctrl: sh-pfc: Confine legacy function GPIOs to SH
In-Reply-To: <1435650327-2542-8-git-send-email-geert+renesas@glider.be>
References: <1435650327-2542-1-git-send-email-geert+renesas@glider.be>
 <1435650327-2542-8-git-send-email-geert+renesas@glider.be>
Message-ID: <10481403.sNoQCGtpkA@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

Thank you for the patch.

On Tuesday 30 June 2015 09:45:27 Geert Uytterhoeven wrote:
> Legacy function GPIOs are no longer used on ARM since commit
> a27c5cd1a08cc95c ("sh-pfc: sh73a0: Remove function GPIOs").
> Extract its setup code into a separate function, and make all function
> GPIO related code and data depend on CONFIG_SUPERH.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Compile-tested on sh using se7724_defconfig.
> ---
>  drivers/pinctrl/sh-pfc/core.h   |  2 ++
>  drivers/pinctrl/sh-pfc/gpio.c   | 39 ++++++++++++++++++++++++++----------
>  drivers/pinctrl/sh-pfc/sh_pfc.h |  2 ++
>  3 files changed, 32 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
> index 4c3c37bf7161804d..c38ace46d7111b0d 100644
> --- a/drivers/pinctrl/sh-pfc/core.h
> +++ b/drivers/pinctrl/sh-pfc/core.h
> @@ -46,7 +46,9 @@ struct sh_pfc {
>  	unsigned int nr_gpio_pins;
> 
>  	struct sh_pfc_chip *gpio;
> +#ifdef CONFIG_SUPERH
>  	struct sh_pfc_chip *func;
> +#endif
> 
>  	struct sh_pfc_pinctrl *pinctrl;
>  };
> diff --git a/drivers/pinctrl/sh-pfc/gpio.c b/drivers/pinctrl/sh-pfc/gpio.c
> index 30654e800580524d..15f4eea186e2ba56 100644
> --- a/drivers/pinctrl/sh-pfc/gpio.c
> +++ b/drivers/pinctrl/sh-pfc/gpio.c
> @@ -290,6 +290,7 @@ static int gpio_pin_setup(struct sh_pfc_chip *chip)
>   * Function GPIOs
>   */
> 
> +#ifdef CONFIG_SUPERH
>  static int gpio_function_request(struct gpio_chip *gc, unsigned offset)
>  {
>  	static bool __print_once;
> @@ -330,6 +331,31 @@ static int gpio_function_setup(struct sh_pfc_chip
> *chip) return 0;
>  }
> 
> +static int sh_pfc_add_function_gpios(struct sh_pfc *pfc)
> +{
> +	struct sh_pfc_chip *chip;
> +
> +	if (!pfc->info->nr_func_gpios)
> +		return 0;
> +
> +	chip = sh_pfc_add_gpiochip(pfc, gpio_function_setup, NULL);
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +
> +	pfc->func = chip;
> +
> +	return 0;
> +}
> +
> +static void sh_pfc_remove_function_gpios(struct sh_pfc *pfc)
> +{
> +	gpiochip_remove(&pfc->func->gpio_chip);
> +}
> +#else
> +static inline int sh_pfc_add_function_gpios(struct sh_pfc *pfc) { return 0;
> }
> +static inline int sh_pfc_remove_function_gpios(struct sh_pfc *pfc) {
> return 0; }

Given that those functions are only called from a single location, would it 
make sense to just compile the calls conditionally instead ? I would find that 
slightly more readable as it would be more explicit.

> +#endif
> +
>  /*
> ---------------------------------------------------------------------------
> -- * Register/unregister
>   */
> @@ -397,22 +423,13 @@ int sh_pfc_register_gpiochip(struct sh_pfc *pfc)
>  	}
> 
>  	/* Register the function GPIOs chip. */
> -	if (pfc->info->nr_func_gpios == 0)
> -		return 0;
> -
> -	chip = sh_pfc_add_gpiochip(pfc, gpio_function_setup, NULL);
> -	if (IS_ERR(chip))
> -		return PTR_ERR(chip);
> -
> -	pfc->func = chip;
> -
> -	return 0;
> +	return sh_pfc_add_function_gpios(pfc);
>  }
> 
>  int sh_pfc_unregister_gpiochip(struct sh_pfc *pfc)
>  {
>  	gpiochip_remove(&pfc->gpio->gpio_chip);
> -	gpiochip_remove(&pfc->func->gpio_chip);
> +	sh_pfc_remove_function_gpios(pfc);
> 
>  	return 0;
>  }
> diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h
> b/drivers/pinctrl/sh-pfc/sh_pfc.h index c7508d5f688613b2..c6f9163b3e23041f
> 100644
> --- a/drivers/pinctrl/sh-pfc/sh_pfc.h
> +++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
> @@ -138,8 +138,10 @@ struct sh_pfc_soc_info {
>  	const struct sh_pfc_function *functions;
>  	unsigned int nr_functions;
> 
> +#ifdef CONFIG_SUPERH
>  	const struct pinmux_func *func_gpios;
>  	unsigned int nr_func_gpios;
> +#endif
> 
>  	const struct pinmux_cfg_reg *cfg_regs;
>  	const struct pinmux_data_reg *data_regs;

-- 
Regards,

Laurent Pinchart
