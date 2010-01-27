From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Wed, 27 Jan 2010 15:39:53 +0100
Subject: [PATCH v3] input: MXC: add mxc-keypad driver to support the
	Keypad Port present in the mxc application processors family.
In-Reply-To: <19296.12024.559688.606548@ipc1.ka-ro>
References: <1264586106.2463.23.camel@realization>
	<19296.5728.557535.920849@ipc1.ka-ro>
	<1264594452.2463.62.camel@realization>
	<19296.12024.559688.606548@ipc1.ka-ro>
Message-ID: <1264603193.2463.75.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On mer, 2010-01-27 at 13:18 +0100, Lothar Wa?mann wrote:
> Hi,
> 
> Alberto Panizzo writes:
> > > > +	irq = platform_get_irq(pdev, 0);
> > > > +	if (irq < 0) {
> > > > +		dev_err(&pdev->dev, "failed to get keypad irq\n");
> > > > +		return -ENXIO;
> > > > +	}
> > > >
> > > This should be -ENODEV.
> > > 
> > Lot of reference keyboard driver use -ENXIO..
> > May should be better: return irq ?
> > 
> Yes, of course. If a function returns an error code that should be
> promoted to the caller instead of inventing a new error code.
> 
> 
> Lothar Wa?mann

But, errno.h say:
#define ENXIO           6                // Device not configured
#define ENODEV          19               // Operation not supported by device

And looking at the code of platform_get* these functions return only what
it is written in the platform_device data.
So the only way these functions fails is a not configured platform_device 
with IRQ and I/O memory.

Maybe the error outputs are wrong. What about these:
	if (pdata == NULL) {
		dev_err(&pdev->dev, "no platform data defined\n");
		return -ENXIO;
	}

	irq = platform_get_irq(pdev, 0);
	if (irq < 0) {
		dev_err(&pdev->dev, "no irq defined in platform data\n");
		return -ENXIO;
	}

	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	if (res == NULL) {
		dev_err(&pdev->dev, "no I/O memory defined in platform data\n");
		return -ENXIO;
	}

	res = request_mem_region(res->start, resource_size(res), pdev->name);
	if (res == NULL) {
		dev_err(&pdev->dev, "failed to request I/O memory\n");
		return -EBUSY;
	}
