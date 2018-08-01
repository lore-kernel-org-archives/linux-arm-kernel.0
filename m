From: ludovic.Barre@st.com (Ludovic Barre)
Date: Wed, 1 Aug 2018 11:36:50 +0200
Subject: [PATCH 03/14] mmc: mmci: internalize dma_inprogress into mmci dma
 functions
In-Reply-To: <1533116221-380-1-git-send-email-ludovic.Barre@st.com>
References: <1533116221-380-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1533116221-380-4-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch internalizes the dma_inprogress into mmci dma interfaces.
This allows to simplify and prepare the next dma callbacks
for mmci host ops. __dma_inprogress is called in mmci_dma_data_error
and mmci_dma_finalize.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 16 ++++++++++------
 drivers/mmc/host/mmci.h |  4 +---
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index d8fa178..8144a87 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -497,6 +497,9 @@ static void __mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
 
 static void mmci_dma_data_error(struct mmci_host *host)
 {
+	if (!__dma_inprogress(host))
+		return;
+
 	dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
 	dmaengine_terminate_all(host->dma_current);
 	host->dma_in_progress = false;
@@ -512,6 +515,9 @@ static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
 	u32 status;
 	int i;
 
+	if (!__dma_inprogress(dmae))
+		return;
+
 	/* Wait up to 1ms for the DMA to complete */
 	for (i = 0; ; i++) {
 		status = readl(host->base + MMCISTATUS);
@@ -903,8 +909,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 		u32 remain, success;
 
 		/* Terminate the DMA transfer */
-		if (dma_inprogress(host))
-			mmci_dma_data_error(host);
+		mmci_dma_data_error(host);
 
 		/*
 		 * Calculate how far we are into the transfer.  Note that
@@ -942,8 +947,8 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 		dev_err(mmc_dev(host->mmc), "stray MCI_DATABLOCKEND interrupt\n");
 
 	if (status & MCI_DATAEND || data->error) {
-		if (dma_inprogress(host))
-			mmci_dma_finalize(host, data);
+		mmci_dma_finalize(host, data);
+
 		mmci_stop_data(host);
 
 		if (!data->error)
@@ -1050,8 +1055,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	if ((!sbc && !cmd->data) || cmd->error) {
 		if (host->data) {
 			/* Terminate the DMA transfer */
-			if (dma_inprogress(host))
-				mmci_dma_data_error(host);
+			mmci_dma_data_error(host);
 
 			mmci_stop_data(host);
 		}
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 696a066..f1ec066 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -332,9 +332,7 @@ struct mmci_host {
 	struct mmci_host_next	next_data;
 	bool			dma_in_progress;
 
-#define dma_inprogress(host)	((host)->dma_in_progress)
-#else
-#define dma_inprogress(host)	(0)
+#define __dma_inprogress(host)	((host)->dma_in_progress)
 #endif
 };
 
-- 
2.7.4
