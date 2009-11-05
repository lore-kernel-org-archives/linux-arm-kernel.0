From: daniel@caiaq.de (Daniel Mack)
Date: Thu,  5 Nov 2009 18:13:36 +0100
Subject: [PATCH 3/3] ARM: MXC: mxcmmc: Teach the driver SDIO operations
In-Reply-To: <1257441216-19604-3-git-send-email-daniel@caiaq.de>
References: <1257441216-19604-1-git-send-email-daniel@caiaq.de>
	<1257441216-19604-2-git-send-email-daniel@caiaq.de>
	<1257441216-19604-3-git-send-email-daniel@caiaq.de>
Message-ID: <1257441216-19604-4-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Successfully tested on MX31 hardware using libertas SDIO peripherals.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 drivers/mmc/host/mxcmmc.c |   48 ++++++++++++++++++++++++++++++++++++--------
 1 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 8aa6de0..01324c5 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -119,6 +119,7 @@ struct mxcmci_host {
 	int			detect_irq;
 	int			dma;
 	int			do_dma;
+	int			use_sdio;
 	unsigned int		power_mode;
 	struct imxmmc_platform_data *pdata;
 
@@ -138,6 +139,7 @@ struct mxcmci_host {
 	int			clock;
 
 	struct work_struct	datawork;
+	spinlock_t		lock;
 };
 
 static void mxcmci_set_clk_rate(struct mxcmci_host *host, unsigned int clk_ios);
@@ -226,6 +228,8 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
 static int mxcmci_start_cmd(struct mxcmci_host *host, struct mmc_command *cmd,
 		unsigned int cmdat)
 {
+	u32 int_cntr;
+
 	WARN_ON(host->cmd != NULL);
 	host->cmd = cmd;
 
@@ -249,13 +253,15 @@ static int mxcmci_start_cmd(struct mxcmci_host *host, struct mmc_command *cmd,
 		return -EINVAL;
 	}
 
+	int_cntr = INT_END_CMD_RES_EN;
+
 	if (mxcmci_use_dma(host))
-		writel(INT_READ_OP_EN | INT_WRITE_OP_DONE_EN |
-				INT_END_CMD_RES_EN,
-				host->base + MMC_REG_INT_CNTR);
-	else
-		writel(INT_END_CMD_RES_EN, host->base + MMC_REG_INT_CNTR);
+		int_cntr |= INT_READ_OP_EN | INT_WRITE_OP_DONE_EN;
+
+	if (host->use_sdio)
+		int_cntr |= INT_SDIO_IRQ_EN;
 
+	writel(int_cntr, host->base + MMC_REG_INT_CNTR);
 	writew(cmd->opcode, host->base + MMC_REG_CMD);
 	writel(cmd->arg, host->base + MMC_REG_ARG);
 	writew(cmdat, host->base + MMC_REG_CMD_DAT_CONT);
@@ -536,8 +542,12 @@ static irqreturn_t mxcmci_irq(int irq, void *devid)
 
 	dev_dbg(mmc_dev(host->mmc), "%s: 0x%08x\n", __func__, stat);
 
+	if ((stat & STATUS_SDIO_INT_ACTIVE) && host->use_sdio)
+		mmc_signal_sdio_irq(host->mmc);
+
 	if (stat & STATUS_END_CMD_RESP)
 		mxcmci_cmd_done(host, stat);
+
 #ifdef HAS_DMA
 	if (mxcmci_use_dma(host) &&
 		  (stat & (STATUS_DATA_TRANS_DONE | STATUS_WRITE_OP_DONE)))
@@ -674,11 +684,30 @@ static int mxcmci_get_ro(struct mmc_host *mmc)
 	return -ENOSYS;
 }
 
+static void mxcmci_enable_sdio_irq(struct mmc_host *mmc, int enable)
+{
+	struct mxcmci_host *host = mmc_priv(mmc);
+	unsigned long flags;
+	u32 int_cntr;
+
+	spin_lock_irqsave(&host->lock, flags);
+	host->use_sdio = enable;
+	int_cntr = readl(host->base + MMC_REG_INT_CNTR);
+
+	if (enable)
+		int_cntr |= INT_SDIO_IRQ_EN;
+	else
+		int_cntr &= ~INT_SDIO_IRQ_EN;
+
+	writel(int_cntr, host->base + MMC_REG_INT_CNTR);
+	spin_unlock_irqrestore(&host->lock, flags);
+}
 
 static const struct mmc_host_ops mxcmci_ops = {
-	.request	= mxcmci_request,
-	.set_ios	= mxcmci_set_ios,
-	.get_ro		= mxcmci_get_ro,
+	.request		= mxcmci_request,
+	.set_ios		= mxcmci_set_ios,
+	.get_ro			= mxcmci_get_ro,
+	.enable_sdio_irq	= mxcmci_enable_sdio_irq,
 };
 
 static int mxcmci_probe(struct platform_device *pdev)
@@ -706,7 +735,7 @@ static int mxcmci_probe(struct platform_device *pdev)
 	}
 
 	mmc->ops = &mxcmci_ops;
-	mmc->caps = MMC_CAP_4_BIT_DATA;
+	mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SDIO_IRQ;
 
 	/* MMC core transfer sizes tunable parameters */
 	mmc->max_hw_segs = 64;
@@ -725,6 +754,7 @@ static int mxcmci_probe(struct platform_device *pdev)
 
 	host->mmc = mmc;
 	host->pdata = pdev->dev.platform_data;
+	spin_lock_init(&host->lock);
 
 	if (host->pdata && host->pdata->ocr_avail)
 		mmc->ocr_avail = host->pdata->ocr_avail;
-- 
1.6.5.2
