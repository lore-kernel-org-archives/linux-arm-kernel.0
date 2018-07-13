From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Fri, 13 Jul 2018 11:24:39 +0200
Subject: [PATCH] pinctrl: at91: fix deferred probing support
In-Reply-To: <20180712192222.32481-1-robh@kernel.org>
References: <20180712192222.32481-1-robh@kernel.org>
Message-ID: <20180713092439.3f6q6et4si2x3dle@M43218.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 12, 2018 at 01:22:22PM -0600, Rob Herring wrote:
> AT91 pinctrl deferred probing support is broken if the GPIO devices
> haven't probed first and set gpio_banks to non-zero. The later condition
> that only some GPIO devices haven't probed can't actually happen as
> either all the GPIO devices have probed first or none of them have. Plus
> the pinctrl driver has already returned -EINVAL, so it's not on the
> deferred list to retry probing.
> 
> Fix this by consolidating the checking that all GPIO devices are probed.
> 
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-gpio at vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com> 

> ---
> This is a result of trying to remove of_platform_default_populate from 
> at91 code and relying on the DT core handling populating devices. That 
> changed the probe order and broke booting.
> 
> Compile tested only.

Tested on an at91-sama5d4_xplained board, it still boots.

Regards

Ludovic

> 
> Rob
> 
>  drivers/pinctrl/pinctrl-at91.c | 36 ++++++++++++----------------------
>  1 file changed, 13 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> index 50f0ec42c637..167838901b75 100644
> --- a/drivers/pinctrl/pinctrl-at91.c
> +++ b/drivers/pinctrl/pinctrl-at91.c
> @@ -1162,7 +1162,7 @@ static int at91_pinctrl_probe_dt(struct platform_device *pdev,
>  				 struct at91_pinctrl *info)
>  {
>  	int ret = 0;
> -	int i, j;
> +	int i, j, ngpio_chips_enabled = 0;
>  	uint32_t *tmp;
>  	struct device_node *np = pdev->dev.of_node;
>  	struct device_node *child;
> @@ -1175,10 +1175,17 @@ static int at91_pinctrl_probe_dt(struct platform_device *pdev,
>  		of_match_device(at91_pinctrl_of_match, &pdev->dev)->data;
>  	at91_pinctrl_child_count(info, np);
>  
> -	if (gpio_banks < 1) {
> -		dev_err(&pdev->dev, "you need to specify at least one gpio-controller\n");
> -		return -EINVAL;
> -	}
> +	/*
> +	 * We need all the GPIO drivers to probe FIRST, or we will not be able
> +	 * to obtain references to the struct gpio_chip * for them, and we
> +	 * need this to proceed.
> +	 */
> +	for (i = 0; i < MAX_GPIO_BANKS; i++)
> +		if (gpio_chips[i])
> +			ngpio_chips_enabled++;
> +
> +	if (ngpio_chips_enabled < info->nactive_banks)
> +		return -EPROBE_DEFER;
>  
>  	ret = at91_pinctrl_mux_mask(info, np);
>  	if (ret)
> @@ -1234,7 +1241,7 @@ static int at91_pinctrl_probe(struct platform_device *pdev)
>  {
>  	struct at91_pinctrl *info;
>  	struct pinctrl_pin_desc *pdesc;
> -	int ret, i, j, k, ngpio_chips_enabled = 0;
> +	int ret, i, j, k;
>  
>  	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
>  	if (!info)
> @@ -1244,23 +1251,6 @@ static int at91_pinctrl_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	/*
> -	 * We need all the GPIO drivers to probe FIRST, or we will not be able
> -	 * to obtain references to the struct gpio_chip * for them, and we
> -	 * need this to proceed.
> -	 */
> -	for (i = 0; i < gpio_banks; i++)
> -		if (gpio_chips[i])
> -			ngpio_chips_enabled++;
> -
> -	if (ngpio_chips_enabled < info->nactive_banks) {
> -		dev_warn(&pdev->dev,
> -			 "All GPIO chips are not registered yet (%d/%d)\n",
> -			 ngpio_chips_enabled, info->nactive_banks);
> -		devm_kfree(&pdev->dev, info);
> -		return -EPROBE_DEFER;
> -	}
> -
>  	at91_pinctrl_desc.name = dev_name(&pdev->dev);
>  	at91_pinctrl_desc.npins = gpio_banks * MAX_NB_GPIO_PER_BANK;
>  	at91_pinctrl_desc.pins = pdesc =
> -- 
> 2.17.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-gpio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
