From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 04 Aug 2015 10:53:15 +0200
Subject: [PATCH v3 2/2] pinctrl: rockchip: only enable gpio clock when it
 setting
In-Reply-To: <1438670487-27598-2-git-send-email-hl@rock-chips.com>
References: <1438670487-27598-1-git-send-email-hl@rock-chips.com>
 <1438670487-27598-2-git-send-email-hl@rock-chips.com>
Message-ID: <4658505.Inxl9yYzep@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Dienstag, 4. August 2015, 14:41:27 schrieb Lin Huang:
> gpio can keep state even the clock disable, for save power
> consumption, only enable gpio clock when it setting
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
> Changes in v3:
> -match author and Signed-off-by name

I guess this patch has the same problem as Stephen pointed out for the clk-one 
with the Signed-off-bys. As you did most of the development here, you should 
probably simply remove my Signed-off-by.

You can add a
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

instead. Two additional nits below.


> 
>  drivers/pinctrl/pinctrl-rockchip.c | 57
> +++++++++++++++++++++++++++++++++++--- 1 file changed, 53 insertions(+), 4
> deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-rockchip.c
> b/drivers/pinctrl/pinctrl-rockchip.c index cc2843a..70a4539 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.c
> +++ b/drivers/pinctrl/pinctrl-rockchip.c
> @@ -945,6 +945,7 @@ static int _rockchip_pmx_gpio_set_direction(struct
> gpio_chip *chip, if (ret < 0)
>  		return ret;
> 
> +	clk_enable(bank->clk);
>  	spin_lock_irqsave(&bank->slock, flags);
> 
>  	data = readl_relaxed(bank->reg_base + GPIO_SWPORT_DDR);
> @@ -953,9 +954,11 @@ static int _rockchip_pmx_gpio_set_direction(struct
> gpio_chip *chip, data |= BIT(pin);
>  	else
>  		data &= ~BIT(pin);
> +

unrelated new blank line


>  	writel_relaxed(data, bank->reg_base + GPIO_SWPORT_DDR);
> 
>  	spin_unlock_irqrestore(&bank->slock, flags);
> +	clk_disable(bank->clk);
> 
>  	return 0;
>  }
> @@ -1389,6 +1392,7 @@ static void rockchip_gpio_set(struct gpio_chip *gc,
> unsigned offset, int value) unsigned long flags;
>  	u32 data;
> 
> +	clk_enable(bank->clk);
>  	spin_lock_irqsave(&bank->slock, flags);
> 
>  	data = readl(reg);
> @@ -1398,6 +1402,7 @@ static void rockchip_gpio_set(struct gpio_chip *gc,
> unsigned offset, int value) writel(data, reg);
> 
>  	spin_unlock_irqrestore(&bank->slock, flags);
> +	clk_disable(bank->clk);
>  }
> 
>  /*
> @@ -1409,7 +1414,9 @@ static int rockchip_gpio_get(struct gpio_chip *gc,
> unsigned offset) struct rockchip_pin_bank *bank = gc_to_pin_bank(gc);
>  	u32 data;
> 
> +	clk_enable(bank->clk);
>  	data = readl(bank->reg_base + GPIO_EXT_PORT);
> +	clk_disable(bank->clk);
>  	data >>= offset;
>  	data &= 1;
>  	return data;
> @@ -1546,6 +1553,7 @@ static int rockchip_irq_set_type(struct irq_data *d,
> unsigned int type) if (ret < 0)
>  		return ret;
> 
> +	clk_enable(bank->clk);
>  	spin_lock_irqsave(&bank->slock, flags);
> 
>  	data = readl_relaxed(bank->reg_base + GPIO_SWPORT_DDR);
> @@ -1603,6 +1611,7 @@ static int rockchip_irq_set_type(struct irq_data *d,
> unsigned int type) default:
>  		irq_gc_unlock(gc);
>  		spin_unlock_irqrestore(&bank->slock, flags);
> +		clk_disable(bank->clk);
>  		return -EINVAL;
>  	}
> 
> @@ -1611,6 +1620,7 @@ static int rockchip_irq_set_type(struct irq_data *d,
> unsigned int type)
> 
>  	irq_gc_unlock(gc);
>  	spin_unlock_irqrestore(&bank->slock, flags);
> +	clk_disable(bank->clk);
> 
>  	return 0;
>  }
> @@ -1620,8 +1630,10 @@ static void rockchip_irq_suspend(struct irq_data *d)
>  	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
>  	struct rockchip_pin_bank *bank = gc->private;
> 
> +	clk_enable(bank->clk);
>  	bank->saved_masks = irq_reg_readl(gc, GPIO_INTMASK);
>  	irq_reg_writel(gc, ~gc->wake_active, GPIO_INTMASK);
> +	clk_disable(bank->clk);
>  }
> 
>  static void rockchip_irq_resume(struct irq_data *d)
> @@ -1629,7 +1641,27 @@ static void rockchip_irq_resume(struct irq_data *d)
>  	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
>  	struct rockchip_pin_bank *bank = gc->private;
> 
> +	clk_enable(bank->clk);
>  	irq_reg_writel(gc, bank->saved_masks, GPIO_INTMASK);
> +	clk_disable(bank->clk);
> +}
> +
> +static void rockchip_irq_gc_mask_clr_bit(struct irq_data *d)
> +{
> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> +	struct rockchip_pin_bank *bank = gc->private;
> +
> +	clk_enable(bank->clk);
> +	irq_gc_mask_clr_bit(d);
> +}
> +
> +void rockchip_irq_gc_mask_set_bit(struct irq_data *d)
> +{
> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> +	struct rockchip_pin_bank *bank = gc->private;
> +
> +	irq_gc_mask_set_bit(d);
> +	clk_disable(bank->clk);
>  }
> 
>  static int rockchip_interrupts_register(struct platform_device *pdev,
> @@ -1640,7 +1672,7 @@ static int rockchip_interrupts_register(struct
> platform_device *pdev, unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE |
> IRQ_NOAUTOEN;
>  	struct irq_chip_generic *gc;
>  	int ret;
> -	int i;
> +	int i, j;
> 
>  	for (i = 0; i < ctrl->nr_banks; ++i, ++bank) {
>  		if (!bank->valid) {
> @@ -1649,11 +1681,19 @@ static int rockchip_interrupts_register(struct
> platform_device *pdev, continue;
>  		}
> 
> +		ret = clk_enable(bank->clk);
> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to enable clock for bank %s\n",
> +				bank->name);
> +			continue;
> +		}
> +
>  		bank->domain = irq_domain_add_linear(bank->of_node, 32,
>  						&irq_generic_chip_ops, NULL);
>  		if (!bank->domain) {
>  			dev_warn(&pdev->dev, "could not initialize irq domain for bank 
%s\n",
>  				 bank->name);
> +			clk_disable(bank->clk);
>  			continue;
>  		}
> 
> @@ -1664,6 +1704,7 @@ static int rockchip_interrupts_register(struct
> platform_device *pdev, dev_err(&pdev->dev, "could not alloc generic chips
> for bank %s\n", bank->name);
>  			irq_domain_remove(bank->domain);
> +			clk_disable(bank->clk);
>  			continue;
>  		}
> 
> @@ -1681,8 +1722,9 @@ static int rockchip_interrupts_register(struct
> platform_device *pdev, gc->chip_types[0].regs.mask = GPIO_INTMASK;
>  		gc->chip_types[0].regs.ack = GPIO_PORTS_EOI;
>  		gc->chip_types[0].chip.irq_ack = irq_gc_ack_set_bit;
> -		gc->chip_types[0].chip.irq_mask = irq_gc_mask_set_bit;
> -		gc->chip_types[0].chip.irq_unmask = irq_gc_mask_clr_bit;
> +		gc->chip_types[0].chip.irq_mask = rockchip_irq_gc_mask_set_bit;
> +		gc->chip_types[0].chip.irq_unmask =
> +						  rockchip_irq_gc_mask_clr_bit;
>  		gc->chip_types[0].chip.irq_set_wake = irq_gc_set_wake;
>  		gc->chip_types[0].chip.irq_suspend = rockchip_irq_suspend;
>  		gc->chip_types[0].chip.irq_resume = rockchip_irq_resume;
> @@ -1691,6 +1733,12 @@ static int rockchip_interrupts_register(struct
> platform_device *pdev,
> 
>  		irq_set_chained_handler_and_data(bank->irq,
>  						 rockchip_irq_demux, bank);
> +
> +		/* map the gpio irqs here, when the clock is still running */
> +		for (j = 0 ; j < 32 ; j++)
> +			irq_create_mapping(bank->domain, j);
> +
> +		clk_disable(bank->clk);
>  	}
> 
>  	return 0;
> @@ -1808,7 +1856,7 @@ static int rockchip_get_bank_data(struct
> rockchip_pin_bank *bank, if (IS_ERR(bank->clk))
>  		return PTR_ERR(bank->clk);
> 
> -	return clk_prepare_enable(bank->clk);
> +	return clk_prepare(bank->clk);
>  }
> 
>  static const struct of_device_id rockchip_pinctrl_dt_match[];
> @@ -1927,6 +1975,7 @@ static int __maybe_unused
> rockchip_pinctrl_suspend(struct device *dev) static int __maybe_unused
> rockchip_pinctrl_resume(struct device *dev) {
>  	struct rockchip_pinctrl *info = dev_get_drvdata(dev);
> +

this new blank looks unrelated


>  	int ret = regmap_write(info->regmap_base, RK3288_GRF_GPIO6C_IOMUX,
>  			       rk3288_grf_gpio6c_iomux |
>  			       GPIO6C6_SEL_WRITE_ENABLE);
