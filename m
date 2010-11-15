From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 15 Nov 2010 17:43:36 +0100
Subject: [PATCH 05/11] ARM: imx: Add GPIO support for i.MX28
In-Reply-To: <1289831795-4373-6-git-send-email-shawn.guo@freescale.com>
References: <1289831795-4373-1-git-send-email-shawn.guo@freescale.com>
	<1289831795-4373-6-git-send-email-shawn.guo@freescale.com>
Message-ID: <20101115164336.GM8942@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 15, 2010 at 10:36:29PM +0800, Shawn Guo wrote:
> SoC i.MX28 implements GPIO functions in block PINCTRL. It adds
> the support in the same file used by other i.MX SoCs, and uses
> cpu_is_mx28() to distinguish the PINCTRL from GPIO used by other
> i.MX SoCs.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/plat-mxc/gpio.c |  186 +++++++++++++++++++++++++++++++++++++--------
>  1 files changed, 153 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
> index 9c3e362..f0d94af 100644
> --- a/arch/arm/plat-mxc/gpio.c
> +++ b/arch/arm/plat-mxc/gpio.c
> @@ -30,6 +30,17 @@
>  static struct mxc_gpio_port *mxc_gpio_ports;
>  static int gpio_table_size;
>  
> +/* PINCTRL */
> +#define GPIO_PORT_ID(p)	(((void *)p - (void *)mxc_gpio_ports) / sizeof(p))
> +#define GPIO_DOUT(p)		(0x0700 + GPIO_PORT_ID(p) * 0x10)
> +#define GPIO_DIN(p)		(0x0900 + GPIO_PORT_ID(p) * 0x10)
> +#define GPIO_DOE(p)		(0x0b00 + GPIO_PORT_ID(p) * 0x10)
> +#define GPIO_PIN2IRQ(p)		(0x1000 + GPIO_PORT_ID(p) * 0x10)
> +#define GPIO_IRQEN(p)		(0x1100 + GPIO_PORT_ID(p) * 0x10)
> +#define GPIO_LEV(p)		(0x1200 + GPIO_PORT_ID(p) * 0x10)
> +#define GPIO_POL(p)		(0x1300 + GPIO_PORT_ID(p) * 0x10)
> +#define GPIO_IRQSTAT(p)		(0x1400 + GPIO_PORT_ID(p) * 0x10)
> +
>  #define cpu_is_mx1_mx2()	(cpu_is_mx1() || cpu_is_mx2())
>  
>  #define GPIO_DR		(cpu_is_mx1_mx2() ? 0x1c : 0x00)
> @@ -40,17 +51,25 @@ static int gpio_table_size;
>  #define GPIO_IMR	(cpu_is_mx1_mx2() ? 0x30 : 0x14)
>  #define GPIO_ISR	(cpu_is_mx1_mx2() ? 0x34 : 0x18)
>  
> -#define GPIO_INT_LOW_LEV	(cpu_is_mx1_mx2() ? 0x3 : 0x0)
> -#define GPIO_INT_HIGH_LEV	(cpu_is_mx1_mx2() ? 0x2 : 0x1)
> -#define GPIO_INT_RISE_EDGE	(cpu_is_mx1_mx2() ? 0x0 : 0x2)
> -#define GPIO_INT_FALL_EDGE	(cpu_is_mx1_mx2() ? 0x1 : 0x3)
> +#define GPIO_INT_LOW_LEV \
> +	(cpu_is_mx28() ? 0x1 : (cpu_is_mx1_mx2() ? 0x3 : 0x0))

