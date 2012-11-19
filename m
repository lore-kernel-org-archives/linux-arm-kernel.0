From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 11:05:04 +0100
Subject: [PATCH 26/30] dma: mv_xor: remove the pool_size from platform_data
In-Reply-To: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353319508-30566-27-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pool_size is always PAGE_SIZE, and since it is a software
configuration paramter (and not a hardware description parameter), we
cannot make it part of the Device Tree binding, so we'd better remove
it from the platform_data as well.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/plat-orion/common.c             |   18 ++----------------
 drivers/dma/mv_xor.c                     |   15 ++++++---------
 drivers/dma/mv_xor.h                     |    1 +
 include/linux/platform_data/dma-mv_xor.h |    1 -
 4 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index 09d8360..2d4b641 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -625,14 +625,7 @@ static struct resource orion_xor0_shared_resources[] = {
 	},
 };
 
-static struct mv_xor_channel_data orion_xor0_channels_data[2] = {
-	{
-		.pool_size	= PAGE_SIZE,
-	},
-	{
-		.pool_size	= PAGE_SIZE,
-	},
-};
+static struct mv_xor_channel_data orion_xor0_channels_data[2];
 
 static struct mv_xor_platform_data orion_xor0_pdata = {
 	.channels = orion_xor0_channels_data,
@@ -698,14 +691,7 @@ static struct resource orion_xor1_shared_resources[] = {
 	},
 };
 
-static struct mv_xor_channel_data orion_xor1_channels_data[2] = {
-	{
-		.pool_size	= PAGE_SIZE,
-	},
-	{
-		.pool_size	= PAGE_SIZE,
-	},
-};
+static struct mv_xor_channel_data orion_xor1_channels_data[2];
 
 static struct mv_xor_platform_data orion_xor1_pdata = {
 	.channels = orion_xor1_channels_data,
diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index fc983bf..ec741b4 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -603,7 +603,7 @@ static int mv_xor_alloc_chan_resources(struct dma_chan *chan)
 	int idx;
 	struct mv_xor_chan *mv_chan = to_mv_xor_chan(chan);
 	struct mv_xor_desc_slot *slot = NULL;
-	int num_descs_in_pool = mv_chan->pool_size/MV_XOR_SLOT_SIZE;
+	int num_descs_in_pool = MV_XOR_POOL_SIZE/MV_XOR_SLOT_SIZE;
 
 	/* Allocate descriptor slots */
 	idx = mv_chan->slots_allocated;
@@ -1074,7 +1074,7 @@ static int mv_xor_channel_remove(struct mv_xor_chan *mv_chan)
 
 	dma_async_device_unregister(&mv_chan->dmadev);
 
-	dma_free_coherent(dev, mv_chan->pool_size,
+	dma_free_coherent(dev, MV_XOR_POOL_SIZE,
 			  mv_chan->dma_desc_pool_virt, mv_chan->dma_desc_pool);
 
 	list_for_each_entry_safe(chan, _chan, &mv_chan->dmadev.channels,
@@ -1088,8 +1088,7 @@ static int mv_xor_channel_remove(struct mv_xor_chan *mv_chan)
 static struct mv_xor_chan *
 mv_xor_channel_add(struct mv_xor_device *xordev,
 		   struct platform_device *pdev,
-		   int idx, dma_cap_mask_t cap_mask,
-		   size_t pool_size, int irq)
+		   int idx, dma_cap_mask_t cap_mask, int irq)
 {
 	int ret = 0;
 	struct mv_xor_chan *mv_chan;
@@ -1109,9 +1108,8 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	 * note: writecombine gives slightly better performance, but
 	 * requires that we explicitly flush the writes
 	 */
-	mv_chan->pool_size = pool_size;
 	mv_chan->dma_desc_pool_virt =
-	  dma_alloc_writecombine(&pdev->dev, mv_chan->pool_size,
+	  dma_alloc_writecombine(&pdev->dev, MV_XOR_POOL_SIZE,
 				 &mv_chan->dma_desc_pool, GFP_KERNEL);
 	if (!mv_chan->dma_desc_pool_virt)
 		return ERR_PTR(-ENOMEM);
@@ -1193,7 +1191,7 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	return mv_chan;
 
  err_free_dma:
-	dma_free_coherent(&pdev->dev, pool_size,
+	dma_free_coherent(&pdev->dev, MV_XOR_POOL_SIZE,
 			  mv_chan->dma_desc_pool_virt, mv_chan->dma_desc_pool);
 	return ERR_PTR(ret);
 }
@@ -1296,8 +1294,7 @@ static int mv_xor_probe(struct platform_device *pdev)
 
 			xordev->channels[i] =
 				mv_xor_channel_add(xordev, pdev, i,
-						   cd->cap_mask,
-						   cd->pool_size, irq);
+						   cd->cap_mask, irq);
 			if (IS_ERR(xordev->channels[i])) {
 				ret = PTR_ERR(xordev->channels[i]);
 				goto err_channel_add;
diff --git a/drivers/dma/mv_xor.h b/drivers/dma/mv_xor.h
index dab9f30..698b448 100644
--- a/drivers/dma/mv_xor.h
+++ b/drivers/dma/mv_xor.h
@@ -24,6 +24,7 @@
 #include <linux/interrupt.h>
 
 #define USE_TIMER
+#define MV_XOR_POOL_SIZE		PAGE_SIZE
 #define MV_XOR_SLOT_SIZE		64
 #define MV_XOR_THRESHOLD		1
 #define MV_XOR_MAX_CHANNELS             2
diff --git a/include/linux/platform_data/dma-mv_xor.h b/include/linux/platform_data/dma-mv_xor.h
index b18dc24..8ec18f6 100644
--- a/include/linux/platform_data/dma-mv_xor.h
+++ b/include/linux/platform_data/dma-mv_xor.h
@@ -14,7 +14,6 @@
 
 struct mv_xor_channel_data {
 	dma_cap_mask_t			cap_mask;
-	size_t				pool_size;
 };
 
 struct mv_xor_platform_data {
-- 
1.7.9.5
