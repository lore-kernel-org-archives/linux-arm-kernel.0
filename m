From: tony@atomide.com (Tony Lindgren)
Date: Wed, 31 Oct 2018 08:57:38 -0700
Subject: [PATCH] mmc: core: Lower max_seg_size if too high for DMA
Message-ID: <20181031155738.18367-1-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With CONFIG_DMA_API_DEBUG_SG a device may produce the following warning:

"DMA-API: mapping sg segment longer than device claims to support"

We default to 64KiB if a DMA engine driver does not initialize dma_parms
and call dma_set_max_seg_size(). This may be lower that what many MMC
drivers do with mmc->max_seg_size = mmc->max_blk_size * mmc->max_blk_count.

Let's do a sanity check for max_seg_size being higher than what DMA
supports in mmc_add_host() and lower it as needed.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Reported-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/core/host.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/idr.h>
 #include <linux/of.h>
@@ -415,6 +416,19 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 
 EXPORT_SYMBOL(mmc_alloc_host);
 
+static void mmc_check_max_seg_size(struct mmc_host *host)
+{
+	unsigned int max_seg_size = dma_get_max_seg_size(mmc_dev(host));
+
+	if (host->max_seg_size <= max_seg_size)
+		return;
+
+	dev_info(mmc_dev(host), "Lowering max_seg_size for DMA: %u vs %u\n",
+		 host->max_seg_size, max_seg_size);
+
+	host->max_seg_size = max_seg_size;
+}
+
 /**
  *	mmc_add_host - initialise host hardware
  *	@host: mmc host
@@ -430,6 +444,8 @@ int mmc_add_host(struct mmc_host *host)
 	WARN_ON((host->caps & MMC_CAP_SDIO_IRQ) &&
 		!host->ops->enable_sdio_irq);
 
+	mmc_check_max_seg_size(host);
+
 	err = device_add(&host->class_dev);
 	if (err)
 		return err;
-- 
2.19.1
