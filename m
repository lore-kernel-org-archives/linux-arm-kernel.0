From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 31 Mar 2014 17:18:07 +0200
Subject: [PATCH V2 06/19] mmc: mmci: Use the common mmc DT parser
In-Reply-To: <1396279100-2920-1-git-send-email-ulf.hansson@linaro.org>
References: <1396279100-2920-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1396279100-2920-7-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let mmci DT parser only handle the specific bindings related to mmci
and extend the DT support by converting to the common mmc DT parser.

While both DT and platform data exist, DT takes precedence. If there
are supplied DT data, the card detect and write protect GPIOS are
enforced to be provided through it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c |   92 +++++++++++++++++------------------------------
 1 file changed, 33 insertions(+), 59 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 3663bc15..892921d 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1386,12 +1386,9 @@ static struct mmc_host_ops mmci_ops = {
 	.start_signal_voltage_switch = mmci_sig_volt_switch,
 };
 
-#ifdef CONFIG_OF
 static void mmci_dt_populate_generic_pdata(struct device_node *np,
 					struct mmci_platform_data *pdata)
 {
-	int bus_width = 0;
-
 	if (of_get_property(np, "st,sig-dir-dat0", NULL))
 		pdata->sigdir |= MCI_ST_DATA0DIREN;
 	if (of_get_property(np, "st,sig-dir-dat2", NULL))
@@ -1404,46 +1401,22 @@ static void mmci_dt_populate_generic_pdata(struct device_node *np,
 		pdata->sigdir |= MCI_ST_CMDDIREN;
 	if (of_get_property(np, "st,sig-pin-fbclk", NULL))
 		pdata->sigdir |= MCI_ST_FBCLKEN;
+}
 
-	pdata->gpio_wp = of_get_named_gpio(np, "wp-gpios", 0);
-	pdata->gpio_cd = of_get_named_gpio(np, "cd-gpios", 0);
-
-	if (of_get_property(np, "cd-inverted", NULL))
-		pdata->cd_invert = true;
-	else
-		pdata->cd_invert = false;
+static int mmci_of_parse(struct device_node *np, struct mmc_host *mmc)
+{
+	int ret = mmc_of_parse(mmc);
 
-	of_property_read_u32(np, "max-frequency", &pdata->f_max);
-	if (!pdata->f_max)
-		pr_warn("%s has no 'max-frequency' property\n", np->full_name);
+	if (ret)
+		return ret;
 
 	if (of_get_property(np, "mmc-cap-mmc-highspeed", NULL))
-		pdata->capabilities |= MMC_CAP_MMC_HIGHSPEED;
+		mmc->caps |= MMC_CAP_MMC_HIGHSPEED;
 	if (of_get_property(np, "mmc-cap-sd-highspeed", NULL))
-		pdata->capabilities |= MMC_CAP_SD_HIGHSPEED;
+		mmc->caps |= MMC_CAP_SD_HIGHSPEED;
 
-	of_property_read_u32(np, "bus-width", &bus_width);
-	switch (bus_width) {
-	case 0 :
-		/* No bus-width supplied. */
-		break;
-	case 4 :
-		pdata->capabilities |= MMC_CAP_4_BIT_DATA;
-		break;
-	case 8 :
-		pdata->capabilities |= MMC_CAP_8_BIT_DATA;
-		break;
-	default :
-		pr_warn("%s: Unsupported bus width\n", np->full_name);
-	}
-}
-#else
-static void mmci_dt_populate_generic_pdata(struct device_node *np,
-					struct mmci_platform_data *pdata)
-{
-	return;
+	return 0;
 }
-#endif
 
 static int mmci_probe(struct amba_device *dev,
 	const struct amba_id *id)
@@ -1478,6 +1451,10 @@ static int mmci_probe(struct amba_device *dev,
 	if (!mmc)
 		return -ENOMEM;
 
+	ret = mmci_of_parse(np, mmc);
+	if (ret)
+		goto host_free;
+
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
 
@@ -1531,14 +1508,15 @@ static int mmci_probe(struct amba_device *dev,
 	else
 		mmc->f_min = DIV_ROUND_UP(host->mclk, 512);
 	/*
-	 * If the platform data supplies a maximum operating
-	 * frequency, this takes precedence. Else, we fall back
-	 * to using the module parameter, which has a (low)
-	 * default value in case it is not specified. Either
-	 * value must not exceed the clock rate into the block,
-	 * of course.
+	 * If no maximum operating frequency is supplied, fall back to use
+	 * the module parameter, which has a (low) default value in case it
+	 * is not specified. Either value must not exceed the clock rate into
+	 * the block, of course. Also note that DT takes precedence over
+	 * platform data.
 	 */
-	if (plat->f_max)
+	if (mmc->f_max)
+		mmc->f_max = min(host->mclk, mmc->f_max);
+	else if (plat->f_max)
 		mmc->f_max = min(host->mclk, plat->f_max);
 	else
 		mmc->f_max = min(host->mclk, fmax);
@@ -1551,11 +1529,14 @@ static int mmci_probe(struct amba_device *dev,
 	else if (plat->ocr_mask)
 		dev_warn(mmc_dev(mmc), "Platform OCR mask is ignored\n");
 
-	mmc->caps = plat->capabilities;
-	mmc->caps2 = plat->capabilities2;
-	if (!plat->cd_invert)
-		mmc->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
-	mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
+	/* DT takes precedence over platform data. */
+	mmc->caps = np ? mmc->caps : plat->capabilities;
+	mmc->caps2 = np ? mmc->caps2 : plat->capabilities2;
+	if (!np) {
+		if (!plat->cd_invert)
+			mmc->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
+		mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
+	}
 
 	if (variant->busy_detect) {
 		mmci_ops.card_busy = mmci_card_busy;
@@ -1567,7 +1548,7 @@ static int mmci_probe(struct amba_device *dev,
 	mmc->ops = &mmci_ops;
 
 	/* We support these PM capabilities. */
-	mmc->pm_caps = MMC_PM_KEEP_POWER;
+	mmc->pm_caps |= MMC_PM_KEEP_POWER;
 
 	/*
 	 * We can do SGIO
@@ -1604,20 +1585,13 @@ static int mmci_probe(struct amba_device *dev,
 	writel(0, host->base + MMCIMASK1);
 	writel(0xfff, host->base + MMCICLEAR);
 
-	if (plat->gpio_cd == -EPROBE_DEFER) {
-		ret = -EPROBE_DEFER;
-		goto clk_disable;
-	}
-	if (gpio_is_valid(plat->gpio_cd)) {
+	/* If DT, cd/wp gpios must be supplied through it. */
+	if (!np && gpio_is_valid(plat->gpio_cd)) {
 		ret = mmc_gpio_request_cd(mmc, plat->gpio_cd, 0);
 		if (ret)
 			goto clk_disable;
 	}
-	if (plat->gpio_wp == -EPROBE_DEFER) {
-		ret = -EPROBE_DEFER;
-		goto clk_disable;
-	}
-	if (gpio_is_valid(plat->gpio_wp)) {
+	if (!np && gpio_is_valid(plat->gpio_wp)) {
 		ret = mmc_gpio_request_ro(mmc, plat->gpio_wp);
 		if (ret)
 			goto clk_disable;
-- 
1.7.9.5
