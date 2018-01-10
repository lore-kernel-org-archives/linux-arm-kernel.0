From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 9 Jan 2018 22:11:33 -0800
Subject: [PATCH 3/3] pinctrl: qcom: Don't allow protected pins to be
 requested
In-Reply-To: <20180110015848.11480-4-sboyd@codeaurora.org>
References: <20180110015848.11480-1-sboyd@codeaurora.org>
 <20180110015848.11480-4-sboyd@codeaurora.org>
Message-ID: <20180110061133.GP12655@minitux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 09 Jan 17:58 PST 2018, Stephen Boyd wrote:

I like it, a few comment below though.

> +static int msm_gpio_init_irq_valid_mask(struct gpio_chip *chip,
> +					struct msm_pinctrl *pctrl)
> +{
> +	int ret;
> +	unsigned int len, i;
> +	unsigned int max_gpios = pctrl->soc->ngpios;
> +	struct device_node *np = pctrl->dev->of_node;
> +
> +	/* The number of GPIOs in the ACPI tables */
> +	ret = device_property_read_u16_array(pctrl->dev, "gpios", NULL, 0);
> +	if (ret > 0 && ret < max_gpios) {
> +		u16 *tmp;
> +
> +		len = ret;
> +		tmp = kmalloc_array(len, sizeof(tmp[0]), GFP_KERNEL);
> +		if (!tmp)
> +			return -ENOMEM;
> +
> +		ret = device_property_read_u16_array(pctrl->dev, "gpios", tmp,
> +						     len);
> +		if (ret < 0) {
> +			dev_err(pctrl->dev, "could not read list of GPIOs\n");
> +			kfree(tmp);
> +			return ret;
> +		}
> +
> +		bitmap_zero(chip->irq_valid_mask, max_gpios);

The valid_mask is moving into the gpio_irq_chip, so this should be
chip->irq.valid_mask.

See dc7b0387ee89 ("gpio: Move irq_valid_mask into struct gpio_irq_chip")

> +		for (i = 0; i < len; i++)
> +			set_bit(tmp[i], chip->irq_valid_mask);
> +

You're leaking tmp here.

> +		return 0;
> +	}
> +
> +	/* If there's a DT ngpios-ranges property then add those ranges */
> +	ret = of_property_count_u32_elems(np,  "ngpios-ranges");
> +	if (ret > 0 && ret % 2 == 0 && ret / 2 < max_gpios) {
> +		u32 start;
> +		u32 count;
> +
> +		len = ret / 2;
> +		bitmap_zero(chip->irq_valid_mask, max_gpios);
> +
> +		for (i = 0; i < len; i++) {

If you take steps of 2, when looping from 0 to ret, your loop index will
have the value that you're passing as index into the read - without
duplicating it.

> +			of_property_read_u32_index(np, "ngpios-ranges",
> +						   i * 2, &start);
> +			of_property_read_u32_index(np, "ngpios-ranges",
> +						   i * 2 + 1, &count);
> +			bitmap_set(chip->irq_valid_mask, start, count);
> +		}
> +	}
> +
> +	return 0;
> +}
[..]
> @@ -824,6 +907,7 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
>  	chip->parent = pctrl->dev;
>  	chip->owner = THIS_MODULE;
>  	chip->of_node = pctrl->dev->of_node;
> +	chip->irq_need_valid_mask = msm_gpio_needs_irq_valid_mask(pctrl);

chip->irq.need_valid_mask

>  
>  	ret = gpiochip_add_data(&pctrl->chip, pctrl);
>  	if (ret) {
> @@ -831,6 +915,12 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
>  		return ret;
>  	}
>  
> +	ret = msm_gpio_init_irq_valid_mask(chip, pctrl);
> +	if (ret) {
> +		dev_err(pctrl->dev, "Failed to setup irq valid bits\n");

gpiochip_remove() here, to release resources allocated by
gpiochip_add_data.

> +		return ret;
> +	}
> +
>  	ret = gpiochip_add_pin_range(&pctrl->chip, dev_name(pctrl->dev), 0, 0, chip->ngpio);
>  	if (ret) {
>  		dev_err(pctrl->dev, "Failed to add pin range\n");

Regards,
Bjorn
