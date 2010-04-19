From: ra7055@freescale.com (Herring Robert-RA7055)
Date: Mon, 19 Apr 2010 07:53:11 -0700
Subject: [RFC PATCH 08/10] imx: Add MX53 core support
In-Reply-To: <20100418023517.GC7882@pengutronix.de>
References: <1271446524-26450-9-git-send-email-r.herring@freescale.com>
	<20100418023517.GC7882@pengutronix.de>
Message-ID: <DE2504B3A515524BBE6934369EFDC0DA0937E261@az33exm20.fsl.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sasha,

> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer at pengutronix.de] 
> Sent: Saturday, April 17, 2010 9:35 PM
> To: Herring Robert-RA7055
> Cc: linux-arm-kernel at lists.infradead.org; amit.kucheria at canonical.com
> Subject: Re: [RFC PATCH 08/10] imx: Add MX53 core support
> 
> On Fri, Apr 16, 2010 at 02:35:22PM -0500, Rob Herring wrote:
> 
> [snip]
> 
> > +
> > +void __init mx5x_init_irq(void)
> 
> What does the x stand for? Obviously not 1, so how about 
> mx53_init_irq?

All new MX5 chips will have memory map similar to MX53 rather than MX51.
So this function will cover at least MX53 and MX50.

> 
> > +{
> > +	void __iomem *tzic_virt;
> > +
> > +	tzic_virt = ioremap(MX5x_TZIC_BASE_ADDR, SZ_4K);
> > +	if (!tzic_virt)
> > +		panic("unable to map TZIC interrupt controller\n");
> > +	tzic_init_irq(tzic_virt);
> > +}
> > +
> > diff --git a/arch/arm/plat-mxc/devices.c 
> b/arch/arm/plat-mxc/devices.c
> > index 56f2fb5..7c4c722 100644
> > --- a/arch/arm/plat-mxc/devices.c
> > +++ b/arch/arm/plat-mxc/devices.c
> > @@ -20,13 +20,26 @@
> >  #include <linux/init.h>
> >  #include <linux/platform_device.h>
> >  #include <mach/common.h>
> > +#include <mach/hardware.h>
> >  
> >  int __init mxc_register_device(struct platform_device 
> *pdev, void *data)
> >  {
> >  	int ret;
> > +	int i;
> >  
> >  	pdev->dev.platform_data = data;
> >  
> > +	if (cpu_is_mx53()) {
> > +		for (i = 0; i < pdev->num_resources; i++) {
> > +			struct resource *r = &pdev->resource[i];
> > +			if (resource_type(r) != IORESOURCE_MEM)
> > +				continue;
> > +
> > +			r->start = MX5x_FIXUP_ADDR(r->start);
> > +			r->end = MX5x_FIXUP_ADDR(r->end);
> > +		}
> > +	}
> 
> This MX5x_FIXUP_ADDR stuff really looks painful. Please just 
> use proper
> MX53_ defines and use them where appropriate. We can really effort a
> duplicate set of resources when both i.MX51 and i.MX53 support are
> compiled in. You might have a look how Uwe did this in
> arch/arm/mach-mx2/devices.c.
> 

I agree it is a bit ugly, but it is all in effort to run a single kernel
image. It is a 10 line change vs. 100's of lines of code
duplicated/renamed. At that point, the question would be why even put
them in the same mach dir because very little code would be common. MX2
situation is a bit different as the top-level memory map is the same,
but the peripherals are mixed up. Taking the MX2 approach, you will then
have namespace collision with the device names, so all those need to be
renamed too.

What if I make the runtime fix-up only be done when building both chips?

Regards,
Rob
