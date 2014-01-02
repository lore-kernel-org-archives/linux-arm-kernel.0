From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Jan 2014 16:07:37 +0000
Subject: [PATCH RFC 20/26] ARM: omap: clean up DMA register accesses
In-Reply-To: <1388677778.1871.255.camel@smile>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk>
 <E1VyjwR-0005FH-RH@rmk-PC.arm.linux.org.uk> <1388677778.1871.255.camel@smile>
Message-ID: <20140102160737.GK32243@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 02, 2014 at 05:49:38PM +0200, Andy Shevchenko wrote:
> On Thu, 2014-01-02 at 15:12 +0000, Russell King wrote:
> > We can do much better with this by using a structure to describe each
> > register, rather than code.
> > 
> 
> One comment bellow.
> 
> 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  arch/arm/mach-omap1/dma.c |  121 +++++++++++++++++++++------------------------
> >  arch/arm/mach-omap2/dma.c |   99 ++++++++++++++++++-------------------
> >  include/linux/omap-dma.h  |   13 +++++
> >  3 files changed, 117 insertions(+), 116 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
> > index 11f0b0ee67a3..de30e28ff487 100644
> > --- a/arch/arm/mach-omap1/dma.c
> > +++ b/arch/arm/mach-omap1/dma.c
> > @@ -32,53 +32,52 @@
> >  
> >  #define OMAP1_DMA_BASE			(0xfffed800)
> >  #define OMAP1_LOGICAL_DMA_CH_COUNT	17
> > -#define OMAP1_DMA_STRIDE		0x40
> 
> Does this belong to patch 19/26 ?

Why?

> >  static void __iomem *dma_base;
> >  static inline void dma_write(u32 val, int reg, int lch)
> >  {
> > -	u8  stride;
> > -	u32 offset;
> > +	void __iomem *addr = dma_base;
> >  
> > -	stride = (reg >= CPC) ? OMAP1_DMA_STRIDE : 0;
                                ^^^^^^^^^^^^^^^^
The code here still uses it prior to this patch.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
