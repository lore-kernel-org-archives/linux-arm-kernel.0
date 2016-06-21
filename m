From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 21 Jun 2016 17:06:25 +0100
Subject: [PATCH] arm64: mm: only initialize swiotlb when necessary
In-Reply-To: <3518191.m1tVRlZvU1@wuerfel>
References: <1465372426-4077-1-git-send-email-jszhang@marvell.com>
 <20160608120829.GB16322@e104818-lin.cambridge.arm.com>
 <3518191.m1tVRlZvU1@wuerfel>
Message-ID: <20160621160625.GE14542@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 05:49:59PM +0200, Arnd Bergmann wrote:
> On Wednesday, June 8, 2016 1:08:29 PM CEST Catalin Marinas wrote:
> > On Wed, Jun 08, 2016 at 03:53:46PM +0800, Jisheng Zhang wrote:
> > >  static int __init arm64_dma_init(void)
> > >  {
> > > +     if (swiotlb_force || max_pfn > (arm64_dma_phys_limit >> PAGE_SHIFT))
> > > +             swiotlb = 1;
> > > +
> > >       return atomic_pool_init();
> > >  }
> > 
> > So any platform with RAM larger than 4GB would still initialise swiotlb.
> > I wouldn't say it's an issue, 64MB is not a significant loss on such
> > systems.
> > 
> > An alternative would be to defer the freeing until we are aware of all
> > possible dma masks for the populated devices (e.g. from DT), though I'm
> > not sure that's enough, drivers may try to change such masks when
> > probed.
> 
> Right, this is a hard problem, because you can in theory have odd devices
> that require a DMA mask lower than the limit of ZONE_DMA.

I'm not sure what we can do about such devices even with swiotlb. The
bounce buffer is allocated from ZONE_DMA and currently it assumes a
32-bit mask from the start of RAM, so it is not guaranteed to support a
smaller mask. We may need to come up with some DT memory node attribute
to define the minimum DMA-able memory and restrict ZONE_DMA during early
boot but I would rather wait until we hit a real issue in practice.

Anyway, I plan to merge this patch as is, we can improve the logic in
the future if we have a better idea.

-- 
Catalin
