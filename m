From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  5 Dec 2013 14:34:47 +0100
Subject: [PATCH 2/6] mmc: mxs: use standard flag for non-removable status
In-Reply-To: <1386250491-4708-1-git-send-email-s.hauer@pengutronix.de>
References: <1386250491-4708-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1386250491-4708-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The standard caps already have a MMC_CAP_NONREMOVABLE flag. Use it
rather than a custom non_removable flag.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mmc/host/mxs-mmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 50fc9df..374fca7 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -73,7 +73,6 @@ struct mxs_mmc_host {
 	bool				wp_inverted;
 	bool				cd_inverted;
 	bool				broken_cd;
-	bool				non_removable;
 };
 
 static int mxs_mmc_get_ro(struct mmc_host *mmc)
@@ -97,7 +96,7 @@ static int mxs_mmc_get_cd(struct mmc_host *mmc)
 	struct mxs_mmc_host *host = mmc_priv(mmc);
 	struct mxs_ssp *ssp = &host->ssp;
 
-	return host->non_removable || host->broken_cd ||
+	return host->broken_cd ||
 		!(readl(ssp->base + HW_SSP_STATUS(ssp)) &
 		  BM_SSP_STATUS_CARD_DETECT) ^ host->cd_inverted;
 }
@@ -654,8 +653,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	else if (bus_width == 8)
 		mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
 	host->broken_cd = of_property_read_bool(np, "broken-cd");
-	host->non_removable = of_property_read_bool(np, "non-removable");
-	if (host->non_removable)
+	if (of_property_read_bool(np, "non-removable"))
 		mmc->caps |= MMC_CAP_NONREMOVABLE;
 	host->wp_gpio = of_get_named_gpio_flags(np, "wp-gpios", 0, &flags);
 	if (flags & OF_GPIO_ACTIVE_LOW)
-- 
1.8.4.3
