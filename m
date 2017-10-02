From: matthieu.castet@parrot.com (Matthieu CASTET)
Date: Mon,  2 Oct 2017 15:01:55 +0200
Subject: [PATCH] [DEV] dma mapping : export caller to vmallocinfo
Message-ID: <20171002130155.19325-1-matthieu.castet@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For example on arm64 board, this add info to "user" entries in vmallocinfo

Before :
[...]
0xffffff8008997000 0xffffff80089d8000 266240 user
[...]

Afer :
[...]
0xffffff8008997000 0xffffff80089d8000 266240 atomic_pool_init+0x0/0x1d8 user
[...]

This help to debug mapping issues, and is consistent with others entries
(ioremap, vmalloc, ...) that already provide caller.

Signed-off-by: Matthieu CASTET <matthieu.castet@parrot.com>
---
 arch/arm64/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 614af886b7ef..115b32639a3c 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -166,7 +166,7 @@ static void *__dma_alloc(struct device *dev, size_t size,
 	/* create a coherent mapping */
 	page = virt_to_page(ptr);
 	coherent_ptr = dma_common_contiguous_remap(page, size, VM_USERMAP,
-						   prot, NULL);
+						   prot, __builtin_return_address(0));
 	if (!coherent_ptr)
 		goto no_map;
 
-- 
2.14.2
