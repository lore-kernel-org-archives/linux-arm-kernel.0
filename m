From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 Oct 2012 13:28:07 -0700
Subject: [PATCH v2 2/9] pinctrl: single: support gpio request and free
In-Reply-To: <1350922139-3693-3-git-send-email-haojian.zhuang@gmail.com>
References: <1350922139-3693-1-git-send-email-haojian.zhuang@gmail.com>
 <1350922139-3693-3-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <20121022202805.GG4730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Haojian Zhuang <haojian.zhuang@gmail.com> [121022 09:11]:
> Marvell's PXA/MMP silicon also match the behavior of pinctrl-single.
> Each pin binds to one register. A lot of pins could be configured
> as gpio.
> 
> Now add three properties in below.
> pinctrl-single,gpio-ranges: gpio range array
> pinctrl-single,gpio: <gpio base, npins in range, pin base in range>
> pinctrl-single,gpio-func: <gpio function value in mux>
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
> ---
>  drivers/pinctrl/pinctrl-single.c |   94 +++++++++++++++++++++++++++++++++++++-
>  1 files changed, 92 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
> index 726a729..6a0b24b 100644
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
> @@ -28,8 +28,10 @@
>  #define DRIVER_NAME			"pinctrl-single"
>  #define PCS_MUX_PINS_NAME		"pinctrl-single,pins"
>  #define PCS_MUX_BITS_NAME		"pinctrl-single,bits"
> +#define PCS_GPIO_FUNC_NAME		"pinctrl-single,gpio-func"

I think we can now get rid of these defines, I initially added
them as we had a bit hard time finding a suitable name for the
driver. These are only used in one location, so let's not add
new ones here.

>  static int pcs_request_gpio(struct pinctrl_dev *pctldev,
> -			struct pinctrl_gpio_range *range, unsigned offset)
> +			    struct pinctrl_gpio_range *range, unsigned pin)
>  {
> -	return -ENOTSUPP;
> +	struct pcs_device *pcs = pinctrl_dev_get_drvdata(pctldev);
> +	struct pcs_gpio_range *gpio = NULL;
> +	int end, mux_bytes;
> +	unsigned data;
> +
> +	gpio = container_of(range, struct pcs_gpio_range, range);
> +	if (!gpio->func_en)
> +		return 0;
> +	end = range->pin_base + range->npins - 1;
> +	if (pin < range->pin_base || pin > end) {
> +		dev_err(pctldev->dev, "pin %d isn't in the range of "
> +			"%d to %d\n", pin, range->pin_base, end);
> +		return -EINVAL;
> +	}
> +	mux_bytes = pcs->width / BITS_PER_BYTE;
> +	data = pcs_readl(pcs->base + pin * mux_bytes) & ~pcs->fmask;
> +	data |= gpio->gpio_func;
> +	pcs_writel(data, pcs->base + pin * mux_bytes);
> +	return 0;
>  }

I think I already commented on this one.. Is this safe if you don't
have GPIOs configured? Or should you return -ENODEV in that case?

> +static int __devinit pcs_add_gpio_range(struct device_node *node,
> +					struct pcs_device *pcs)
> +{
> +	struct pcs_gpio_range *gpio;
> +	struct device_node *np;
> +	const __be32 *list;
> +	const char list_name[] = "pinctrl-single,gpio-ranges";
> +	const char name[] = "pinctrl-single";
> +	u32 gpiores[PCS_MAX_GPIO_VALUES];
> +	int ret, size, i, mux_bytes = 0;
> +
> +	list = of_get_property(node, list_name, &size);
> +	if (!list)
> +		return -ENOENT;

Here you should return 0 if not found, otherwise things go bad for
me at least as I don't have GPIOs configured. See more below.

> +		gpio->range.name = kmemdup(name, sizeof(name), GFP_KERNEL);
> +		pinctrl_add_gpio_range(pcs->pctl, &gpio->range);

Just checking.. These get released with pinctrl_unregister() when
unloading, right? And nothing else to free in pinctrl-single.c
either?

> @@ -975,6 +1061,10 @@ static int __devinit pcs_probe(struct platform_device *pdev)
>  		goto free;
>  	}
>  
> +	ret = pcs_add_gpio_range(np, pcs);
> +	if (ret < 0)
> +		return ret;
> +

Here you need to goto free on error. Maybe just fold in the
attached fix if that looks OK to you:

--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -930,7 +930,7 @@ static int __devinit pcs_add_gpio_range(struct device_node *node,
 
 	list = of_get_property(node, list_name, &size);
 	if (!list)
-		return -ENOENT;
+		return 0;
 	size = size / sizeof(*list);
 	for (i = 0; i < size; i++) {
 		np = of_parse_phandle(node, list_name, i);
@@ -1065,7 +1065,7 @@ static int __devinit pcs_probe(struct platform_device *pdev)
 
 	ret = pcs_add_gpio_range(np, pcs);
 	if (ret < 0)
-		return ret;
+		goto free;
 
 	dev_info(pcs->dev, "%i pins at pa %p size %u\n",
 		 pcs->desc.npins, pcs->base, pcs->size);
