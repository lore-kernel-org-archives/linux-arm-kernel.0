From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 16 Nov 2016 10:20:13 +0100
Subject: [PATCH] ARM64: dma-mapping: preallocate DMA-debug hash tables in
 core_initcall
References: <CGME20161116092025eucas1p2ebaf3ead7de79130ca2656d532284e5b@eucas1p2.samsung.com>
Message-ID: <1479288013-30945-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fs_initcall is definitely too late to initialize DMA-debug hash tables,
because some drivers might get probed and use DMA mapping framework
already in core_initcall. Late initialization of DMA-debug results in
false warning about accessing memory, that was not allocated. This issue
has been observed on ARM 32bit, but the same driver can be used also on
ARM64.

This patch moves initialization of DMA-debug to core_initcall. This is
safe from the initialization perspective. dma_debug_do_init() internally
calls debugfs functions and debugfs also gets initialised at
core_initcall(), and that is earlier than arch code in the link order,
so it will get initialized just before the DMA-debug.

Reported-by: Seung-Woo Kim <sw0312.kim@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
For more details on this issue, see the patch for ARM 32bit arch:
https://www.spinics.net/lists/arm-kernel/msg542721.html
https://www.spinics.net/lists/arm-kernel/msg542782.html
---
 arch/arm64/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 3f74d0d..8653426 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -538,7 +538,7 @@ static int __init dma_debug_do_init(void)
 	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
 	return 0;
 }
-fs_initcall(dma_debug_do_init);
+core_initcall(dma_debug_do_init);
 
 
 #ifdef CONFIG_IOMMU_DMA
-- 
1.9.1
