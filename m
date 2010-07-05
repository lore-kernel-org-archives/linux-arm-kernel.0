From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 5 Jul 2010 09:02:22 +0200
Subject: [RFC PATCH] arm/imx/gpio: add spinlock protection
In-Reply-To: <7fe710a6bc27460852588d2e561ec4c4a4644ab0.1278227668.git.baruch@tkos.co.il>
References: <7fe710a6bc27460852588d2e561ec4c4a4644ab0.1278227668.git.baruch@tkos.co.il>
Message-ID: <20100705070222.GB18865@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

[I added David to Cc and so didn't strip the patch.]

On Sun, Jul 04, 2010 at 10:15:13AM +0300, Baruch Siach wrote:
> The GPIO and IRQ/GPIO registers need protection from concurrent access for
> operations that are not atomic.
> 
> Cc: Juergen Beisert <j.beisert@pengutronix.de>
> Cc: Daniel Mack <daniel@caiaq.de>
> Reported-by: rpkamiak at rockwellcollins.com
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
I think this is OK, I just wonder if it's worth to introduce two
spinlocks.

Best regards
Uwe

> ---
>  arch/arm/plat-mxc/gpio.c              |   28 +++++++++++++++++++++++++---
>  arch/arm/plat-mxc/include/mach/gpio.h |    3 +++
>  2 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
> index 71437c6..a8a33cd 100644
> --- a/arch/arm/plat-mxc/gpio.c
> +++ b/arch/arm/plat-mxc/gpio.c
> @@ -56,10 +56,13 @@ static void _set_gpio_irqenable(struct mxc_gpio_port *port, u32 index,
>  				int enable)
>  {
>  	u32 l;
> +	unsigned long flags;
>  
> +	spin_lock_irqsave(&port->irq_lock, flags);
>  	l = __raw_readl(port->base + GPIO_IMR);
>  	l = (l & (~(1 << index))) | (!!enable << index);
>  	__raw_writel(l, port->base + GPIO_IMR);
> +	spin_unlock_irqrestore(&port->irq_lock, flags);
>  }
>  
>  static void gpio_ack_irq(u32 irq)
> @@ -87,8 +90,11 @@ static int gpio_set_irq_type(u32 irq, u32 type)
>  	u32 gpio = irq_to_gpio(irq);
>  	struct mxc_gpio_port *port = &mxc_gpio_ports[gpio / 32];
>  	u32 bit, val;
> -	int edge;
> +	int edge, rc = 0;
>  	void __iomem *reg = port->base;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&port->irq_lock, flags);
>  
>  	port->both_edges &= ~(1 << (gpio & 31));
>  	switch (type) {
> @@ -116,7 +122,8 @@ static int gpio_set_irq_type(u32 irq, u32 type)
>  		edge = GPIO_INT_HIGH_LEV;
>  		break;
>  	default:
> -		return -EINVAL;
> +		rc = -EINVAL;
> +		goto out;
>  	}
>  
>  	reg += GPIO_ICR1 + ((gpio & 0x10) >> 2); /* lower or upper register */
> @@ -125,9 +132,12 @@ static int gpio_set_irq_type(u32 irq, u32 type)
>  	__raw_writel(val | (edge << (bit << 1)), reg);
>  	_clear_gpio_irqstatus(port, gpio & 0x1f);
>  
> -	return 0;
> +out:
> +	spin_unlock_irqrestore(&port->irq_lock, flags);
> +	return rc;
>  }
>  
> +/* caller must hold port->irq_lock */
>  static void mxc_flip_edge(struct mxc_gpio_port *port, u32 gpio)
>  {
>  	void __iomem *reg = port->base;
> @@ -157,12 +167,15 @@ static void mxc_flip_edge(struct mxc_gpio_port *port, u32 gpio)
>  static void mxc_gpio_irq_handler(struct mxc_gpio_port *port, u32 irq_stat)
>  {
>  	u32 gpio_irq_no_base = port->virtual_irq_start;
> +	unsigned long flags;
>  
>  	while (irq_stat != 0) {
>  		int irqoffset = fls(irq_stat) - 1;
>  
> +		spin_lock_irqsave(&port->irq_lock, flags);
>  		if (port->both_edges & (1 << irqoffset))
>  			mxc_flip_edge(port, irqoffset);
> +		spin_unlock_irqrestore(&port->irq_lock, flags);
>  
>  		generic_handle_irq(gpio_irq_no_base + irqoffset);
>  
> @@ -214,13 +227,16 @@ static void _set_gpio_direction(struct gpio_chip *chip, unsigned offset,
>  	struct mxc_gpio_port *port =
>  		container_of(chip, struct mxc_gpio_port, chip);
>  	u32 l;
> +	unsigned long flags;
>  
> +	spin_lock_irqsave(&port->lock, flags);
>  	l = __raw_readl(port->base + GPIO_GDIR);
>  	if (dir)
>  		l |= 1 << offset;
>  	else
>  		l &= ~(1 << offset);
>  	__raw_writel(l, port->base + GPIO_GDIR);
> +	spin_unlock_irqrestore(&port->lock, flags);
>  }
>  
>  static void mxc_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
> @@ -229,9 +245,12 @@ static void mxc_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
>  		container_of(chip, struct mxc_gpio_port, chip);
>  	void __iomem *reg = port->base + GPIO_DR;
>  	u32 l;
> +	unsigned long flags;
>  
> +	spin_lock_irqsave(&port->lock, flags);
>  	l = (__raw_readl(reg) & (~(1 << offset))) | (value << offset);
>  	__raw_writel(l, reg);
> +	spin_unlock_irqrestore(&port->lock, flags);
>  }
>  
>  static int mxc_gpio_get(struct gpio_chip *chip, unsigned offset)
> @@ -285,6 +304,9 @@ int __init mxc_gpio_init(struct mxc_gpio_port *port, int cnt)
>  		port[i].chip.base = i * 32;
>  		port[i].chip.ngpio = 32;
>  
> +		spin_lock_init(&port[i].lock);
> +		spin_lock_init(&port[i].irq_lock);
> +
>  		/* its a serious configuration bug when it fails */
>  		BUG_ON( gpiochip_add(&port[i].chip) < 0 );
>  
> diff --git a/arch/arm/plat-mxc/include/mach/gpio.h b/arch/arm/plat-mxc/include/mach/gpio.h
> index 894d2f8..a37724a 100644
> --- a/arch/arm/plat-mxc/include/mach/gpio.h
> +++ b/arch/arm/plat-mxc/include/mach/gpio.h
> @@ -36,6 +36,9 @@ struct mxc_gpio_port {
>  	int virtual_irq_start;
>  	struct gpio_chip chip;
>  	u32 both_edges;
> +
> +	spinlock_t	lock;		/* GPIO registers */
> +	spinlock_t	irq_lock;	/* IRQ registers */
>  };
>  
>  int mxc_gpio_init(struct mxc_gpio_port*, int);
> -- 
> 1.7.1

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
