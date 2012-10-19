From: tony@atomide.com (Tony Lindgren)
Date: Fri, 19 Oct 2012 15:37:35 -0700
Subject: [PATCH 06/10] pinctrl: single: support gpio request and free
In-Reply-To: <1350551224-12857-6-git-send-email-haojian.zhuang@gmail.com>
References: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
 <1350551224-12857-6-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <20121019223734.GU4730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Few minor comments below.

* Haojian Zhuang <haojian.zhuang@gmail.com> [121018 02:08]:
> Marvell's PXA/MMP silicon also match the behavior of pinctrl-single.
> Each pin binds to one register. A lot of pins could be configured
> as gpio.
> 
> Now add three properties in below.
> pinctrl-single,gpio-mask: mask of enable/disable value of gpio
> pinctrl-single,gpio-ranges: gpio range array
> pinctrl-single,gpio: <gpio base, npins in range, pin base>
> pinctrl-single,gpio-enable: <gpio enable register offset, enable
> value>
> pinctrl-single,gpio-disable: <gpio disable register offset, disable
> value>

Looks like this needs to be rebased also against v3.7-rc1 to apply
cleanly. Maybe also undo the wrapping in the description above while
at it?
 
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
> @@ -75,6 +76,26 @@ struct pcs_function {
>  };
>  
>  /**
> + * struct pcs_gpio_range - pinctrl gpio range
> + * @range:	subrange of the GPIO number space
> + * @reg_en:	register of enabling gpio function
> + * @reg_dis:	register of disabling gpio function
> + * @val_en:	enable value on gpio function
> + * @val_dis:	disable value on gpio function
> + * @need_en:	need to handle enable value on gpio function
> + * @need_dis:	need to handle disable value on gpio function
> + */
> +struct pcs_gpio_range {
> +	struct pinctrl_gpio_range range;
> +	u32 reg_en;
> +	u32 reg_dis;

These should be void __iomem *reg_en and reg_dis to avoid casts?

You now introduce few "warning: cast removes address space of
expression" warnings when checking with sparse..

> @@ -387,9 +414,48 @@ static void pcs_disable(struct pinctrl_dev *pctldev, unsigned fselector,
>  }
>  
>  static int pcs_request_gpio(struct pinctrl_dev *pctldev,
> -			struct pinctrl_gpio_range *range, unsigned offset)
> +			    struct pinctrl_gpio_range *range, unsigned offset)
>  {
> -	return -ENOTSUPP;
> +	struct pcs_device *pcs = pinctrl_dev_get_drvdata(pctldev);
> +	struct pcs_gpio_range *gpio = NULL;
> +	int end;
> +	unsigned data;

Should you return -ENOTSUPP if not configured for GPIO here?

> +	gpio = container_of(range, struct pcs_gpio_range, range);
> +	if (!gpio->need_en)
> +		return 0;
> +	end = range->pin_base + range->npins - 1;
> +	if (offset < range->pin_base || offset > end) {
> +		dev_err(pctldev->dev, "offset %d isn't in the range of "
> +			"%d to %d\n", offset, range->pin_base, end);
> +		return -EINVAL;
> +	}
> +	data = pcs_readl((void __iomem *)gpio->reg_en) & ~pcs->gmask;
> +	data |= gpio->val_en;
> +	pcs_writel(data, (void __iomem *)gpio->reg_en);

These casts should not be needed then.

> +	return 0;
> +}
> +
> +static void pcs_disable_gpio(struct pinctrl_dev *pctldev,
> +			     struct pinctrl_gpio_range *range, unsigned offset)
> +{
> +	struct pcs_device *pcs = pinctrl_dev_get_drvdata(pctldev);
> +	struct pcs_gpio_range *gpio = NULL;
> +	int end;
> +	unsigned data;
> +
> +	gpio = container_of(range, struct pcs_gpio_range, range);
> +	if (!gpio->need_dis)
> +		return;
> +	end = range->pin_base + range->npins - 1;
> +	if (offset < range->pin_base || offset > end) {
> +		dev_err(pctldev->dev, "offset %d isn't in the range of "
> +			"%d to %d\n", offset, range->pin_base, end);
> +		return;
> +	}
> +	data = pcs_readl((void __iomem *)gpio->reg_dis) & ~pcs->gmask;
> +	data |= gpio->val_dis;
> +	pcs_writel(data, (void __iomem *)gpio->reg_dis);

And these casts.

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
> +	ret = of_property_read_u32(node, "pinctrl-single,gpio-mask",
> +				&pcs->gmask);
> +	if (ret < 0)
> +		return 0;
> +	list = of_get_property(node, list_name, &size);
> +	if (!list)
> +		return -ENOENT;
> +	size = size / sizeof(*list);
> +	for (i = 0; i < size; i++) {
> +		np = of_parse_phandle(node, list_name, i);
> +		memset(gpiores, 0, sizeof(u32) * PCS_MAX_GPIO_VALUES);
> +		ret = of_property_read_u32_array(np, "pinctrl-single,gpio",
> +						 gpiores, PCS_MAX_GPIO_VALUES);
> +		if (ret < 0)
> +			return -ENOENT;
> +		gpio = devm_kzalloc(pcs->dev, sizeof(*gpio), GFP_KERNEL);
> +		if (!gpio) {
> +			dev_err(pcs->dev, "failed to allocate pcs gpio\n");
> +			return -ENOMEM;
> +		}
> +		gpio->range.id = i;
> +		gpio->range.base = gpiores[0];
> +		gpio->range.npins = gpiores[1];
> +		gpio->range.name = kmemdup(name, sizeof(name), GFP_KERNEL);
> +		mux_bytes = pcs->width / BITS_PER_BYTE;
> +		gpio->range.pin_base = gpiores[2] / mux_bytes;
> +		memset(gpiores, 0, sizeof(u32) * PCS_MAX_GPIO_VALUES);
> +		ret = of_property_read_u32_array(np,
> +				"pinctrl-single,gpio-enable", gpiores, 2);
> +		if (!ret) {
> +			gpio->reg_en = (u32)pcs->base + gpiores[0];
> +			gpio->val_en = gpiores[1];
> +			gpio->need_en = 1;
> +		}
> +		memset(gpiores, 0, sizeof(u32) * PCS_MAX_GPIO_VALUES);
> +		ret = of_property_read_u32_array(np,
> +				"pinctrl-single,gpio-disable", gpiores, 2);
> +		if (!ret) {
> +			gpio->reg_dis = (u32)pcs->base + gpiores[0];
> +			gpio->val_dis = gpiores[1];
> +			gpio->need_dis = 1;
> +		}

I think it's the u32 casts here that introduce the sparse warnings.

Other than that looks OK to me.

Regards,

Tony
