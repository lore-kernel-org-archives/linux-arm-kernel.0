From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 19 Mar 2014 18:00:04 -0400 (EDT)
Subject: [PATCH 37/62] ARM: sa1100/pxa: fix MTD_XIP build
In-Reply-To: <20140319201255.GI7528@n2100.arm.linux.org.uk>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-38-git-send-email-arnd@arndb.de>
 <20140319201255.GI7528@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.11.1403191758240.1291@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Mar 2014, Russell King - ARM Linux wrote:

> On Wed, Mar 19, 2014 at 08:29:34PM +0100, Arnd Bergmann wrote:
> > In commit 3169663ac5902 "ARM: sa11x0/pxa: convert OS timer registers
> > to IOMEM", the definition of the OSCR macro was changed to be an
> > __iomem pointer, but the same register is also used by the XIP
> > code. This patch does the corresponding change here as well.
> > 
> > Since PXA now uses a local variable for the base address of the
> > ICIP register, the xip_irqpending function has to be moved
> > into irq.c in the process.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > ---
> >  arch/arm/mach-pxa/include/mach/mtd-xip.h    | 7 ++++---
> >  arch/arm/mach-pxa/irq.c                     | 8 ++++++++
> >  arch/arm/mach-sa1100/include/mach/mtd-xip.h | 4 ++--
> >  3 files changed, 14 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm/mach-pxa/include/mach/mtd-xip.h b/arch/arm/mach-pxa/include/mach/mtd-xip.h
> > index 990d2bf..c4c90d1 100644
> > --- a/arch/arm/mach-pxa/include/mach/mtd-xip.h
> > +++ b/arch/arm/mach-pxa/include/mach/mtd-xip.h
> > @@ -17,11 +17,12 @@
> >  
> >  #include <mach/regs-ost.h>
> >  
> > -#define xip_irqpending()	(ICIP & ICMR)
> > +extern bool xip_irqpending(void);
> >  
> >  /* we sample OSCR and convert desired delta to usec (1/4 ~= 1000000/3686400) */
> > -#define xip_currtime()		(OSCR)
> > -#define xip_elapsed_since(x)	(signed)((OSCR - (x)) / 4)
> > +#define xip_irqpending()	xip_irqpending()
> > +#define xip_currtime()		readl(OSCR)
> > +#define xip_elapsed_since(x)	(signed)((readl(OSCR) - (x)) / 4)
> 
> I don't think you can do that.  I believe xip_irqpending() has to be
> inline so that the XIP code (located in RAM) can detect when an
> interrupt is pending, suspend the MTD operation, switch the MTD back
> to read mode, and then allow the kernel to run.
> 
> I'd be nervous about this without Nicolas checking it, or it being
> built and the resulting assembly inspected.

At the very minimum, xip_irqpending() should be marked with the __xipram 
attribute.


Nicolas
