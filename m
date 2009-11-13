From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Nov 2009 23:19:43 +0000
Subject: [PATCH] [ARM] Kirkwood: Prevent kernel from crashing if PCIe
	bridge is present
In-Reply-To: <200911130850.09903.dk-arm-linux@gmx.de>
References: <200911121519.42786.dk-arm-linux@gmx.de>
	<20091112205528.GA11304@n2100.arm.linux.org.uk>
	<200911130850.09903.dk-arm-linux@gmx.de>
Message-ID: <20091113231943.GA8637@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 13, 2009 at 08:50:09AM +0100, Dieter Kiermaier wrote:
> Am Donnerstag 12 November 2009 21:55:28 schrieb Russell King - ARM Linux:
> > On Thu, Nov 12, 2009 at 03:19:42PM +0100, Dieter Kiermaier wrote:
> > > diff --git a/arch/arm/mach-kirkwood/openrd_base-setup.c b/arch/arm/mach-kirkwood/openrd_base-setup.c
> > > index 77617c7..9e57326 100644
> > > --- a/arch/arm/mach-kirkwood/openrd_base-setup.c
> > > +++ b/arch/arm/mach-kirkwood/openrd_base-setup.c
> > > @@ -14,6 +14,7 @@
> > >  #include <linux/mtd/partitions.h>
> > >  #include <linux/ata_platform.h>
> > >  #include <linux/mv643xx_eth.h>
> > > +#include <asm/io.h>
> > 
> > linux/io.h please (and please ensure future patches similarly use that
> > header rather than asm/io.h).  checkpatch will tell you this.
> 
> Sorry for my stupid question but was is the difference?
> Is it that asm/* provides "architecture specific headers and linux/*
> abstract this on level more from the hardware?

Yes.  Since there is also a general move to propagate stuff out of
architecture files into generic files, it will save hastle later on
if this stuff is already correct.

LDD is sometimes out dated with things like this.  The general advice
here is that for any asm/foo.h, if there exists linux/foo.h then linux/foo.h
should be included instead.  There are exceptions to this, in particular
asm/irq.h and asm/memory.h (since the linux/ equivalents aren't really
to do with these.)
