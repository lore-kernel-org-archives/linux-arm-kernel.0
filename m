From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 2 Oct 2017 10:44:14 -0700
Subject: [PATCH 1/2] [v5] pinctrl: qcom: disable GPIO groups with no pins
In-Reply-To: <1504798409-32041-2-git-send-email-timur@codeaurora.org>
References: <1504798409-32041-1-git-send-email-timur@codeaurora.org>
 <1504798409-32041-2-git-send-email-timur@codeaurora.org>
Message-ID: <20171002174414.GL1165@minitux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 07 Sep 08:33 PDT 2017, Timur Tabi wrote:

Sorry for the slow response, I finally met with Linus last week to
discuss this.

> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
[..]
> @@ -825,13 +897,39 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
>  	chip->owner = THIS_MODULE;
>  	chip->of_node = pctrl->dev->of_node;
>  
> +	/* If the GPIO map is sparse, then we need to disable specific IRQs */
> +	chip->irq_need_valid_mask = pctrl->soc->sparse;
> +
>  	ret = gpiochip_add_data(&pctrl->chip, pctrl);
>  	if (ret) {
>  		dev_err(pctrl->dev, "Failed register gpiochip\n");
>  		return ret;
>  	}
>  
> -	ret = gpiochip_add_pin_range(&pctrl->chip, dev_name(pctrl->dev), 0, 0, chip->ngpio);
> +	/*
> +	 * If irq_need_valid_mask is true, then gpiochip_add_data() will
> +	 * initialize irq_valid_mask to all 1s.  We need to clear all the
> +	 * GPIOs that are unavailable, and we need to find each block
> +	 * of consecutive available GPIOs are add them as pin ranges.
> +	 */
> +	if (chip->irq_need_valid_mask) {
> +		for (i = 0; i < ngpio; i++)
> +			if (!groups[i].npins)
> +				clear_bit(i, pctrl->chip.irq_valid_mask);
> +
> +		while ((count = msm_gpio_get_next_range(pctrl, &start))) {
> +			ret = gpiochip_add_pin_range(&pctrl->chip,
> +						     dev_name(pctrl->dev),
> +						     start, start, count);
> +			if (ret)
> +				break;
> +			start += count;

I do not fancy the idea of specifying a bitmap of valid irq pins and
then having the driver register the pin-ranges in-between. If we provide
a bitmap of validity to the core it should support using this for the
pins as well. (Which I believe is what Linus answered in the discussion
following patch 0/2)

> +		}
> +	} else {
> +		ret = gpiochip_add_pin_range(&pctrl->chip, dev_name(pctrl->dev),
> +					     0, 0, ngpio);
> +	}
> +

Regards,
Bjorn
