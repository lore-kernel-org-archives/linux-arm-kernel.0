From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 6 Jan 2016 11:55:56 +0800
Subject: [PATCH v2 03/12] mmc: sdhci-msm: factorise sdhci_msm_pdata outisde of
 sdhci_msm_host
In-Reply-To: <1452052565-4232-1-git-send-email-jszhang@marvell.com>
References: <1452052565-4232-1-git-send-email-jszhang@marvell.com>
Message-ID: <1452052565-4232-4-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no need to allocate one sdhci_msm_pdata for each sdhci_msm_host.
This patch removes the sdhci_msm_pdata member from sdhci_msm_host and
uses one static global sdhci_msm_pdata for all sdhci msm hosts. It also
marks sdhci_msm_ops as const.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/mmc/host/sdhci-msm.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 4695bee..ffac9b4 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -60,7 +60,6 @@ struct sdhci_msm_host {
 	struct clk *pclk;	/* SDHC peripheral bus clock */
 	struct clk *bus_clk;	/* SDHC bus voter clock */
 	struct mmc_host *mmc;
-	struct sdhci_pltfm_data sdhci_msm_pdata;
 };
 
 /* Platform specific tuning */
@@ -418,7 +417,7 @@ static const struct of_device_id sdhci_msm_dt_match[] = {
 
 MODULE_DEVICE_TABLE(of, sdhci_msm_dt_match);
 
-static struct sdhci_ops sdhci_msm_ops = {
+static const struct sdhci_ops sdhci_msm_ops = {
 	.platform_execute_tuning = sdhci_msm_execute_tuning,
 	.reset = sdhci_reset,
 	.set_clock = sdhci_set_clock,
@@ -426,6 +425,12 @@ static struct sdhci_ops sdhci_msm_ops = {
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
+static const struct sdhci_pltfm_data sdhci_msm_pdata = {
+	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
+		  SDHCI_QUIRK_SINGLE_POWER_WRITE,
+	.ops = &sdhci_msm_ops,
+};
+
 static int sdhci_msm_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
@@ -441,8 +446,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	if (!msm_host)
 		return -ENOMEM;
 
-	msm_host->sdhci_msm_pdata.ops = &sdhci_msm_ops;
-	host = sdhci_pltfm_init(pdev, &msm_host->sdhci_msm_pdata, 0);
+	host = sdhci_pltfm_init(pdev, &sdhci_msm_pdata, 0);
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
@@ -522,9 +526,6 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	/* Set HC_MODE_EN bit in HC_MODE register */
 	writel_relaxed(HC_MODE_EN, (msm_host->core_mem + CORE_HC_MODE));
 
-	host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
-	host->quirks |= SDHCI_QUIRK_SINGLE_POWER_WRITE;
-
 	host_version = readw_relaxed((host->ioaddr + SDHCI_HOST_VERSION));
 	dev_dbg(&pdev->dev, "Host Version: 0x%x Vendor Version 0x%x\n",
 		host_version, ((host_version & SDHCI_VENDOR_VER_MASK) >>
-- 
2.7.0.rc3