I'm more and more conviced that it doesn't make sense to fold mx28 into
the existing mxc code.
> +#define GPIO_INT_HIGH_LEV \
> +	(cpu_is_mx28() ? 0x3 : (cpu_is_mx1_mx2() ? 0x2 : 0x1))
> +#define GPIO_INT_RISE_EDGE \
> +	(cpu_is_mx1_mx2() ? 0x0 : 0x2)
> +#define GPIO_INT_FALL_EDGE \
> +	(cpu_is_mx28() ? 0x0 : (cpu_is_mx1_mx2() ? 0x1 : 0x3))
>  #define GPIO_INT_NONE		0x4
>  
>  /* Note: This driver assumes 32 GPIOs are handled in one register */
>  
>  static void _clear_gpio_irqstatus(struct mxc_gpio_port *port, u32 index)
>  {
> -	__raw_writel(1 << index, port->base + GPIO_ISR);
> +	if (cpu_is_mx28())
> +		__raw_writel(1 << index,
> +				port->base + GPIO_IRQSTAT(port) + CLR_ADDR);
> +	else
> +		__raw_writel(1 << index, port->base + GPIO_ISR);
>  }
>  
>  static void _set_gpio_irqenable(struct mxc_gpio_port *port, u32 index,
> @@ -58,9 +77,23 @@ static void _set_gpio_irqenable(struct mxc_gpio_port *port, u32 index,
>  {
>  	u32 l;
>  
> -	l = __raw_readl(port->base + GPIO_IMR);
> -	l = (l & (~(1 << index))) | (!!enable << index);
> -	__raw_writel(l, port->base + GPIO_IMR);
> +	if (cpu_is_mx28()) {
> +		if (enable == 0) {
> +			__raw_writel(1 << index,
> +				port->base + GPIO_PIN2IRQ(port) + CLR_ADDR);
> +			__raw_writel(1 << index,
> +				port->base + GPIO_IRQEN(port) + CLR_ADDR);
> +		} else {
> +			__raw_writel(1 << index,
> +				port->base + GPIO_PIN2IRQ(port) + SET_ADDR);
> +			__raw_writel(1 << index,
> +				port->base + GPIO_IRQEN(port) + SET_ADDR);
> +		}
> +	} else {
> +		l = __raw_readl(port->base + GPIO_IMR);
> +		l = (l & (~(1 << index))) | (!!enable << index);
> +		__raw_writel(l, port->base + GPIO_IMR);
> +	}
>  }
>  
>  static void gpio_ack_irq(u32 irq)
> @@ -120,10 +153,28 @@ static int gpio_set_irq_type(u32 irq, u32 type)
>  		return -EINVAL;
>  	}
>  
> -	reg += GPIO_ICR1 + ((gpio & 0x10) >> 2); /* lower or upper register */
> -	bit = gpio & 0xf;
> -	val = __raw_readl(reg) & ~(0x3 << (bit << 1));
> -	__raw_writel(val | (edge << (bit << 1)), reg);
> +	if (cpu_is_mx28()) {
> +		/* set level or edge */
> +		if (edge & 0x1)
> +			__raw_writel(1 << (gpio & 31),
> +					port->base + GPIO_LEV(port) + SET_ADDR);
> +		else
> +			__raw_writel(1 << (gpio & 31),
> +					port->base + GPIO_LEV(port) + CLR_ADDR);
> +		/* set polarity */
> +		if ((edge >> 1) & 0x1)
> +			__raw_writel(1 << (gpio & 31),
> +					port->base + GPIO_POL(port) + SET_ADDR);
> +		else
> +			__raw_writel(1 << (gpio & 31),
> +					port->base + GPIO_POL(port) + CLR_ADDR);
> +	} else {
> +		reg += GPIO_ICR1 + ((gpio & 0x10) >> 2);
> +		bit = gpio & 0xf;
> +		val = __raw_readl(reg) & ~(0x3 << (bit << 1));
> +		__raw_writel(val | (edge << (bit << 1)), reg);
> +	}
> +
>  	_clear_gpio_irqstatus(port, gpio & 0x1f);
>  
>  	return 0;
> @@ -135,23 +186,36 @@ static void mxc_flip_edge(struct mxc_gpio_port *port, u32 gpio)
>  	u32 bit, val;
>  	int edge;
>  
> -	reg += GPIO_ICR1 + ((gpio & 0x10) >> 2); /* lower or upper register */
> -	bit = gpio & 0xf;
> -	val = __raw_readl(reg);
> -	edge = (val >> (bit << 1)) & 3;
> -	val &= ~(0x3 << (bit << 1));
> -	if (edge == GPIO_INT_HIGH_LEV) {
> -		edge = GPIO_INT_LOW_LEV;
> -		pr_debug("mxc: switch GPIO %d to low trigger\n", gpio);
> -	} else if (edge == GPIO_INT_LOW_LEV) {
> -		edge = GPIO_INT_HIGH_LEV;
> -		pr_debug("mxc: switch GPIO %d to high trigger\n", gpio);
> +	if (cpu_is_mx28()) {
> +		edge = 1 << (gpio & 31);
> +		val = __raw_readl(port->base + GPIO_LEV(port));
> +		if (val & edge) {
> +			/* level is invalid for this function */
> +			pr_err("mxc: invalid configuration for GPIO %d: %x\n",
> +				gpio, edge);
> +			return;
> +		}
> +		__raw_writel(1 << (gpio & 31),
> +				port->base + GPIO_POL(port) + TOG_ADDR);
>  	} else {
> -		pr_err("mxc: invalid configuration for GPIO %d: %x\n",
> -		       gpio, edge);
> -		return;
> +		reg += GPIO_ICR1 + ((gpio & 0x10) >> 2);
> +		bit = gpio & 0xf;
> +		val = __raw_readl(reg);
> +		edge = (val >> (bit << 1)) & 3;
> +		val &= ~(0x3 << (bit << 1));
> +		if (edge == GPIO_INT_HIGH_LEV) {
> +			edge = GPIO_INT_LOW_LEV;
> +			pr_debug("mxc: switch GPIO %d to low trigger\n", gpio);
> +		} else if (edge == GPIO_INT_LOW_LEV) {
> +			edge = GPIO_INT_HIGH_LEV;
> +			pr_debug("mxc: switch GPIO %d to high trigger\n", gpio);
> +		} else {
> +			pr_err("mxc: invalid configuration for GPIO %d: %x\n",
> +			       gpio, edge);
> +			return;
> +		}
> +		__raw_writel(val | (edge << (bit << 1)), reg);
>  	}
> -	__raw_writel(val | (edge << (bit << 1)), reg);
>  }
>  
>  /* handle 32 interrupts in one status register */
> @@ -183,6 +247,29 @@ static void mx3_gpio_irq_handler(u32 irq, struct irq_desc *desc)
>  	mxc_gpio_irq_handler(port, irq_stat);
>  }
>  
> +/* MX28 has one interrupt *per* gpio port */
> +static void mx28_gpio_irq_handler(u32 irq, struct irq_desc *desc)
> +{
> +	u32 irq_stat;
> +	struct mxc_gpio_port *port = (struct mxc_gpio_port *)get_irq_data(irq);
> +	u32 gpio_irq_no_base = port->virtual_irq_start;
> +
> +	irq_stat = __raw_readl(port->base + GPIO_IRQSTAT(port)) &
> +			__raw_readl(port->base + GPIO_IRQEN(port)) &
> +			__raw_readl(port->base + GPIO_PIN2IRQ(port));
> +
> +	while (irq_stat != 0) {
> +		int irqoffset = fls(irq_stat) - 1;
> +
> +		if (port->both_edges & (1 << irqoffset))
> +			mxc_flip_edge(port, irqoffset);
> +
> +		generic_handle_irq(gpio_irq_no_base + irqoffset);
> +
> +		irq_stat &= ~(1 << irqoffset);
> +	}
> +}
> +
>  /* MX2 has one interrupt *for all* gpio ports */
>  static void mx2_gpio_irq_handler(u32 irq, struct irq_desc *desc)
>  {
> @@ -247,14 +334,20 @@ static void _set_gpio_direction(struct gpio_chip *chip, unsigned offset,
>  		container_of(chip, struct mxc_gpio_port, chip);
>  	u32 l;
>  	unsigned long flags;
> +	void __iomem *reg;
> +
> +	if (cpu_is_mx28())
> +		reg = port->base + GPIO_DOE(port);
> +	else
> +		reg = port->base + GPIO_GDIR;
>  
>  	spin_lock_irqsave(&port->lock, flags);
> -	l = __raw_readl(port->base + GPIO_GDIR);
> +	l = __raw_readl(reg);
>  	if (dir)
>  		l |= 1 << offset;
>  	else
>  		l &= ~(1 << offset);
> -	__raw_writel(l, port->base + GPIO_GDIR);
> +	__raw_writel(l, reg);
>  	spin_unlock_irqrestore(&port->lock, flags);
>  }
>  
> @@ -262,9 +355,14 @@ static void mxc_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
>  {
>  	struct mxc_gpio_port *port =
>  		container_of(chip, struct mxc_gpio_port, chip);
> -	void __iomem *reg = port->base + GPIO_DR;
>  	u32 l;
>  	unsigned long flags;
> +	void __iomem *reg;
> +
> +	if (cpu_is_mx28())
> +		reg = port->base + GPIO_DOUT(port);
> +	else
> +		reg = port->base + GPIO_DR;
Here again, you clutter several hot paths with if(cpu_is_...()) tests.

gpiolib is generic enough not to need this.
>  
>  	spin_lock_irqsave(&port->lock, flags);
>  	l = (__raw_readl(reg) & (~(1 << offset))) | (!!value << offset);
> @@ -276,8 +374,14 @@ static int mxc_gpio_get(struct gpio_chip *chip, unsigned offset)
>  {
>  	struct mxc_gpio_port *port =
>  		container_of(chip, struct mxc_gpio_port, chip);
> +	void __iomem *reg;
> +
> +	if (cpu_is_mx28())
> +		reg = port->base + GPIO_DIN(port);
> +	else
> +		reg = port->base + GPIO_PSR;
>  
> -	return (__raw_readl(port->base + GPIO_PSR) >> offset) & 1;
> +	return (__raw_readl(reg) >> offset) & 1;
>  }
>  
>  static int mxc_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
> @@ -306,8 +410,19 @@ int __init mxc_gpio_init(struct mxc_gpio_port *port, int cnt)
>  
>  	for (i = 0; i < cnt; i++) {
>  		/* disable the interrupt and clear the status */
> -		__raw_writel(0, port[i].base + GPIO_IMR);
> -		__raw_writel(~0, port[i].base + GPIO_ISR);
> +		if (cpu_is_mx28()) {
> +			__raw_writel(0, port[i].base +
> +						GPIO_PIN2IRQ(&port[i]));
> +			__raw_writel(0, port[i].base +
> +						GPIO_IRQEN(&port[i]));
> +			__raw_writel(~0, port[i].base +
> +						GPIO_IRQSTAT(&port[i]) +
> +						CLR_ADDR);
> +		} else {
> +			__raw_writel(0, port[i].base + GPIO_IMR);
> +			__raw_writel(~0, port[i].base + GPIO_ISR);
> +		}
> +
>  		for (j = port[i].virtual_irq_start;
>  			j < port[i].virtual_irq_start + 32; j++) {
>  			set_irq_chip(j, &gpio_irq_chip);
> @@ -338,6 +453,11 @@ int __init mxc_gpio_init(struct mxc_gpio_port *port, int cnt)
>  						mx3_gpio_irq_handler);
>  				set_irq_data(port[i].irq_high, &port[i]);
>  			}
> +		} else if (cpu_is_mx28()) {
> +			/* setup one handler for each entry */
> +			set_irq_chained_handler(port[i].irq,
> +						mx28_gpio_irq_handler);
> +			set_irq_data(port[i].irq, &port[i]);
>  		}
>  	}
>  
> -- 
> 1.7.1
> 
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
