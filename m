From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 23 Oct 2014 18:32:18 +0200
Subject: [PATCH v2 4/4] pinctrl: rockchip: Protect read-modify-write with
 the spinlock
In-Reply-To: <1413913655-22351-4-git-send-email-dianders@chromium.org>
References: <1413913655-22351-1-git-send-email-dianders@chromium.org>
 <1413913655-22351-4-git-send-email-dianders@chromium.org>
Message-ID: <2662114.YSJpathv6W@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 21. Oktober 2014, 10:47:35 schrieb Doug Anderson:
> There were a few instances where the rockchip pinctrl driver would do
> read-modify-write with no spinlock.  Add a spinlock for these cases.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

thanks for catching those

> ---
> Changes in v2:
> - Made sure to release the lock in an error condition.
> 
>  drivers/pinctrl/pinctrl-rockchip.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-rockchip.c
> b/drivers/pinctrl/pinctrl-rockchip.c index 6c14f6c..59a5461 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.c
> +++ b/drivers/pinctrl/pinctrl-rockchip.c
> @@ -861,6 +861,7 @@ static int _rockchip_pmx_gpio_set_direction(struct
> gpio_chip *chip, {
>  	struct rockchip_pin_bank *bank;
>  	int ret;
> +	unsigned long flags;
>  	u32 data;
> 
>  	bank = gc_to_pin_bank(chip);
> @@ -869,6 +870,8 @@ static int _rockchip_pmx_gpio_set_direction(struct
> gpio_chip *chip, if (ret < 0)
>  		return ret;
> 
> +	spin_lock_irqsave(&bank->slock, flags);
> +
>  	data = readl_relaxed(bank->reg_base + GPIO_SWPORT_DDR);
>  	/* set bit to 1 for output, 0 for input */
>  	if (!input)
> @@ -877,6 +880,8 @@ static int _rockchip_pmx_gpio_set_direction(struct
> gpio_chip *chip, data &= ~BIT(pin);
>  	writel_relaxed(data, bank->reg_base + GPIO_SWPORT_DDR);
> 
> +	spin_unlock_irqrestore(&bank->slock, flags);
> +
>  	return 0;
>  }
> 
> @@ -1394,6 +1399,7 @@ static void rockchip_irq_demux(unsigned int irq,
> struct irq_desc *desc) u32 polarity = 0, data = 0;
>  	u32 pend;
>  	bool edge_changed = false;
> +	unsigned long flags;
> 
>  	dev_dbg(bank->drvdata->dev, "got irq for bank %s\n", bank->name);
> 
> @@ -1439,10 +1445,14 @@ static void rockchip_irq_demux(unsigned int irq,
> struct irq_desc *desc)
> 
>  	if (bank->toggle_edge_mode && edge_changed) {
>  		/* Interrupt params should only be set with ints disabled */
> +		spin_lock_irqsave(&bank->slock, flags);
> +
>  		data = readl_relaxed(bank->reg_base + GPIO_INTEN);
>  		writel_relaxed(0, bank->reg_base + GPIO_INTEN);
>  		writel(polarity, bank->reg_base + GPIO_INT_POLARITY);
>  		writel(data, bank->reg_base + GPIO_INTEN);
> +
> +		spin_unlock_irqrestore(&bank->slock, flags);
>  	}
> 
>  	chained_irq_exit(chip, desc);
> @@ -1456,6 +1466,7 @@ static int rockchip_irq_set_type(struct irq_data *d,
> unsigned int type) u32 polarity;
>  	u32 level;
>  	u32 data;
> +	unsigned long flags;
>  	int ret;
> 
>  	/* make sure the pin is configured as gpio input */
> @@ -1463,15 +1474,20 @@ static int rockchip_irq_set_type(struct irq_data *d,
> unsigned int type) if (ret < 0)
>  		return ret;
> 
> +	spin_lock_irqsave(&bank->slock, flags);
> +
>  	data = readl_relaxed(bank->reg_base + GPIO_SWPORT_DDR);
>  	data &= ~mask;
>  	writel_relaxed(data, bank->reg_base + GPIO_SWPORT_DDR);
> 
> +	spin_unlock_irqrestore(&bank->slock, flags);
> +
>  	if (type & IRQ_TYPE_EDGE_BOTH)
>  		__irq_set_handler_locked(d->irq, handle_edge_irq);
>  	else
>  		__irq_set_handler_locked(d->irq, handle_level_irq);
> 
> +	spin_lock_irqsave(&bank->slock, flags);
>  	irq_gc_lock(gc);
> 
>  	level = readl_relaxed(gc->reg_base + GPIO_INTTYPE_LEVEL);
> @@ -1514,6 +1530,7 @@ static int rockchip_irq_set_type(struct irq_data *d,
> unsigned int type) break;
>  	default:
>  		irq_gc_unlock(gc);
> +		spin_unlock_irqrestore(&bank->slock, flags);
>  		return -EINVAL;
>  	}
> 
> @@ -1521,6 +1538,7 @@ static int rockchip_irq_set_type(struct irq_data *d,
> unsigned int type) writel_relaxed(polarity, gc->reg_base +
> GPIO_INT_POLARITY);
> 
>  	irq_gc_unlock(gc);
> +	spin_unlock_irqrestore(&bank->slock, flags);
> 
>  	return 0;
>  }
