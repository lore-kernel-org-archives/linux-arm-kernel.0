From: addy.ke@rock-chips.com (Addy Ke)
Date: Fri, 20 Feb 2015 10:55:25 +0800
Subject: [PATCH v2] mmc: dw_mmc: fix bug that cause mmc_test failture
In-Reply-To: <1422273849-29773-1-git-send-email-addy.ke@rock-chips.com>
References: <1422273849-29773-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <1424400925-3867-1-git-send-email-addy.ke@rock-chips.com>
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
Changes in v2:
- DRTO and EBE are both set, should not send abort command too,
  suggested by Doug Anderson. 

 drivers/mmc/host/dw_mmc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 4d2e3c2..a27048a 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1520,7 +1520,10 @@ static void dw_mci_tasklet_func(unsigned long priv)
 			if (test_and_clear_bit(EVENT_DATA_ERROR,
 					       &host->pending_events)) {
 				dw_mci_stop_dma(host);
-				send_stop_abort(host, data);
+				if (data->stop ||
+				    !(host->data_status & (SDMMC_INT_DRTO |
+							   SDMMC_INT_EBE)))
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
+				    !(host->data_status & (SDMMC_INT_DRTO |
+							   SDMMC_INT_EBE)))
+					send_stop_abort(host, data);
 				state = STATE_DATA_ERROR;
 				break;
 			}
-- 
1.8.3.2
