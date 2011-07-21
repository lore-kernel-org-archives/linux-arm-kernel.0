From: zhangfei.gao@marvell.com (Zhangfei Gao)
Date: Thu, 21 Jul 2011 10:34:32 +0800
Subject: [PATCH] mmc: sdio add regulator vsdio
In-Reply-To: <1311215673-2489-1-git-send-email-zhangfei.gao@marvell.com>
References: <1311215673-2489-1-git-send-email-zhangfei.gao@marvell.com>
Message-ID: <1311215673-2489-2-git-send-email-zhangfei.gao@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sdio client may be required power on/off dynamically.
With regulator vsdio, sdio client power on/off could be executed by mmc_power_up/down

CC: Ohad Ben-Cohen <ohad@wizery.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 drivers/mmc/host/sdhci.c  |   24 ++++++++++++++++++++++++
 include/linux/mmc/sdhci.h |    2 ++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 790f959..61fff10 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1295,6 +1295,18 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	sdhci_set_clock(host, ios->clock);
 
+	if (host->vsdio) {
+		if (ios->power_mode != host->power_mode_old) {
+			if (ios->power_mode == MMC_POWER_OFF)
+				regulator_disable(host->vsdio);
+
+			if (ios->power_mode == MMC_POWER_UP)
+				regulator_enable(host->vsdio);
+		}
+
+		host->power_mode_old = ios->power_mode;
+	}
+
 	if (ios->power_mode == MMC_POWER_OFF)
 		sdhci_set_power(host, -1);
 	else
@@ -2751,6 +2763,13 @@ int sdhci_add_host(struct sdhci_host *host)
 		regulator_enable(host->vmmc);
 	}
 
+	host->vsdio = regulator_get(mmc_dev(mmc), "vsdio");
+	if (IS_ERR(host->vsdio))
+		host->vsdio = NULL;
+	else
+		printk(KERN_INFO "%s: vsdio regulator found\n",
+			mmc_hostname(mmc));
+
 	sdhci_init(host, 0);
 
 #ifdef CONFIG_MMC_DEBUG
@@ -2842,6 +2861,11 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 		regulator_put(host->vmmc);
 	}
 
+	if (host->vsdio) {
+		regulator_disable(host->vsdio);
+		regulator_put(host->vsdio);
+	}
+
 	kfree(host->adma_desc);
 	kfree(host->align_buffer);
 
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 13c13f8..bea07c7 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -94,6 +94,8 @@ struct sdhci_host {
 	const struct sdhci_ops *ops;	/* Low level hw interface */
 
 	struct regulator *vmmc;	/* Power regulator */
+	struct regulator *vsdio;	/* sdio Power regulator */
+	unsigned char power_mode_old;	/* power supply mode */
 
 	/* Internal data */
 	struct mmc_host *mmc;	/* MMC structure */
-- 
1.6.0.4
