From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 30 Sep 2011 22:32:02 +0800
Subject: [PATCH v4 6/7] arm/imx6q: add device tree machine support
In-Reply-To: <20110930090156.GS17204@pulham.picochip.com>
References: <1317200808-6275-1-git-send-email-shawn.guo@linaro.org>
	<1317200808-6275-7-git-send-email-shawn.guo@linaro.org>
	<20110930090156.GS17204@pulham.picochip.com>
Message-ID: <20110930143201.GF19807@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2011 at 10:01:56AM +0100, Jamie Iles wrote:
> Hi Shawn,
> 
> On Wed, Sep 28, 2011 at 05:06:47PM +0800, Shawn Guo wrote:
> > It adds generic device tree based machine support for imx6q.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> [...]
> > diff --git a/arch/arm/mach-imx/mach-imx6q.c 
> > b/arch/arm/mach-imx/mach-imx6q.c
> > new file mode 100644
> > index 0000000..8bf5fa3
> > --- /dev/null
> > +++ b/arch/arm/mach-imx/mach-imx6q.c
> [...]
> > +static void __init imx6q_gpio_add_irq_domain(struct device_node *np,
> > +				struct device_node *interrupt_parent)
> > +{
> > +	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS -
> > +				   32 * 7; /* imx6q gets 7 gpio ports */
> > +
> > +	irq_domain_add_simple(np, gpio_irq_base);
> > +	gpio_irq_base += 32;
> 
> Doesn't this rely on imx6q_gpio_add_irq_domain() being called for each 
> gpio bank in the order that they appear in the device tree (and that the 
> dt is correctly ordered)?
> 
Not really.  In case of DT, gpio core will dynamically assign gpio
range from the end of total number (MXC_GPIO_IRQ_START + ARCH_NR_GPIOS
for imx case) for each gpio bank that gets probed.  Supposing we have
gpio0 ~ gpio6 sorted in dts, we will have the following gpio ranges
assigned by gpio core.

 gpio0: MXC_GPIO_IRQ_START + ARCH_NR_GPIOS - 32
 gpio1: MXC_GPIO_IRQ_START + ARCH_NR_GPIOS - 32 * 2
 ...
 gpio6: MXC_GPIO_IRQ_START + ARCH_NR_GPIOS - 32 * 7

Regards,
Shawn

> > +}
> > +
> > +static const struct of_device_id imx6q_irq_match[] __initconst = {
> > +	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
> > +	{ .compatible = "fsl,imx6q-gpio", .data = imx6q_gpio_add_irq_domain, },
> > +	{ /* sentinel */ }
> > +};
> > +
> > +static void __init imx6q_init_irq(void)
> > +{
> > +	l2x0_of_init(0, ~0UL);
> > +	imx_src_init();
> > +	imx_gpc_init();
> > +	of_irq_init(imx6q_irq_match);
> > +}
