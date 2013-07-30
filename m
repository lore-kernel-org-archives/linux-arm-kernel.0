From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 30 Jul 2013 10:39:29 +0200
Subject: [RFC 2/8] gpio: mxc: Support for initialization as submodule
In-Reply-To: <20130730034354.GF19715@S2101-09.ap.freescale.net>
References: <1374938808-27316-1-git-send-email-mpa@pengutronix.de>
 <1374938808-27316-3-git-send-email-mpa@pengutronix.de>
 <20130730034354.GF19715@S2101-09.ap.freescale.net>
Message-ID: <20130730083929.GI16871@s25.your-server.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 11:43:57AM +0800, Shawn Guo wrote:
> On Sat, Jul 27, 2013 at 05:26:42PM +0200, Markus Pargmann wrote:
> > On imx27 and imx21, there is no clear seperation between iomux control
> > registers and GPIO data registers. For easier pingroup definitions, the
> > gpio drivers will be initialized as subnodes of the iomux controller. It
> > is necessary to share the registers between iomux and gpio.
> > 
> > This patch adds support to pass a register memory region via platform
> > data.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  drivers/gpio/gpio-mxc.c  | 35 +++++++++++++++++++----------------
> >  include/linux/gpio-mxc.h | 17 +++++++++++++++++
> >  2 files changed, 36 insertions(+), 16 deletions(-)
> >  create mode 100644 include/linux/gpio-mxc.h
> 
> Since the header is created only for holding platform_data, we should
> probably put it into include/linux/platform_data/.

Yes, I moved the header to include/linux/platform_data/gpio-mxc.h.

> > 
> > diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
> > index cee040f..0c4e32c 100644
> > --- a/drivers/gpio/gpio-mxc.c
> > +++ b/drivers/gpio/gpio-mxc.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/irqdomain.h>
> >  #include <linux/irqchip/chained_irq.h>
> >  #include <linux/gpio.h>
> > +#include <linux/gpio-mxc.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/slab.h>
> >  #include <linux/basic_mmio_gpio.h>
> > @@ -400,6 +401,7 @@ static int mxc_gpio_probe(struct platform_device *pdev)
> >  	struct device_node *np = pdev->dev.of_node;
> >  	struct mxc_gpio_port *port;
> >  	struct resource *iores;
> > +	struct mxc_gpio_platform_data *pdata = pdev->dev.platform_data;
> >  	int irq_base;
> >  	int err;
> >  
> > @@ -410,27 +412,28 @@ static int mxc_gpio_probe(struct platform_device *pdev)
> >  	if (!port)
> >  		return -ENOMEM;
> >  
> > -	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	if (!iores) {
> > -		return -ENODEV;
> > -	}
> > -
> > -	if (!devm_request_mem_region(&pdev->dev, iores->start,
> > -				resource_size(iores), pdev->name)) {
> > -		return -EBUSY;
> > -	}
> > -
> > -	port->base = devm_ioremap(&pdev->dev, iores->start,
> > -			resource_size(iores));
> > -	if (!port->base) {
> > -		return -ENOMEM;
> > +	if (pdata) {
> > +		port->base = pdata->base;
> > +		iores = NULL;
> 
> Why is this needed?

The memory regions used for iomux control overlap the regions used by
the gpio driver. So we need to share the memory with the pinctrl driver.

> 
> > +	} else {
> > +		iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +		if (!iores)
> > +			return -ENODEV;
> > +
> > +		if (!devm_request_mem_region(&pdev->dev, iores->start,
> > +					resource_size(iores), pdev->name))
> > +			return -EBUSY;
> > +
> > +		port->base = devm_ioremap(&pdev->dev, iores->start,
> > +				resource_size(iores));
> > +		if (!port->base)
> > +			return -ENOMEM;
> >  	}
> >  
> >  	port->irq_high = platform_get_irq(pdev, 1);
> >  	port->irq = platform_get_irq(pdev, 0);
> > -	if (port->irq < 0) {
> > +	if (port->irq < 0)
> >  		return -EINVAL;
> > -	}
> 
> The change belongs to patch #1.

Removed from this patch.

Thanks,

Markus

> 
> Shawn
> 
> >  
> >  	/* disable the interrupt and clear the status */
> >  	writel(0, port->base + GPIO_IMR);
> > diff --git a/include/linux/gpio-mxc.h b/include/linux/gpio-mxc.h
> > new file mode 100644
> > index 0000000..6be51bc
> > --- /dev/null
> > +++ b/include/linux/gpio-mxc.h
> > @@ -0,0 +1,17 @@
> > +#ifndef _LINUX_GPIO_MXC_H
> > +#define _LINUX_GPIO_MXC_H
> > +
> > +#include <linux/types.h>
> > +
> > +/*
> > + * MXC GPIO driver platform data. If this platform data is passed to the
> > + * driver, it will use the memory base defined in the struct. This is used for
> > + * iomuxc drivers on imx21 and imx27, where the GPIO data register is embedded
> > + * between the iomuxc registers.
> > + */
> > +
> > +struct mxc_gpio_platform_data {
> > +	void __iomem *base;
> > +};
> > +
> > +#endif /* _LINUX_GPIO_MXC_H */
> > -- 
> > 1.8.3.2
> > 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
