From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Tue, 29 Nov 2011 15:51:26 +0100
Subject: [PATCH] mmc: mmci: Fixup error handling for dma
Message-ID: <1322578286-18727-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When getting a cmd irq during an ongoing data transfer
with dma, the dma job were never terminated. This is now
corrected.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Per Forlin <per.forlin@stericsson.com>
---
 drivers/mmc/host/mmci.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index e900f51..62ad649 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -761,8 +761,12 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	}
 
 	if (!cmd->data || cmd->error) {
-		if (host->data)
+		if (host->data) {
+			/* Terminate the DMA transfer */
+			if (dma_inprogress(host))
+				mmci_dma_data_error(host);
 			mmci_stop_data(host);
+		}
 		mmci_request_end(host, cmd->mrq);
 	} else if (!(cmd->data->flags & MMC_DATA_READ)) {
 		mmci_start_data(host, cmd->data);
-- 
1.7.5.4
