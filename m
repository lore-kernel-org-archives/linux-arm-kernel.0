From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 19 Feb 2010 01:05:42 +0100
Subject: [PATCH 4/7] ARM: MMCI: add DMA support using dmaengine
Message-ID: <1266537942-12830-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This extends the MMCI/PL180/PL181 driver with generic
support for DMA operation using the DMA engine, or rather
the DMA device part of the DMA engine.

This is done mainly by using the DMA device API, but
requiring that a DMA device supporting AMBA (PrimeCell)
devices include <linux/amba/dma.h> and implement
dma_set_ambaconfig() as a config path for all PrimeCell
specifics. We currently only pass in the target address
and bytewidth, but we can add attributes as needed by
other PrimeCells.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 drivers/mmc/host/mmci.c   |  286 ++++++++++++++++++++++++++++++++++++++-------
 drivers/mmc/host/mmci.h   |    7 +-
 include/linux/amba/dma.h  |   34 ++++++
 include/linux/amba/mmci.h |   14 +++
 4 files changed, 297 insertions(+), 44 deletions(-)
 create mode 100644 include/linux/amba/dma.h

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 1252cd6..a95c72a 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -23,8 +23,11 @@
 #include <linux/clk.h>
 #include <linux/scatterlist.h>
 #include <linux/gpio.h>
-#include <linux/amba/mmci.h>
 #include <linux/regulator/consumer.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/amba/dma.h>
+#include <linux/amba/mmci.h>
 
 #include <asm/cacheflush.h>
 #include <asm/div64.h>
@@ -96,12 +99,207 @@ static void mmci_stop_data(struct mmci_host *host)
 	host->data = NULL;
 }
 
