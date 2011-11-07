From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 7 Nov 2011 23:25:53 +0100
Subject: [PATCH 1/3] ARM: pxa: Add DT support to pxa2xx-uart
In-Reply-To: <20111107222429.GE28491@ponder.secretlab.ca>
References: <1320172354-3795-1-git-send-email-marek.vasut@gmail.com>
 <1320172354-3795-2-git-send-email-marek.vasut@gmail.com>
 <20111107222429.GE28491@ponder.secretlab.ca>
Message-ID: <201111072325.53386.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Tue, Nov 01, 2011 at 07:32:32PM +0100, Marek Vasut wrote:
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
> > +	if (*portid >= 4)
> > +		return -ENODEV;
> > +
> > +	/* Check if we're probing compatible ports only! */
> > +	if (of_get_property(np, "marvell,pxa250", NULL))
> 
> This looks wrong.  Compatibility should be based solely on the
> 'compatible' property of the device node.  A separate
> of_get_property() doesn't make much sense.  You can use
> of_device_is_compatible(), or a better option would probably be to use
> of_match_device() so that you can add additional setup data from the
> .data field in the serial_pxa_dt_ids list.
> 
> > +		if (!cpu_is_pxa25x())
> > +			return -EINVAL;
> 
> Do you really want to fail silently here?  If the cpu does not match
> pxa25x, then there is something very wrong with the device tree data
> for the machine.  I would fail loudly with WARN_ON() or dev_err().  :-)

Please see V2 of the patch. I offloaded the responsibility to user, which is how 
it should be.

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
> > 
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
> Doing it this way eliminates the #ifdef:
> 
> 	.of_match_table = of_match_ptr(serial_pxa_dt_ids),

Done in V2
> 
> Otherwise looks good.
> 
> g.

Thanks
M
