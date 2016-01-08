From: dianders@chromium.org (Douglas Anderson)
Date: Thu,  7 Jan 2016 16:36:45 -0800
Subject: [PATCH v4 3/3] ARM: dma-mapping: Use DMA_ATTR_NOHUGEPAGE hint to
 optimize allocation
In-Reply-To: <1452213405-22942-1-git-send-email-dianders@chromium.org>
References: <1452213405-22942-1-git-send-email-dianders@chromium.org>
Message-ID: <1452213405-22942-4-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we know that TLB efficiency will not be an issue when memory is
accessed then it's not terribly important to allocate big chunks of
memory.  The whole point of allocating the big chunks was that it would
make TLB usage efficient.

As Marek Szyprowski indicated:
    Please note that mapping memory with larger pages significantly
    improves performance, especially when IOMMU has a little TLB
    cache. This can be easily observed when multimedia devices do
    processing of RGB data with 90/270 degree rotation
Image rotation is distinctly an operation that needs to bounce around
through memory, so it makes sense that TLB efficiency is important
there.

Video decoding, on the other hand, is a fairly sequential operation.
During video decoding it's not expected that we'll be jumping all over
memory.  Decoding video is also pretty heavy and the TLB misses aren't a
huge deal.  Presumably most HW video acceleration users of dma-mapping
will not care about huge pages and will set DMA_ATTR_NOHUGEPAGE.

Allocating big chunks of memory is quite expensive, especially if we're
doing it repeadly and memory is full.  In one (out of tree) usage model
it is common that arm_iommu_alloc_attrs() is called 16 times in a row,
each one trying to allocate 4 MB of memory.  This is called whenever the
system encounters a new video, which could easily happen while the
memory system is stressed out.  In fact, on certain social media
websites that auto-play video and have infinite scrolling, it's quite
common to see not just one of these 16x4MB allocations but 2 or 3 right
after another.  Asking the system even to do a small amount of extra
work to give us big chunks in this case is just not a good use of time.

Allocating big chunks of memory is also expensive indirectly.  Even if
we ask the system not to do ANY extra work to allocate _our_ memory,
we're still potentially eating up all big chunks in the system.
Presumably there are other users in the system that aren't quite as
flexible and that actually need these big chunks.  By eating all the big
chunks we're causing extra work for the rest of the system.  We also may
start making other memory allocations fail.  While the system may be
robust to such failures (as is the case with dwc2 USB trying to allocate
buffers for Ethernet data and with WiFi trying to allocate buffers for
WiFi data), it is yet another big performance hit.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
Changes in v4:
- renamed DMA_ATTR_SEQUENTIAL to DMA_ATTR_NOHUGEPAGE
- added Marek's ack

Changes in v3:
- Use DMA_ATTR_SEQUENTIAL hint patch new for v3.

Changes in v2: None

 arch/arm/mm/dma-mapping.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index bc9cebfa0891..96d71bcb4c3a 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1158,6 +1158,10 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 		return pages;
 	}
 
+	/* Go straight to 4K chunks if caller says it's OK. */
+	if (dma_get_attr(DMA_ATTR_NOHUGEPAGE, attrs))
+		order_idx = ARRAY_SIZE(iommu_order_array) - 1;
+
 	/*
 	 * IOMMU can map any pages, so himem can also be used here
 	 */
-- 
2.6.0.rc2.230.g3dd15c0
