From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Mar 2014 16:22:27 +0100
Subject: [patch 08/26] arm: Replace various irq_desc accesses
In-Reply-To: <20140223212737.099151500@linutronix.de>
References: <20140223212703.511977310@linutronix.de>
 <20140223212737.099151500@linutronix.de>
Message-ID: <201403201622.27725.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 23 February 2014, Thomas Gleixner wrote:
> --- tip.orig/arch/arm/mach-omap1/ams-delta-fiq.c
> +++ tip/arch/arm/mach-omap1/ams-delta-fiq.c
> @@ -44,13 +44,10 @@ static unsigned int irq_counter[16];
>  
>  static irqreturn_t deferred_fiq(int irq, void *dev_id)
>  {
> -       struct irq_desc *irq_desc;
> -       struct irq_chip *irq_chip = NULL;
>         int gpio, irq_num, fiq_count;
> +       struct irq_chip *irq_chip;
>  
> -       irq_desc = irq_to_desc(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK));
> -       if (irq_desc)
> -               irq_chip = irq_desc->irq_data.chip;
> +       irq_chip = irq_get_irq_chip(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK));

I got a compile error because irq_get_irq_chip() doesn't exist. I suppose
you meant irq_get_chip.

	Arnd
