From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 23 Feb 2012 16:56:45 +0530
Subject: [PATCH v2 2/6] mmc: omap_hsmmc: remove unused .set_sleep function
In-Reply-To: <1329996409-26861-1-git-send-email-rnayak@ti.com>
References: <1329996409-26861-1-git-send-email-rnayak@ti.com>
Message-ID: <1329996409-26861-3-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Balaji T K <balajitk@ti.com>

set_sleep seems to be unused in omap_hsmmc driver. so get rid of it.

Signed-off-by: Balaji T K <balajitk@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Tested-by: Venkatraman S <svenkatr@ti.com>
---
 arch/arm/plat-omap/include/plat/mmc.h |    2 -
 drivers/mmc/host/omap_hsmmc.c         |   60 ---------------------------------
 2 files changed, 0 insertions(+), 62 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index f75946c..7a38750 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -137,8 +137,6 @@ struct omap_mmc_platform_data {
 		int (*set_power)(struct device *dev, int slot,
 				 int power_on, int vdd);
 		int (*get_ro)(struct device *dev, int slot);
-		int (*set_sleep)(struct device *dev, int slot, int sleep,
-				 int vdd, int cardsleep);
 		void (*remux)(struct device *dev, int slot, int power_on);
 		/* Call back before enabling / disabling regulators */
 		void (*before_set_reg)(struct device *dev, int slot,
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 2a660ab..9955aee 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -324,61 +324,6 @@ static int omap_hsmmc_4_set_power(struct device *dev, int slot, int power_on,
 	return 0;
 }
 
-static int omap_hsmmc_1_set_sleep(struct device *dev, int slot, int sleep,
-				  int vdd, int cardsleep)
-{
-	struct omap_hsmmc_host *host =
-		platform_get_drvdata(to_platform_device(dev));
-	int mode = sleep ? REGULATOR_MODE_STANDBY : REGULATOR_MODE_NORMAL;
-
-	return regulator_set_mode(host->vcc, mode);
-}
-
-static int omap_hsmmc_235_set_sleep(struct device *dev, int slot, int sleep,
-				   int vdd, int cardsleep)
-{
-	struct omap_hsmmc_host *host =
-		platform_get_drvdata(to_platform_device(dev));
-	int err, mode;
-
-	/*
-	 * If we don't see a Vcc regulator, assume it's a fixed
-	 * voltage always-on regulator.
-	 */
-	if (!host->vcc)
-		return 0;
-
-	mode = sleep ? REGULATOR_MODE_STANDBY : REGULATOR_MODE_NORMAL;
-
-	if (!host->vcc_aux)
-		return regulator_set_mode(host->vcc, mode);
-
-	if (cardsleep) {
-		/* VCC can be turned off if card is asleep */
-		if (sleep)
-			err = mmc_regulator_set_ocr(host->mmc, host->vcc, 0);
-		else
-			err = mmc_regulator_set_ocr(host->mmc, host->vcc, vdd);
-	} else
-		err = regulator_set_mode(host->vcc, mode);
-	if (err)
-		return err;
-
-	if (!mmc_slot(host).vcc_aux_disable_is_sleep)
-		return regulator_set_mode(host->vcc_aux, mode);
-
-	if (sleep)
-		return regulator_disable(host->vcc_aux);
-	else
-		return regulator_enable(host->vcc_aux);
-}
-
-static int omap_hsmmc_4_set_sleep(struct device *dev, int slot, int sleep,
-					int vdd, int cardsleep)
-{
-	return 0;
-}
-
 static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 {
 	struct regulator *reg;
@@ -389,18 +334,15 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 	case OMAP_MMC1_DEVID:
 		/* On-chip level shifting via PBIAS0/PBIAS1 */
 		mmc_slot(host).set_power = omap_hsmmc_1_set_power;
-		mmc_slot(host).set_sleep = omap_hsmmc_1_set_sleep;
 		break;
 	case OMAP_MMC2_DEVID:
 	case OMAP_MMC3_DEVID:
 	case OMAP_MMC5_DEVID:
 		/* Off-chip level shifting, or none */
 		mmc_slot(host).set_power = omap_hsmmc_235_set_power;
-		mmc_slot(host).set_sleep = omap_hsmmc_235_set_sleep;
 		break;
 	case OMAP_MMC4_DEVID:
 		mmc_slot(host).set_power = omap_hsmmc_4_set_power;
-		mmc_slot(host).set_sleep = omap_hsmmc_4_set_sleep;
 	default:
 		pr_err("MMC%d configuration not supported!\n", host->id);
 		return -EINVAL;
@@ -462,7 +404,6 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 
 err:
 	mmc_slot(host).set_power = NULL;
-	mmc_slot(host).set_sleep = NULL;
 	return ret;
 }
 
@@ -471,7 +412,6 @@ static void omap_hsmmc_reg_put(struct omap_hsmmc_host *host)
 	regulator_put(host->vcc);
 	regulator_put(host->vcc_aux);
 	mmc_slot(host).set_power = NULL;
-	mmc_slot(host).set_sleep = NULL;
 }
 
 static inline int omap_hsmmc_have_reg(void)
-- 
1.7.1
