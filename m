From: b42378@freescale.com (Nicolin Chen)
Date: Fri, 1 Nov 2013 19:36:03 +0800
Subject: [PATCH 5/8] uio: uio_pruss: use gen_pool_dma_alloc() to allocate sram
 memory
In-Reply-To: <cover.1383303752.git.b42378@freescale.com>
References: <cover.1383303752.git.b42378@freescale.com>
Message-ID: <f26a7fd466d22aaaeae9cf32d3c4c43c333e0b35.1383303752.git.b42378@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since gen_pool_dma_alloc() is introduced, we implement it to simplify code.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 drivers/uio/uio_pruss.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/uio/uio_pruss.c b/drivers/uio/uio_pruss.c
index f519da9..96c4a19 100644
--- a/drivers/uio/uio_pruss.c
+++ b/drivers/uio/uio_pruss.c
@@ -158,14 +158,12 @@ static int pruss_probe(struct platform_device *dev)
 	if (pdata->sram_pool) {
 		gdev->sram_pool = pdata->sram_pool;
 		gdev->sram_vaddr =
-			gen_pool_alloc(gdev->sram_pool, sram_pool_sz);
+			(unsigned long)gen_pool_dma_alloc(gdev->sram_pool,
+					sram_pool_sz, &gdev->sram_paddr);
 		if (!gdev->sram_vaddr) {
 			dev_err(&dev->dev, "Could not allocate SRAM pool\n");
 			goto out_free;
 		}
-		gdev->sram_paddr =
-			gen_pool_virt_to_phys(gdev->sram_pool,
-					      gdev->sram_vaddr);
 	}
 
 	gdev->ddr_vaddr = dma_alloc_coherent(&dev->dev, extram_pool_sz,
-- 
1.8.4
