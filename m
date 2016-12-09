From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  9 Dec 2016 11:30:00 +0100
Subject: [PATCH v3 04/12] mmc: sdhci: Export sdhci_enable_sdio_irq() from
 sdhci.c
In-Reply-To: <cover.e0137cef24a16a2c7d795548de554993595d4a98.1481279228.git-series.gregory.clement@free-electrons.com>
References: <cover.e0137cef24a16a2c7d795548de554993595d4a98.1481279228.git-series.gregory.clement@free-electrons.com>
Message-ID: <04201111658cabdce1aa10767fa408da36636d64.1481279228.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hu Ziji <huziji@marvell.com>

Export sdhci_enable_sdio_irq() from sdhci.c. Thus vendor SDHC
driver can implement its specific SDIO irq contorl.

Signed-off-by: Hu Ziji <huziji@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/mmc/host/sdhci.c | 3 ++-
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e971abb1368f..e174379ee019 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1817,7 +1817,7 @@ static void sdhci_enable_sdio_irq_nolock(struct sdhci_host *host, int enable)
 	}
 }
 
-static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
+void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
 	unsigned long flags;
@@ -1831,6 +1831,7 @@ static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	sdhci_enable_sdio_irq_nolock(host, enable);
 	spin_unlock_irqrestore(&host->lock, flags);
 }
+EXPORT_SYMBOL_GPL(sdhci_enable_sdio_irq);
 
 int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 				      struct mmc_ios *ios)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 95beadc66849..a3e8913452fc 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -692,6 +692,7 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
 int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 				      struct mmc_ios *ios);
 int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
+void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable);
 
 #ifdef CONFIG_PM
 extern int sdhci_suspend_host(struct sdhci_host *host);
-- 
git-series 0.9.1
