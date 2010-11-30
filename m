From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Tue, 30 Nov 2010 15:38:59 +0100 (CET)
Subject: [PATCH 17/54] ARM: gemini: irq_data conversion.
In-Reply-To: <20101130133642.GR15575@mail.wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
	<20101130133642.GR15575@mail.wantstofly.org>
Message-ID: <alpine.LNX.2.00.1011301538240.8848@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>

On Tue, 30 Nov 2010, Lennert Buytenhek wrote:

> Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
> ---
>  arch/arm/mach-gemini/gpio.c |   26 +++++++++++++-------------
>  arch/arm/mach-gemini/irq.c  |   20 ++++++++++----------
>  2 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/arm/mach-gemini/gpio.c b/arch/arm/mach-gemini/gpio.c
> index fe3bd5a..fa3d333 100644
> --- a/arch/arm/mach-gemini/gpio.c
> +++ b/arch/arm/mach-gemini/gpio.c
> @@ -54,33 +54,33 @@ static void _set_gpio_irqenable(unsigned int base, unsigned int index,
>  	__raw_writel(reg, base + GPIO_INT_EN);
>  }
>  
> -static void gpio_ack_irq(unsigned int irq)
> +static void gpio_ack_irq(struct irq_data *d)
>  {
> -	unsigned int gpio = irq_to_gpio(irq);
> +	unsigned int gpio = irq_to_gpio(d->irq);
>  	unsigned int base = GPIO_BASE(gpio / 32);
>  
>  	__raw_writel(1 << (gpio % 32), base + GPIO_INT_CLR);
>  }
>  
> -static void gpio_mask_irq(unsigned int irq)
> +static void gpio_mask_irq(struct irq_data *d)
>  {
> -	unsigned int gpio = irq_to_gpio(irq);
> +	unsigned int gpio = irq_to_gpio(d->irq);
>  	unsigned int base = GPIO_BASE(gpio / 32);
>  
>  	_set_gpio_irqenable(base, gpio % 32, 0);
>  }
>  
> -static void gpio_unmask_irq(unsigned int irq)
> +static void gpio_unmask_irq(struct irq_data *d)
>  {
> -	unsigned int gpio = irq_to_gpio(irq);
> +	unsigned int gpio = irq_to_gpio(d->irq);
>  	unsigned int base = GPIO_BASE(gpio / 32);
>  
>  	_set_gpio_irqenable(base, gpio % 32, 1);
>  }
>  
> -static int gpio_set_irq_type(unsigned int irq, unsigned int type)
> +static int gpio_set_irq_type(struct irq_data *d, unsigned int type)
>  {
> -	unsigned int gpio = irq_to_gpio(irq);
> +	unsigned int gpio = irq_to_gpio(d->irq);
>  	unsigned int gpio_mask = 1 << (gpio % 32);
>  	unsigned int base = GPIO_BASE(gpio / 32);
>  	unsigned int reg_both, reg_level, reg_type;
> @@ -120,7 +120,7 @@ static int gpio_set_irq_type(unsigned int irq, unsigned int type)
>  	__raw_writel(reg_level, base + GPIO_INT_LEVEL);
>  	__raw_writel(reg_both, base + GPIO_INT_BOTH_EDGE);
>  
> -	gpio_ack_irq(irq);
> +	gpio_ack_irq(d->irq);
>  
>  	return 0;
>  }
> @@ -146,10 +146,10 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>  
>  static struct irq_chip gpio_irq_chip = {
>  	.name = "GPIO",
> -	.ack = gpio_ack_irq,
> -	.mask = gpio_mask_irq,
> -	.unmask = gpio_unmask_irq,
> -	.set_type = gpio_set_irq_type,
> +	.irq_ack = gpio_ack_irq,
> +	.irq_mask = gpio_mask_irq,
> +	.irq_unmask = gpio_unmask_irq,
> +	.irq_set_type = gpio_set_irq_type,
>  };
>  
>  static void _set_gpio_direction(struct gpio_chip *chip, unsigned offset,
> diff --git a/arch/arm/mach-gemini/irq.c b/arch/arm/mach-gemini/irq.c
> index 9e613ca..96bc227 100644
> --- a/arch/arm/mach-gemini/irq.c
> +++ b/arch/arm/mach-gemini/irq.c
> @@ -32,34 +32,34 @@
>  #define FIQ_LEVEL(base_addr)	(base_addr + 0x30)
>  #define FIQ_STATUS(base_addr)	(base_addr + 0x34)
>  
> -static void gemini_ack_irq(unsigned int irq)
> +static void gemini_ack_irq(struct irq_data *d)
>  {
> -	__raw_writel(1 << irq, IRQ_CLEAR(IO_ADDRESS(GEMINI_INTERRUPT_BASE)));
> +	__raw_writel(1 << d->irq, IRQ_CLEAR(IO_ADDRESS(GEMINI_INTERRUPT_BASE)));
>  }
>  
> -static void gemini_mask_irq(unsigned int irq)
> +static void gemini_mask_irq(struct irq_data *d)
>  {
>  	unsigned int mask;
>  
>  	mask = __raw_readl(IRQ_MASK(IO_ADDRESS(GEMINI_INTERRUPT_BASE)));
> -	mask &= ~(1 << irq);
> +	mask &= ~(1 << d->irq);
>  	__raw_writel(mask, IRQ_MASK(IO_ADDRESS(GEMINI_INTERRUPT_BASE)));
>  }
>  
> -static void gemini_unmask_irq(unsigned int irq)
> +static void gemini_unmask_irq(struct irq_data *d)
>  {
>  	unsigned int mask;
>  
>  	mask = __raw_readl(IRQ_MASK(IO_ADDRESS(GEMINI_INTERRUPT_BASE)));
> -	mask |= (1 << irq);
> +	mask |= (1 << d->irq);
>  	__raw_writel(mask, IRQ_MASK(IO_ADDRESS(GEMINI_INTERRUPT_BASE)));
>  }
>  
>  static struct irq_chip gemini_irq_chip = {
> -	.name	= "INTC",
> -	.ack	= gemini_ack_irq,
> -	.mask	= gemini_mask_irq,
> -	.unmask	= gemini_unmask_irq,
> +	.name		= "INTC",
> +	.irq_ack	= gemini_ack_irq,
> +	.irq_mask	= gemini_mask_irq,
> +	.irq_unmask	= gemini_unmask_irq,
>  };
>  
>  static struct resource irq_resource = {
> -- 
> 1.7.1
> 
> 
