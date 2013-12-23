From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 23 Dec 2013 21:50:08 +0800
Subject: [PATCH] mmc: sdhci: use time_after to replace mdelay-loop for timeout
Message-ID: <1387806608-3467-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Barry.Song@csr.com>

1ms busy-loop might be wasted when the condition "if(sdhci_readl(host,
SDHCI_PRESENT_STATE) & mask)" becomes false just after the if().
here we use time_after which will have no redundant busy-wait loop.

Signed-off-by: Barry Song <Barry.Song@csr.com>
Cc: Bin Shi <Bin.Shi@csr.com>
---
 drivers/mmc/host/sdhci.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index aac92bd..52f5289 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1036,9 +1036,6 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 
 	WARN_ON(host->cmd);
 
-	/* Wait max 10 ms */
-	timeout = 10;
-
 	mask = SDHCI_CMD_INHIBIT;
 	if ((cmd->data != NULL) || (cmd->flags & MMC_RSP_BUSY))
 		mask |= SDHCI_DATA_INHIBIT;
@@ -1048,8 +1045,11 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	if (host->mrq->data && (cmd == host->mrq->data->stop))
 		mask &= ~SDHCI_DATA_INHIBIT;
 
+	/* Wait max 10 ms */
+	timeout = jiffies + msecs_to_jiffies(10);
+
 	while (sdhci_readl(host, SDHCI_PRESENT_STATE) & mask) {
-		if (timeout == 0) {
+		if (time_after(jiffies, timeout)) {
 			pr_err("%s: Controller never released "
 				"inhibit bit(s).\n", mmc_hostname(host->mmc));
 			sdhci_dumpregs(host);
@@ -1057,8 +1057,6 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 			tasklet_schedule(&host->finish_tasklet);
 			return;
 		}
-		timeout--;
-		mdelay(1);
 	}
 
 	mod_timer(&host->timer, jiffies + 10 * HZ);
-- 
1.7.5.4
