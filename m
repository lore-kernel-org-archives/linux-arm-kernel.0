From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  9 Dec 2016 11:29:58 +0100
Subject: [PATCH v3 02/12] mmc: sdhci: Export
 sdhci_start_signal_voltage_switch() in sdhci.c
In-Reply-To: <cover.e0137cef24a16a2c7d795548de554993595d4a98.1481279228.git-series.gregory.clement@free-electrons.com>
References: <cover.e0137cef24a16a2c7d795548de554993595d4a98.1481279228.git-series.gregory.clement@free-electrons.com>
Message-ID: <e63f9c5a962426c811955927a322c967ff822607.1481279228.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hu Ziji <huziji@marvell.com>

Export sdhci_start_signal_voltage_switch() from sdhci.c.
Thus vendor sdhci driver can implement its own signal voltage
switch routine.

Signed-off-by: Hu Ziji <huziji@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/mmc/host/sdhci.c | 5 +++--
 drivers/mmc/host/sdhci.h | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ea06faf8a437..8e6e4e37e3b4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1832,8 +1832,8 @@ static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
-static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
-					     struct mmc_ios *ios)
+int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
+				      struct mmc_ios *ios)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
 	u16 ctrl;
@@ -1925,6 +1925,7 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 		return 0;
 	}
 }
+EXPORT_SYMBOL_GPL(sdhci_start_signal_voltage_switch);
 
 static int sdhci_card_busy(struct mmc_host *mmc)
 {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 37771de4cafa..cd18b6f19c3b 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -689,6 +689,8 @@ void sdhci_set_bus_width(struct sdhci_host *host, int width);
 void sdhci_reset(struct sdhci_host *host, u8 mask);
 void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
 void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
+int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
+				      struct mmc_ios *ios);
 
 #ifdef CONFIG_PM
 extern int sdhci_suspend_host(struct sdhci_host *host);
-- 
git-series 0.9.1
