From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 27 Jan 2010 09:32:21 -0800
Subject: [PATCH v3] input: MXC: add mxc-keypad driver to support the
	Keypad Port present in the mxc application processors family.
In-Reply-To: <19296.29180.633167.456022@ipc1.ka-ro>
References: <1264586106.2463.23.camel@realization>
	<19296.5728.557535.920849@ipc1.ka-ro>
	<1264594452.2463.62.camel@realization>
	<19296.12024.559688.606548@ipc1.ka-ro>
	<1264603193.2463.75.camel@realization>
	<19296.21298.394254.553268@ipc1.ka-ro>
	<1264606159.2463.81.camel@realization>
	<19296.29180.633167.456022@ipc1.ka-ro>
Message-ID: <20100127173221.GA8723@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2010 at 06:03:56PM +0100, Lothar Wa?mann wrote:
> Hi,
> 
> Alberto Panizzo writes:
> > On mer, 2010-01-27 at 15:52 +0100, Lothar Wa?mann wrote:
> > > Hi,
> > > 
> > > Alberto Panizzo writes:
> > > > On mer, 2010-01-27 at 13:18 +0100, Lothar Wa?mann wrote:
> > > > > Hi,
> > > > > 
> > > > > Alberto Panizzo writes:
> > > > > > > > +	irq = platform_get_irq(pdev, 0);
> > > > > > > > +	if (irq < 0) {
> > > > > > > > +		dev_err(&pdev->dev, "failed to get keypad irq\n");
> > > > > > > > +		return -ENXIO;
> > > > > > > > +	}
> > > > > > > >
> > > > > > > This should be -ENODEV.
> > > > > > > 
> > > > > > Lot of reference keyboard driver use -ENXIO..
> > > > > > May should be better: return irq ?
> > > > > > 
> > > > > Yes, of course. If a function returns an error code that should be
> > > > > promoted to the caller instead of inventing a new error code.
> > > > > 
> > > > > 
> > > > > Lothar Wa?mann
> > > > 
> > > > But, errno.h say:
> > > > #define ENXIO           6                // Device not configured
> > > > #define ENODEV          19               // Operation not supported by device
> > > > 
> > > What errno.h file is that?
> > > I have:
> > > ./include/asm-generic/errno-base.h:#define      ENXIO            6      /* No such device or address */
> > > ./include/asm-generic/errno-base.h:#define      ENODEV          19      /* No such device */
> > > 
> > > AFAIK ENXIO is used when actual I/O has been attempted. But in this
> > > case the driver is still being configured and did not do any I/O yet.
> > > 
> > > 
> > > Lothar Wa?mann
> > 
> > The errno.h that I propose is a googled one and the kernel-one do not explain well..
> > Not for fighting, I wont understand.
> > 
> > In drivers/base/platform.c:
> > 
> > /**
> >  * platform_get_irq - get an IRQ for a device
> >  * @dev: platform device
> >  * @num: IRQ number index
> >  */
> > int platform_get_irq(struct platform_device *dev, unsigned int num)
> > {
> > 	struct resource *r = platform_get_resource(dev, IORESOURCE_IRQ, num);
> > 
> > 	return r ? r->start : -ENXIO;
> > }
> > 
> > If there isn't the irq resource asked platform_get_irq return ENXIO.
> > 
> The POSIX spec says:
> |[ENXIO]
> |    No such device or address. Input or output on a special file
> |refers to a device that does not exist, or makes a request beyond the
> |capabilities of the device. It may also occur when, for example, a
> |tape drive is not on-line. 
> 
> http://www.opengroup.org/onlinepubs/000095399/functions/xsh_chap02_03.html
> 

POSIX does not say anything about module loading process so what it says
is not directly applicable in this case.

I think in this particular case ENODEV (your original suggestion) does
not make much sense because the device is there (platform code did create
an instance for us and we are trying to bind to it) but it is
misconfigured. In such cases I am normally leaning towards EINVAL but
ENXIO or, better yet, propagating the error returned by lower levels, is
also good.

Thanks.

-- 
Dmitry
