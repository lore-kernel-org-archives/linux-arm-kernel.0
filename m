From: thomas.lendacky@amd.com (Tom Lendacky)
Date: Mon, 7 Jul 2014 11:03:03 -0500
Subject: [PATCH] arm64/dma: Flush the coherent mapping in
 __dma_alloc_noncoherent
Message-ID: <20140707160303.30884.66565.stgit@tlendack-t1.amdoffice.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In 3.15 (-rc3) the default arm64 DMA operations changed from coherent
to non-coherent operations. This change broke some devices. The
associated devices were specifying AXI domain and cache coherency
signals equal to write-back, no-allocate. Given that the non-coherent
operations resulted in un-cached operations, the device should have
succeeded even with those cache coherency signals (the DMA should not
have found anything in cache and went to memory). But this was not the
case. Not until the coherent mapping range was flushed did the device
work properly.

In __dma_alloc_noncoherent the allocated memory is flushed but
the coherent mapping is not.  If a device is performing DMA
with non-allocating caching hints (will look in cache, but if
not found will go to memory and not allocate a cache entry) this
could result in unpredictable results.  So flush the coherent
mapping as well.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/arm64/mm/dma-mapping.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 4164c5a..56bdd89 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -120,6 +120,9 @@ static void *__dma_alloc_noncoherent(struct device *dev, size_t size,
 	if (!coherent_ptr)
 		goto no_map;
 
+	/* remove any dirty cache lines on the mapping */
+	__dma_flush_range(coherent_ptr, coherent_ptr + size);
+
 	return coherent_ptr;
 
 no_map:
