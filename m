From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 23 Feb 2012 16:56:48 +0530
Subject: [PATCH v2 5/6] mmc: omap_hsmmc: Get rid of omap_hsmmc_4_set_power
 function
In-Reply-To: <1329996409-26861-1-git-send-email-rnayak@ti.com>
References: <1329996409-26861-1-git-send-email-rnayak@ti.com>
Message-ID: <1329996409-26861-6-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that omap_hsmmc_set_power() already has a check to return 0
if !host->vcc, it seems like it can be used even on MMC4 instead
of the dummy omap_hsmmc_4_set_power().

This also helps get rid of all the host->id based check to
populate the right function for on-chip/external level
shifting and use omap_hsmmc_set_power() for all MMC modules.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Tested-by: Venkatraman S <svenkatr@ti.com>
Tested-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   21 +--------------------
 1 files changed, 1 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index f98c599..17e264b 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -297,32 +297,13 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
 	return ret;
 }
 
-static int omap_hsmmc_4_set_power(struct device *dev, int slot, int power_on,
-					int vdd)
-{
-	return 0;
-}
-
 static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 {
 	struct regulator *reg;
 	int ret = 0;
 	int ocr_value = 0;
 
-	switch (host->id) {
-	case OMAP_MMC1_DEVID:
-	case OMAP_MMC2_DEVID:
-	case OMAP_MMC3_DEVID:
-	case OMAP_MMC5_DEVID:
-		/* On-chip level shifting via PBIAS0/PBIAS1 */
-		mmc_slot(host).set_power = omap_hsmmc_set_power;
-		break;
-	case OMAP_MMC4_DEVID:
-		mmc_slot(host).set_power = omap_hsmmc_4_set_power;
-	default:
-		pr_err("MMC%d configuration not supported!\n", host->id);
-		return -EINVAL;
-	}
+	mmc_slot(host).set_power = omap_hsmmc_set_power;
 
 	reg = regulator_get(host->dev, "vmmc");
 	if (IS_ERR(reg)) {
-- 
1.7.1
