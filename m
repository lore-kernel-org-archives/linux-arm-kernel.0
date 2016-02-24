From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 24 Feb 2016 10:08:41 -0800
Subject: [PATCH 19/50] pinctrl: ssbi-gpi: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-20-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
 <1456319775-3216-20-git-send-email-ldewangan@nvidia.com>
Message-ID: <20160224180841.GM21240@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 24 Feb 05:15 PST 2016, Laxman Dewangan wrote:

> Use devm_pinctrl_register() for pin control registration and clean
> the error path.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> ---

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

>  drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
> index cd8580d..f71dda6 100644
> --- a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
> +++ b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
> @@ -729,7 +729,7 @@ static int pm8xxx_gpio_probe(struct platform_device *pdev)
>  	pctrl->desc.custom_conf_items = pm8xxx_conf_items;
>  #endif
>  
> -	pctrl->pctrl = pinctrl_register(&pctrl->desc, &pdev->dev, pctrl);
> +	pctrl->pctrl = devm_pinctrl_register(&pdev->dev, &pctrl->desc, pctrl);
>  	if (IS_ERR(pctrl->pctrl)) {
>  		dev_err(&pdev->dev, "couldn't register pm8xxx gpio driver\n");
>  		return PTR_ERR(pctrl->pctrl);
> @@ -745,7 +745,7 @@ static int pm8xxx_gpio_probe(struct platform_device *pdev)
>  	ret = gpiochip_add_data(&pctrl->chip, pctrl);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed register gpiochip\n");
> -		goto unregister_pinctrl;
> +		return ret;
>  	}
>  
>  	ret = gpiochip_add_pin_range(&pctrl->chip,
> @@ -765,9 +765,6 @@ static int pm8xxx_gpio_probe(struct platform_device *pdev)
>  unregister_gpiochip:
>  	gpiochip_remove(&pctrl->chip);
>  
> -unregister_pinctrl:
> -	pinctrl_unregister(pctrl->pctrl);
> -
>  	return ret;
>  }
>  
> @@ -777,8 +774,6 @@ static int pm8xxx_gpio_remove(struct platform_device *pdev)
>  
>  	gpiochip_remove(&pctrl->chip);
>  
> -	pinctrl_unregister(pctrl->pctrl);
> -
>  	return 0;
>  }
>  
> -- 
> 2.1.4
> 
