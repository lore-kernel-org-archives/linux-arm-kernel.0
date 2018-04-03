From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 2 Apr 2018 21:04:23 -0700
Subject: [PATCH 1/2] pinctrl: qcom: remove static globals to allow
 multiple TLMMs
In-Reply-To: <1521848700-22214-1-git-send-email-timur@codeaurora.org>
References: <1521848700-22214-1-git-send-email-timur@codeaurora.org>
Message-ID: <20180403040423.GA453@tuxbook-pro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 23 Mar 16:44 PDT 2018, Timur Tabi wrote:

> Two data structures are declared as static globals but are intended to
> be per-TLMM.  Move them into the msm_pinctrl structure and initialize
> them at runtime.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 44 ++++++++++++++++++--------------------
>  1 file changed, 21 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index ad80a17c9990..fa4e94fedb8c 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -58,7 +58,10 @@ struct msm_pinctrl {
>  	struct device *dev;
>  	struct pinctrl_dev *pctrl;
>  	struct gpio_chip chip;
> +	struct pinctrl_desc desc;
>  	struct notifier_block restart_nb;
> +
> +	struct irq_chip irq_chip;
>  	int irq;
>  
>  	raw_spinlock_t lock;
> @@ -390,13 +393,6 @@ static int msm_config_group_set(struct pinctrl_dev *pctldev,
>  	.pin_config_group_set	= msm_config_group_set,
>  };
>  
> -static struct pinctrl_desc msm_pinctrl_desc = {
> -	.pctlops = &msm_pinctrl_ops,
> -	.pmxops = &msm_pinmux_ops,
> -	.confops = &msm_pinconf_ops,
> -	.owner = THIS_MODULE,
> -};
> -
>  static int msm_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
>  {
>  	const struct msm_pingroup *g;
> @@ -776,15 +772,6 @@ static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
>  	return 0;
>  }
>  
> -static struct irq_chip msm_gpio_irq_chip = {
> -	.name           = "msmgpio",
> -	.irq_mask       = msm_gpio_irq_mask,
> -	.irq_unmask     = msm_gpio_irq_unmask,
> -	.irq_ack        = msm_gpio_irq_ack,
> -	.irq_set_type   = msm_gpio_irq_set_type,
> -	.irq_set_wake   = msm_gpio_irq_set_wake,
> -};
> -
>  static void msm_gpio_irq_handler(struct irq_desc *desc)
>  {
>  	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
> @@ -877,6 +864,13 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
>  	chip->of_node = pctrl->dev->of_node;
>  	chip->need_valid_mask = msm_gpio_needs_valid_mask(pctrl);
>  
> +	pctrl->irq_chip.name = "msmgpio";
> +	pctrl->irq_chip.irq_mask = msm_gpio_irq_mask;
> +	pctrl->irq_chip.irq_unmask = msm_gpio_irq_unmask;
> +	pctrl->irq_chip.irq_ack = msm_gpio_irq_ack;
> +	pctrl->irq_chip.irq_set_type = msm_gpio_irq_set_type;
> +	pctrl->irq_chip.irq_set_wake = msm_gpio_irq_set_wake;
> +
>  	ret = gpiochip_add_data(&pctrl->chip, pctrl);
>  	if (ret) {
>  		dev_err(pctrl->dev, "Failed register gpiochip\n");
> @@ -898,7 +892,7 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
>  	}
>  
>  	ret = gpiochip_irqchip_add(chip,
> -				   &msm_gpio_irq_chip,
> +				   &pctrl->irq_chip,
>  				   0,
>  				   handle_edge_irq,
>  				   IRQ_TYPE_NONE);
> @@ -908,7 +902,7 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
>  		return -ENOSYS;
>  	}
>  
> -	gpiochip_set_chained_irqchip(chip, &msm_gpio_irq_chip, pctrl->irq,
> +	gpiochip_set_chained_irqchip(chip, &pctrl->irq_chip, pctrl->irq,
>  				     msm_gpio_irq_handler);
>  
>  	return 0;
> @@ -979,11 +973,15 @@ int msm_pinctrl_probe(struct platform_device *pdev,
>  		return pctrl->irq;
>  	}
>  
> -	msm_pinctrl_desc.name = dev_name(&pdev->dev);
> -	msm_pinctrl_desc.pins = pctrl->soc->pins;
> -	msm_pinctrl_desc.npins = pctrl->soc->npins;
> -	pctrl->pctrl = devm_pinctrl_register(&pdev->dev, &msm_pinctrl_desc,
> -					     pctrl);
> +	pctrl->desc.owner = THIS_MODULE;
> +	pctrl->desc.pctlops = &msm_pinctrl_ops;
> +	pctrl->desc.pmxops = &msm_pinmux_ops;
> +	pctrl->desc.confops = &msm_pinconf_ops;
> +	pctrl->desc.name = dev_name(&pdev->dev);
> +	pctrl->desc.pins = pctrl->soc->pins;
> +	pctrl->desc.npins = pctrl->soc->npins;
> +
> +	pctrl->pctrl = devm_pinctrl_register(&pdev->dev, &pctrl->desc, pctrl);
>  	if (IS_ERR(pctrl->pctrl)) {
>  		dev_err(&pdev->dev, "Couldn't register pinctrl driver\n");
>  		return PTR_ERR(pctrl->pctrl);
> -- 
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
> Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
