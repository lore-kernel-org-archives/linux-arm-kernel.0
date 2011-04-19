From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 19 Apr 2011 11:02:34 +0200
Subject: [PATCH] mmci: sync DATAEND irq with dma transfer done
Message-ID: <1303203754-1731-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@stericsson.com>

The end of a dma job must be synced with a DATAEND irq. This will
prevent the mmci driver from ending the mmc request before the
dma driver is completely done. By using DMA_PREP_INTERRUPT we
register a callback function which will is called when from the
dma driver when the dma transfer is completed.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c |  128 +++++++++++++++++++++++++++++++----------------
 drivers/mmc/host/mmci.h |    3 +
 2 files changed, 87 insertions(+), 44 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 4941e06..67e3e4b 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -196,6 +196,53 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
 	sg_miter_start(&host->sg_miter, data->sg, data->sg_len, flags);
 }
 
+static void
+mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
+{
+	void __iomem *base = host->base;
+
+	dev_dbg(mmc_dev(host->mmc), "op %02x arg %08x flags %08x\n",
+	    cmd->opcode, cmd->arg, cmd->flags);
+
+	if (readl(base + MMCICOMMAND) & MCI_CPSM_ENABLE) {
+		writel(0, base + MMCICOMMAND);
+		udelay(1);
+	}
+
+	c |= cmd->opcode | MCI_CPSM_ENABLE;
+	if (cmd->flags & MMC_RSP_PRESENT) {
+		if (cmd->flags & MMC_RSP_136)
+			c |= MCI_CPSM_LONGRSP;
+		c |= MCI_CPSM_RESPONSE;
+	}
+	if (/*interrupt*/0)
+		c |= MCI_CPSM_INTERRUPT;
+
+	host->cmd = cmd;
+
+	writel(cmd->arg, base + MMCIARGUMENT);
+	writel(c, base + MMCICOMMAND);
+}
+
+static void mmci_complete_data_xfer(struct mmci_host *host)
+{
+	struct mmc_data *data = host->data;
+
+	if ((host->size == 0) || data->error) {
+
+		mmci_stop_data(host);
+
+		if (!data->error)
+			data->bytes_xfered = data->blksz * data->blocks;
+
+		if (!data->stop) {
+			mmci_request_end(host, data->mrq);
+		} else {
+			mmci_start_command(host, data->stop, 0);
+		}
+	}
+}
+
 /*
  * All the DMA operation mode stuff goes inside this ifdef.
  * This assumes that you have a generic DMA device interface,
@@ -334,6 +381,28 @@ static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
 	}
 }
 
+static void mmci_dma_callback(void *arg)
+{
+	unsigned long flags;
+	struct mmci_host *host = arg;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	mmci_dma_unmap(host, host->data);
+
+	/* Mark that the entire data is transferred for this dma session. */
+	host->size = 0;
+
+	/*
+	 * Make sure we have received a MCI_DATAEND irq before
+	 * completing the data transfer.
+	 */
+	if (host->dataend)
+		mmci_complete_data_xfer(host);
+
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
 static void mmci_dma_data_error(struct mmci_host *host)
 {
 	dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
@@ -382,10 +451,15 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 
 	dmaengine_slave_config(chan, &conf);
 	desc = device->device_prep_slave_sg(chan, data->sg, nr_sg,
-					    conf.direction, DMA_CTRL_ACK);
+					    conf.direction,
+					    DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
 	if (!desc)
 		goto unmap_exit;
 
+	/* Setup dma callback function. */
+	desc->callback = mmci_dma_callback;
+	desc->callback_param = host;
+
 	/* Okay, go for it. */
 	host->dma_current = chan;
 
@@ -451,6 +525,7 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 
 	host->data = data;
 	host->size = data->blksz * data->blocks;
+	host->dataend = false;
 	data->bytes_xfered = 0;
 
 	clks = (unsigned long long)data->timeout_ns * host->cclk;
@@ -509,34 +584,6 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 }
 
 static void
-mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
-{
-	void __iomem *base = host->base;
-
-	dev_dbg(mmc_dev(host->mmc), "op %02x arg %08x flags %08x\n",
-	    cmd->opcode, cmd->arg, cmd->flags);
-
-	if (readl(base + MMCICOMMAND) & MCI_CPSM_ENABLE) {
-		writel(0, base + MMCICOMMAND);
-		udelay(1);
-	}
-
-	c |= cmd->opcode | MCI_CPSM_ENABLE;
-	if (cmd->flags & MMC_RSP_PRESENT) {
-		if (cmd->flags & MMC_RSP_136)
-			c |= MCI_CPSM_LONGRSP;
-		c |= MCI_CPSM_RESPONSE;
-	}
-	if (/*interrupt*/0)
-		c |= MCI_CPSM_INTERRUPT;
-
-	host->cmd = cmd;
-
-	writel(cmd->arg, base + MMCIARGUMENT);
-	writel(c, base + MMCICOMMAND);
-}
-
-static void
 mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 	      unsigned int status)
 {
@@ -581,21 +628,11 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 	if (status & MCI_DATABLOCKEND)
 		dev_err(mmc_dev(host->mmc), "stray MCI_DATABLOCKEND interrupt\n");
 
-	if (status & MCI_DATAEND || data->error) {
-		if (dma_inprogress(host))
-			mmci_dma_unmap(host, data);
-		mmci_stop_data(host);
-
-		if (!data->error)
-			/* The error clause is handled above, success! */
-			data->bytes_xfered = data->blksz * data->blocks;
+	if (status & MCI_DATAEND)
+		host->dataend = true;
 
-		if (!data->stop) {
-			mmci_request_end(host, data->mrq);
-		} else {
-			mmci_start_command(host, data->stop, 0);
-		}
-	}
+	if (host->dataend || data->error)
+		mmci_complete_data_xfer(host);
 }
 
 static void
@@ -618,8 +655,11 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	}
 
 	if (!cmd->data || cmd->error) {
-		if (host->data)
+		if (host->data) {
+			if (dma_inprogress(host))
+				mmci_dma_data_error(host);
 			mmci_stop_data(host);
+		}
 		mmci_request_end(host, cmd->mrq);
 	} else if (!(cmd->data->flags & MMC_DATA_READ)) {
 		mmci_start_data(host, cmd->data);
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index bb32e21..3f98d9d 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -195,6 +195,9 @@ struct mmci_host {
 	unsigned int		size;
 	struct regulator	*vcc;
 
+	/* sync of DATAEND irq */
+	bool			dataend;
+
 #ifdef CONFIG_DMA_ENGINE
 	/* DMA stuff */
 	struct dma_chan		*dma_current;
-- 
1.7.3.2
