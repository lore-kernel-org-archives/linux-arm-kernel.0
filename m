From: csd@broadcom.com (Christian Daudt)
Date: Wed, 7 Aug 2013 11:59:41 -0700
Subject: [PATCH] ARM: mmc: fix NONREMOVABLE test in sdhci-bcm-kona
Message-ID: <1375901981-1495-1-git-send-email-csd@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sdhci-bcm-kona driver is incorrectly doing "|" to bit-test
NONREMOVABLE. Switch to "&"

Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
Reviewed-by: Matt Porter <matt.porter@linaro.org>
Signed-off-by: Christian Daudt <csd@broadcom.com>

diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
index 87175f9..9ffac0b 100644
--- a/drivers/mmc/host/sdhci-bcm-kona.c
+++ b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -263,7 +263,7 @@ static int __init sdhci_bcm_kona_probe(struct platform_device *pdev)
 		(mmc_gpio_get_cd(host->mmc) != -ENOSYS) ? 'Y' : 'N',
 		(mmc_gpio_get_ro(host->mmc) != -ENOSYS) ? 'Y' : 'N');
 
-	if (host->mmc->caps | MMC_CAP_NONREMOVABLE)
+	if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
 		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 
 	dev_dbg(dev, "is_8bit=%c\n",
@@ -282,7 +282,7 @@ static int __init sdhci_bcm_kona_probe(struct platform_device *pdev)
 	}
 
 	/* if device is eMMC, emulate card insert right here */
-	if (host->mmc->caps | MMC_CAP_NONREMOVABLE) {
+	if (host->mmc->caps & MMC_CAP_NONREMOVABLE) {
 		ret = sdhci_bcm_kona_sd_card_emulate(host, 1);
 		if (ret) {
 			dev_err(dev,
-- 
1.7.10.4
