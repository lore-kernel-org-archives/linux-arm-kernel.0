From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Sat, 14 Aug 2010 18:30:37 +0900
Subject: ARM: 2.6.3[45] PCI regression (IXP4xx and PXA?)
In-Reply-To: <20100813215413.GA21607@n2100.arm.linux.org.uk>
References: <20100811072532.GA21511@n2100.arm.linux.org.uk>
	<20100813152224H.fujita.tomonori@lab.ntt.co.jp>
	<20100813215413.GA21607@n2100.arm.linux.org.uk>
Message-ID: <20100814181306U.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Aug 2010 22:54:13 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Fri, Aug 13, 2010 at 03:23:53PM +0900, FUJITA Tomonori wrote:
> > On Wed, 11 Aug 2010 08:25:32 +0100
> > Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > > It doesn't break dmabounce.
> > > 
> > > What it breaks is the fact that a PCI device which can do 32-bit DMA is
> > > connected to a PCI bus which can only access the first 64MB of memory
> > > through the host bridge, but the system has more than 64MB available.
> > > 
> > > Allowing a 32-bit DMA mask means that dmabounce can't detect that memory
> > > above 64MB needs to be bounced to memory below the 64MB boundary.
> > 
> > But dmabounce doesn't look at dev->coherent_dma_mask.
> > 
> > The change breaks __dma_alloc_buffer()? If we set dev->coherent_dma_mask
> > to DMA_BIT_MASK(32) for ixp4xx's pci devices, __dma_alloc_buffer()
> > doesn't use GFP_DMA.
> 
> With an incorrect coherent_dma_mask, dma_alloc_coherent() will return
> memory outside of the 64MB window.

Yeah, that's what I wrote above, I think.


>  This means that when dmabounce comes to allocate the replacement
> buffer, it gets a buffer which won't be accessible to the DMA
> controller

Really? looks like dmabounce does nothing for coherent memory that
dma_alloc_coherent() allocates.

The following very hacky patch works?

Or we could introduce something like ARCH_HAS_DMA_SET_COHERENT_MASK to
let architectures to have dma_set_coherent_mask.

A long solution would be having two dma_mask for a device and a
bus. We also need something to represent a DMA-capable range instead
of the dma mask.

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index c704eed..2a3fc2e 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -77,6 +77,11 @@ static struct page *__dma_alloc_buffer(struct device *dev, size_t size, gfp_t gf
 	if (mask < 0xffffffffULL)
 		gfp |= GFP_DMA;
 
+#ifdef CONFIG_DMABOUNCE
+	if (dev->archdata.dmabounce)
+		gfp |= GFP_DMA;
+#endif
+
 	page = alloc_pages(gfp, order);
 	if (!page)
 		return NULL;
