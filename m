From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 10 Dec 2013 14:50:34 +0000
Subject: [PATCH 3/3] swiotlb: Add support for CMA allocations
In-Reply-To: <20131210135032.GB29700@mudshark.cambridge.arm.com>
References: <1386634334-31139-1-git-send-email-lauraa@codeaurora.org>
 <1386634334-31139-4-git-send-email-lauraa@codeaurora.org>
 <1da8f502-0e34-4b54-929e-bcbe40b20b7f@email.android.com>
 <52A66211.6010707@codeaurora.org>
 <83dd58eb-9a44-4b76-aa68-4669b26acab8@email.android.com>
 <20131210102555.GB2338@mudshark.cambridge.arm.com>
 <20131210104231.GB2521@darko.cambridge.arm.com>
 <20131210135032.GB29700@mudshark.cambridge.arm.com>
Message-ID: <20131210145033.GB2854@darko.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 01:50:32PM +0000, Will Deacon wrote:
> On Tue, Dec 10, 2013 at 10:42:31AM +0000, Catalin Marinas wrote:
> > On Tue, Dec 10, 2013 at 10:25:56AM +0000, Will Deacon wrote:
> > > On Tue, Dec 10, 2013 at 12:40:20AM +0000, Konrad Rzeszutek Wilk wrote:
> > > > Laura Abbott <lauraa@codeaurora.org> wrote:
> > > > >On 12/9/2013 4:29 PM, Konrad Rzeszutek Wilk wrote:
> > > > >> Can this be done in the platform dma_ops functions instead?
> > > > >
> > > > >I suppose it could but that seems like it would result in lots of 
> > > > >duplicated code if every architecture that uses swiotlb wants to use
> > > > >CMA.
> > > > >
> > > > 
> > > > Then let's do that it that way. Thank you.
> > > 
> > > Note that once arch/arm64 starts growing things like support for non-coherent
> > > DMA and IOMMU mappings, we'll probably want to factor out a bunch of the
> > > boilerplat from our dma-mapping.c file into places like lib/iommu-helper.c.
> > 
> > For coherency, we could build it on top of whatever dma (allocation) ops
> > are registered, whether swiotlb or iommu (see part of
> > https://git.kernel.org/cgit/linux/kernel/git/cmarinas/linux-aarch64.git/commit/?h=devel&id=c67fe405be6b55399c9e53dfeba5e2c6b930e429)
> > 
> > Regarding iommu, I don't think we need CMA on top, so it makes sense to
> > keep the CMA in the swiotlb code.
> 
> I don't think it does; swiotlb doesn't care about things like remapping
> highmem pages returned from CMA, so inlining the code in there just implies
> that we should inline it in all of the dma_ops implementations that might
> want it (although agreed about IOMMU not needing it. I'm thinking about
> things like the non-coherent ops under arch/arm/).

My suggestion was to build coherency on top of the low-level dma
allocation/mapping ops in the arch code by function pointer redirection
or with arch hooks in the dma alloc code (e.g. swiotlb.c) as an
optimisation. Anyway, that's for another thread.

Looking through the arm code, it seems that contiguous allocation can be
triggered when dma_get_attr(DMA_ATTR_FORCE_CONTIGUOUS) independent of
iommu use. At a second thought, this could be useful to reduce the SMMU
TLB pressure for certain devices (not sure about alignment guarantees of
CMA).

If we look at the buffer allocation independent of the actual dma
address generation, I agree that we shouldn't merge CMA into swiotlb.
With swiotlb we get bouncing if needed (I assume this is not required
with CMA). With iommu, the same buffer gets mapped in the device memory
space and we don't actually need to bother with ioremap_page_range(),
just temporary kmap for cache flushing (if highmem).

> Instead, it should either be in a library that they can all use as they see
> fit, or in the code that deals with all of the dma_ops in the architecture
> backend.

For arm64, since we don't need highmem, I'm tempted to just call the
dma_alloc_from_contiguous directly in arch/arm64/mm/dma-mapping.c, the
patch should be a few lines only. We let the code sharing via lib/ to
other 32-bit architectures ;).

-- 
Catalin
