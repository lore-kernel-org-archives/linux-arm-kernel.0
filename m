From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 23 Feb 2012 16:56:47 +0530
Subject: [PATCH v2 4/6] mmc: omap_hsmmc: Get rid of omap_hsmmc_1_set_power
 function
In-Reply-To: <1329996409-26861-1-git-send-email-rnayak@ti.com>
References: <1329996409-26861-1-git-send-email-rnayak@ti.com>
Message-ID: <1329996409-26861-5-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use omap_hsmmc_235_set_poweri() (now renamed as omap_hsmmc_set_power())
for MMC1 instance as well and get rid of omap_hsmmc_1_set_power()
completely.
omap_hsmmc_235_set_power() seems to implemented as a superset of
omap_hsmmc_1_set_power() with additonal functionality implemented
based on additional checks and hence should just work for MMC1
as well.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Tested-by: Venkatraman S <svenkatr@ti.com>
Tested-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   30 +++---------------------------
 1 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 91faf42..f98c599 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -241,28 +241,7 @@ static int omap_hsmmc_resume_cdirq(struct device *dev, int slot)
 
 #ifdef CONFIG_REGULATOR
 
-static int omap_hsmmc_1_set_power(struct device *dev, int slot, int power_on,
-				  int vdd)
-{
-	struct omap_hsmmc_host *host =
-		platform_get_drvdata(to_platform_device(dev));
-	int ret;
-
-	if (mmc_slot(host).before_set_reg)
-		mmc_slot(host).before_set_reg(dev, slot, power_on, vdd);
-
-	if (power_on)
-		ret = mmc_regulator_set_ocr(host->mmc, host->vcc, vdd);
-	else
-		ret = mmc_regulator_set_ocr(host->mmc, host->vcc, 0);
-
-	if (mmc_slot(host).after_set_reg)
-		mmc_slot(host).after_set_reg(dev, slot, power_on, vdd);
-
-	return ret;
-}
-
-static int omap_hsmmc_235_set_power(struct device *dev, int slot, int power_on,
+static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
 				   int vdd)
 {
 	struct omap_hsmmc_host *host =
@@ -332,14 +311,11 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 
 	switch (host->id) {
 	case OMAP_MMC1_DEVID:
-		/* On-chip level shifting via PBIAS0/PBIAS1 */
-		mmc_slot(host).set_power = omap_hsmmc_1_set_power;
-		break;
 	case OMAP_MMC2_DEVID:
 	case OMAP_MMC3_DEVID:
 	case OMAP_MMC5_DEVID:
-		/* Off-chip level shifting, or none */
-		mmc_slot(host).set_power = omap_hsmmc_235_set_power;
+		/* On-chip level shifting via PBIAS0/PBIAS1 */
+		mmc_slot(host).set_power = omap_hsmmc_set_power;
 		break;
 	case OMAP_MMC4_DEVID:
 		mmc_slot(host).set_power = omap_hsmmc_4_set_power;
-- 
1.7.1
