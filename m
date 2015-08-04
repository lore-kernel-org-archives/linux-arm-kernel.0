From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 04 Aug 2015 17:19:57 +0300
Subject: [PATCH v2 6/6] pinctrl: sh-pfc: Confine legacy function GPIOs to
 SH
In-Reply-To: <1438696519-13727-7-git-send-email-geert+renesas@glider.be>
References: <1438696519-13727-1-git-send-email-geert+renesas@glider.be>
 <1438696519-13727-7-git-send-email-geert+renesas@glider.be>
Message-ID: <2553252.oFXfDSh3t2@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

Thank you for the patch.

On Tuesday 04 August 2015 15:55:19 Geert Uytterhoeven wrote:
> Legacy function GPIOs are no longer used on ARM since commit
> a27c5cd1a08cc95c ("sh-pfc: sh73a0: Remove function GPIOs").
> Extract its setup code into a separate function, and make all function
> GPIO related code and data depend on CONFIG_SUPERH.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

We now need a volunteer to port SH to proper pinctrl to remove the function 
GPIOs completely :-)

> ---
> Compile-tested on sh using se7724_defconfig.
> 
> v2:
>   - Add Acked-by,
>   - #ifdef out the code instead of introducing helper and dummy
>     functions.
> ---
>  drivers/pinctrl/sh-pfc/core.h   | 2 ++
>  drivers/pinctrl/sh-pfc/gpio.c   | 7 ++++++-
>  drivers/pinctrl/sh-pfc/sh_pfc.h | 2 ++
>  3 files changed, 10 insertions(+), 1 deletion(-)
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
> index e46439030914ad13..685b3c24627daf03 100644
> --- a/drivers/pinctrl/sh-pfc/gpio.c
> +++ b/drivers/pinctrl/sh-pfc/gpio.c
> @@ -261,6 +261,7 @@ static int gpio_pin_setup(struct sh_pfc_chip *chip)
>   * Function GPIOs
>   */
> 
> +#ifdef CONFIG_SUPERH
>  static int gpio_function_request(struct gpio_chip *gc, unsigned offset)
>  {
>  	static bool __print_once;
> @@ -300,6 +301,7 @@ static int gpio_function_setup(struct sh_pfc_chip *chip)
> 
>  	return 0;
>  }
> +#endif
> 
>  /*
> ---------------------------------------------------------------------------
> -- * Register/unregister
> @@ -399,6 +401,7 @@ int sh_pfc_register_gpiochip(struct sh_pfc *pfc)
>  		}
>  	}
> 
> +#ifdef CONFIG_SUPERH
>  	/* Register the function GPIOs chip. */
>  	if (pfc->info->nr_func_gpios == 0)
>  		return 0;
> @@ -408,6 +411,7 @@ int sh_pfc_register_gpiochip(struct sh_pfc *pfc)
>  		return PTR_ERR(chip);
> 
>  	pfc->func = chip;
> +#endif /* CONFIG_SUPERH */
> 
>  	return 0;
>  }
> @@ -415,7 +419,8 @@ int sh_pfc_register_gpiochip(struct sh_pfc *pfc)
>  int sh_pfc_unregister_gpiochip(struct sh_pfc *pfc)
>  {
>  	gpiochip_remove(&pfc->gpio->gpio_chip);
> +#ifdef CONFIG_SUPERH
>  	gpiochip_remove(&pfc->func->gpio_chip);
> -
> +#endif
>  	return 0;
>  }
> diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h
> b/drivers/pinctrl/sh-pfc/sh_pfc.h index 0874cfee6889afa1..1f43bae56065e659
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
