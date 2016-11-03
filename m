From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Thu, 03 Nov 2016 15:21:27 +0900
Subject: [PATCH 05/13] mmc: dw_mmc: call the dw_mci_prep_stop_abort() by
 default
In-Reply-To: <20161103062135.10697-1-jh80.chung@samsung.com>
References: <20161103062135.10697-1-jh80.chung@samsung.com>
Message-ID: <20161103062135.10697-6-jh80.chung@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

stop_cmdr should be set to values relevant to stop command.
It migth be assigned to values whatever there is mrq->stop or not.
Then it doesn't need to use dw_mci_prepare_command().
It's enough to use the prep_stop_abort for preparing stop command.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 23fc505..16df93b 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -385,7 +385,7 @@ static void dw_mci_start_command(struct dw_mci *host,
 
 static inline void send_stop_abort(struct dw_mci *host, struct mmc_data *data)
 {
-	struct mmc_command *stop = data->stop ? data->stop : &host->stop_abort;
+	struct mmc_command *stop = &host->stop_abort;
 
 	dw_mci_start_command(host, stop, host->stop_cmdr);
 }
@@ -1277,10 +1277,7 @@ static void __dw_mci_start_request(struct dw_mci *host,
 		spin_unlock_irqrestore(&host->irq_lock, irqflags);
 	}
 
-	if (mrq->stop)
-		host->stop_cmdr = dw_mci_prepare_command(slot->mmc, mrq->stop);
-	else
-		host->stop_cmdr = dw_mci_prep_stop_abort(host, cmd);
+	host->stop_cmdr = dw_mci_prep_stop_abort(host, cmd);
 }
 
 static void dw_mci_start_request(struct dw_mci *host,
@@ -1890,8 +1887,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
 			if (test_and_clear_bit(EVENT_DATA_ERROR,
 					       &host->pending_events)) {
 				dw_mci_stop_dma(host);
-				if (data->stop ||
-				    !(host->data_status & (SDMMC_INT_DRTO |
+				if (!(host->data_status & (SDMMC_INT_DRTO |
 							   SDMMC_INT_EBE)))
 					send_stop_abort(host, data);
 				state = STATE_DATA_ERROR;
@@ -1927,8 +1923,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
 			if (test_and_clear_bit(EVENT_DATA_ERROR,
 					       &host->pending_events)) {
 				dw_mci_stop_dma(host);
-				if (data->stop ||
-				    !(host->data_status & (SDMMC_INT_DRTO |
+				if (!(host->data_status & (SDMMC_INT_DRTO |
 							   SDMMC_INT_EBE)))
 					send_stop_abort(host, data);
 				state = STATE_DATA_ERROR;
@@ -2004,7 +1999,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
 			host->cmd = NULL;
 			host->data = NULL;
 
-			if (mrq->stop)
+			if (!mrq->sbc && mrq->stop)
 				dw_mci_command_complete(host, mrq->stop);
 			else
 				host->cmd_status = 0;
-- 
2.10.1