+static void
+mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
+{
+	void __iomem *base = host->base;
+
+	dev_dbg(mmc_dev(host->mmc), "op %02x arg %08x flags %08x\n",
+		cmd->opcode, cmd->arg, cmd->flags);
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
+/*
+ * All the DMA operation mode stuff goes inside this ifdef.
+ * This assumes that you have a generic DMA device interface,
+ * no custom DMA interfaces are supported.
+ */
+#ifdef CONFIG_DMADEVICES
+static void __devinit mmci_setup_dma(struct mmci_host *host)
+{
+	struct mmci_platform_data *plat = host->plat;
+	struct amba_dma_channel_config rx_conf = {
+		.addr = host->phybase + MMCIFIFO,
+		.addr_width = 4,
+	};
+	struct amba_dma_channel_config tx_conf = {
+		.addr = host->phybase + MMCIFIFO,
+		.addr_width = 4,
+	};
+	dma_cap_mask_t mask;
+
+	/* Try to acquire a generic DMA engine slave channel */
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+	/*
+	 * If only an RX channel is specified, the driver will
+	 * attempt to use it bidirectionally, however if it is
+	 * is specified but cannot be located, DMA will be disabled.
+	 */
+	host->dma_rx_channel = dma_request_channel(mask,
+						plat->dma_filter,
+						plat->dma_rx_param);
+	if (host->dma_rx_channel)
+		dma_set_ambaconfig(host->dma_rx_channel, &rx_conf);
+	if (plat->dma_tx_param) {
+		host->dma_tx_channel = dma_request_channel(mask,
+							   plat->dma_filter,
+							   plat->dma_tx_param);
+		if (!host->dma_tx_channel) {
+			dma_release_channel(host->dma_rx_channel);
+			host->dma_rx_channel = NULL;
+		} else {
+			dma_set_ambaconfig(host->dma_tx_channel, &tx_conf);
+		}
+	} else {
+		host->dma_tx_channel = host->dma_rx_channel;
+	}
+}
+
+static void __devexit mmci_disable_dma(struct mmci_host *host)
+{
+	if (host->dma_rx_channel)
+		dma_release_channel(host->dma_rx_channel);
+	if (host->dma_tx_channel)
+		dma_release_channel(host->dma_tx_channel);
+}
+
+static void mmci_dma_data_end(struct mmci_host *host)
+{
+	struct mmc_data *data = host->data;
+
+	dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
+		     (data->flags & MMC_DATA_WRITE)
+		     ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+}
+
+static void mmci_dma_data_error(struct mmci_host *host)
+{
+	struct mmc_data *data = host->data;
+	struct dma_chan *chan;
+
+	dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
+	if (data->flags & MMC_DATA_READ)
+		chan = host->dma_rx_channel;
+	else
+		chan = host->dma_tx_channel;
+	dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
+		     (data->flags & MMC_DATA_WRITE)
+		     ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+	chan->device->device_terminate_all(chan);
+}
+
+/*
+ * This one gets called repeatedly to copy data using
+ * DMA until there is no more data left to copy.
+ */
+static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
+{
+	struct mmc_data *data = host->data;
+	enum dma_data_direction direction;
+	struct dma_chan *chan;
+	struct dma_async_tx_descriptor *desc;
+	struct scatterlist *sg;
+	unsigned int sglen;
+	int i;
+
+	datactrl |= MCI_DPSM_DMAENABLE;
+	if (data->flags & MMC_DATA_READ) {
+		direction = DMA_FROM_DEVICE;
+		chan = host->dma_rx_channel;
+	} else {
+		direction = DMA_TO_DEVICE;
+		chan = host->dma_tx_channel;
+	}
+
+	/* Check for weird stuff in the sg list */
+	for_each_sg(data->sg, sg, data->sg_len, i) {
+		if (sg->offset & 3 || sg->length & 3)
+			return -EINVAL;
+	}
+
+	sglen = dma_map_sg(mmc_dev(host->mmc), data->sg,
+			   data->sg_len, direction);
+	if (sglen != data->sg_len)
+		goto unmap_exit;
+
+	desc = chan->device->device_prep_slave_sg(chan,
+					data->sg, data->sg_len, direction,
+					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc)
+		goto unmap_exit;
+
+	host->dma_desc = desc;
+	dev_vdbg(mmc_dev(host->mmc), "Submit MMCI DMA job, sglen %d "
+		 "blksz %04x blks %04x flags %08x\n",
+		 sglen, data->blksz, data->blocks, data->flags);
+	desc->tx_submit(desc);
+	chan->device->device_issue_pending(chan);
+
+	/* Trigger the DMA transfer */
+	writel(datactrl, host->base + MMCIDATACTRL);
+	/*
+	 * Let the MMCI say when the data is ended and it's time
+	 * to fire next DMA request. When that happens, MMCI will
+	 * call mmci_data_end()
+	 */
+	writel(readl(host->base + MMCIMASK0) | MCI_DATAENDMASK,
+	       host->base + MMCIMASK0);
+	return 0;
+
+unmap_exit:
+	dma_unmap_sg(mmc_dev(host->mmc), data->sg, sglen, direction);
+	return -ENOMEM;
+}
+#else
+/* Blank functions if the DMA engine is not available */
+static inline void mmci_setup_dma(struct mmci_host *host)
+{
+}
+
+static inline void mmci_disable_dma(struct mmci_host *host)
+{
+}
+
+static inline void mmci_dma_data_end(struct mmci_host *host)
+{
+}
+
+static inline void mmci_dma_data_error(struct mmci_host *host)
+{
+}
+
+static inline int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
+{
+	return -ENOSYS;
+}
+#endif
+
 static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 {
 	unsigned int datactrl, timeout, irqmask;
 	unsigned long long clks;
 	void __iomem *base;
 	int blksz_bits;
+	int ret;
 
 	dev_dbg(mmc_dev(host->mmc), "blksz %04x blks %04x flags %08x\n",
 		data->blksz, data->blocks, data->flags);
@@ -110,8 +308,6 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	host->size = data->blksz;
 	host->data_xfered = 0;
 
-	mmci_init_sg(host, data);
-
 	clks = (unsigned long long)data->timeout_ns * host->cclk;
 	do_div(clks, 1000000000UL);
 
@@ -125,13 +321,30 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	BUG_ON(1 << blksz_bits != data->blksz);
 
 	datactrl = MCI_DPSM_ENABLE | blksz_bits << 4;
-	if (data->flags & MMC_DATA_READ) {
+
+	if (data->flags & MMC_DATA_READ)
 		datactrl |= MCI_DPSM_DIRECTION;
+
+	if (host->dma_rx_channel) {
+		/*
+		 * Attempt to use DMA operation mode, if this
+		 * should fail, fall back to PIO mode
+		 */
+		ret = mmci_dma_start_data(host, datactrl);
+		if (!ret)
+			return;
+	}
+
+	/* IRQ mode, map the SG list for CPU reading/writing */
+	mmci_init_sg(host, data);
+
+	if (data->flags & MMC_DATA_READ) {
 		irqmask = MCI_RXFIFOHALFFULLMASK;
 
 		/*
-		 * If we have less than a FIFOSIZE of bytes to transfer,
-		 * trigger a PIO interrupt as soon as any data is available.
+		 * If we have less than a FIFOSIZE of bytes to
+		 * transfer, trigger a PIO interrupt as soon as any
+		 * data is available.
 		 */
 		if (host->size < MCI_FIFOSIZE)
 			irqmask |= MCI_RXDATAAVLBLMASK;
@@ -144,39 +357,12 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	}
 
 	writel(datactrl, base + MMCIDATACTRL);
+	/* No interrupt when data ends */
 	writel(readl(base + MMCIMASK0) & ~MCI_DATAENDMASK, base + MMCIMASK0);
 	writel(irqmask, base + MMCIMASK1);
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
@@ -204,14 +390,19 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 			data->error = -EIO;
 		status |= MCI_DATAEND;
 
-		/*
-		 * We hit an error condition.  Ensure that any data
-		 * partially written to a page is properly coherent.
-		 */
-		if (host->sg_len && data->flags & MMC_DATA_READ)
-			flush_dcache_page(sg_page(host->sg_ptr));
+		if (host->dma_rx_channel) {
+			mmci_dma_data_error(host);
+		} else {
+			/*
+			 * We hit an error condition.  Ensure that any data
+			 * partially written to a page is properly coherent.
+			 */
+			if (host->sg_len && data->flags & MMC_DATA_READ)
+				flush_dcache_page(sg_page(host->sg_ptr));
+		}
 	}
 	if (status & MCI_DATAEND) {
+		mmci_dma_data_end(host);
 		mmci_stop_data(host);
 
 		if (!data->stop) {
@@ -621,6 +812,7 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 		dev_dbg(mmc_dev(mmc), "eventual mclk rate: %u Hz\n",
 			host->mclk);
 	}
+	host->phybase = dev->res.start;
 	host->base = ioremap(dev->res.start, resource_size(&dev->res));
 	if (!host->base) {
 		ret = -ENOMEM;
@@ -721,6 +913,8 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 			goto err_gpio_wp;
 	}
 
+	mmci_setup_dma(host);
+
 	ret = request_irq(dev->irq[0], mmci_irq, IRQF_SHARED, DRIVER_NAME " (cmd)", host);
 	if (ret)
 		goto unmap;
@@ -736,9 +930,13 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 
 	mmc_add_host(mmc);
 
-	dev_info(&dev->dev, "%s: MMCI rev %x cfg %02x at 0x%016llx irq %d,%d\n",
-		mmc_hostname(mmc), amba_rev(dev), amba_config(dev),
-		(unsigned long long)dev->res.start, dev->irq[0], dev->irq[1]);
+	dev_info(&dev->dev, "%s: MMCI/PL180 manf %x rev %x cfg %02x at 0x%016llx\n",
+		 mmc_hostname(mmc), amba_manf(dev), amba_rev(dev), amba_config(dev),
+		 (unsigned long long)dev->res.start);
+	dev_info(&dev->dev, "IRQ %d, %d (pio), DMA RX %s, DMA TX %s\n",
+		 dev->irq[0], dev->irq[1],
+		 host->dma_rx_channel ? dma_chan_name(host->dma_rx_channel) : "NOT USED",
+		 host->dma_tx_channel ? dma_chan_name(host->dma_tx_channel) : "NOT USED");
 
 	init_timer(&host->timer);
 	host->timer.data = (unsigned long)host;
@@ -749,6 +947,7 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 	return 0;
 
  irq0_free:
+	mmci_disable_dma(host);
 	free_irq(dev->irq[0], host);
  unmap:
 	if (host->gpio_wp != -ENOSYS)
@@ -789,6 +988,7 @@ static int __devexit mmci_remove(struct amba_device *dev)
 		writel(0, host->base + MMCICOMMAND);
 		writel(0, host->base + MMCIDATACTRL);
 
+		mmci_disable_dma(host);
 		free_irq(dev->irq[0], host);
 		free_irq(dev->irq[1], host);
 
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 1ceb9a9..13557e9 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -137,7 +137,6 @@
  * The size of the FIFO in bytes.
  */
 #define MCI_FIFOSIZE	(16*4)
-	
 #define MCI_FIFOHALFSIZE (MCI_FIFOSIZE / 2)
 
 #define NR_SG		16
@@ -145,6 +144,7 @@
 struct clk;
 
 struct mmci_host {
+	phys_addr_t		phybase;
 	void __iomem		*base;
 	struct mmc_request	*mrq;
 	struct mmc_command	*cmd;
@@ -175,7 +175,12 @@ struct mmci_host {
 	struct scatterlist	*sg_ptr;
 	unsigned int		sg_off;
 	unsigned int		size;
+
 	struct regulator	*vcc;
+	/* DMA stuff */
+	struct dma_chan		*dma_rx_channel;
+	struct dma_chan		*dma_tx_channel;
+	struct dma_async_tx_descriptor *dma_desc;
 };
 
 static inline void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
diff --git a/include/linux/amba/dma.h b/include/linux/amba/dma.h
new file mode 100644
index 0000000..f550a10
--- /dev/null
+++ b/include/linux/amba/dma.h
@@ -0,0 +1,34 @@
+/*
+ *  linux/include/amba/dma.h
+ *
+ *  Copyright (C) 2010 ST-Ericsson AB
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#if !defined(AMBA_DMA_H) && defined(CONFIG_DMADEVICES)
+#define AMBA_DMA_H
+
+/**
+ * struct amba_dma_channel_request - this struct is passed in as
+ * configuration data to a DMA engine in order to set up a certain
+ * channel for DMA transport. Anything the DMA engine needs to
+ * know about the PrimeCell shall be passed through this struct.
+ * The DMA engine has to provide an additional function:
+ * dma_set_ambaconfig() in order for it to work with PrimeCells.
+ * @addr: this is the physical address where DMA data should be
+ * read (RX) or written (TX)
+ * @addr_width: this is the width of the source (RX) or target
+ * (TX) register where DMA data shall be read/written, in bytes.
+ * legal values: 1, 2, 4, 8.
+ */
+struct amba_dma_channel_config {
+	dma_addr_t addr;
+	u8 addr_width:4;
+};
+
+void dma_set_ambaconfig(struct dma_chan *chan,
+			struct amba_dma_channel_config *config);
+
+#endif /* AMBA_DMA_H */
diff --git a/include/linux/amba/mmci.h b/include/linux/amba/mmci.h
index 7e466fe..0c89072 100644
--- a/include/linux/amba/mmci.h
+++ b/include/linux/amba/mmci.h
@@ -25,6 +25,17 @@
  * @gpio_cd: read this GPIO pin to detect card insertion
  * @capabilities: the capabilities of the block as implemented in
  * this platform, signify anything MMC_CAP_* from mmc/host.h
+ * @dma_filter: function used to select an apropriate RX and TX
+ * DMA channel to be used for DMA, if and only if you're deploying the
+ * generic DMA engine
+ * @dma_rx_param: parameter passed to the DMA allocation
+ * filter in order to select an apropriate RX channel. If
+ * there is a bidirectional RX+TX channel, then just specify
+ * this and leave dma_tx_param set to NULL
+ * @dma_tx_param: parameter passed to the DMA allocation
+ * filter in order to select an apropriate TX channel. If this
+ * is NULL the driver will attempt to use the RX channel as a
+ * bidirectional channel
  */
 struct mmci_platform_data {
 	unsigned int f_max;
@@ -34,6 +45,9 @@ struct mmci_platform_data {
 	int	gpio_wp;
 	int	gpio_cd;
 	unsigned long capabilities;
+	bool (*dma_filter)(struct dma_chan *chan, void *filter_param);
+	void *dma_rx_param;
+	void *dma_tx_param;
 };
 
 #endif
-- 
1.6.6
