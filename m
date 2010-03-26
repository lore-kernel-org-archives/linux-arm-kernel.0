From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 26 Mar 2010 11:51:58 -0400 (EDT)
Subject: [PATCH] ARM: fix highmem with VIPT cache and DMA
In-Reply-To: <1269610458.807.49.camel@e102109-lin.cambridge.arm.com>
References: <alpine.LFD.2.00.1003251638030.694@xanadu.home>
	<1269610458.807.49.camel@e102109-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.00.1003261144020.694@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Mar 2010, Catalin Marinas wrote:

> On Thu, 2010-03-25 at 21:02 +0000, Nicolas Pitre wrote:
> > --- a/arch/arm/include/asm/highmem.h
> > +++ b/arch/arm/include/asm/highmem.h
> > @@ -11,7 +11,11 @@
> > 
> >  #define kmap_prot              PAGE_KERNEL
> > 
> > -#define flush_cache_kmaps()    flush_cache_all()
> > +#define flush_cache_kmaps() \
> > +       do { \
> > +               if (cache_is_vivt()) \
> > +                       flush_cache_all(); \
> > +       } while (0)
> 
> Do the aliasing VIPT caches need flushing as well?

No idea.  Highmem is not supported with aliasing VIPT at the moment 
anyway -- see commit 3f973e2216.  I don't have hardware with aliasing 
VIPT cache either.


Nicolas
