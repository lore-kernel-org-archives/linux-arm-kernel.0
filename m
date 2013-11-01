From: b42378@freescale.com (Nicolin Chen)
Date: Fri, 1 Nov 2013 19:48:17 +0800
Subject: [PATCH][RESEND 4/8] [media] coda: use gen_pool_dma_alloc() to
 allocate iram buffer
In-Reply-To: <cover.1383306365.git.b42378@freescale.com>
References: <cover.1383306365.git.b42378@freescale.com>
Message-ID: <a4cb5380b1eeb1c634cedfe05d2a7dee950742a4.1383306365.git.b42378@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since gen_pool_dma_alloc() is introduced, we implement it to simplify code.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 drivers/media/platform/coda.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/coda.c b/drivers/media/platform/coda.c
index ed4998c..bd72fb9 100644
--- a/drivers/media/platform/coda.c
+++ b/drivers/media/platform/coda.c
@@ -3298,13 +3298,12 @@ static int coda_probe(struct platform_device *pdev)
 		dev->iram_size = CODA7_IRAM_SIZE;
 		break;
 	}
-	dev->iram_vaddr = gen_pool_alloc(dev->iram_pool, dev->iram_size);
+	dev->iram_vaddr = (unsigned long)gen_pool_dma_alloc(dev->iram_pool,
+			dev->iram_size, (dma_addr_t *)&dev->iram_paddr);
 	if (!dev->iram_vaddr) {
 		dev_err(&pdev->dev, "unable to alloc iram\n");
 		return -ENOMEM;
 	}
-	dev->iram_paddr = gen_pool_virt_to_phys(dev->iram_pool,
-						dev->iram_vaddr);
 
 	platform_set_drvdata(pdev, dev);
 
-- 
1.8.4
