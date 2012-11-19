From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 11:04:48 +0100
Subject: [PATCH 10/30] dma: mv_xor: rename mv_xor_platform_data to
 mv_xor_channel_data
In-Reply-To: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353319508-30566-11-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mv_xor_platform_data used to be the platform_data structure associated
to the 'mv_xor' driver. This driver no longer exists, and this data
structure really contains the properties of each XOR channel part of a
given XOR engine. Therefore 'struct mv_xor_channel_data' is a more
appropriate name.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/plat-orion/common.c             |   28 ++++++++++++++--------------
 drivers/dma/mv_xor.c                     |    2 +-
 include/linux/platform_data/dma-mv_xor.h |    4 ++--
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index 5a66211..7ffbe77 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -625,7 +625,7 @@ static struct resource orion_xor0_shared_resources[] = {
 	},
 };
 
-static struct mv_xor_platform_data orion_xor0_channels_pdata[2] = {
+static struct mv_xor_channel_data orion_xor0_channels_data[2] = {
 	{
 		.hw_id		= 0,
 		.pool_size	= PAGE_SIZE,
@@ -637,7 +637,7 @@ static struct mv_xor_platform_data orion_xor0_channels_pdata[2] = {
 };
 
 static struct mv_xor_shared_platform_data orion_xor0_pdata = {
-	.channels = orion_xor0_channels_pdata,
+	.channels = orion_xor0_channels_data,
 };
 
 static struct platform_device orion_xor0_shared = {
@@ -671,12 +671,12 @@ void __init orion_xor0_init(unsigned long mapbase_low,
 	 * two engines can't do memset simultaneously, this limitation
 	 * satisfied by removing memset support from one of the engines.
 	 */
-	dma_cap_set(DMA_MEMCPY, orion_xor0_channels_pdata[0].cap_mask);
-	dma_cap_set(DMA_XOR, orion_xor0_channels_pdata[0].cap_mask);
+	dma_cap_set(DMA_MEMCPY, orion_xor0_channels_data[0].cap_mask);
+	dma_cap_set(DMA_XOR, orion_xor0_channels_data[0].cap_mask);
 
-	dma_cap_set(DMA_MEMSET, orion_xor0_channels_pdata[1].cap_mask);
-	dma_cap_set(DMA_MEMCPY, orion_xor0_channels_pdata[1].cap_mask);
-	dma_cap_set(DMA_XOR, orion_xor0_channels_pdata[1].cap_mask);
+	dma_cap_set(DMA_MEMSET, orion_xor0_channels_data[1].cap_mask);
+	dma_cap_set(DMA_MEMCPY, orion_xor0_channels_data[1].cap_mask);
+	dma_cap_set(DMA_XOR, orion_xor0_channels_data[1].cap_mask);
 
 	platform_device_register(&orion_xor0_shared);
 }
@@ -700,7 +700,7 @@ static struct resource orion_xor1_shared_resources[] = {
 	},
 };
 
-static struct mv_xor_platform_data orion_xor1_channels_pdata[2] = {
+static struct mv_xor_channel_data orion_xor1_channels_data[2] = {
 	{
 		.hw_id		= 0,
 		.pool_size	= PAGE_SIZE,
@@ -712,7 +712,7 @@ static struct mv_xor_platform_data orion_xor1_channels_pdata[2] = {
 };
 
 static struct mv_xor_shared_platform_data orion_xor1_pdata = {
-	.channels = orion_xor1_channels_pdata,
+	.channels = orion_xor1_channels_data,
 };
 
 static struct platform_device orion_xor1_shared = {
@@ -746,12 +746,12 @@ void __init orion_xor1_init(unsigned long mapbase_low,
 	 * two engines can't do memset simultaneously, this limitation
 	 * satisfied by removing memset support from one of the engines.
 	 */
-	dma_cap_set(DMA_MEMCPY, orion_xor1_channels_pdata[0].cap_mask);
-	dma_cap_set(DMA_XOR, orion_xor1_channels_pdata[0].cap_mask);
+	dma_cap_set(DMA_MEMCPY, orion_xor1_channels_data[0].cap_mask);
+	dma_cap_set(DMA_XOR, orion_xor1_channels_data[0].cap_mask);
 
-	dma_cap_set(DMA_MEMSET, orion_xor1_channels_pdata[1].cap_mask);
-	dma_cap_set(DMA_MEMCPY, orion_xor1_channels_pdata[1].cap_mask);
-	dma_cap_set(DMA_XOR, orion_xor1_channels_pdata[1].cap_mask);
+	dma_cap_set(DMA_MEMSET, orion_xor1_channels_data[1].cap_mask);
+	dma_cap_set(DMA_MEMCPY, orion_xor1_channels_data[1].cap_mask);
+	dma_cap_set(DMA_XOR, orion_xor1_channels_data[1].cap_mask);
 
 	platform_device_register(&orion_xor1_shared);
 }
diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index be3907b..c7926e4 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1300,7 +1300,7 @@ static int mv_xor_shared_probe(struct platform_device *pdev)
 
 	if (pdata && pdata->channels) {
 		for (i = 0; i < MV_XOR_MAX_CHANNELS; i++) {
-			struct mv_xor_platform_data *cd;
+			struct mv_xor_channel_data *cd;
 			int irq;
 
 			cd = &pdata->channels[i];
diff --git a/include/linux/platform_data/dma-mv_xor.h b/include/linux/platform_data/dma-mv_xor.h
index 4a0980b..40ea3d5 100644
--- a/include/linux/platform_data/dma-mv_xor.h
+++ b/include/linux/platform_data/dma-mv_xor.h
@@ -12,14 +12,14 @@
 
 #define MV_XOR_SHARED_NAME	"mv_xor_shared"
 
-struct mv_xor_platform_data {
+struct mv_xor_channel_data {
 	int				hw_id;
 	dma_cap_mask_t			cap_mask;
 	size_t				pool_size;
 };
 
 struct mv_xor_shared_platform_data {
-	struct mv_xor_platform_data    *channels;
+	struct mv_xor_channel_data    *channels;
 };
 
 #endif
-- 
1.7.9.5
