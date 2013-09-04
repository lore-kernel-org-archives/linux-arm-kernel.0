From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 4 Sep 2013 20:54:10 +0800
Subject: [PATCH 1/8] mmc: sdhci: add hooks for platform specific tuning
In-Reply-To: <1378299257-2980-1-git-send-email-b29396@freescale.com>
References: <1378299257-2980-1-git-send-email-b29396@freescale.com>
Message-ID: <1378299257-2980-2-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tuning of some platforms may not follow the standard host control
spec v3.0, e.g. Freescale uSDHC on i.MX6Q/DL.
Add a hook here to allow execute platform specific tuning instead of
standard host controller tuning.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci.c |    8 ++++++++
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index dd2c083..2890cfd 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1875,6 +1875,14 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		return 0;
 	}
 
+	if (host->ops->platform_execute_tuning) {
+		spin_unlock(&host->lock);
+		enable_irq(host->irq);
+		err = host->ops->platform_execute_tuning(host, opcode);
+		sdhci_runtime_pm_put(host);
+		return err;
+	}
+
 	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 
 	/*
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index b037f18..976c14b 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -288,6 +288,7 @@ struct sdhci_ops {
 	unsigned int    (*get_ro)(struct sdhci_host *host);
 	void	(*platform_reset_enter)(struct sdhci_host *host, u8 mask);
 	void	(*platform_reset_exit)(struct sdhci_host *host, u8 mask);
+	int	(*platform_execute_tuning)(struct sdhci_host *host, u32 opcode);
 	int	(*set_uhs_signaling)(struct sdhci_host *host, unsigned int uhs);
 	void	(*hw_reset)(struct sdhci_host *host);
 	void	(*platform_suspend)(struct sdhci_host *host);
-- 
1.7.1
