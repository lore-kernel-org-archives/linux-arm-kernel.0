From: dk-arm-linux@gmx.de (Dieter Kiermaier)
Date: Fri, 13 Nov 2009 08:50:09 +0100
Subject: [PATCH] [ARM] Kirkwood: Prevent kernel from crashing if PCIe
	bridge is present
In-Reply-To: <20091112205528.GA11304@n2100.arm.linux.org.uk>
References: <200911121519.42786.dk-arm-linux@gmx.de>
	<20091112205528.GA11304@n2100.arm.linux.org.uk>
Message-ID: <200911130850.09903.dk-arm-linux@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag 12 November 2009 21:55:28 schrieb Russell King - ARM Linux:
> On Thu, Nov 12, 2009 at 03:19:42PM +0100, Dieter Kiermaier wrote:
> > diff --git a/arch/arm/mach-kirkwood/openrd_base-setup.c b/arch/arm/mach-kirkwood/openrd_base-setup.c
> > index 77617c7..9e57326 100644
> > --- a/arch/arm/mach-kirkwood/openrd_base-setup.c
> > +++ b/arch/arm/mach-kirkwood/openrd_base-setup.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/mtd/partitions.h>
> >  #include <linux/ata_platform.h>
> >  #include <linux/mv643xx_eth.h>
> > +#include <asm/io.h>
> 
> linux/io.h please (and please ensure future patches similarly use that
> header rather than asm/io.h).  checkpatch will tell you this.

Sorry for my stupid question but was is the difference?
Is it that asm/* provides "architecture specific headers and linux/*
abstract this on level more from the hardware?

I've taken it form LDD (thanks Alessandro!)  but never thought about it.

> 
> >  #include <asm/mach-types.h>
> >  #include <asm/mach/arch.h>
> >  #include <mach/kirkwood.h>
> > @@ -76,9 +77,19 @@ static void __init openrd_base_init(void)
> >  
> >  static int __init openrd_base_pci_init(void)
> >  {
> > +	u32 cpu_config_reg;
> > +	void __iomem *base;
> > +	base = ioremap(0xf1020100, 4);
> > +	if (base)
> > +	{
> 
> checkpatch will also tell you to put the opening brace on the previous line.
> 

Something new I learned. I've read much docs but everyday there is something new
like checkpatch.pl - sorry for missing that.

Many thanks for commenting,
Dieter

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
