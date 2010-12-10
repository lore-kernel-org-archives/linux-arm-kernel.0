From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 10 Dec 2010 11:24:16 +0100
Subject: [PATCH v5 07/15] ARM: mxs: Add gpio support
In-Reply-To: <1291968402-19393-2-git-send-email-shawn.guo@freescale.com>
References: <1291968402-19393-1-git-send-email-shawn.guo@freescale.com>
	<1291968402-19393-2-git-send-email-shawn.guo@freescale.com>
Message-ID: <20101210102416.GH17441@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Fri, Dec 10, 2010 at 04:06:40PM +0800, Shawn Guo wrote:
> +	/* set level or edge */
> +	if (edge & GPIO_INT_LEV_MASK)
> +		__raw_writel(1 << (gpio & 31),
> +			port->base + PINCTRL_IRQLEV(port->id) + MXS_SET_ADDR);
> +	else
> +		__raw_writel(1 << (gpio & 31),
> +			port->base + PINCTRL_IRQLEV(port->id) + MXS_CLR_ADDR);
Is this preferable?:

	__raw_writel(1 << (gpio & 31), port->base + PINCTRL_IRQLEV(port->id) +
		(edge & GPIO_INT_LEV_MASK ? MXS_SET_ADDR : MXS_CLR_ADDR))

.  I'm not sure.  And if you like my __raw_setl/__raw_clearl (or
__raw_clrl?) suggestion this won't work though.  If you don't, I'd
prefer to be easily able to see that the two commands only differ by
MXS_SET_ADDR vs. MXS_CLR_ADDR.

e.g.

	u32 nicename = 1 << (gpio & 31);
	correcttype addr = port->base + PINCTRL_IRQLEV(port->id);

	if (edge & GPIO_INT_LEV_MASK)
		__raw_writel(nicename, addr + MXS_SET_ADDR);
	else
		__raw_writel(nicename, addr + MXS_CLR_ADDR);

> +	/* set polarity */
> +	if (edge & GPIO_INT_POL_MASK)
> +		__raw_writel(1 << (gpio & 31),
> +			port->base + PINCTRL_IRQPOL(port->id) + MXS_SET_ADDR);
> +	else
> +		__raw_writel(1 << (gpio & 31),
> +			port->base + PINCTRL_IRQPOL(port->id) + MXS_CLR_ADDR);
ditto.  You can even reuse nicename here.

> +
> +	_clear_gpio_irqstatus(port, gpio & 0x1f);
> +
> +	return 0;
> +}
> +
> +/* MXS has one interrupt *per* gpio port */
> +static void mxs_gpio_irq_handler(u32 irq, struct irq_desc *desc)
> +{
> +	u32 irq_stat;
> +	struct mxs_gpio_port *port = (struct mxs_gpio_port *)get_irq_data(irq);
> +	u32 gpio_irq_no_base = port->virtual_irq_start;
> +
> +	irq_stat = __raw_readl(port->base + PINCTRL_IRQSTAT(port->id)) &
> +			__raw_readl(port->base + PINCTRL_IRQEN(port->id)) &
> +			__raw_readl(port->base + PINCTRL_PIN2IRQ(port->id));
I think now a bit set in PINCTRL_IRQEN implies the same bit set in
PINCTRL_PIN2IRQ, doesn't it?  If so, & PINCTRL_PIN2IRQ doesn't add any
value.

> +static void _set_gpio_direction(struct gpio_chip *chip, unsigned offset,
> +				int dir)
mxs_gpio_direction_set would better match the naming scheme of
mxs_gpio_direction_input and mxs_gpio_direction_output.  (If you ask me,
don't use leading underscores in .c files, static is enough to signal
the function to be private.)

> +{
> +	struct mxs_gpio_port *port =
> +		container_of(chip, struct mxs_gpio_port, chip);
> +
> +	if (dir)
> +		__raw_writel(1 << offset,
> +			port->base + PINCTRL_DOE(port->id) + MXS_SET_ADDR);
> +	else
> +		__raw_writel(1 << offset,
> +			port->base + PINCTRL_DOE(port->id) + MXS_CLR_ADDR);
as above, at least give a name for port->base + PINCTRL_DOE(port->id).

> +int __init mxs_gpio_init(struct mxs_gpio_port *port, int cnt)
> +{
> +	int i, j;
> +
> +	/* save for local usage */
> +	mxs_gpio_ports = port;
> +	gpio_table_size = cnt;
> +
> +	pr_info("MXS GPIO hardware\n");
> +
> +	for (i = 0; i < cnt; i++) {
> +		/* disable the interrupt and clear the status */
> +		__raw_writel(0, port[i].base +
> +				PINCTRL_PIN2IRQ(i));
> +		__raw_writel(0, port[i].base +
> +				PINCTRL_IRQEN(i));
> +		__raw_writel(~0, port[i].base +
> +				PINCTRL_IRQSTAT(i) + MXS_CLR_ADDR);
Why not __raw_writel(0, port[i].base + PINCTRL_IRQSTAT(i)) ?
(And note that applying ~ on a signed integer isn't portable in
general.  For all sane archs this is the same as ~0U though and ARM is
sane (here), still I think it's good to be aware of such things and
avoid them if easily possible.)

> +		/* its a serious configuration bug when it fails */
> +		BUG_ON( gpiochip_add(&port[i].chip) < 0 );
> +
> +		/* setup one handler for each entry */
> +		set_irq_chained_handler(port[i].irq, mxs_gpio_irq_handler);
> +		set_irq_data(port[i].irq, &port[i]);
I think it's saver to first setup the irq stuff and only then register
the gpiochip.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
