From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 31 Jan 2012 22:36:13 +0800
Subject: [PATCH v3 2/2] gpio: pl061: enable interrupts with DT style
 binding
In-Reply-To: <1327944699-29882-3-git-send-email-robherring2@gmail.com>
References: <1327944699-29882-1-git-send-email-robherring2@gmail.com>
 <1327944699-29882-3-git-send-email-robherring2@gmail.com>
Message-ID: <20120131143609.GA26436@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2012 at 11:31:39AM -0600, Rob Herring wrote:
...
> -static void __init pl061_init_gc(struct pl061_gpio *chip, int irq_base)
> +static void __init pl061_init_gc(struct pl061_gpio *chip,
> +				 struct device_node *node, int irq_base)
>  {
>  	struct irq_chip_type *ct;
>  
> @@ -212,15 +212,17 @@ static void __init pl061_init_gc(struct pl061_gpio *chip, int irq_base)
>  	ct->chip.irq_set_wake = irq_gc_set_wake;
>  	ct->regs.mask = GPIOIE;
>  
> -	irq_setup_generic_chip(chip->irq_gc, IRQ_MSK(PL061_GPIO_NR),
> -			       IRQ_GC_INIT_NESTED_LOCK, IRQ_NOREQUEST, 0);
> +	irq_setup_generic_chip_domain(chip->irq_gc, node,
> +				      IRQ_MSK(PL061_GPIO_NR),
> +				      IRQ_GC_INIT_NESTED_LOCK,
> +				      IRQ_NOREQUEST, 0);
>  }

The function irq_setup_generic_chip_domain() is wrapped by
#ifdef CONFIG_IRQ_DOMAIN in patch #1.  Is it true that pl061 driver
will never work with !IRQ_DOMAIN case?

-- 
Regards,
Shawn
