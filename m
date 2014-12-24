From: m-karicheri2@ti.com (Murali Karicheri)
Date: Wed, 24 Dec 2014 16:56:50 -0500
Subject: [PATCH] dma-mapping: fix size when of_dma_get_range() fails
Message-ID: <1419458210-4079-1-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When call to of_dma_get_range() fails, the code currently set size
to dev->coherent_dma_mask instead of dev->coherent_dma_mask + 1. Fix this
to make the code consistent with the case when size is obtained from
dma-range property.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/of/platform.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index a54ec10..af9aef1 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -185,7 +185,7 @@ static void of_dma_configure(struct device *dev)
 	ret = of_dma_get_range(dev->of_node, &dma_addr, &paddr, &size);
 	if (ret < 0) {
 		dma_addr = offset = 0;
-		size = dev->coherent_dma_mask;
+		size = dev->coherent_dma_mask + 1;
 	} else {
 		offset = PFN_DOWN(paddr - dma_addr);
 		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
-- 
1.7.9.5
