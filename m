From: jassi.brar@samsung.com (Jassi)
Date: Tue, 15 Sep 2009 19:01:20 +0900
Subject: [PATCH 3/7] S3C64XX DMA: Debugged alloc's with GFP_KERNEL flag in
	Intr context.
Message-ID: <1253008880-7555-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s3c2410_dma_enqueue makes call to kzalloc and dma_pool_alloc with GFP_KERNEL
flag set, this can be an issue for drivers, like I2S, which call s3c2410_dma_enqueue
from dma-bufferdone callback.
Changed the flag GFP_KERNEL to GFP_ATOMIC.

Signed-Off-by: Jassi <jassi.brar@samsung.com>
---
 arch/arm/plat-s3c64xx/dma.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/dma.c b/arch/arm/plat-s3c64xx/dma.c
index b26d2a2..266a107 100644
--- a/arch/arm/plat-s3c64xx/dma.c
+++ b/arch/arm/plat-s3c64xx/dma.c
@@ -345,13 +345,13 @@ int s3c2410_dma_enqueue(unsigned int channel, void *id,
 	if (!chan)
 		return -EINVAL;
 
-	buff = kzalloc(sizeof(struct s3c64xx_dma_buff), GFP_KERNEL);
+	buff = kzalloc(sizeof(struct s3c64xx_dma_buff), GFP_ATOMIC);
 	if (!buff) {
 		printk(KERN_ERR "%s: no memory for buffer\n", __func__);
 		return -ENOMEM;
 	}
 
-	lli = dma_pool_alloc(dma_pool, GFP_KERNEL, &buff->lli_dma);
+	lli = dma_pool_alloc(dma_pool, GFP_ATOMIC, &buff->lli_dma);
 	if (!lli) {
 		printk(KERN_ERR "%s: no memory for lli\n", __func__);
 		ret = -ENOMEM;
-- 
1.6.2.5
