From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 25 Mar 2013 16:02:31 +0100
Subject: [PATCH 2/2] mmc: mxs-mmc: add non-removeable property
In-Reply-To: <1364223751-28253-1-git-send-email-mkl@pengutronix.de>
References: <1364223751-28253-1-git-send-email-mkl@pengutronix.de>
Message-ID: <1364223751-28253-3-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some boards have non removeable cards like eMMC. Handle such case.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/mmc/host/mxs-mmc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 0cdf1f6..b85f383 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -73,6 +73,7 @@ struct mxs_mmc_host {
 	int				wp_gpio;
 	bool				wp_inverted;
 	bool				cd_inverted;
+	bool				non_removeable;
 };
 
 static int mxs_mmc_get_ro(struct mmc_host *mmc)
@@ -96,8 +97,9 @@ static int mxs_mmc_get_cd(struct mmc_host *mmc)
 	struct mxs_mmc_host *host = mmc_priv(mmc);
 	struct mxs_ssp *ssp = &host->ssp;
 
-	return !(readl(ssp->base + HW_SSP_STATUS(ssp)) &
-		 BM_SSP_STATUS_CARD_DETECT)) ^ host->cd_inverted;
+	return host->non_removeable ||
+		!(readl(ssp->base + HW_SSP_STATUS(ssp)) &
+		  BM_SSP_STATUS_CARD_DETECT) ^ host->cd_inverted;
 }
 
 static void mxs_mmc_reset(struct mxs_mmc_host *host)
@@ -687,8 +689,10 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
 	else if (bus_width == 8)
 		mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
+	host->non_removeable = of_property_read_bool(np, "non-removable");
+	if (host->non_removeable)
+		mmc->caps |= MMC_CAP_NONREMOVABLE;
 	host->wp_gpio = of_get_named_gpio_flags(np, "wp-gpios", 0, &flags);
-
 	if (flags & OF_GPIO_ACTIVE_LOW)
 		host->wp_inverted = 1;
 
-- 
1.8.2.rc2
