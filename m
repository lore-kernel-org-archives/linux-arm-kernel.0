From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 11 Jan 2017 18:19:07 +0100
Subject: [PATCH v5 04/12] mmc: sdhci: Export sdhci_enable_sdio_irq() from
 sdhci.c
In-Reply-To: <cover.8527229dae6c124f24c5e637430c2cdc86f80392.1484154449.git-series.gregory.clement@free-electrons.com>
References: <cover.8527229dae6c124f24c5e637430c2cdc86f80392.1484154449.git-series.gregory.clement@free-electrons.com>
Message-ID: <ed779664ae0187f88688610cdb0432f628ec8ef5.1484154449.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hu Ziji <huziji@marvell.com>

Export sdhci_enable_sdio_irq() from sdhci.c.
Thus vendor SDHC driver can implement its specific SDIO irq
control.

Signed-off-by: Hu Ziji <huziji@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/mmc/host/sdhci.c | 3 ++-
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d2338dc362f4..9a4fda81ff81 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1824,7 +1824,7 @@ static void sdhci_enable_sdio_irq_nolock(struct sdhci_host *host, int enable)
 	}
 }
 
-static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
+void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
 	unsigned long flags;
@@ -1838,6 +1838,7 @@ static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	sdhci_enable_sdio_irq_nolock(host, enable);
 	spin_unlock_irqrestore(&host->lock, flags);
 }
+EXPORT_SYMBOL_GPL(sdhci_enable_sdio_irq);
 
 int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 				      struct mmc_ios *ios)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index e4a07543a12b..609783364941 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -694,6 +694,7 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
 void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
 int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 				      struct mmc_ios *ios);
+void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable);
 
 #ifdef CONFIG_PM
 extern int sdhci_suspend_host(struct sdhci_host *host);
-- 
git-series 0.9.1
