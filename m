From: cyril@ti.com (Cyril Chemparathy)
Date: Tue, 24 Jul 2012 01:38:26 -0000
Subject: [RFC 19/23] drivers: cma: fix addressing on PAE machines
In-Reply-To: <1343092165-9470-1-git-send-email-cyril@ti.com>
References: <1343092165-9470-1-git-send-email-cyril@ti.com>
Message-ID: <1343092165-9470-20-git-send-email-cyril@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a couple of bugs that otherwise impair CMA functionality on
PAE machines:

  - alignment must be a 64-bit type when running on systems with 64-bit
    physical addresses.  If this is not the case, the limit calculation thunks
    allocations down to an address range < 4G.

  - The allocated range is now being checked using dma_supported() instead of
    hardcoding a 32-bit addressable limit.

Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
Signed-off-by: Cyril Chemparathy <cyril@ti.com>
---
 drivers/base/dma-contiguous.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
index 78efb03..e10bd9a 100644
--- a/drivers/base/dma-contiguous.c
+++ b/drivers/base/dma-contiguous.c
@@ -234,7 +234,7 @@ int __init dma_declare_contiguous(struct device *dev, unsigned long size,
 				  phys_addr_t base, phys_addr_t limit)
 {
 	struct cma_reserved *r = &cma_reserved[cma_reserved_count];
-	unsigned long alignment;
+	phys_addr_t alignment;
 
 	pr_debug("%s(size %lx, base %08lx, limit %08lx)\n", __func__,
 		 (unsigned long)size, (unsigned long)base,
@@ -271,7 +271,7 @@ int __init dma_declare_contiguous(struct device *dev, unsigned long size,
 		if (!addr) {
 			base = -ENOMEM;
 			goto err;
-		} else if (addr + size > ~(unsigned long)0) {
+		} else if (!dma_supported(dev, addr + size)) {
 			memblock_free(addr, size);
 			base = -EINVAL;
 			goto err;
-- 
1.7.9.5
