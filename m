From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 11:05:03 +0100
Subject: [PATCH 25/30] dma: mv_xor: remove hw_id field from platform_data
In-Reply-To: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353319508-30566-26-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need for the platform_data to give this ID, it is simply
the channel number, so we can compute it inside the driver when
registering the channels.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/plat-orion/common.c             |    4 ----
 drivers/dma/mv_xor.c                     |    6 +++---
 include/linux/platform_data/dma-mv_xor.h |    1 -
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index 31517ce..09d8360 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -627,11 +627,9 @@ static struct resource orion_xor0_shared_resources[] = {
 
 static struct mv_xor_channel_data orion_xor0_channels_data[2] = {
 	{
-		.hw_id		= 0,
 		.pool_size	= PAGE_SIZE,
 	},
 	{
-		.hw_id		= 1,
 		.pool_size	= PAGE_SIZE,
 	},
 };
@@ -702,11 +700,9 @@ static struct resource orion_xor1_shared_resources[] = {
 
 static struct mv_xor_channel_data orion_xor1_channels_data[2] = {
 	{
-		.hw_id		= 0,
 		.pool_size	= PAGE_SIZE,
 	},
 	{
-		.hw_id		= 1,
 		.pool_size	= PAGE_SIZE,
 	},
 };
diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index a6a5a28..fc983bf 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1088,7 +1088,7 @@ static int mv_xor_channel_remove(struct mv_xor_chan *mv_chan)
 static struct mv_xor_chan *
 mv_xor_channel_add(struct mv_xor_device *xordev,
 		   struct platform_device *pdev,
-		   int hw_id, dma_cap_mask_t cap_mask,
+		   int idx, dma_cap_mask_t cap_mask,
 		   size_t pool_size, int irq)
 {
 	int ret = 0;
@@ -1101,7 +1101,7 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 		goto err_free_dma;
 	}
 
-	mv_chan->idx = hw_id;
+	mv_chan->idx = idx;
 
 	dma_dev = &mv_chan->dmadev;
 
@@ -1295,7 +1295,7 @@ static int mv_xor_probe(struct platform_device *pdev)
 			}
 
 			xordev->channels[i] =
-				mv_xor_channel_add(xordev, pdev, cd->hw_id,
+				mv_xor_channel_add(xordev, pdev, i,
 						   cd->cap_mask,
 						   cd->pool_size, irq);
 			if (IS_ERR(xordev->channels[i])) {
diff --git a/include/linux/platform_data/dma-mv_xor.h b/include/linux/platform_data/dma-mv_xor.h
index 367bb21..b18dc24 100644
--- a/include/linux/platform_data/dma-mv_xor.h
+++ b/include/linux/platform_data/dma-mv_xor.h
@@ -13,7 +13,6 @@
 #define MV_XOR_NAME	"mv_xor"
 
 struct mv_xor_channel_data {
-	int				hw_id;
 	dma_cap_mask_t			cap_mask;
 	size_t				pool_size;
 };
-- 
1.7.9.5
