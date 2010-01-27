From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Wed, 27 Jan 2010 16:29:19 +0100
Subject: [PATCH v3] input: MXC: add mxc-keypad driver to support the
	Keypad Port present in the mxc application processors family.
In-Reply-To: <19296.21298.394254.553268@ipc1.ka-ro>
References: <1264586106.2463.23.camel@realization>
	<19296.5728.557535.920849@ipc1.ka-ro>
	<1264594452.2463.62.camel@realization>
	<19296.12024.559688.606548@ipc1.ka-ro>
	<1264603193.2463.75.camel@realization>
	<19296.21298.394254.553268@ipc1.ka-ro>
Message-ID: <1264606159.2463.81.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On mer, 2010-01-27 at 15:52 +0100, Lothar Wa?mann wrote:
> Hi,
> 
> Alberto Panizzo writes:
> > On mer, 2010-01-27 at 13:18 +0100, Lothar Wa?mann wrote:
> > > Hi,
> > > 
> > > Alberto Panizzo writes:
> > > > > > +	irq = platform_get_irq(pdev, 0);
> > > > > > +	if (irq < 0) {
> > > > > > +		dev_err(&pdev->dev, "failed to get keypad irq\n");
> > > > > > +		return -ENXIO;
> > > > > > +	}
> > > > > >
> > > > > This should be -ENODEV.
> > > > > 
> > > > Lot of reference keyboard driver use -ENXIO..
> > > > May should be better: return irq ?
> > > > 
> > > Yes, of course. If a function returns an error code that should be
> > > promoted to the caller instead of inventing a new error code.
> > > 
> > > 
> > > Lothar Wa?mann
> > 
> > But, errno.h say:
> > #define ENXIO           6                // Device not configured
> > #define ENODEV          19               // Operation not supported by device
> > 
> What errno.h file is that?
> I have:
> ./include/asm-generic/errno-base.h:#define      ENXIO            6      /* No such device or address */
> ./include/asm-generic/errno-base.h:#define      ENODEV          19      /* No such device */
> 
> AFAIK ENXIO is used when actual I/O has been attempted. But in this
> case the driver is still being configured and did not do any I/O yet.
> 
> 
> Lothar Wa?mann

The errno.h that I propose is a googled one and the kernel-one do not explain well..
Not for fighting, I wont understand.

In drivers/base/platform.c:

/**
 * platform_get_irq - get an IRQ for a device
 * @dev: platform device
 * @num: IRQ number index
 */
int platform_get_irq(struct platform_device *dev, unsigned int num)
{
	struct resource *r = platform_get_resource(dev, IORESOURCE_IRQ, num);

	return r ? r->start : -ENXIO;
}

If there isn't the irq resource asked platform_get_irq return ENXIO.

Alberto
