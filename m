From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Jan 2011 09:50:29 +0000
Subject: [PATCH] ARM: add PrimeCell generic DMA to MMCI/PL180
In-Reply-To: <AANLkTi=kMnXm+VU2V8HR98DhL1wVk6cJJQ0DtkV=yFqs@mail.gmail.com>
References: <1286358159-6994-1-git-send-email-linus.walleij@stericsson.com>
	<20101219163240.GA27929@n2100.arm.linux.org.uk>
	<20101219195959.GA28157@n2100.arm.linux.org.uk>
	<20101221135421.GS28157@n2100.arm.linux.org.uk>
	<20101221155935.GV28157@n2100.arm.linux.org.uk>
	<AANLkTin2fBLsq2YJHjZ=e+gmwWXWezH0t38bzsjiJ+i=@mail.gmail.com>
	<20110124160127.GA24104@n2100.arm.linux.org.uk>
	<AANLkTi=GmYoDYhKGpvzt2vHWSEb2b72cQbQfVc4PANdH@mail.gmail.com>
	<20110124212228.GN24104@n2100.arm.linux.org.uk>
	<AANLkTi=kMnXm+VU2V8HR98DhL1wVk6cJJQ0DtkV=yFqs@mail.gmail.com>
Message-ID: <20110126095029.GB2562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 25, 2011 at 09:33:07AM +0100, Linus Walleij wrote:
> On 24 January 2011 22:22, Russell King - ARM Linux
> <linux@arm.linux.org.uk>wrote:
> > On Mon, Jan 24, 2011 at 10:06:53PM +0100, Linus Walleij wrote:
> > > What it does is to emulate single requests below a certain
> > > threshold by requesting one-word bursts. I think this is
> > > primarily for SDIO, not card transfers.
> >
> > This should be handled in hardware, if not it's DMA controller specific
> > as it shouldn't burst past the remainder of the transfer.  If your DMA
> > controller does burst past the number of bytes in the transfer, surely
> > that's something that your DMA controller code needs to work around?
> 
> Yes that indeed seems resonable. With the COH901318 DMA engine
> it worked just fine without the burst threshold. Just want to give my
> colleagues a chance to have a second opinion on this.

I've left this in, but noted a todo item in the commit message to remove
this.

I'd like to remove this, and then propose that DMA slave drivers should
store the entire channel configuration (and we drop the direction argument)
rather than picking out the source/destination parts of the structure so
we can avoid calling the DMA configuration function on every DMA request.

It'd also be less susceptible to mismatches between the configured direction
and the direction passed into the prep_dma_slave_sg() function (which I
think should be responsible for picking the configuration from the
dma_slave_config structure.)

> > > The original intent was to avoid writing anything than 32bit words
> > > into the register, and with the SDIO-modified versions you can
> > > actually do that.
> >
> > Surely that's to do with the DMA controller though?
> 
> Absolutely.

So shouldn't this be in the DMA engine driver, so that prep_dma_slave_sg()
returns NULL if the scatterlist is unsuitable?

Here's the current patch, rebased on top of the blockend removal stuff.

8<------
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH] ARM: MMCI: add dmaengine-based DMA support

Based on a patch from Linus Walleij.

Add dmaengine based support for DMA to the MMCI driver, using the
Primecell DMA engine interface.  The changes over Linus' driver are:

- rename txsize_threshold to dmasize_threshold, as this reflects the
  purpose more.
- use 'mmci_dma_' as the function prefix rather than 'dma_mmci_'.
- clean up requesting of dma channels.
- don't release a single channel twice when it's shared between tx and rx.
- get rid of 'dma_enable' bool - instead check whether the channel is NULL.
- detect incomplete DMA at the end of a transfer.  Some DMA controllers
  (eg, PL08x) are unable to be configured for scatter DMA and also listen
  to all four DMA request signals [BREQ,SREQ,LBREQ,LSREQ] from the MMCI.
  They can do one or other but not both.  As MMCI uses LBREQ/LSREQ for the
  final burst/words, PL08x does not transfer the last few words.
- map and unmap DMA buffers using the DMA engine struct device, not the
  MMCI struct device - the DMA engine is doing the DMA transfer, not us.
- avoid double-unmapping of the DMA buffers on MMCI data errors.
- don't check for negative values from the dmaengine tx submission
  function - Dan says this must never fail.
- use new dmaengine helper functions rather than using the ugly function
  pointers directly.
- allow DMA code to be fully optimized away using dma_inprogress() which
  is defined to constant 0 if DMA engine support is disabled.
- request maximum segment size from the DMA engine struct device and
  set this appropriately.
- removed checking of buffer alignment - the DMA engine should deal with
  its own restrictions on buffer alignment, not the individual DMA engine
  users.
