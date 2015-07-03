From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 3 Jul 2015 11:26:08 +0100
Subject: [PATCH v5] arm DMA: Fix allocation from CMA for coherent DMA
In-Reply-To: <20150703090305.GR7557@n2100.arm.linux.org.uk>
References: <1435699746-21395-1-git-send-email-lorenx4@gmail.com>
 <20150701111251.GA21981@e104818-lin.cambridge.arm.com>
 <20150703090305.GR7557@n2100.arm.linux.org.uk>
Message-ID: <20150703102607.GI25907@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 03, 2015 at 10:03:06AM +0100, Russell King - ARM Linux wrote:
> On Wed, Jul 01, 2015 at 12:12:51PM +0100, Catalin Marinas wrote:
> > On Tue, Jun 30, 2015 at 11:29:06PM +0200, Lorenzo Nava wrote:
> > > This patch allows the use of CMA for DMA coherent memory allocation.
> > > At the moment if the input parameter "is_coherent" is set to true
> > > the allocation is not made using the CMA, which I think is not the
> > > desired behaviour.
> > > 
> > > Signed-off-by: Lorenzo Nava <lorenx4@gmail.com>
> > > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > 
> > If Russell doesn't have any objections, you can send the patch to
> > his patch system. See here for more information:
> 
> I'm left wondering whether this patch is really want Lorenzo wants.
> From my reading of it, while this has the effect of allocating from
> CMA for coherent devices, it's no different from the non-coherent
> case, because by calling __alloc_from_contiguous(), we end up
> remapping the allocated memory, removing the cacheability status
> from the allocated pages.

The arm_coherent_dma_alloc() function is changed by this patch to pass
PAGE_KERNEL as prot, so the cacheability attributes should be preserved.
We have a superfluous __dma_remap() call for lowmem CMA pages which
changes the protection from PAGE_KERNEL to PAGE_KERNEL but, as you
mentioned in another reply, the overhead of CMA is big enough to not
make this noticeable.

The alternative (as I suggested in one of the earlier versions of this
patch) was to change __get_dma_pgprot() to take a "coherent" argument
and return PAGE_KERNEL. But since the coherent mmap was fixed in a
similar way to this patch (and merged already), I gave up on my initial
suggestion.

> This brings up an interesting point: presumably, it's been tested, and
> people are happy with the performance it's giving, inspite of it not
> returning cacheable memory... or maybe it hasn't been tested that much?

It must cacheable memory, otherwise it's not a performance but a data
corruption issue. For example, a cacheable device access may allocate in
an outer cache but non-cacheable CPU access doesn't look into it.

-- 
Catalin
