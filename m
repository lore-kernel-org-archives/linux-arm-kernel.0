From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Wed, 20 Nov 2013 16:01:11 +0100
Subject: [PATCH] mmc: atmel-mci: fix timeout errors in SDIO mode when using DMA
Message-ID: <1384959671-5646-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

With some SDIO devices, timeout errors can happen when reading data. To solve
this issue the DMA transfer has to be activated before sending the command to
the device. This order is incorrect in PDC mode. So we have to take care if we
are using DMA or PDC to know when to send the MMC command.

Cc: <stable@vger.kernel.org> #3.2+
Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/atmel-mci.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index b8dfe0d..289da71 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1193,11 +1193,22 @@ static void atmci_start_request(struct atmel_mci *host,
 	iflags |= ATMCI_CMDRDY;
 	cmd = mrq->cmd;
 	cmdflags = atmci_prepare_command(slot->mmc, cmd);
-	atmci_send_command(host, cmd, cmdflags);
+
+	/*
+	 * DMA transfer should be started before sending the command to avoid
+	 * unexpected errors especially for read operations in SDIO mode.
+	 * Unfortunately, in PDC mode, command has to be sent before starting
+	 * the transfer.
+	 */
+	if (host->submit_data != &atmci_submit_data_dma)
+		atmci_send_command(host, cmd, cmdflags);
 
 	if (data)
 		host->submit_data(host, data);
 
+	if (host->submit_data == &atmci_submit_data_dma)
+		atmci_send_command(host, cmd, cmdflags);
+
 	if (mrq->stop) {
 		host->stop_cmdr = atmci_prepare_command(slot->mmc, mrq->stop);
 		host->stop_cmdr |= ATMCI_CMDR_STOP_XFER;
-- 
1.7.9.5
