From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 7 Jun 2017 14:06:11 +0530
Subject: [PATCH 2/3] mmc: host: omap_hsmmc: use mmc_regulator_get_supply() to
 get regulators
In-Reply-To: <20170607083612.14224-1-kishon@ti.com>
References: <20170607083612.14224-1-kishon@ti.com>
Message-ID: <20170607083612.14224-3-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for using the generic mmc binding for io regulator
("vqmmc"), use mmc_regulator_get_supply() to get vmmc and vqmmc regulators.
Only if "vqmmc" regulator isn't found, fallback to use "vmmc_aux"
regulator.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index de82ac0a87e2..f6da8bc0d64f 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -466,34 +466,27 @@ static int omap_hsmmc_disable_boot_regulators(struct omap_hsmmc_host *host)
 
 static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 {
-	int ocr_value = 0;
 	int ret;
 	struct mmc_host *mmc = host->mmc;
 
 	if (mmc_pdata(host)->set_power)
 		return 0;
 
-	mmc->supply.vmmc = devm_regulator_get_optional(host->dev, "vmmc");
-	if (IS_ERR(mmc->supply.vmmc)) {
-		ret = PTR_ERR(mmc->supply.vmmc);
-		if ((ret != -ENODEV) && host->dev->of_node)
-			return ret;
-		dev_dbg(host->dev, "unable to get vmmc regulator %ld\n",
-			PTR_ERR(mmc->supply.vmmc));
-	} else {
-		ocr_value = mmc_regulator_get_ocrmask(mmc->supply.vmmc);
-		if (ocr_value > 0)
-			mmc_pdata(host)->ocr_mask = ocr_value;
-	}
+	ret = mmc_regulator_get_supply(mmc);
+	if (ret == -EPROBE_DEFER)
+		return ret;
 
 	/* Allow an aux regulator */
-	mmc->supply.vqmmc = devm_regulator_get_optional(host->dev, "vmmc_aux");
 	if (IS_ERR(mmc->supply.vqmmc)) {
-		ret = PTR_ERR(mmc->supply.vqmmc);
-		if ((ret != -ENODEV) && host->dev->of_node)
-			return ret;
-		dev_dbg(host->dev, "unable to get vmmc_aux regulator %ld\n",
-			PTR_ERR(mmc->supply.vqmmc));
+		mmc->supply.vqmmc = devm_regulator_get_optional(host->dev,
+								"vmmc_aux");
+		if (IS_ERR(mmc->supply.vqmmc)) {
+			ret = PTR_ERR(mmc->supply.vqmmc);
+			if ((ret != -ENODEV) && host->dev->of_node)
+				return ret;
+			dev_dbg(host->dev, "unable to get vmmc_aux regulator %ld\n",
+				PTR_ERR(mmc->supply.vqmmc));
+		}
 	}
 
 	host->pbias = devm_regulator_get_optional(host->dev, "pbias");
@@ -2143,7 +2136,8 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_irq;
 
-	mmc->ocr_avail = mmc_pdata(host)->ocr_mask;
+	if (mmc_pdata(host)->ocr_mask)
+		mmc->ocr_avail = mmc_pdata(host)->ocr_mask;
 
 	omap_hsmmc_disable_irq(host);
 
-- 
2.11.0