TODO: remove burst setting

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/mmci.c   |  296 +++++++++++++++++++++++++++++++++++++++++++--
 drivers/mmc/host/mmci.h   |   13 ++
 include/linux/amba/mmci.h |   17 +++
 3 files changed, 316 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 2de12fe..3eaeed1 100644
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
@@ -41,20 +43,26 @@ static unsigned int fmax = 515633;
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
  * @sdio: variant supports SDIO
  * @st_clkdiv: true if using a ST-specific clock divider algorithm
  */
 struct variant_data {
 	unsigned int		clkreg;
 	unsigned int		clkreg_enable;
+	unsigned int		dmareg_enable;
 	unsigned int		datalength_bits;
 	unsigned int		fifosize;
 	unsigned int		fifohalfsize;
+	unsigned int		dmasize_threshold;
 	bool			sdio;
 	bool			st_clkdiv;
 };
@@ -76,8 +84,10 @@ static struct variant_data variant_u300 = {
 static struct variant_data variant_ux500 = {
 	.fifosize		= 30 * 4,
 	.fifohalfsize		= 8 * 4,
+	.dmasize_threshold	= 16,
 	.clkreg			= MCI_CLK_ENABLE,
 	.clkreg_enable		= 1 << 14, /* HWFCEN */
+	.dmareg_enable		= 1 << 12, /* DMAREQCTRL */
 	.datalength_bits	= 24,
 	.sdio			= true,
 	.st_clkdiv		= true,
@@ -188,6 +198,251 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
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
+		dev_info(mmc_dev(host->mmc), "no DMA platform data\n");
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
+	dev_info(mmc_dev(host->mmc), "DMA channels RX %s, TX %s\n",
+		 rxname, txname);
+
+	/*
+	 * Limit the maximum segment size in any SG entry according to
+	 * the parameters of the DMA engine device.
+	 */
+	if (host->dma_tx_channel) {
+		struct device *dev = host->dma_tx_channel->device->dev;
+		unsigned int max_seg_size = dma_get_max_seg_size(dev);
+
+		if (max_seg_size < host->mmc->max_seg_size)
+			host->mmc->max_seg_size = max_seg_size;
+	}
+	if (host->dma_rx_channel) {
+		struct device *dev = host->dma_rx_channel->device->dev;
+		unsigned int max_seg_size = dma_get_max_seg_size(dev);
+
+		if (max_seg_size < host->mmc->max_seg_size)
+			host->mmc->max_seg_size = max_seg_size;
+	}
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
+	host->dma_rx_channel = host->dma_tx_channel = NULL;
+}
+
+static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
+{
+	struct dma_chan *chan = host->dma_current;
+	enum dma_data_direction dir;
+	u32 status;
+	int i;
+
+	/* Wait up to 1ms for the DMA to complete */
+	for (i = 0; ; i++) {
+		status = readl(host->base + MMCISTATUS);
+		if (!(status & MCI_RXDATAAVLBLMASK) || i >= 100)
+			break;
+		udelay(10);
+	}
+
+	/*
+	 * Check to see whether we still have some data left in the FIFO -
+	 * this catches DMA controllers which are unable to monitor the
+	 * DMALBREQ and DMALSREQ signals while allowing us to DMA to non-
+	 * contiguous buffers.  On TX, we'll get a FIFO underrun error.
+	 */
+	if (status & MCI_RXDATAAVLBLMASK) {
+		dmaengine_terminate_all(chan);
+		data->error = -EIO;
+	}
+
+	if (data->flags & MMC_DATA_WRITE) {
+		dir = DMA_TO_DEVICE;
+	} else {
+		dir = DMA_FROM_DEVICE;
+	}
+
+	dma_unmap_sg(chan->device->dev, data->sg, data->sg_len, dir);
+
+	/*
+	 * Use of DMA with scatter-gather is impossible.
+	 * Give up with DMA and switch back to PIO mode.
+	 */
+	if (status & MCI_RXDATAAVLBLMASK) {
+		dev_err(mmc_dev(host->mmc), "buggy DMA detected. Taking evasive action.\n");
+		mmci_dma_release(host);
+	}
+}
+
+static void mmci_dma_data_error(struct mmci_host *host)
+{
+	dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
+	dmaengine_terminate_all(host->dma_current);
+}
+
+static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
+{
+	struct variant_data *variant = host->variant;
+	struct dma_slave_config conf = {
+		.src_addr = host->phybase + MMCIFIFO,
+		.dst_addr = host->phybase + MMCIFIFO,
+		.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
+		.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
+		.src_maxburst = variant->fifohalfsize >> 2, /* # of words */
+		.dst_maxburst = variant->fifohalfsize >> 2, /* # of words */
+	};
+	struct mmc_data *data = host->data;
+	struct dma_chan *chan;
+	struct dma_device *device;
+	struct dma_async_tx_descriptor *desc;
+	struct scatterlist *sg;
+	int i, nr_sg;
+
+	host->dma_current = NULL;
+
+	if (data->flags & MMC_DATA_READ) {
+		conf.direction = DMA_FROM_DEVICE;
+		chan = host->dma_rx_channel;
+	} else {
+		conf.direction = DMA_TO_DEVICE;
+		chan = host->dma_tx_channel;
+	}
+
+	/* If there's no DMA channel, fall back to PIO */
+	if (!chan)
+		return -EINVAL;
+
+	/* shouldn't this be in the DMA engine driver? */
+	if (host->size <= variant->dmasize_threshold) {
+		conf.src_maxburst = 1;
+		conf.dst_maxburst = 1;
+	}
+
+	device = chan->device;
+	nr_sg = dma_map_sg(device->dev, data->sg, data->sg_len, conf.direction);
+	if (nr_sg == 0)
+		return -EINVAL;
+
+	dmaengine_slave_config(chan, &conf);
+	desc = device->device_prep_slave_sg(chan, data->sg, nr_sg,
+					    conf.direction, DMA_CTRL_ACK);
+	if (!desc)
+		goto unmap_exit;
+
+	/* Okay, go for it. */
+	host->dma_current = chan;
+
+	dev_vdbg(mmc_dev(host->mmc),
+		 "Submit MMCI DMA job, sglen %d blksz %04x blks %04x flags %08x\n",
+		 data->sg_len, data->blksz, data->blocks, data->flags);
+	dmaengine_submit(desc);
+	dma_async_issue_pending(chan);
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
+	dmaengine_terminate_all(chan);
+	dma_unmap_sg(device->dev, data->sg, data->sg_len, conf.direction);
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
@@ -203,8 +458,6 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	host->size = data->blksz * data->blocks;
 	host->data_xfered = 0;
 
-	mmci_init_sg(host, data);
-
 	clks = (unsigned long long)data->timeout_ns * host->cclk;
 	do_div(clks, 1000000000UL);
 
@@ -218,8 +471,21 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
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
@@ -301,9 +567,12 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 
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
 
@@ -320,6 +589,8 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 		dev_err(mmc_dev(host->mmc), "stray MCI_DATABLOCKEND interrupt\n");
 
 	if (status & MCI_DATAEND) {
+		if (dma_inprogress(host))
+			mmci_dma_unmap(host, data);
 		mmci_stop_data(host);
 
 		if (!data->error)
@@ -775,6 +1046,7 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 		dev_dbg(mmc_dev(mmc), "eventual mclk rate: %u Hz\n",
 			host->mclk);
 	}
+	host->phybase = dev->res.start;
 	host->base = ioremap(dev->res.start, resource_size(&dev->res));
 	if (!host->base) {
 		ret = -ENOMEM;
@@ -902,9 +1174,12 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 
 	amba_set_drvdata(dev, mmc);
 
-	dev_info(&dev->dev, "%s: PL%03x rev%u at 0x%08llx irq %d,%d\n",
-		mmc_hostname(mmc), amba_part(dev), amba_rev(dev),
-		(unsigned long long)dev->res.start, dev->irq[0], dev->irq[1]);
+	dev_info(&dev->dev, "%s: PL%03x manf %x rev%u at 0x%08llx irq %d,%d (pio)\n",
+		 mmc_hostname(mmc), amba_part(dev), amba_manf(dev),
+		 amba_rev(dev), (unsigned long long)dev->res.start,
+		 dev->irq[0], dev->irq[1]);
+
+	mmci_dma_setup(host);
 
 	mmc_add_host(mmc);
 
@@ -951,6 +1226,7 @@ static int __devexit mmci_remove(struct amba_device *dev)
 		writel(0, host->base + MMCICOMMAND);
 		writel(0, host->base + MMCIDATACTRL);
 
+		mmci_dma_release(host);
 		free_irq(dev->irq[0], host);
 		if (!host->singleirq)
 			free_irq(dev->irq[1], host);
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index c1df7b8..9626f51 100644
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
@@ -181,5 +183,16 @@ struct mmci_host {
 	struct sg_mapping_iter	sg_miter;
 	unsigned int		size;
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
index f4ee9ac..f602270 100644
--- a/include/linux/amba/mmci.h
+++ b/include/linux/amba/mmci.h
@@ -6,6 +6,9 @@
 
 #include <linux/mmc/host.h>
 
+/* Just some dummy forwarding */
+struct dma_chan;
+
 /**
  * struct mmci_platform_data - platform configuration for the MMCI
  * (also known as PL180) block.
@@ -27,6 +30,17 @@
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
@@ -38,6 +52,9 @@ struct mmci_platform_data {
 	int	gpio_cd;
 	bool	cd_invert;
 	unsigned long capabilities;
+	bool (*dma_filter)(struct dma_chan *chan, void *filter_param);
+	void *dma_rx_param;
+	void *dma_tx_param;
 };
 
 #endif
-- 
1.6.2.5
