From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  7 May 2012 22:43:09 +0800
Subject: [PATCH 07/10] mmc: mxs-mmc: copy wp_gpio in struct mxs_mmc_host
In-Reply-To: <1336401793-13753-1-git-send-email-shawn.guo@linaro.org>
References: <1336401793-13753-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1336401793-13753-8-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It has wp_gpio copied in struct mxs_mmc_host from platform_data,
so that the use of platform_data can be limited in probe function,
which will ease the device tree probe.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/mxs-mmc.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index e905721..66f792a 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -160,21 +160,17 @@ struct mxs_mmc_host {
 	unsigned char			bus_width;
 	spinlock_t			lock;
 	int				sdio_irq_en;
+	int				wp_gpio;
 };
 
 static int mxs_mmc_get_ro(struct mmc_host *mmc)
 {
 	struct mxs_mmc_host *host = mmc_priv(mmc);
-	struct mxs_mmc_platform_data *pdata =
-		mmc_dev(host->mmc)->platform_data;
 
-	if (!pdata)
-		return -EFAULT;
-
-	if (!gpio_is_valid(pdata->wp_gpio))
+	if (!gpio_is_valid(host->wp_gpio))
 		return -EINVAL;
 
-	return gpio_get_value(pdata->wp_gpio);
+	return gpio_get_value(host->wp_gpio);
 }
 
 static int mxs_mmc_get_cd(struct mmc_host *mmc)
@@ -758,6 +754,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 			mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
 		if (pdata->flags & SLOTF_4_BIT_CAPABLE)
 			mmc->caps |= MMC_CAP_4_BIT_DATA;
+		host->wp_gpio = pdata->wp_gpio;
 	}
 
 	mmc->f_min = 400000;
-- 
1.7.5.4
