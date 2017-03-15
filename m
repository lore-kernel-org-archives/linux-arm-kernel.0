From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 15 Mar 2017 17:41:21 +0100
Subject: [RFC PATCH 2/4] pinctrl: rockchip: convert to raw spinlock
In-Reply-To: <39203480.lbsBriduiK@phil>
References: <20170313183813.3582-1-john@metanate.com>
 <20170313183813.3582-3-john@metanate.com> <39203480.lbsBriduiK@phil>
Message-ID: <2549921.4Nq1JGygY8@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 15. M?rz 2017, 17:28:56 CET schrieb Heiko Stuebner:
> Am Montag, 13. M?rz 2017, 18:38:11 CET schrieb John Keeping:
> > This lock is used from rockchip_irq_set_type() which is part of the
> > irq_chip implementation and thus must use raw_spinlock_t as documented
> > in Documentation/gpio/driver.txt.
> > 
> > Signed-off-by: John Keeping <john@metanate.com>
> 
> Looks good
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

I have to take that back.
This leaves the spin_lock in the schmitt trigger unconverted and produces 
compile issues.

So it either needs to be converted or removed - I guess it should be removed.

> 
> > ---
> > 
> >  drivers/pinctrl/pinctrl-rockchip.c | 30 +++++++++++++++---------------
> >  1 file changed, 15 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/pinctrl/pinctrl-rockchip.c
> > b/drivers/pinctrl/pinctrl-rockchip.c index 1defe83a5c4d..2f963aea64b2
> > 100644
> > --- a/drivers/pinctrl/pinctrl-rockchip.c
> > +++ b/drivers/pinctrl/pinctrl-rockchip.c
> > @@ -163,7 +163,7 @@ struct rockchip_pin_bank {
> > 
> >  	struct irq_domain		*domain;
> >  	struct gpio_chip		gpio_chip;
> >  	struct pinctrl_gpio_range	grange;
> > 
> > -	spinlock_t			slock;
> > +	raw_spinlock_t			slock;
> > 
> >  	u32				toggle_edge_mode;
> >  
> >  };
> > 
> > @@ -1292,14 +1292,14 @@ static int rockchip_set_pull(struct
> > rockchip_pin_bank *bank,
> > 
> >  	switch (ctrl->type) {
> > 
> >  	case RK2928:
> > -		spin_lock_irqsave(&bank->slock, flags);
> > +		raw_spin_lock_irqsave(&bank->slock, flags);
> > 
> >  		data = BIT(bit + 16);
> >  		if (pull == PIN_CONFIG_BIAS_DISABLE)
> >  		
> >  			data |= BIT(bit);
> >  		
> >  		ret = regmap_write(regmap, reg, data);
> > 
> > -		spin_unlock_irqrestore(&bank->slock, flags);
> > +		raw_spin_unlock_irqrestore(&bank->slock, flags);
> > 
> >  		break;
> >  	
> >  	case RK1108:
> > 
> >  	case RK3188:
> > @@ -1433,7 +1433,7 @@ static int _rockchip_pmx_gpio_set_direction(struct
> > gpio_chip *chip, return ret;
> > 
> >  	clk_enable(bank->clk);
> > 
> > -	spin_lock_irqsave(&bank->slock, flags);
> > +	raw_spin_lock_irqsave(&bank->slock, flags);
> > 
> >  	data = readl_relaxed(bank->reg_base + GPIO_SWPORT_DDR);
> >  	/* set bit to 1 for output, 0 for input */
> > 
> > @@ -1443,7 +1443,7 @@ static int _rockchip_pmx_gpio_set_direction(struct
> > gpio_chip *chip, data &= ~BIT(pin);
> > 
> >  	writel_relaxed(data, bank->reg_base + GPIO_SWPORT_DDR);
> > 
> > -	spin_unlock_irqrestore(&bank->slock, flags);
> > +	raw_spin_unlock_irqrestore(&bank->slock, flags);
> > 
> >  	clk_disable(bank->clk);
> >  	
> >  	return 0;
> > 
> > @@ -1874,7 +1874,7 @@ static void rockchip_gpio_set(struct gpio_chip *gc,
> > unsigned offset, int value) u32 data;
> > 
> >  	clk_enable(bank->clk);
> > 
> > -	spin_lock_irqsave(&bank->slock, flags);
> > +	raw_spin_lock_irqsave(&bank->slock, flags);
> > 
> >  	data = readl(reg);
> >  	data &= ~BIT(offset);
> > 
> > @@ -1882,7 +1882,7 @@ static void rockchip_gpio_set(struct gpio_chip *gc,
> > unsigned offset, int value) data |= BIT(offset);
> > 
> >  	writel(data, reg);
> > 
> > -	spin_unlock_irqrestore(&bank->slock, flags);
> > +	raw_spin_unlock_irqrestore(&bank->slock, flags);
> > 
> >  	clk_disable(bank->clk);
> >  
> >  }
> > 
> > @@ -1994,7 +1994,7 @@ static void rockchip_irq_demux(struct irq_desc
> > *desc)
> > 
> >  			data = readl_relaxed(bank->reg_base + GPIO_EXT_PORT);
> >  			do {
> > 
> > -				spin_lock_irqsave(&bank->slock, flags);
> > +				raw_spin_lock_irqsave(&bank->slock, flags);
> > 
> >  				polarity = readl_relaxed(bank->reg_base +
> >  				
> >  							 GPIO_INT_POLARITY);
> > 
> > @@ -2005,7 +2005,7 @@ static void rockchip_irq_demux(struct irq_desc
> > *desc)
> > 
> >  				writel(polarity,
> >  				
> >  				       bank->reg_base + GPIO_INT_POLARITY);
> > 
> > -				spin_unlock_irqrestore(&bank->slock, flags);
> > +				raw_spin_unlock_irqrestore(&bank->slock, flags);
> > 
> >  				data_old = data;
> >  				data = readl_relaxed(bank->reg_base +
> > 
> > @@ -2036,20 +2036,20 @@ static int rockchip_irq_set_type(struct irq_data
> > *d, unsigned int type) return ret;
> > 
> >  	clk_enable(bank->clk);
> > 
> > -	spin_lock_irqsave(&bank->slock, flags);
> > +	raw_spin_lock_irqsave(&bank->slock, flags);
> > 
> >  	data = readl_relaxed(bank->reg_base + GPIO_SWPORT_DDR);
> >  	data &= ~mask;
> >  	writel_relaxed(data, bank->reg_base + GPIO_SWPORT_DDR);
> > 
> > -	spin_unlock_irqrestore(&bank->slock, flags);
> > +	raw_spin_unlock_irqrestore(&bank->slock, flags);
> > 
> >  	if (type & IRQ_TYPE_EDGE_BOTH)
> >  	
> >  		irq_set_handler_locked(d, handle_edge_irq);
> >  	
> >  	else
> >  	
> >  		irq_set_handler_locked(d, handle_level_irq);
> > 
> > -	spin_lock_irqsave(&bank->slock, flags);
> > +	raw_spin_lock_irqsave(&bank->slock, flags);
> > 
> >  	irq_gc_lock(gc);
> >  	
> >  	level = readl_relaxed(gc->reg_base + GPIO_INTTYPE_LEVEL);
> > 
> > @@ -2092,7 +2092,7 @@ static int rockchip_irq_set_type(struct irq_data *d,
> > unsigned int type) break;
> > 
> >  	default:
> >  		irq_gc_unlock(gc);
> > 
> > -		spin_unlock_irqrestore(&bank->slock, flags);
> > +		raw_spin_unlock_irqrestore(&bank->slock, flags);
> > 
> >  		clk_disable(bank->clk);
> >  		return -EINVAL;
> >  	
> >  	}
> > 
> > @@ -2101,7 +2101,7 @@ static int rockchip_irq_set_type(struct irq_data *d,
> > unsigned int type) writel_relaxed(polarity, gc->reg_base +
> > GPIO_INT_POLARITY);
> > 
> >  	irq_gc_unlock(gc);
> > 
> > -	spin_unlock_irqrestore(&bank->slock, flags);
> > +	raw_spin_unlock_irqrestore(&bank->slock, flags);
> > 
> >  	clk_disable(bank->clk);
> >  	
> >  	return 0;
> > 
> > @@ -2383,7 +2383,7 @@ static struct rockchip_pin_ctrl
> > *rockchip_pinctrl_get_soc_data( for (i = 0; i < ctrl->nr_banks; ++i,
> > ++bank) {
> > 
> >  		int bank_pins = 0;
> > 
> > -		spin_lock_init(&bank->slock);
> > +		raw_spin_lock_init(&bank->slock);
> > 
> >  		bank->drvdata = d;
> >  		bank->pin_base = ctrl->nr_pins;
> >  		ctrl->nr_pins += bank->nr_pins;
