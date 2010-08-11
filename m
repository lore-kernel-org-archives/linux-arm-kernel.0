From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 11 Aug 2010 16:19:26 +0300
Subject: [RFC/PATCH 2/6] sdio: add power_restore support
In-Reply-To: <1281532770-27545-1-git-send-email-ohad@wizery.com>
References: <1281532770-27545-1-git-send-email-ohad@wizery.com>
Message-ID: <1281532770-27545-3-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a power_restore handler to the SDIO bus ops,
in order to support waking up SDIO cards that
were powered off by runtime pm.

Note: this approach would also require changing
the power_restore/save bus handlers to support
a return value.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/mmc/core/sdio.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 645f173..ddbb9d3 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -511,11 +511,27 @@ static int mmc_sdio_resume(struct mmc_host *host)
 	return err;
 }
 
+static void mmc_sdio_power_restore(struct mmc_host *host)
+{
+	int err;
+
+	BUG_ON(!host);
+	BUG_ON(!host->card);
+
+	mmc_claim_host(host);
+	err = mmc_sdio_init_card(host, host->ocr, host->card,
+			(host->pm_flags & MMC_PM_KEEP_POWER));
+	if (!err && host->sdio_irqs)
+		mmc_signal_sdio_irq(host);
+	mmc_release_host(host);
+}
+
 static const struct mmc_bus_ops mmc_sdio_ops = {
 	.remove = mmc_sdio_remove,
 	.detect = mmc_sdio_detect,
 	.suspend = mmc_sdio_suspend,
 	.resume = mmc_sdio_resume,
+	.power_restore = mmc_sdio_power_restore,
 };
 
 
-- 
1.7.0.4
