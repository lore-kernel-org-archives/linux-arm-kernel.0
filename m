From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 5 Dec 2012 18:10:27 +0800
Subject: [PATCH V2 6/6] ARM: tegra20: cpuidle: apply coupled cpuidle
 for powered-down mode
In-Reply-To: <1354701715-24150-8-git-send-email-josephl@nvidia.com>
References: <1354701715-24150-1-git-send-email-josephl@nvidia.com>
 <1354701715-24150-8-git-send-email-josephl@nvidia.com>
Message-ID: <1354702227.25317.0.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, there is something wrong.
Please ignore this mail.

On Wed, 2012-12-05 at 18:01 +0800, Joseph Lo wrote:
> 	return ret;
> diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
> index 63cb643..32ecdb6 100644
> --- a/drivers/gpio/gpio-tegra.c
> +++ b/drivers/gpio/gpio-tegra.c
> @@ -71,6 +71,7 @@ struct tegra_gpio_bank {
>  	u32 oe[4];
>  	u32 int_enb[4];
>  	u32 int_lvl[4];
> +	u32 wake_enb[4];
>  #endif
>  };
>  
> @@ -332,6 +333,9 @@ static int tegra_gpio_suspend(struct device *dev)
>  			bank->oe[p] = tegra_gpio_readl(GPIO_OE(gpio));
>  			bank->int_enb[p] = tegra_gpio_readl(GPIO_INT_ENB(gpio));
>  			bank->int_lvl[p] = tegra_gpio_readl(GPIO_INT_LVL(gpio));
> +
> +			/* Enable gpio irq for wake up source */
> +			tegra_gpio_writel(bank->wake_enb[p], GPIO_INT_ENB(gpio));
>  		}
>  	}
>  	local_irq_restore(flags);
> @@ -341,6 +345,36 @@ static int tegra_gpio_suspend(struct device *dev)
>  static int tegra_gpio_wake_enable(struct irq_data *d, unsigned int enable)
>  {
>  	struct tegra_gpio_bank *bank = irq_data_get_irq_chip_data(d);
> +	u8 port, bit, mask;
> +	int gpio = d->hwirq;
> +
> +	if (gpio < 0)
> +		return -EIO;
> +
> +	port = GPIO_PORT(gpio);
> +	bit = GPIO_BIT(gpio);
> +	mask = BIT(bit);
> +
> +	if (enable)
> +		bank->wake_enb[port] |= mask;
> +	else
> +		bank->wake_enb[port] &= ~mask;
> +
> +	return 0;
> +}
> +
> +static int tegra_gpio_irq_set_wake(struct irq_data *d, unsigned int enable)
> +{
> +	struct tegra_gpio_bank *bank = irq_data_get_irq_chip_data(d);
> +	int ret;
> +
> +	ret = tegra_gpio_wake_enable(d, enable);
> +	if (ret) {
> +		pr_err("Failed gpio wake %s for irq=%d error=%d\n",
> +				(enable ? "enable" : "disable"), d->irq, ret);
> +		return ret;
> +	}
> +printk(KERN_EMERG "gpio back->irq: %d hwirq: %d irq: %d\n", bank->irq, d->hwirq, d->irq);
>  	return irq_set_irq_wake(bank->irq, enable);
>  }
>  #endif
> @@ -352,7 +386,7 @@ static struct irq_chip tegra_gpio_irq_chip = {
>  	.irq_unmask	= tegra_gpio_irq_unmask,
>  	.irq_set_type	= tegra_gpio_irq_set_type,
>  #ifdef CONFIG_PM_SLEEP
> -	.irq_set_wake	= tegra_gpio_wake_enable,
> +	.irq_set_wake	= tegra_gpio_irq_set_wake,
>  #endif
>  };
>  
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index 79435de..0a14ec0 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -398,7 +398,7 @@ static irqreturn_t gpio_keys_irq_isr(int irq, void *dev_id)
>  	BUG_ON(irq != bdata->irq);
>  
>  	spin_lock_irqsave(&bdata->lock, flags);
> -
> +printk(KERN_EMERG "key pressed irq %d\n", bdata->irq);
>  	if (!bdata->key_pressed) {
>  		if (bdata->button->wakeup)
>  			pm_wakeup_event(bdata->input->dev.parent, 0);
> @@ -809,8 +809,10 @@ static int gpio_keys_suspend(struct device *dev)
>  	if (device_may_wakeup(dev)) {
>  		for (i = 0; i < ddata->pdata->nbuttons; i++) {
>  			struct gpio_button_data *bdata = &ddata->data[i];
> -			if (bdata->button->wakeup)
> +			if (bdata->button->wakeup) {
> +printk(KERN_EMERG "gpio-key wake irq:%d\n", bdata->irq);
>  				enable_irq_wake(bdata->irq);
> +			}
>  		}
>  	} else {
>  		mutex_lock(&input->mutex);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
