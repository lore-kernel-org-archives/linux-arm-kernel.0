From: addy.ke@rock-chips.com (Addy Ke)
Date: Mon, 26 Jan 2015 20:04:09 +0800
Subject: [PATCH] mmc: dw_mmc: fix bug that cause mmc_test failture
Message-ID: <1422273849-29773-1-git-send-email-addy.ke@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The STOP command can terminate a data transfer between a memory card and
mmc controller.

As show in Synopsys DesignWare Cores Mobile Stroage Host Databook:
Data timeout and Data end-bit error will terminate further data transfer
by mmc controller. So we should not send abort command to terminate a
data transfer again if we got DRTO and EBE interrupt.

After this patch, all mmc_test cases can pass on RK3288-Pink2 board.

Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
---
 drivers/mmc/host/dw_mmc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 4d2e3c2..4bd7df1 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1520,7 +1520,10 @@ static void dw_mci_tasklet_func(unsigned long priv)
 			if (test_and_clear_bit(EVENT_DATA_ERROR,
 					       &host->pending_events)) {
 				dw_mci_stop_dma(host);
-				send_stop_abort(host, data);
+				if (data->stop ||
+				    !(host->data_status & SDMMC_INT_DRTO) ||
+				    !(host->data_status & SDMMC_INT_EBE))
+					send_stop_abort(host, data);
 				state = STATE_DATA_ERROR;
 				break;
 			}
@@ -1547,7 +1550,10 @@ static void dw_mci_tasklet_func(unsigned long priv)
 			if (test_and_clear_bit(EVENT_DATA_ERROR,
 					       &host->pending_events)) {
 				dw_mci_stop_dma(host);
-				send_stop_abort(host, data);
+				if (data->stop ||
+				    !(host->data_status & SDMMC_INT_DRTO) ||
+				    !(host->data_status & SDMMC_INT_EBE))
+					send_stop_abort(host, data);
 				state = STATE_DATA_ERROR;
 				break;
 			}
-- 
1.8.3.2
