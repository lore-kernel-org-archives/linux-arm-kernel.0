From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 19 Feb 2010 01:05:12 +0100
Subject: [PATCH 1/7] ARM: MMCI: remove custom DBG macro and printk
Message-ID: <1266537912-12020-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes the custom DBG macro in favor of the in-kernel
dev_dbg() macro. Probably a leftover from a time when dev_dbg()
didn't yet exist. Also remove a printk() in favor of dev_err().

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mmc/host/mmci.c |   30 ++++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 643818a..84c103a 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -2,6 +2,7 @@
  *  linux/drivers/mmc/host/mmci.c - ARM PrimeCell MMCI PL180/1 driver
  *
  *  Copyright (C) 2003 Deep Blue Solutions, Ltd, All Rights Reserved.
+ *  Copyright (C) 2010 ST-Ericsson AB.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -34,9 +35,6 @@
 
 #define DRIVER_NAME "mmci-pl18x"
 
-#define DBG(host,fmt,args...)	\
-	pr_debug("%s: %s: " fmt, mmc_hostname(host->mmc), __func__ , args)
-
 static unsigned int fmax = 515633;
 
 /*
@@ -105,8 +103,8 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	void __iomem *base;
 	int blksz_bits;
 
-	DBG(host, "blksz %04x blks %04x flags %08x\n",
-	    data->blksz, data->blocks, data->flags);
+	dev_dbg(mmc_dev(host->mmc), "blksz %04x blks %04x flags %08x\n",
+		data->blksz, data->blocks, data->flags);
 
 	host->data = data;
 	host->size = data->blksz;
@@ -155,7 +153,7 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
 {
 	void __iomem *base = host->base;
 
-	DBG(host, "op %02x arg %08x flags %08x\n",
+	dev_dbg(mmc_dev(host->mmc), "op %02x arg %08x flags %08x\n",
 	    cmd->opcode, cmd->arg, cmd->flags);
 
 	if (readl(base + MMCICOMMAND) & MCI_CPSM_ENABLE) {
@@ -197,6 +195,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 #endif
 	}
 	if (status & (MCI_DATACRCFAIL|MCI_DATATIMEOUT|MCI_TXUNDERRUN|MCI_RXOVERRUN)) {
+		dev_dbg(mmc_dev(host->mmc), "MCI ERROR IRQ (status %08x)\n", status);
 		if (status & MCI_DATACRCFAIL)
 			data->error = -EILSEQ;
 		else if (status & MCI_DATATIMEOUT)
@@ -318,7 +317,7 @@ static irqreturn_t mmci_pio_irq(int irq, void *dev_id)
 
 	status = readl(base + MMCISTATUS);
 
-	DBG(host, "irq1 %08x\n", status);
+	dev_dbg(mmc_dev(host->mmc), "irq1 (pio) %08x\n", status);
 
 	do {
 		unsigned long flags;
@@ -412,7 +411,7 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 		status &= readl(host->base + MMCIMASK0);
 		writel(status, host->base + MMCICLEAR);
 
-		DBG(host, "irq0 %08x\n", status);
+		dev_dbg(mmc_dev(host->mmc), "irq0 (data+cmd) %08x\n", status);
 
 		data = host->data;
 		if (status & (MCI_DATACRCFAIL|MCI_DATATIMEOUT|MCI_TXUNDERRUN|
@@ -439,8 +438,8 @@ static void mmci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	WARN_ON(host->mrq != NULL);
 
 	if (mrq->data && !is_power_of_2(mrq->data->blksz)) {
-		printk(KERN_ERR "%s: Unsupported block size (%d bytes)\n",
-			mmc_hostname(mmc), mrq->data->blksz);
+		dev_err(mmc_dev(mmc), "unsupported block size (%d bytes)\n",
+			mrq->data->blksz);
 		mrq->cmd->error = -EINVAL;
 		mmc_request_done(mmc, mrq);
 		return;
@@ -593,8 +592,8 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 
 	host->hw_designer = amba_manf(dev);
 	host->hw_revision = amba_rev(dev);
-	DBG(host, "designer ID = 0x%02x\n", host->hw_designer);
-	DBG(host, "revision = 0x%01x\n", host->hw_revision);
+	dev_dbg(mmc_dev(mmc), "designer ID = 0x%02x\n", host->hw_designer);
+	dev_dbg(mmc_dev(mmc), "revision = 0x%01x\n", host->hw_revision);
 
 	host->clk = clk_get(&dev->dev, NULL);
 	if (IS_ERR(host->clk)) {
@@ -619,7 +618,8 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 		if (ret < 0)
 			goto clk_disable;
 		host->mclk = clk_get_rate(host->clk);
-		DBG(host, "eventual mclk rate: %u Hz\n", host->mclk);
+		dev_dbg(mmc_dev(mmc), "eventual mclk rate: %u Hz\n",
+			host->mclk);
 	}
 	host->base = ioremap(dev->res.start, resource_size(&dev->res));
 	if (!host->base) {
@@ -630,6 +630,8 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 	mmc->ops = &mmci_ops;
 	mmc->f_min = (host->mclk + 511) / 512;
 	mmc->f_max = min(host->mclk, fmax);
+	dev_dbg(mmc_dev(mmc), "clocking block at %u Hz\n", mmc->f_max);
+
 #ifdef CONFIG_REGULATOR
 	/* If we're using the regulator framework, try to fetch a regulator */
 	host->vcc = regulator_get(&dev->dev, "vmmc");
@@ -723,7 +725,7 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 
 	mmc_add_host(mmc);
 
-	printk(KERN_INFO "%s: MMCI rev %x cfg %02x at 0x%016llx irq %d,%d\n",
+	dev_info(&dev->dev, "%s: MMCI rev %x cfg %02x at 0x%016llx irq %d,%d\n",
 		mmc_hostname(mmc), amba_rev(dev), amba_config(dev),
 		(unsigned long long)dev->res.start, dev->irq[0], dev->irq[1]);
 
-- 
1.6.6
