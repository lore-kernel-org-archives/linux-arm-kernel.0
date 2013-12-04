From: gsi@denx.de (Gerhard Sittig)
Date: Wed, 4 Dec 2013 14:26:13 +0100
Subject: [PATCH v2] pinctrl: baytrail: lock IRQs when starting them
In-Reply-To: <1386082822-20094-1-git-send-email-linus.walleij@linaro.org>
References: <1386082822-20094-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20131204132613.GD2982@book.gsilab.sittig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 16:00 +0100, Linus Walleij wrote:
> 
> --- a/drivers/pinctrl/pinctrl-baytrail.c
> +++ b/drivers/pinctrl/pinctrl-baytrail.c
> @@ -372,11 +372,33 @@ static void byt_irq_mask(struct irq_data *d)
>  {
>  }
>  
> +static unsigned int byt_irq_startup(struct irq_data *d)
> +{
> +	struct byt_gpio *vg = irq_data_get_irq_handler_data(d);
> +
> +	if (gpio_lock_as_irq(&vg->chip, irqd_to_hwirq(d)))
> +		dev_err(vg->chip.dev,
> +			"unable to lock HW IRQ %lu for IRQ\n",
> +			irqd_to_hwirq(d));
> +	byt_irq_unmask(d);
> +	return 0;
> +}

Just a thought:  If failure to lock is non-fatal, should the
message be a warning then?

I do agree that failure to lock the GPIO should be non-fatal, as
there was debate and still might be concerns about how strict
locking should be.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
