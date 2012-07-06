From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri,  6 Jul 2012 11:58:33 +0200
Subject: [PATCH] mmc: atmel-mci: fix incorrect setting of host->data to NULL
Message-ID: <1341568713-8869-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setting host->data to NULL is incorrect sequence in STATE_SENDING_STOP
state of FSM: This early setting leads to the skip of dma_unmap_sg()
in atmci_dma_cleanup() which is a bug.

Idea taken form dw_mmc by Seungwon Jeon.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/atmel-mci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 78e5326..2ce109d 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1860,7 +1860,6 @@ static void atmci_tasklet_func(unsigned long priv)
 
 			dev_dbg(&host->pdev->dev, "FSM: cmd ready\n");
 			host->cmd = NULL;
-			host->data = NULL;
 			data->bytes_xfered = data->blocks * data->blksz;
 			data->error = 0;
 			atmci_command_complete(host, mrq->stop);
@@ -1874,6 +1873,7 @@ static void atmci_tasklet_func(unsigned long priv)
 				atmci_writel(host, ATMCI_IER, ATMCI_NOTBUSY);
 				state = STATE_WAITING_NOTBUSY;
 			}
+			host->data = NULL;
 			break;
 
 		case STATE_END_REQUEST:
-- 
1.7.5.4
