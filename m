From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 4 Sep 2013 20:54:11 +0800
Subject: [PATCH 2/8] mmc: sdhci: allow platform access of sdhci_send_command
In-Reply-To: <1378299257-2980-1-git-send-email-b29396@freescale.com>
References: <1378299257-2980-1-git-send-email-b29396@freescale.com>
Message-ID: <1378299257-2980-3-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It helps for platform code to use it send tuning commands.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci.c |    4 ++--
 drivers/mmc/host/sdhci.h |    2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2890cfd..ae8200a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -49,7 +49,6 @@ static unsigned int debug_quirks2;
 
 static void sdhci_finish_data(struct sdhci_host *);
 
-static void sdhci_send_command(struct sdhci_host *, struct mmc_command *);
 static void sdhci_finish_command(struct sdhci_host *);
 static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
 static void sdhci_tuning_timer(unsigned long data);
@@ -981,7 +980,7 @@ static void sdhci_finish_data(struct sdhci_host *host)
 		tasklet_schedule(&host->finish_tasklet);
 }
 
-static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
+void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	int flags;
 	u32 mask;
@@ -1053,6 +1052,7 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 
 	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
 }
+EXPORT_SYMBOL_GPL(sdhci_send_command);
 
 static void sdhci_finish_command(struct sdhci_host *host)
 {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 976c14b..0a3ed01 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -394,6 +394,8 @@ static inline void *sdhci_priv(struct sdhci_host *host)
 extern void sdhci_card_detect(struct sdhci_host *host);
 extern int sdhci_add_host(struct sdhci_host *host);
 extern void sdhci_remove_host(struct sdhci_host *host, int dead);
+extern void sdhci_send_command(struct sdhci_host *host,
+				struct mmc_command *cmd);
 
 #ifdef CONFIG_PM
 extern int sdhci_suspend_host(struct sdhci_host *host);
-- 
1.7.1
