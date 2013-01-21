From: tony@atomide.com (Tony Lindgren)
Date: Mon, 21 Jan 2013 08:56:41 -0800
Subject: [PATCH v7 01/15] Revert "pinctrl: single: support gpio request
 and free"
In-Reply-To: <1358494279-16503-2-git-send-email-haojian.zhuang@linaro.org>
References: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
 <1358494279-16503-2-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20130121165640.GH15361@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Haojian Zhuang <haojian.zhuang@linaro.org> [130117 23:34]:
> This reverts commit 2e8b2eab94c35d83bb7da71c63b4695f32ddca88.
> 
> Conflicts:
> 	drivers/pinctrl/pinctrl-single.c
> 
> ERROR: "__aeabi_uldivmod" [drivers/pinctrl/pinctrl-single.ko]
> undefined!]
> 
> On Fri, Jan 11, 2013 at 4:00 PM, Russell King wrote:
> 
> > The above error happens in builds including pinctrl-single - the
> > reason
> > is this, where resource_size_t may be 64-bit.
> >
> >                 gpio->range.pin_base = (r.start - pcs->res->start) /
> >                 mux_bytes;
> >                 gpio->range.npins = (r.end - r.start) / mux_bytes + 1;
> 
> The reason of not fixing this issue and reverting the patch instead is
> this patch can't handle another case. It's not easy to handle multiple
> gpios sharing one pin register. So this gpio range feature will be
> implemented by other patches.

Makes sense to me, I don't think we have any users yet for this:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  drivers/pinctrl/pinctrl-single.c |   79 +-------------------------------------
>  1 file changed, 2 insertions(+), 77 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
> index f6a360b..5c32e88 100644
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
> @@ -30,7 +30,6 @@
>  #define PCS_MUX_BITS_NAME		"pinctrl-single,bits"
>  #define PCS_REG_NAME_LEN		((sizeof(unsigned long) * 2) + 1)
>  #define PCS_OFF_DISABLED		~0U
> -#define PCS_MAX_GPIO_VALUES		2
>  
>  /**
>   * struct pcs_pingroup - pingroups for a function
> @@ -78,16 +77,6 @@ struct pcs_function {
>  };
>  
>  /**
> - * struct pcs_gpio_range - pinctrl gpio range
> - * @range:	subrange of the GPIO number space
> - * @gpio_func:	gpio function value in the pinmux register
> - */
> -struct pcs_gpio_range {
> -	struct pinctrl_gpio_range range;
> -	int gpio_func;
> -};
> -
> -/**
>   * struct pcs_data - wrapper for data needed by pinctrl framework
>   * @pa:		pindesc array
>   * @cur:	index to current element
> @@ -414,26 +403,9 @@ static void pcs_disable(struct pinctrl_dev *pctldev, unsigned fselector,
>  }
>  
>  static int pcs_request_gpio(struct pinctrl_dev *pctldev,
> -			    struct pinctrl_gpio_range *range, unsigned pin)
> +			struct pinctrl_gpio_range *range, unsigned offset)
>  {
> -	struct pcs_device *pcs = pinctrl_dev_get_drvdata(pctldev);
> -	struct pcs_gpio_range *gpio = NULL;
> -	int end, mux_bytes;
> -	unsigned data;
> -
> -	gpio = container_of(range, struct pcs_gpio_range, range);
> -	end = range->pin_base + range->npins - 1;
> -	if (pin < range->pin_base || pin > end) {
> -		dev_err(pctldev->dev,
> -			"pin %d isn't in the range of %d to %d\n",
> -			pin, range->pin_base, end);
> -		return -EINVAL;
> -	}
> -	mux_bytes = pcs->width / BITS_PER_BYTE;
> -	data = pcs->read(pcs->base + pin * mux_bytes) & ~pcs->fmask;
> -	data |= gpio->gpio_func;
> -	pcs->write(data, pcs->base + pin * mux_bytes);
> -	return 0;
> +	return -ENOTSUPP;
>  }
>  
>  static struct pinmux_ops pcs_pinmux_ops = {
> @@ -907,49 +879,6 @@ static void pcs_free_resources(struct pcs_device *pcs)
>  
>  static struct of_device_id pcs_of_match[];
>  
> -static int pcs_add_gpio_range(struct device_node *node, struct pcs_device *pcs)
> -{
> -	struct pcs_gpio_range *gpio;
> -	struct device_node *child;
> -	struct resource r;
> -	const char name[] = "pinctrl-single";
> -	u32 gpiores[PCS_MAX_GPIO_VALUES];
> -	int ret, i = 0, mux_bytes = 0;
> -
> -	for_each_child_of_node(node, child) {
> -		ret = of_address_to_resource(child, 0, &r);
> -		if (ret < 0)
> -			continue;
> -		memset(gpiores, 0, sizeof(u32) * PCS_MAX_GPIO_VALUES);
> -		ret = of_property_read_u32_array(child, "pinctrl-single,gpio",
> -						 gpiores, PCS_MAX_GPIO_VALUES);
> -		if (ret < 0)
> -			continue;
> -		gpio = devm_kzalloc(pcs->dev, sizeof(*gpio), GFP_KERNEL);
> -		if (!gpio) {
> -			dev_err(pcs->dev, "failed to allocate pcs gpio\n");
> -			return -ENOMEM;
> -		}
> -		gpio->range.name = devm_kzalloc(pcs->dev, sizeof(name),
> -						GFP_KERNEL);
> -		if (!gpio->range.name) {
> -			dev_err(pcs->dev, "failed to allocate range name\n");
> -			return -ENOMEM;
> -		}
> -		memcpy((char *)gpio->range.name, name, sizeof(name));
> -
> -		gpio->range.id = i++;
> -		gpio->range.base = gpiores[0];
> -		gpio->gpio_func = gpiores[1];
> -		mux_bytes = pcs->width / BITS_PER_BYTE;
> -		gpio->range.pin_base = (r.start - pcs->res->start) / mux_bytes;
> -		gpio->range.npins = (r.end - r.start) / mux_bytes + 1;
> -
> -		pinctrl_add_gpio_range(pcs->pctl, &gpio->range);
> -	}
> -	return 0;
> -}
> -
>  static int pcs_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> @@ -1046,10 +975,6 @@ static int pcs_probe(struct platform_device *pdev)
>  		goto free;
>  	}
>  
> -	ret = pcs_add_gpio_range(np, pcs);
> -	if (ret < 0)
> -		goto free;
> -
>  	dev_info(pcs->dev, "%i pins at pa %p size %u\n",
>  		 pcs->desc.npins, pcs->base, pcs->size);
>  
> -- 
> 1.7.10.4
> 
