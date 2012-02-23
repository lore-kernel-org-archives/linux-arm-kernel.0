From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 23 Feb 2012 16:56:49 +0530
Subject: [PATCH v2 6/6] mmc: omap_hsmmc: Don't expect MMC1 to always have vmmc
 supply
In-Reply-To: <1329996409-26861-1-git-send-email-rnayak@ti.com>
References: <1329996409-26861-1-git-send-email-rnayak@ti.com>
Message-ID: <1329996409-26861-7-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MMC1 is not the only instance that can be used/wired for SD.
So remove this assumption from the driver.

Now that all the mmc id based usage is removed, get rid
of all the DEVID defines and also the 'id' field from the
omap_hsmmc_host structure.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Tested-by: Venkatraman S <svenkatr@ti.com>
Tested-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   31 ++-----------------------------
 1 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 17e264b..e3eb9d4 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -106,17 +106,6 @@
 #define SOFTRESET		(1 << 1)
 #define RESETDONE		(1 << 0)
 
-/*
- * FIXME: Most likely all the data using these _DEVID defines should come
- * from the platform_data, or implemented in controller and slot specific
- * functions.
- */
-#define OMAP_MMC1_DEVID		0
-#define OMAP_MMC2_DEVID		1
-#define OMAP_MMC3_DEVID		2
-#define OMAP_MMC4_DEVID		3
-#define OMAP_MMC5_DEVID		4
-
 #define MMC_AUTOSUSPEND_DELAY	100
 #define MMC_TIMEOUT_MS		20
 #define OMAP_MMC_MIN_CLOCK	400000
@@ -164,7 +153,6 @@ struct omap_hsmmc_host {
 	void	__iomem		*base;
 	resource_size_t		mapbase;
 	spinlock_t		irq_lock; /* Prevent races with irq handler */
-	unsigned int		id;
 	unsigned int		dma_len;
 	unsigned int		dma_sg_idx;
 	unsigned char		bus_mode;
@@ -300,7 +288,6 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
 static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 {
 	struct regulator *reg;
-	int ret = 0;
 	int ocr_value = 0;
 
 	mmc_slot(host).set_power = omap_hsmmc_set_power;
@@ -308,15 +295,6 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 	reg = regulator_get(host->dev, "vmmc");
 	if (IS_ERR(reg)) {
 		dev_dbg(host->dev, "vmmc regulator missing\n");
-		/*
-		* HACK: until fixed.c regulator is usable,
-		* we don't require a main regulator
-		* for MMC2 or MMC3
-		*/
-		if (host->id == OMAP_MMC1_DEVID) {
-			ret = PTR_ERR(reg);
-			goto err;
-		}
 	} else {
 		host->vcc = reg;
 		ocr_value = mmc_regulator_get_ocrmask(reg);
@@ -324,8 +302,8 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 			mmc_slot(host).ocr_mask = ocr_value;
 		} else {
 			if (!(mmc_slot(host).ocr_mask & ocr_value)) {
-				pr_err("MMC%d ocrmask %x is not supported\n",
-					host->id, mmc_slot(host).ocr_mask);
+				pr_err("MMC ocrmask %x is not supported\n",
+					mmc_slot(host).ocr_mask);
 				mmc_slot(host).ocr_mask = 0;
 				return -EINVAL;
 			}
@@ -358,10 +336,6 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 	}
 
 	return 0;
-
-err:
-	mmc_slot(host).set_power = NULL;
-	return ret;
 }
 
 static void omap_hsmmc_reg_put(struct omap_hsmmc_host *host)
@@ -1791,7 +1765,6 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	host->dev->dma_mask = &pdata->dma_mask;
 	host->dma_ch	= -1;
 	host->irq	= irq;
-	host->id	= pdev->id;
 	host->slot_id	= 0;
 	host->mapbase	= res->start;
 	host->base	= ioremap(host->mapbase, SZ_4K);
-- 
1.7.1
