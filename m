From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:55:41 +0100
Subject: [PATCH 187/222] mmc: sdhci: clean up sdio interrupt enable handling
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdejF-0007QA-6i@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't need to change the SDHCI_SDIO_IRQ_ENABLED flag when we're
merely receiving an interrupt - IRQ handling thread in the MMC core
will either re-enable or disable the interrupt via the enable_sdio_irq
callback, which will update this status appropriately.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 79838de6b278..239d90d77ac4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1709,24 +1709,14 @@ static int sdhci_get_ro(struct mmc_host *mmc)
 
 static void sdhci_enable_sdio_irq_nolock(struct sdhci_host *host, int enable)
 {
-	if (host->flags & SDHCI_DEVICE_DEAD)
-		goto out;
-
-	if (enable)
-		host->flags |= SDHCI_SDIO_IRQ_ENABLED;
-	else
-		host->flags &= ~SDHCI_SDIO_IRQ_ENABLED;
-
 	/* SDIO IRQ will be enabled as appropriate in runtime resume */
-	if (host->runtime_suspended)
-		goto out;
-
-	if (enable)
-		sdhci_unmask_irqs(host, SDHCI_INT_CARD_INT);
-	else
-		sdhci_mask_irqs(host, SDHCI_INT_CARD_INT);
-out:
-	mmiowb();
+	if (!(host->flags & SDHCI_DEVICE_DEAD) || host->runtime_suspended) {
+		if (enable)
+			sdhci_unmask_irqs(host, SDHCI_INT_CARD_INT);
+		else
+			sdhci_mask_irqs(host, SDHCI_INT_CARD_INT);
+		mmiowb();
+	}
 }
 
 static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
@@ -1734,9 +1724,18 @@ static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	struct sdhci_host *host = mmc_priv(mmc);
 	unsigned long flags;
 
+	sdhci_runtime_pm_get(host);
+
 	spin_lock_irqsave(&host->lock, flags);
+	if (enable)
+		host->flags |= SDHCI_SDIO_IRQ_ENABLED;
+	else
+		host->flags &= ~SDHCI_SDIO_IRQ_ENABLED;
+
 	sdhci_enable_sdio_irq_nolock(host, enable);
 	spin_unlock_irqrestore(&host->lock, flags);
+
+	sdhci_runtime_pm_put(host);
 }
 
 static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
@@ -2721,7 +2720,7 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)
 	host->runtime_suspended = false;
 
 	/* Enable SDIO IRQ */
-	if ((host->flags & SDHCI_SDIO_IRQ_ENABLED))
+	if (host->flags & SDHCI_SDIO_IRQ_ENABLED)
 		sdhci_enable_sdio_irq_nolock(host, true);
 
 	/* Enable Card Detection */
-- 
1.8.3.1
