From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Thu, 2 Mar 2017 17:47:25 +0800
Subject: [PATCH 4/9] mmc: sdhci: add a callback for using tuning block
In-Reply-To: <1488448050-7574-1-git-send-email-yangbo.lu@nxp.com>
References: <1488448050-7574-1-git-send-email-yangbo.lu@nxp.com>
Message-ID: <1488448050-7574-5-git-send-email-yangbo.lu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some non-standard SD host controllers may use tuning block
for executing tuning procedure.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/mmc/host/sdhci.c | 3 +++
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3c9a924..051b192 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2166,6 +2166,9 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		goto out_unlock;
 	}
 
+	if (host->ops->set_tuning_block)
+		host->ops->set_tuning_block(host);
+
 	host->mmc->retune_period = tuning_count;
 
 	sdhci_start_tuning(host);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 04af687..d43519b 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -568,6 +568,7 @@ struct sdhci_ops {
 					 int card_drv, int *drv_type);
 	int	(*start_signal_voltage_switch)(struct sdhci_host *host,
 					       unsigned char signal_voltage);
+	void	(*set_tuning_block)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.1.0.27.g96db324
