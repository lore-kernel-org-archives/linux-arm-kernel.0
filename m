From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 8 Feb 2016 18:20:31 +0100
Subject: [PATCH] pinctrl: sunxi: set pin function as input on export
In-Reply-To: <1454942242-25690-1-git-send-email-krzysztof.adamski@tieto.com>
References: <1454942242-25690-1-git-send-email-krzysztof.adamski@tieto.com>
Message-ID: <20160208172031.GJ31506@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 08, 2016 at 03:37:22PM +0100, Krzysztof Adamski wrote:
> Default function of a pin in sunxi SoCs is "disabled". By default gpios
> exported by sysfs are set as input and indeed, when reading "direction"
> file you will get "in". The "value" pin won't return proper value,
> though, confusing user of this interface.
> 
> This patch sets direction of a GPIO as input when exporting it.
> 
> Signed-off-by: Krzysztof Adamski <krzysztof.adamski@tieto.com>
> ---
>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> index 7a2465f..905a9fb 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> @@ -452,6 +452,16 @@ static int sunxi_pinctrl_gpio_direction_input(struct gpio_chip *chip,
>  	return pinctrl_gpio_direction_input(chip->base + offset);
>  }
>  
> +int sunxi_pinctrl_gpio_request(struct gpio_chip *chip, unsigned offset)
> +{
> +	int ret = pinctrl_gpio_direction_input(chip->base + offset);
> +
> +	if (ret)
> +		return ret;
> +
> +	return pinctrl_request_gpio(chip->base + offset);
> +}
> +
>  static int sunxi_pinctrl_gpio_get(struct gpio_chip *chip, unsigned offset)
>  {
>  	struct sunxi_pinctrl *pctl = gpiochip_get_data(chip);
> @@ -946,7 +956,7 @@ int sunxi_pinctrl_init(struct platform_device *pdev,
>  
>  	last_pin = pctl->desc->pins[pctl->desc->npins - 1].pin.number;
>  	pctl->chip->owner = THIS_MODULE;
> -	pctl->chip->request = gpiochip_generic_request,
> +	pctl->chip->request = sunxi_pinctrl_gpio_request,
>  	pctl->chip->free = gpiochip_generic_free,
>  	pctl->chip->direction_input = sunxi_pinctrl_gpio_direction_input,
>  	pctl->chip->direction_output = sunxi_pinctrl_gpio_direction_output,
> -- 
> 2.4.2
> 

It seems to me that it's something that should be enforced in the
core, there's nothing sunxi specific here.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160208/5916f902/attachment.sig>
