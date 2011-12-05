From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Mon, 5 Dec 2011 18:36:00 +0100
Subject: [PATCH 14/14] mmc: mmci: Use ios_handler to save power
In-Reply-To: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com>
References: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1323106560-5218-15-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To disable a levelshifter when we are in an idle state will
decrease current consumption. We make use of the ios_handler
at runtime suspend and at regular suspend to accomplish this.

Of course depending on the used levelshifter the decrease of
current differs. For ST6G3244ME the value is up to ~200 uA.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
---
 drivers/mmc/host/mmci.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index c0d6026..b98ee98 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1491,10 +1491,22 @@ static int mmci_save(struct amba_device *dev)
 {
 	struct mmc_host *mmc = amba_get_drvdata(dev);
 	unsigned long flags;
+	struct mmc_ios ios;
+	int ret = 0;
 
 	if (mmc) {
 		struct mmci_host *host = mmc_priv(mmc);
 
+		/* Let the ios_handler act on a POWER_OFF to save power. */
+		if (host->plat->ios_handler) {
+			memcpy(&ios, &mmc->ios, sizeof(struct mmc_ios));
+			ios.power_mode = MMC_POWER_OFF;
+			ret = host->plat->ios_handler(mmc_dev(mmc),
+						      &ios);
+			if (ret)
+				return ret;
+		}
+
 		spin_lock_irqsave(&host->lock, flags);
 
 		/*
@@ -1513,7 +1525,7 @@ static int mmci_save(struct amba_device *dev)
 		amba_vcore_disable(dev);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int mmci_restore(struct amba_device *dev)
@@ -1536,6 +1548,11 @@ static int mmci_restore(struct amba_device *dev)
 		writel(MCI_IRQENABLE, host->base + MMCIMASK0);
 
 		spin_unlock_irqrestore(&host->lock, flags);
+
+		/* Restore settings done by the ios_handler. */
+		if (host->plat->ios_handler)
+			host->plat->ios_handler(mmc_dev(mmc),
+						&mmc->ios);
 	}
 
 	return 0;
-- 
1.7.5.4
