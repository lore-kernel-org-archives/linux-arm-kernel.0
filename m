From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:59:36 +0100
Subject: [PATCH 209/222] mmc: sdhci: clean up sdhci_execute_tuning() decision
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1Wden2-0007Rk-7N@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clean up the code in sdhci_execute_tuning() so the decision whether
to execute tuning is clearer - and despite this reflecting what the
original code was doing, it shows that it may not be what the author
actually intended.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f3b9a4386731..b7e53d43c659 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1806,21 +1806,16 @@ static int sdhci_card_busy(struct mmc_host *mmc)
 
 static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
-	struct sdhci_host *host;
+	struct sdhci_host *host = mmc_priv(mmc);
 	u16 ctrl;
 	int tuning_loop_counter = MAX_TUNING_LOOP;
 	unsigned long timeout;
 	int err = 0;
-	bool requires_tuning_nonuhs = false;
 	unsigned long flags;
 
-	host = mmc_priv(mmc);
-
 	sdhci_runtime_pm_get(host);
 	spin_lock_irqsave(&host->lock, flags);
 
-	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
-
 	/*
 	 * The Host Controller needs tuning only in case of SDR104 mode
 	 * and for SDR50 mode when Use Tuning for SDR50 is set in the
@@ -1828,16 +1823,18 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	 * If the Host Controller supports the HS200 mode then the
 	 * tuning function has to be executed.
 	 */
-	if (host->timing == MMC_TIMING_UHS_SDR50 &&
-	    (host->flags & SDHCI_SDR50_NEEDS_TUNING ||
-	     host->flags & SDHCI_SDR104_NEEDS_TUNING))
-		requires_tuning_nonuhs = true;
-
-	if (host->timing == MMC_TIMING_MMC_HS200 ||
-	    host->timing == MMC_TIMING_UHS_SDR104 ||
-	    requires_tuning_nonuhs)
-		ctrl |= SDHCI_CTRL_EXEC_TUNING;
-	else {
+	switch (host->timing) {
+	case MMC_TIMING_MMC_HS200:
+	case MMC_TIMING_UHS_SDR104:
+		break;
+
+	case MMC_TIMING_UHS_SDR50:
+		if (host->flags & SDHCI_SDR50_NEEDS_TUNING ||
+		    host->flags & SDHCI_SDR104_NEEDS_TUNING)
+			break;
+		/* FALLTHROUGH */
+
+	default:
 		spin_unlock_irqrestore(&host->lock, flags);
 		sdhci_runtime_pm_put(host);
 		return 0;
@@ -1850,6 +1847,8 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		return err;
 	}
 
+	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	ctrl |= SDHCI_CTRL_EXEC_TUNING;
 	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 
 	/*
-- 
1.8.3.1
