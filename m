From: jassisinghbrar@gmail.com (jassi brar)
Date: Thu, 10 Sep 2009 10:46:24 +0900
Subject: S3C64XX DMA: GFP_KERNEL in irq context
Message-ID: <1b68c6790909091846j74440728i6cb092c62336c0b6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 s3c2410_dma_enqueue is called from dma_bufferdone in I2S driver,
which in turn is called from DMA irq handler.
 In that situation s3c2410_dma_enqueue calls kzalloc with GFP_KERNEL flag.

Not sure, if we shud change s3c2410_dma_enqueue itself or the I2S
cpu-drivers to call it from scheduled work after the dma_bufferdone
callback.

For the time being i am using .......

diff --git a/arch/arm/plat-s3c64xx/dma.c b/arch/arm/plat-s3c64xx/dma.c
--- a/arch/arm/plat-s3c64xx/dma.c
+++ b/arch/arm/plat-s3c64xx/dma.c
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
