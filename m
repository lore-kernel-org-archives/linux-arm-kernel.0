From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Dec 2010 15:59:35 +0000
Subject: [PATCH] ARM: add PrimeCell generic DMA to MMCI/PL180
In-Reply-To: <20101221135421.GS28157@n2100.arm.linux.org.uk>
References: <1286358159-6994-1-git-send-email-linus.walleij@stericsson.com>
	<20101219163240.GA27929@n2100.arm.linux.org.uk>
	<20101219195959.GA28157@n2100.arm.linux.org.uk>
	<20101221135421.GS28157@n2100.arm.linux.org.uk>
Message-ID: <20101221155935.GV28157@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 21, 2010 at 01:54:21PM +0000, Russell King - ARM Linux wrote:
> On Sun, Dec 19, 2010 at 07:59:59PM +0000, Russell King - ARM Linux wrote:
> > +static void mmci_dma_data_end(struct mmci_host *host)
> > +{
> > +	struct mmc_data *data = host->data;
> > +
> > +	dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
> 
> Note that when using a separate DMA agent to the targetted device, the
> struct device appropriate for performing the mapping is the DMA agent
> itself, not the targetted device.
> 
> That's because the memory which is addressible by DMA is determined by
> the DMA agent rather than the device.  It's much the same idea as a USB
> bus device submitting buffers needs to map them using the USB _host_
> device, rather than its own struct device.
> 
> IOW, dma_chan->device->dev, not mmc_dev(host->mmc).
> 
> Same goes for other primecell drivers.  I'll update this patch later today
> for that.

This also contains a few other tweaks on top of your original patch too.
All the DMA conditionals get optimized out when we're not building with
a DMA engine enabled platform.

Note that in your original code, mmci_dma_data_error() is always followed
by a call to mmci_dma_data_end(), and that resulted in dma_unmap_sg()
being called twice for the same buffer.

Also, dma_map_sg() returns the number of physical entries mapped, or zero
on failure.  Should we have a DMA mapping implementation which coalesces
entries, the returned number will be less than data->nr_sg, and it is the
number of coalesced entries which should be passed to the DMA engine driver.
You have this bug in the PL022 driver too, so I suspect that your other
drivers need fixing for this.

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 0b4a5bf..bd1fa13 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -2,7 +2,7 @@
  *  linux/drivers/mmc/host/mmci.c - ARM PrimeCell MMCI PL180/1 driver
  *
  *  Copyright (C) 2003 Deep Blue Solutions, Ltd, All Rights Reserved.
- *  Copyright (C) 2010 ST-Ericsson AB.
+ *  Copyright (C) 2010 ST-Ericsson SA
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -24,8 +24,10 @@
 #include <linux/clk.h>
 #include <linux/scatterlist.h>
 #include <linux/gpio.h>
-#include <linux/amba/mmci.h>
 #include <linux/regulator/consumer.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/amba/mmci.h>
 
 #include <asm/div64.h>
 #include <asm/io.h>
@@ -41,11 +43,15 @@ static unsigned int fmax = 515633;
  * struct variant_data - MMCI variant-specific quirks
  * @clkreg: default value for MCICLOCK register
  * @clkreg_enable: enable value for MMCICLOCK register
+ * @dmareg_enable: enable value for MMCIDATACTRL register
  * @datalength_bits: number of bits in the MMCIDATALENGTH register
  * @fifosize: number of bytes that can be written when MMCI_TXFIFOEMPTY
  *	      is asserted (likewise for RX)
  * @fifohalfsize: number of bytes that can be written when MCI_TXFIFOHALFEMPTY
  *		  is asserted (likewise for RX)
+ * @dmasize_threshold: Sets DMA burst size to minimal if transfer size is
+ *		less or equal to this threshold. This shall be specified in
+ *		number of bytes. Set 0 for no burst compensation
  * @broken_blockend: the MCI_DATABLOCKEND is broken on the hardware
  *		and will not work at all.
  * @broken_blockend_dma: the MCI_DATABLOCKEND is broken on the hardware when
@@ -56,9 +62,11 @@ static unsigned int fmax = 515633;
 struct variant_data {
 	unsigned int		clkreg;
 	unsigned int		clkreg_enable;
+	unsigned int		dmareg_enable;
 	unsigned int		datalength_bits;
 	unsigned int		fifosize;
 	unsigned int		fifohalfsize;
+	unsigned int		dmasize_threshold;
 	bool			broken_blockend;
 	bool			broken_blockend_dma;
 	bool			sdio;
@@ -83,8 +91,10 @@ static struct variant_data variant_u300 = {
 static struct variant_data variant_ux500 = {
 	.fifosize		= 30 * 4,
 	.fifohalfsize		= 8 * 4,
+	.dmasize_threshold	= 16,
 	.clkreg			= MCI_CLK_ENABLE,
 	.clkreg_enable		= 1 << 14, /* HWFCEN */
+	.dmareg_enable		= 1 << 12, /* DMAREQCTRL */
 	.datalength_bits	= 24,
 	.broken_blockend	= true,
 	.sdio			= true,
@@ -196,6 +206,224 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
 	sg_miter_start(&host->sg_miter, data->sg, data->sg_len, flags);
 }
 
+/*
+ * All the DMA operation mode stuff goes inside this ifdef.
+ * This assumes that you have a generic DMA device interface,
+ * no custom DMA interfaces are supported.
+ */
+#ifdef CONFIG_DMA_ENGINE
+static void __devinit mmci_dma_setup(struct mmci_host *host)
+{
+	struct mmci_platform_data *plat = host->plat;
+	const char *rxname, *txname;
+	dma_cap_mask_t mask;
+
+	if (!plat || !plat->dma_filter) {
+		dev_err(mmc_dev(host->mmc), "no DMA platform data\n");
+		return;
+	}
+
+	/* Try to acquire a generic DMA engine slave channel */
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	/*
+	 * If only an RX channel is specified, the driver will
+	 * attempt to use it bidirectionally, however if it is
+	 * is specified but cannot be located, DMA will be disabled.
+	 */
+	if (plat->dma_rx_param) {
+		host->dma_rx_channel = dma_request_channel(mask,
+							   plat->dma_filter,
+							   plat->dma_rx_param);
+		/* E.g if no DMA hardware is present */
+		if (!host->dma_rx_channel)
+			dev_err(mmc_dev(host->mmc), "no RX DMA channel\n");
+	}
+
+	if (plat->dma_tx_param) {
+		host->dma_tx_channel = dma_request_channel(mask,
+							   plat->dma_filter,
+							   plat->dma_tx_param);
+		if (!host->dma_tx_channel)
+			dev_warn(mmc_dev(host->mmc), "no TX DMA channel\n");
+	} else {
+		host->dma_tx_channel = host->dma_rx_channel;
+	}
+
+	if (host->dma_rx_channel)
+		rxname = dma_chan_name(host->dma_rx_channel);
+	else
+		rxname = "none";
+
+	if (host->dma_tx_channel)
+		txname = dma_chan_name(host->dma_tx_channel);
+	else
+		txname = "none";
+
+	dev_info(mmc_dev(host->mmc), "DMA channels DMA RX %s, DMA TX %s\n",
+		 rxname, txname);
+}
+
+/*
+ * This is used in __devinit or __devexit so inline it
+ * so it can be discarded.
+ */
+static inline void mmci_dma_release(struct mmci_host *host)
+{
+	struct mmci_platform_data *plat = host->plat;
+
+	if (host->dma_rx_channel)
+		dma_release_channel(host->dma_rx_channel);
+	if (host->dma_tx_channel && plat->dma_tx_param)
+		dma_release_channel(host->dma_tx_channel);
+}
+
+static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
+{
+	if (dma_inprogress(host)) {
+		struct dma_device *dmadev = host->dma_current->device;
+		enum dma_data_direction dir;
+
+		if (data->flags & MMC_DATA_WRITE) {
+			dir = DMA_TO_DEVICE;
+		} else {
+			dir = DMA_FROM_DEVICE;
+		}
+
+		dma_unmap_sg(dmadev->dev, data->sg, data->sg_len, dir);
+	}
+}
+
+static void mmci_dma_data_error(struct mmci_host *host)
+{
+	struct dma_chan *chan = host->dma_current;
+
+	dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
+	chan->device->device_control(chan, DMA_TERMINATE_ALL, 0);
+}
+
+static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
+{
+	struct variant_data *variant = host->variant;
+	struct dma_slave_config rx_conf = {
+		.src_addr = host->phybase + MMCIFIFO,
+		.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
+		.direction = DMA_FROM_DEVICE,
+		.src_maxburst = variant->fifohalfsize >> 2, /* # of words */
+	};
+	struct dma_slave_config tx_conf = {
+		.dst_addr = host->phybase + MMCIFIFO,
+		.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
+		.direction = DMA_TO_DEVICE,
+		.dst_maxburst = variant->fifohalfsize >> 2, /* # of words */
+	};
+	struct dma_slave_config *conf;
+	struct mmc_data *data = host->data;
+	struct dma_chan *chan;
+	struct dma_device *device;
+	struct dma_async_tx_descriptor *desc;
+	struct scatterlist *sg;
+	dma_cookie_t cookie;
+	int i, nr_sg;
+
+	host->dma_current = NULL;
+
+	if (data->flags & MMC_DATA_READ) {
+		if (host->size <= variant->dmasize_threshold)
+			rx_conf.src_maxburst = 1;
+
+		chan = host->dma_rx_channel;
+		conf = &rx_conf;
+	} else {
+		if (host->size <= variant->dmasize_threshold)
+			tx_conf.dst_maxburst = 1;
+
+		chan = host->dma_tx_channel;
+		conf = &tx_conf;
+	}
+
+	/* If there's no DMA channel, fall back to PIO */
+	if (!chan)
+		return -EINVAL;
+
+	/* Check for weird stuff in the sg list */
+	for_each_sg(data->sg, sg, data->sg_len, i) {
+		dev_vdbg(mmc_dev(host->mmc), "MMCI SGlist %d dir %d: length: %08x\n",
+			 i, conf->direction, sg->length);
+		if (sg->offset & 3 || sg->length & 3)
+			return -EINVAL;
+	}
+
+	device = chan->device;
+	nr_sg = dma_map_sg(device->dev, data->sg, data->sg_len,
+			   conf->direction);
+	if (nr_sg == 0)
+		return -EINVAL;
+
+	device->device_control(chan, DMA_SLAVE_CONFIG, (unsigned long)conf);
+	desc = device->device_prep_slave_sg(chan, data->sg, nr_sg,
+					    conf->direction, DMA_CTRL_ACK);
+	if (!desc)
+		goto unmap_exit;
+
+	dev_vdbg(mmc_dev(host->mmc),
+		 "Submit MMCI DMA job, sglen %d blksz %04x blks %04x flags %08x\n",
+		 data->sg_len, data->blksz, data->blocks, data->flags);
+	cookie = desc->tx_submit(desc);
+
+	/* Here overloaded DMA controllers may fail */
+	if (dma_submit_error(cookie))
+		goto unmap_exit;
+
+	host->dma_current = chan;
+
+	device->device_issue_pending(chan);
+
+	datactrl |= MCI_DPSM_DMAENABLE;
+	datactrl |= variant->dmareg_enable;
+
+	/* Trigger the DMA transfer */
+	writel(datactrl, host->base + MMCIDATACTRL);
+
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
+	device->device_control(chan, DMA_TERMINATE_ALL, 0);
+	dma_unmap_sg(device->dev, data->sg, data->sg_len, conf->direction);
+	return -ENOMEM;
+}
+#else
+/* Blank functions if the DMA engine is not available */
+static inline void mmci_dma_setup(struct mmci_host *host)
+{
+}
+
+static inline void mmci_dma_release(struct mmci_host *host)
+{
+}
+
+static inline void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
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
 	struct variant_data *variant = host->variant;
@@ -213,8 +441,6 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	host->blockend = false;
 	host->dataend = false;
 
-	mmci_init_sg(host, data);
-
 	clks = (unsigned long long)data->timeout_ns * host->cclk;
 	do_div(clks, 1000000000UL);
 
@@ -228,13 +454,27 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	BUG_ON(1 << blksz_bits != data->blksz);
 
 	datactrl = MCI_DPSM_ENABLE | blksz_bits << 4;
-	if (data->flags & MMC_DATA_READ) {
+
+	if (data->flags & MMC_DATA_READ)
 		datactrl |= MCI_DPSM_DIRECTION;
+
+	/*
+	 * Attempt to use DMA operation mode, if this
+	 * should fail, fall back to PIO mode
+	 */
+	if (!mmci_dma_start_data(host, datactrl))
+		return;
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
 		if (host->size < variant->fifosize)
 			irqmask |= MCI_RXDATAAVLBLMASK;
@@ -306,9 +546,12 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 
 		/*
 		 * We hit an error condition.  Ensure that any data
-		 * partially written to a page is properly coherent.
+		 * partially written to a page is properly coherent,
+		 * unless we're using DMA.
 		 */
-		if (data->flags & MMC_DATA_READ) {
+		if (dma_inprogress(host))
+			mmci_dma_data_error(host);
+		else if (data->flags & MMC_DATA_READ) {
 			struct sg_mapping_iter *sg_miter = &host->sg_miter;
 			unsigned long flags;
 
@@ -351,7 +594,8 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 		 * flag is unreliable: since it can stay high between
 		 * IRQs it will corrupt the transfer counter.
 		 */
-		if (!variant->broken_blockend)
+		if (!variant->broken_blockend &&
+		    !(dma_inprogress(host) && variant->broken_blockend_dma))
 			host->data_xfered += data->blksz;
 		host->blockend = true;
 	}
@@ -366,6 +610,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 	 */
 	if (host->dataend && (host->blockend || variant->broken_blockend)) {
 		mmci_stop_data(host);
+		mmci_dma_unmap(host, data);
 
 		/* Reset these flags */
 		host->blockend = false;
@@ -375,7 +620,9 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 		 * Variants with broken blockend flags need to handle the
 		 * end of the entire transfer here.
 		 */
-		if (variant->broken_blockend && !data->error)
+		if ((variant->broken_blockend ||
+		     (dma_inprogress(host) && variant->broken_blockend_dma))
+		    && !data->error)
 			host->data_xfered += data->blksz * data->blocks;
 
 		if (!data->stop) {
@@ -828,6 +1075,7 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 		dev_dbg(mmc_dev(mmc), "eventual mclk rate: %u Hz\n",
 			host->mclk);
 	}
+	host->phybase = dev->res.start;
 	host->base = ioremap(dev->res.start, resource_size(&dev->res));
 	if (!host->base) {
 		ret = -ENOMEM;
@@ -938,6 +1186,8 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 	    && host->gpio_cd_irq < 0)
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
 
+	mmci_dma_setup(host);
+
 	ret = request_irq(dev->irq[0], mmci_irq, IRQF_SHARED, DRIVER_NAME " (cmd)", host);
 	if (ret)
 		goto unmap;
@@ -962,15 +1212,17 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 
 	mmc_add_host(mmc);
 
-	dev_info(&dev->dev, "%s: MMCI rev %x cfg %02x at 0x%016llx irq %d,%d\n",
-		mmc_hostname(mmc), amba_rev(dev), amba_config(dev),
-		(unsigned long long)dev->res.start, dev->irq[0], dev->irq[1]);
+	dev_info(&dev->dev, "%s: MMCI/PL180 manf %x rev %x cfg %02x at 0x%016llx\n",
+		 mmc_hostname(mmc), amba_manf(dev), amba_rev(dev), amba_config(dev),
+		 (unsigned long long)dev->res.start);
+	dev_info(&dev->dev, "IRQ %d, %d (pio)\n", dev->irq[0], dev->irq[1]);
 
 	return 0;
 
  irq0_free:
 	free_irq(dev->irq[0], host);
  unmap:
+	mmci_dma_release(host);
 	if (host->gpio_wp != -ENOSYS)
 		gpio_free(host->gpio_wp);
  err_gpio_wp:
@@ -1009,6 +1261,7 @@ static int __devexit mmci_remove(struct amba_device *dev)
 		writel(0, host->base + MMCICOMMAND);
 		writel(0, host->base + MMCIDATACTRL);
 
+		mmci_dma_release(host);
 		free_irq(dev->irq[0], host);
 		if (!host->singleirq)
 			free_irq(dev->irq[1], host);
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index df06f01..659b416 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -148,8 +148,10 @@
 
 struct clk;
 struct variant_data;
+struct dma_chan;
 
 struct mmci_host {
+	phys_addr_t		phybase;
 	void __iomem		*base;
 	struct mmc_request	*mrq;
 	struct mmc_command	*cmd;
@@ -183,6 +185,18 @@ struct mmci_host {
 	/* pio stuff */
 	struct sg_mapping_iter	sg_miter;
 	unsigned int		size;
+
 	struct regulator	*vcc;
+
+#ifdef CONFIG_DMA_ENGINE
+	/* DMA stuff */
+	struct dma_chan		*dma_current;
+	struct dma_chan		*dma_rx_channel;
+	struct dma_chan		*dma_tx_channel;
+
+#define dma_inprogress(host)	((host)->dma_current)
+#else
+#define dma_inprogress(host)	(0)
+#endif
 };
 
diff --git a/include/linux/amba/mmci.h b/include/linux/amba/mmci.h
index f4ee9ac..dbeba68 100644
--- a/include/linux/amba/mmci.h
+++ b/include/linux/amba/mmci.h
@@ -6,6 +6,8 @@
 
 #include <linux/mmc/host.h>
 
+/* Just some dummy forwarding */
+struct dma_chan;
 /**
  * struct mmci_platform_data - platform configuration for the MMCI
  * (also known as PL180) block.
@@ -27,6 +29,17 @@
  * @cd_invert: true if the gpio_cd pin value is active low
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
@@ -38,6 +51,9 @@ struct mmci_platform_data {
 	int	gpio_cd;
 	bool	cd_invert;
 	unsigned long capabilities;
+	bool (*dma_filter)(struct dma_chan *chan, void *filter_param);
+	void *dma_rx_param;
+	void *dma_tx_param;
 };
 
 #endif
