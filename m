From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Feb 2016 15:44:44 +0100
Subject: [RFC 3/3] iommu: dma-iommu: use common implementation also on ARM
 architecture
In-Reply-To: <56CEF2E9.5040706@samsung.com>
References: <1455870164-25337-1-git-send-email-m.szyprowski@samsung.com>
 <2724572.qtPjgumFDJ@wuerfel> <56CEF2E9.5040706@samsung.com>
Message-ID: <4895295.FP9RzJmAYS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 February 2016 13:26:17 Marek Szyprowski wrote:
> >> +}
> >> +
> >> +extern void *arch_alloc_from_atomic_pool(size_t size, struct page **ret_page,
> >> +                                     gfp_t flags);
> >> +extern bool arch_in_atomic_pool(void *start, size_t size);
> >> +extern int arch_free_from_atomic_pool(void *start, size_t size);
> >> +
> >> +
> > doesn't feel completely right yet. In particular the arch_flush_page()
> > interface is probably still too specific to ARM/ARM64 and won't work
> > that way on other architectures.
> >
> > I think it would be better to do this either more generic, or less generic:
> >
> > a) leave the iommu_dma_map_ops definition in the architecture specific
> >     code, but make it call helper functions in the drivers/iommu to do all
> >     of the really generic parts.
> >
> > b) clarify that this is only applicable to arch/arm and arch/arm64, and
> >     unify things further between these two, as they have very similar
> >     requirements in the CPU architecture.
> 
> Some really generic parts are already in iommu/dma-iommu.c and one can build
> it's own, non-ARM CPU architecture based IOMMU/DMA-mapping code. Initially I
> also wanted to use that generic code on both ARM and ARM64, but it 
> turned out
> that both archs, ARM and ARM64 will duplicate 99% of code, which use this
> 'generic' functions. This was the reason why I dedided to move all that
> common code from arch/{arm,arm64}/mm/dma-mapping.c to
> drivers/iommu/dma-iommu-ops.c
> 
> I'm not sure if I can design all the changes that need to be made to
> drivers/iommu/dma-iommu-ops.c to make it more generic. Maybe when one will
> try to use that code with other, non-ARM architecture based arch glue code,
> a better abstraction can be developed. For now I would like to keep all this
> code in a common place so both arm and arm64 will benefit from improvements
> done there.

Fair enough. Let's stay with your approach then.

	Arnd
