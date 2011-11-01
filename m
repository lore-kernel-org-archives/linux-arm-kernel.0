From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 1 Nov 2011 21:15:35 +0100
Subject: [PATCH 1/3] ARM: pxa: Add DT support to pxa2xx-uart
In-Reply-To: <4EB04FDF.1030600@gmail.com>
References: <1320172354-3795-1-git-send-email-marek.vasut@gmail.com>
	<1320172354-3795-2-git-send-email-marek.vasut@gmail.com>
	<4EB04FDF.1030600@gmail.com>
Message-ID: <201111012115.35417.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On 11/01/2011 01:32 PM, Marek Vasut wrote:
> > Add device tree binding for PXA2xx UARTs. Tested on Vpac270 board.
> > 
> > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > ---
> > 
> >  drivers/tty/serial/pxa.c |   50
> >  +++++++++++++++++++++++++++++++++++++++++++-- 1 files changed, 47
> >  insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
> > index 531931c..836cbb4 100644
> > --- a/drivers/tty/serial/pxa.c
> > +++ b/drivers/tty/serial/pxa.c
> > @@ -43,6 +43,8 @@
> > 
> >  #include <linux/clk.h>
> >  #include <linux/io.h>
> >  #include <linux/slab.h>
> > 
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > 
> >  struct uart_pxa_port {
> >  
> >  	struct uart_port        port;
> > 
> > @@ -761,11 +763,50 @@ static const struct dev_pm_ops serial_pxa_pm_ops =
> > {
> > 
> >  };
> >  #endif
> > 
> > +#ifdef CONFIG_OF
> > +static struct of_device_id serial_pxa_dt_ids[] = {
> > +	{ .compatible = "marvell,pxa2xx-uart" },
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, serial_pxa_dt_ids);
> > +
> > +static int serial_pxa_probe_dt(struct platform_device *pdev, int
> > *portid) +{
> > +	struct device_node *np = pdev->dev.of_node;
> > +	static int portnum;
> > +
> > +	if (!np)
> > +		return -ENODEV;
> > +
> > +	/* PXA has up to four UART ports */
> > +	*portid = portnum++;
> 
> You have no guarantee of the probe ordering yet are dependent on the
> number later on to set the name.

The probe order should be the one according to the order of ports in DT, right ?
> 
> > +	if (*portid >= 4)
> > +		return -ENODEV;
> > +
> > +	/* Check if we're probing compatible ports only! */
> > +	if (of_get_property(np, "marvell,pxa250", NULL))
> > +		if (!cpu_is_pxa25x())
> > +			return -EINVAL;
> 
> if dev->of_node is set, then you already know you matched against
> marvell,pxa2xx-uart,

Yes, I'm checking if the port has an additional parameter "marvell,pxa250" set, 
which means it should check if the CPU is pxa250.

> 
> > +
> > +	return 0;
> > +}
> > +#else
> > +static inline int serial_pxa_probe_dt(struct platform_device *pdev, int
> > *portid) +{
> > +	return 0;
> > +}
> > +#endif
> > +
> > 
> >  static int serial_pxa_probe(struct platform_device *dev)
> >  {
> >  
> >  	struct uart_pxa_port *sport;
> >  	struct resource *mmres, *irqres;
> >  	int ret;
> > 
> > +	int portid = dev->id;
> > +
> > +	ret = serial_pxa_probe_dt(dev, &portid);
> > +	if (ret == -EINVAL)
> > +		return 0;
> 
> What about non-DT probing when CONFIG_OF is enabled?

Then ret isn't -EINVAL and it should be ok ?

> 
> >  	mmres = platform_get_resource(dev, IORESOURCE_MEM, 0);
> >  	irqres = platform_get_resource(dev, IORESOURCE_IRQ, 0);
> > 
> > @@ -788,12 +829,12 @@ static int serial_pxa_probe(struct platform_device
> > *dev)
> > 
> >  	sport->port.irq = irqres->start;
> >  	sport->port.fifosize = 64;
> >  	sport->port.ops = &serial_pxa_pops;
> > 
> > -	sport->port.line = dev->id;
> > +	sport->port.line = portid;
> > 
> >  	sport->port.dev = &dev->dev;
> >  	sport->port.flags = UPF_IOREMAP | UPF_BOOT_AUTOCONF;
> >  	sport->port.uartclk = clk_get_rate(sport->clk);
> > 
> > -	switch (dev->id) {
> > +	switch (portid) {
> > 
> >  	case 0: sport->name = "FFUART"; break;
> >  	case 1: sport->name = "BTUART"; break;
> >  	case 2: sport->name = "STUART"; break;
> > 
> > @@ -809,7 +850,7 @@ static int serial_pxa_probe(struct platform_device
> > *dev)
> > 
> >  		goto err_clk;
> >  	
> >  	}
> > 
> > -	serial_pxa_ports[dev->id] = sport;
> > +	serial_pxa_ports[portid] = sport;
> > 
> >  	uart_add_one_port(&serial_pxa_reg, &sport->port);
> >  	platform_set_drvdata(dev, sport);
> > 
> > @@ -846,6 +887,9 @@ static struct platform_driver serial_pxa_driver = {
> > 
> >  #ifdef CONFIG_PM
> >  
> >  		.pm	= &serial_pxa_pm_ops,
> >  
> >  #endif
> > 
> > +#ifdef CONFIG_OF
> > +		.of_match_table = serial_pxa_dt_ids,
> > +#endif
> 
> Use recently added of_match_ptr and remove the ifdef.

ACK
> 
> Rob

Cheers
