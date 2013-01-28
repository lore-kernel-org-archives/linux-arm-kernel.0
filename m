From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 28 Jan 2013 19:58:52 +0800
Subject: [PATCH] ARM: mxs: gpio-mxs: Add IRQ_TYPE_EDGE_BOTH support
In-Reply-To: <1359306248-28690-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1359306248-28690-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <20130128115850.GF31689@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 27, 2013 at 06:04:08PM +0100, Gwenhael Goavec-Merou wrote:
> This patch adds support for IRQ_TYPE_EDGE_BOTH needed for some driver
> (gpio-keys).
> Inspired from gpio-mxc.c
> 
> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
> ---
>  drivers/gpio/gpio-mxs.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
> index fa2a63c..7690eec 100644
> --- a/drivers/gpio/gpio-mxs.c
> +++ b/drivers/gpio/gpio-mxs.c
> @@ -65,6 +65,7 @@ struct mxs_gpio_port {
>  	struct irq_domain *domain;
>  	struct bgpio_chip bgc;
>  	enum mxs_gpio_id devid;
> +	u32 both_edges;
>  };
>  
>  static inline int is_imx23_gpio(struct mxs_gpio_port *port)
> @@ -81,13 +82,24 @@ static inline int is_imx28_gpio(struct mxs_gpio_port *port)
>  
>  static int mxs_gpio_set_irq_type(struct irq_data *d, unsigned int type)
>  {
> +	u32 val;
>  	u32 pin_mask = 1 << d->hwirq;
> +	u32 gpio_idx = d->hwirq;

This does not really needed, since what you need in the code below is
all about pin_mask.

>  	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
>  	struct mxs_gpio_port *port = gc->private;
>  	void __iomem *pin_addr;
>  	int edge;
>  
> +	port->both_edges &= ~(1 << gpio_idx);
>  	switch (type) {
> +	case IRQ_TYPE_EDGE_BOTH:
> +		val = gpio_get_value(port->bgc.gc.base + gpio_idx);
> +		if (val)
> +			edge = GPIO_INT_LOW_LEV;
> +		else
> +			edge = GPIO_INT_HIGH_LEV;

I do not quite understand this.  Why do you need to set LEVEL in case
of EDGE_BOTH?

> +		port->both_edges |= 1 << gpio_idx;
> +		break;
>  	case IRQ_TYPE_EDGE_RISING:
>  		edge = GPIO_INT_RISE_EDGE;
>  		break;
> @@ -123,6 +135,22 @@ static int mxs_gpio_set_irq_type(struct irq_data *d, unsigned int type)
>  
>  	return 0;
>  }

Have a new line here, please.

> +static void mxs_flip_edge(struct mxs_gpio_port *port, u32 gpio)
> +{
> +	u32 bit, val, edge;
> +	void __iomem *pin_addr;
> +
> +	bit = 1<<gpio;

Nit: Have space before << and after, please.

> +
> +	pin_addr = port->base + PINCTRL_IRQPOL(port);
> +	val = readl(pin_addr);
> +	edge = val&bit;

Ditto

Shawn

> +
> +	if (edge)
> +		writel(bit, pin_addr + MXS_CLR);
> +	else
> +		writel(bit, pin_addr + MXS_SET);
> +}
>  
>  /* MXS has one interrupt *per* gpio port */
>  static void mxs_gpio_irq_handler(u32 irq, struct irq_desc *desc)
> @@ -137,6 +165,9 @@ static void mxs_gpio_irq_handler(u32 irq, struct irq_desc *desc)
>  
>  	while (irq_stat != 0) {
>  		int irqoffset = fls(irq_stat) - 1;
> +		if (port->both_edges & (1 << irqoffset))
> +			mxs_flip_edge(port, irqoffset);
> +
>  		generic_handle_irq(irq_find_mapping(port->domain, irqoffset));
>  		irq_stat &= ~(1 << irqoffset);
>  	}
> -- 
> 1.7.12.4
> 
