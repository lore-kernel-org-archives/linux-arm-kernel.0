From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Thu, 27 May 2010 19:54:44 +0200
Subject: [PATCH] mxcmmc: add card detect through DAT3 possibility
In-Reply-To: <1274287568-30253-9-git-send-email-eric@eukrea.com>
References: <1274287568-30253-9-git-send-email-eric@eukrea.com>
Message-ID: <1274982884-13205-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
To: s.hauer at pengutronix.de
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-mmc at vger.kernel.org
---
 arch/arm/plat-mxc/include/mach/mmc.h |    3 +++
 drivers/mmc/host/mxcmmc.c            |   16 +++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mmc.h b/arch/arm/plat-mxc/include/mach/mmc.h
index de2128d..29115f4 100644
--- a/arch/arm/plat-mxc/include/mach/mmc.h
+++ b/arch/arm/plat-mxc/include/mach/mmc.h
@@ -31,6 +31,9 @@ struct imxmmc_platform_data {
 
 	/* adjust slot voltage */
 	void (*setpower)(struct device *, unsigned int vdd);
+
+	/* enable card detect using DAT3 */
+	int dat3_card_detect;
 };
 
 #endif
diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index ec18e3b..74c87e0 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -119,6 +119,7 @@ struct mxcmci_host {
 	int			detect_irq;
 	int			dma;
 	int			do_dma;
+	int			default_irq_mask;
 	int			use_sdio;
 	unsigned int		power_mode;
 	struct imxmmc_platform_data *pdata;
@@ -228,7 +229,7 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
 static int mxcmci_start_cmd(struct mxcmci_host *host, struct mmc_command *cmd,
 		unsigned int cmdat)
 {
-	u32 int_cntr;
+	u32 int_cntr = host->default_irq_mask;
 	unsigned long flags;
 
 	WARN_ON(host->cmd != NULL);
@@ -275,7 +276,7 @@ static int mxcmci_start_cmd(struct mxcmci_host *host, struct mmc_command *cmd,
 static void mxcmci_finish_request(struct mxcmci_host *host,
 		struct mmc_request *req)
 {
-	u32 int_cntr = 0;
+	u32 int_cntr = host->default_irq_mask;
 	unsigned long flags;
 
 	spin_lock_irqsave(&host->lock, flags);
@@ -585,6 +586,9 @@ static irqreturn_t mxcmci_irq(int irq, void *devid)
 		  (stat & (STATUS_DATA_TRANS_DONE | STATUS_WRITE_OP_DONE)))
 		mxcmci_data_done(host, stat);
 #endif
+	if (host->default_irq_mask &&
+		  (stat & (STATUS_CARD_INSERTION | STATUS_CARD_REMOVAL)))
+		mmc_detect_change(host->mmc, msecs_to_jiffies(200));
 	return IRQ_HANDLED;
 }
 
@@ -809,6 +813,12 @@ static int mxcmci_probe(struct platform_device *pdev)
 	else
 		mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
 
+	if (host->pdata && host->pdata->dat3_card_detect)
+		host->default_irq_mask =
+			INT_CARD_INSERTION_EN | INT_CARD_REMOVAL_EN;
+	else
+		host->default_irq_mask = 0;
+
 	host->res = r;
 	host->irq = irq;
 
@@ -835,7 +845,7 @@ static int mxcmci_probe(struct platform_device *pdev)
 	/* recommended in data sheet */
 	writew(0x2db4, host->base + MMC_REG_READ_TO);
 
-	writel(0, host->base + MMC_REG_INT_CNTR);
+	writel(host->default_irq_mask, host->base + MMC_REG_INT_CNTR);
 
 #ifdef HAS_DMA
 	host->dma = imx_dma_request_by_prio(DRIVER_NAME, DMA_PRIO_LOW);
-- 
1.6.3.3
