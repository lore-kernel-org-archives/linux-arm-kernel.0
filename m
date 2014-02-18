From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 18 Feb 2014 15:11:21 +0000
Subject: [PATCH RFC 27/31] mmc: sdhci: clean up sdhci_execute_tuning() decision
In-Reply-To: <20140218150801.GD21483@n2100.arm.linux.org.uk>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Message-ID: <E1WFmKP-0006ne-C9@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clean up the code in sdhci_execute_tuning() so the decision whether
to execute tuning is clearer - and despite this reflecting what the
original code was doing, it shows that it may not be what the author
actually intended.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
=-DO NOT APPLY-=
 drivers/mmc/host/sdhci.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 01eed75d9404..224ca833410c 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci.c
@@ -1806,21 +1806,16 @@ static int sdhci_card_busy(struct mmc_host *mmc)
 
 static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
-	struct sdhci_host *host;
=+DO NOT APPLY+=	struct sdhci_host *host = mmc_priv(mmc);
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
=+DO NOT APPLY+=	switch (host->timing) {
=+DO NOT APPLY+=	case MMC_TIMING_MMC_HS200:
=+DO NOT APPLY+=	case MMC_TIMING_UHS_SDR104:
=+DO NOT APPLY+=		break;
=+DO NOT APPLY+=
=+DO NOT APPLY+=	case MMC_TIMING_UHS_SDR50:
=+DO NOT APPLY+=		if (host->flags & SDHCI_SDR50_NEEDS_TUNING ||
=+DO NOT APPLY+=		    host->flags & SDHCI_SDR104_NEEDS_TUNING)
=+DO NOT APPLY+=			break;
=+DO NOT APPLY+=		/* FALLTHROUGH */
=+DO NOT APPLY+=
=+DO NOT APPLY+=	default:
 		spin_unlock_irqrestore(&host->lock, flags);
 		sdhci_runtime_pm_put(host);
 		return 0;
@@ -1850,6 +1847,8 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		return err;
 	}
 
=+DO NOT APPLY+=	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
=+DO NOT APPLY+=	ctrl |= SDHCI_CTRL_EXEC_TUNING;
 	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 
 	/*
-- 
1.8.3.1
