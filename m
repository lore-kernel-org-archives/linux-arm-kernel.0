From: stillcompiling@gmail.com (Joshua Clayton)
Date: Mon, 15 Jun 2015 09:18:59 -0700
Subject: [PATCH 04/10] dma: sdma-imx set dma script address directly
In-Reply-To: <1434385144-4432-1-git-send-email-stillcompiling@gmail.com>
References: <1434385144-4432-1-git-send-email-stillcompiling@gmail.com>
Message-ID: <1434385144-4432-5-git-send-email-stillcompiling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SDMA uses different firmware scripts per device type and per
direction, but only one script per channel may be used at a time.
By moving the call to sdma_get_pc() into get_context, it will
be called any time the dma direction may change.

Then there is no need to store multiple script addresses, so those
may be removed from struct sdma_channel.

We also add an error message should setting the script fail to
find a valid script address.

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 drivers/dma/imx-sdma.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 7c8703f..fdf88c4 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -257,7 +257,6 @@ struct sdma_channel {
 	unsigned int			period_len;
 	struct sdma_buffer_descriptor	*bd;
 	dma_addr_t			bd_phys;
-	unsigned int			pc_from_device, pc_to_device;
 	unsigned long			flags;
 	dma_addr_t			per_address;
 	unsigned long			event_mask[2];
@@ -688,8 +687,8 @@ static irqreturn_t sdma_int_handler(int irq, void *dev_id)
 /*
  * sets the pc of SDMA script according to the peripheral type
  */
-static void sdma_get_pc(struct sdma_channel *sdmac,
-		enum sdma_peripheral_type peripheral_type)
+static s32 sdma_get_pc(struct sdma_channel *sdmac,
+		enum dma_transfer_direction direction)
 {
 	struct sdma_engine *sdma = to_sdma_engine(sdmac);
 	int per_2_emi = 0, emi_2_per = 0;
@@ -699,10 +698,7 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 	 */
 	int per_2_per = 0, emi_2_emi = 0;
 
-	sdmac->pc_from_device = 0;
-	sdmac->pc_to_device = 0;
-
-	switch (peripheral_type) {
+	switch (sdmac->peripheral_type) {
 	case IMX_DMATYPE_MEMORY:
 		emi_2_emi = sdma->script_addrs->ap_2_ap_addr;
 		break;
@@ -774,8 +770,14 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 		break;
 	}
 
-	sdmac->pc_from_device = per_2_emi;
-	sdmac->pc_to_device = emi_2_per;
+	switch (direction) {
+	case DMA_MEM_TO_DEV:
+		return emi_2_per;
+	case DMA_DEV_TO_MEM:
+		return per_2_emi;
+	default:
+		return 0;
+	}
 }
 
 static int sdma_load_context(struct sdma_channel *sdmac)
@@ -788,15 +790,13 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 	int ret;
 	unsigned long flags;
 
-	if (sdmac->direction == DMA_DEV_TO_MEM) {
-		load_address = sdmac->pc_from_device;
-	} else {
-		load_address = sdmac->pc_to_device;
+	load_address = sdma_get_pc(sdmac, sdmac->direction);
+	if (!load_address) {
+		dev_err(sdma->dev, "SDMA channel %d: No dma script found\n",
+			channel);
+		return -EFAULT;
 	}
 
-	if (load_address < 0)
-		return load_address;
-
 	dev_dbg(sdma->dev, "load_address = %d\n", load_address);
 	dev_dbg(sdma->dev, "wml = 0x%08x\n", (u32)sdmac->watermark_level);
 	dev_dbg(sdma->dev, "shp_addr = 0x%08x\n", sdmac->shp_addr);
@@ -867,8 +867,6 @@ static int sdma_config_channel(struct sdma_channel *sdmac)
 		break;
 	}
 
-	sdma_get_pc(sdmac, sdmac->peripheral_type);
-
 	if ((sdmac->peripheral_type != IMX_DMATYPE_MEMORY) &&
 			(sdmac->peripheral_type != IMX_DMATYPE_DSP)) {
 		/* Handle multiple event channels differently */
-- 
2.1.4
