From: mike@compulab.co.il (Mike Rapoport)
Date: Sun, 20 Dec 2009 10:18:31 +0200
Subject: [PATCH] ARM: dmabounce: fix build
Message-ID: <4B2DDDD7.9030500@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit f74f7e57ae9fa12b2951ae62ce3557799b318399 (ARM: use
flush_kernel_dcache_area() for dmabounce) has broken dmabounce build:

  CC      arch/arm/common/dmabounce.o
arch/arm/common/dmabounce.c: In function 'unmap_single':
arch/arm/common/dmabounce.c:315: error: implicit declaration of function '__cpuc_flush_kernel_dcache_area'
make[2]: *** [arch/arm/common/dmabounce.o] Error 1

Fix it.

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/common/dmabounce.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index bc90364..cc32c1e 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -312,7 +312,7 @@ static inline void unmap_single(struct device *dev, dma_addr_t dma_addr,
 			 * we need to ensure that the data will be coherent
 			 * with user mappings.
 			 */
-			__cpuc_flush_kernel_dcache_area(ptr, size);
+			__cpuc_flush_dcache_area(ptr, size);
 		}
 		free_safe_buffer(dev->archdata.dmabounce, buf);
 	}
-- 
1.6.0.6


-- 
Sincerely yours,
Mike.
