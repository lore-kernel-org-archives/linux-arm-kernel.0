From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Mar 2016 21:32:07 +0200
Subject: [PATCH 2/3] swiotlb: prefix dma_to_phys and phys_to_dma functions
In-Reply-To: <CACJDEmrzKOExg-Rchjy2hfVzkzbCZ=WNn4Bu3EVgim748VvRig@mail.gmail.com>
References: <1458252137-24497-1-git-send-email-okaya@codeaurora.org>
 <56EC1805.5060207@codeaurora.org>
 <CACJDEmrzKOExg-Rchjy2hfVzkzbCZ=WNn4Bu3EVgim748VvRig@mail.gmail.com>
Message-ID: <6420021.rzhE3kJKJP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 March 2016 14:29:29 Konrad Rzeszutek Wilk wrote:
> > diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> > index ada00c3..8c0f66b 100644
> > --- a/arch/arm64/mm/dma-mapping.c
> > +++ b/arch/arm64/mm/dma-mapping.c
> > @@ -29,6 +29,14 @@
> >
> >  #include <asm/cacheflush.h>
> >
> > +/*
> > + * If you are building a system without IOMMU, then you are using SWIOTLB
> > + * library. The ARM64 adaptation of this library does not support address
> > + * translation and it assumes that physical address = dma address for such
> > + * a use case. Please don't build a platform that violates this.
> > + */
> 
> Why not just expand the ARM64 part to support address translation?

Because so far all hardware we have is relatively sane. We only
need to implement this if someone accidentally puts their DMA
space at the wrong address.

There is at least one platform that could in theory use this because
their RAM starts at an address that is outside of the reach of 32-bit
devices, and a static IOMMU mapping (created by firmware) could be
used to map the start of RAM into DMA address zero, to avoid having
to use an IOMMU all the time, but it was considered not worth the
effort to implement that.

	Arnd
