From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 5 Feb 2011 10:08:12 +0800
Subject: [PATCH 1/5] dmaengine: mxs-dma: add dma support for i.MX23/28
In-Reply-To: <1296871696-21008-1-git-send-email-shawn.guo@freescale.com>
References: <1296871696-21008-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1296871696-21008-2-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds dma support for Freescale MXS-based SoC i.MX23/28,
including apbh-dma and apbx-dma.

* apbh-dma and apbx-dma are supported in the driver as two instances,
  and have to be filtered by dma clients via device id.  It becomes
  the convention that apbh-dma always gets registered prior to
  apbx-dma.

* apbh-dma is different between mx23 and mx28, hardware version
  register is used to handle the differences.

* Every the mxs dma channel is statically assigned to client device
  by soc design with fixed irq.  The irq number is being passed by
  alloc_chan function with mxs_dma_data, and client driver has to
  filter the correct channel by its channel id.

* mxs-dma supports pio function besides data transfer.  The driver
  uses dma_data_direction DMA_NONE to identify the pio mode, and
  steals sgl and sg_len to get pio words and numbers from clients.

* mxs dmaengine has some very specific features, like sense function
  and the special NAND support (nand_lock, nand_wait4ready).  These
  are too specific to implemented in generic dmaengine driver.

* The parameter "flags" of prep functions is currently being used to
  pass wait4end flag from clients.

* The driver refers to imx-sdma and only a single descriptor is
  statically assigned to each channel.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/include/mach/dma.h |   16 +
 drivers/dma/Kconfig                  |    8 +
 drivers/dma/Makefile                 |    1 +
 drivers/dma/mxs-dma.c                |  702 ++++++++++++++++++++++++++++++++++
 4 files changed, 727 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/include/mach/dma.h
 create mode 100644 drivers/dma/mxs-dma.c

diff --git a/arch/arm/mach-mxs/include/mach/dma.h b/arch/arm/mach-mxs/include/mach/dma.h
new file mode 100644
index 0000000..429f431
--- /dev/null
+++ b/arch/arm/mach-mxs/include/mach/dma.h
@@ -0,0 +1,16 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __MACH_MXS_DMA_H__
+#define __MACH_MXS_DMA_H__
+
+struct mxs_dma_data {
+	int chan_irq;
+};
+
+#endif /* __MACH_MXS_DMA_H__ */
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 1c28816..0b9a5b1 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -227,6 +227,14 @@ config IMX_DMA
 	  Support the i.MX DMA engine. This engine is integrated into
 	  Freescale i.MX1/21/27 chips.
 
+config MXS_DMA
+	tristate "MXS DMA support"
+	depends on SOC_IMX23 || SOC_MX28
+	select DMA_ENGINE
+	help
+	  Support the MXS DMA engine. This engine including APBH-DMA
+	  and APBX-DMA is integrated into Freescale i.MX23/28 chips.
+
 config DMA_ENGINE
 	bool
 
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 64b21f5..802b557 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_COH901318) += coh901318.o coh901318_lli.o
 obj-$(CONFIG_AMCC_PPC440SPE_ADMA) += ppc4xx/
 obj-$(CONFIG_IMX_SDMA) += imx-sdma.o
 obj-$(CONFIG_IMX_DMA) += imx-dma.o
+obj-$(CONFIG_MXS_DMA) += mxs-dma.o
 obj-$(CONFIG_TIMB_DMA) += timb_dma.o
 obj-$(CONFIG_STE_DMA40) += ste_dma40.o ste_dma40_ll.o
 obj-$(CONFIG_PL330_DMA) += pl330.o
diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
new file mode 100644
index 0000000..8d1e811
--- /dev/null
+++ b/drivers/dma/mxs-dma.c
@@ -0,0 +1,702 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * Refer to drivers/dma/imx-sdma.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/interrupt.h>
+#include <linux/clk.h>
+#include <linux/wait.h>
+#include <linux/sched.h>
+#include <linux/semaphore.h>
+#include <linux/spinlock.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/dmaengine.h>
+#include <linux/delay.h>
+
+#include <asm/irq.h>
+#include <mach/mxs.h>
+#include <mach/dma.h>
+#include <mach/common.h>
+
+#define MXS_DMA_APBH		0
+#define MXS_DMA_APBX		1
+#define dma_is_apbh()		(mxs_dma->dev_id == MXS_DMA_APBH)
+
+#define APBH_VERSION_LATEST	3
+#define apbh_is_old()		(mxs_dma->version < APBH_VERSION_LATEST)
+
+#define HW_APBHX_CTRL0				0x000
+#define  BM_APBH_CTRL0_APB_BURST8_EN		(1 << 29)
+#define  BM_APBH_CTRL0_APB_BURST_EN		(1 << 28)
+#define  BP_APBH_CTRL0_CLKGATE_CHANNEL		(8)
+#define  BP_APBH_CTRL0_RESET_CHANNEL		(16)
+#define HW_APBHX_CTRL1				0x010
+#define HW_APBHX_CTRL2				0x020
+#define HW_APBHX_CHANNEL_CTRL			0x030
+#define  BP_APBHX_CHANNEL_CTRL_RESET_CHANNEL	(16)
+#define HW_APBH_VERSION				(cpu_is_mx23() ? 0x3f0 : 0x800)
+#define HW_APBX_VERSION				0x800
+#define  BP_APBHX_VERSION_MAJOR			(24)
+#define HW_APBHX_CHn_NXTCMDAR(n) \
+	(((dma_is_apbh() && apbh_is_old()) ? 0x050 : 0x110) + (n) * 0x70)
+#define HW_APBHX_CHn_SEMA(n) \
+	(((dma_is_apbh() && apbh_is_old()) ? 0x080 : 0x140) + (n) * 0x70)
+
+struct mxs_dma_ccw_bits {
+	unsigned int	command:2;
+#define MXS_DMA_NO_XFER	0x00
+#define MXS_DMA_WRITE	0x01
+#define MXS_DMA_READ	0x02
+#define MXS_DMA_SENSE	0x03			/* not implemented */
+	unsigned int	chain:1;
+	unsigned int	irq:1;
+	unsigned int	nand_lock:1;		/* not implemented */
+	unsigned int	nand_wait4ready:1;	/* not implemented */
+	unsigned int	dec_sem:1;
+	unsigned int	wait4end:1;
+	unsigned int	halt_on_terminate:1;
+	unsigned int	terminate_flush:1;
+	unsigned int	reserved:2;
+	unsigned int	pio_num:4;
+	unsigned int	xfer_bytes:16;
+#define MAX_XFER_BYTES	0xffff
+};
+
+struct mxs_dma_ccw {
+	u32				next;
+	struct mxs_dma_ccw_bits		bits;
+	dma_addr_t bufaddr;
+#define MXS_PIO_WORDS			16
+	u32 pio_words[MXS_PIO_WORDS];
+};
+
+#define NUM_CCW	(int)(PAGE_SIZE / sizeof(struct mxs_dma_ccw))
+
+struct mxs_dma_chan {
+	struct mxs_dma_engine		*mxs_dma;
+	struct dma_chan			chan;
+	struct dma_async_tx_descriptor	desc;
+	spinlock_t			lock;
+	int				chan_irq;
+	struct mxs_dma_ccw		*ccw;
+	dma_addr_t			ccw_phys;
+	dma_cookie_t			last_completed;
+	enum dma_status			status;
+	unsigned int			flags;
+#define MXS_DMA_SG_LOOP			(1 << 0)
+};
+
+struct mxs_dma_engine {
+	struct device			*dev;
+	int				dev_id;
+	unsigned int			version;
+	void __iomem			*base;
+	struct clk			*clk;
+	struct dma_device		dma_device;
+	struct device_dma_parameters 	dma_parms;
+#define MXS_DMA_CHANNELS		16
+	struct mxs_dma_chan		mxs_chans[MXS_DMA_CHANNELS];
+};
+
+static void mxs_dma_reset_chan(struct mxs_dma_chan *mxs_chan)
+{
+	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
+	int chan_id = mxs_chan->chan.chan_id;
+
+	if (dma_is_apbh() && apbh_is_old())
+		__mxs_setl(1 << (chan_id + BP_APBH_CTRL0_RESET_CHANNEL),
+				mxs_dma->base + HW_APBHX_CTRL0);
+	else
+		__mxs_setl(1 << (chan_id + BP_APBHX_CHANNEL_CTRL_RESET_CHANNEL),
+				mxs_dma->base + HW_APBHX_CHANNEL_CTRL);
+}
+
+static void mxs_dma_enable_chan(struct mxs_dma_chan *mxs_chan)
+{
+	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
+	int chan_id = mxs_chan->chan.chan_id;
+
+	/* set cmd_addr up */
+	__raw_writel(mxs_chan->ccw_phys,
+			mxs_dma->base + HW_APBHX_CHn_NXTCMDAR(chan_id));
+
+	/* enable apbh channel clock */
+	if (dma_is_apbh()) {
+		if (apbh_is_old())
+			__mxs_clrl(1 << (chan_id + BP_APBH_CTRL0_CLKGATE_CHANNEL),
+						mxs_dma->base + HW_APBHX_CTRL0);
+		else
+			__mxs_clrl(1 << chan_id, mxs_dma->base + HW_APBHX_CTRL0);
+	}
+
+	/* write 1 to SEMA to kick off the channel */
+	__raw_writel(1, mxs_dma->base + HW_APBHX_CHn_SEMA(chan_id));
+}
+
+static void mxs_dma_disable_chan(struct mxs_dma_chan *mxs_chan)
+{
+	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
+	int chan_id = mxs_chan->chan.chan_id;
+
+	/* disable apbh channel clock */
+	if (dma_is_apbh()) {
+		if (apbh_is_old())
+			__mxs_setl(1 << (chan_id + BP_APBH_CTRL0_CLKGATE_CHANNEL),
+						mxs_dma->base + HW_APBHX_CTRL0);
+		else
+			__mxs_setl(1 << chan_id, mxs_dma->base + HW_APBHX_CTRL0);
+	}
+
+	mxs_chan->status = DMA_SUCCESS;
+}
+
+static void mxs_dma_pause_chan(struct mxs_dma_chan *mxs_chan)
+{
+	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
+	int chan_id = mxs_chan->chan.chan_id;
+
+	/* freeze the channel */
+	if (dma_is_apbh() && apbh_is_old())
+		__mxs_setl(1 << chan_id, mxs_dma->base + HW_APBHX_CTRL0);
+	else
+		__mxs_setl(1 << chan_id, mxs_dma->base + HW_APBHX_CHANNEL_CTRL);
+
+	mxs_chan->status = DMA_PAUSED;
+}
+
+static void mxs_dma_resume_chan(struct mxs_dma_chan *mxs_chan)
+{
+	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
+	int chan_id = mxs_chan->chan.chan_id;
+
+	/* unfreeze the channel */
+	if (dma_is_apbh() && apbh_is_old())
+		__mxs_clrl(1 << chan_id, mxs_dma->base + HW_APBHX_CTRL0);
+	else
+		__mxs_clrl(1 << chan_id, mxs_dma->base + HW_APBHX_CHANNEL_CTRL);
+
+	mxs_chan->status = DMA_IN_PROGRESS;
+}
+
+static dma_cookie_t mxs_dma_assign_cookie(struct mxs_dma_chan *mxs_chan)
+{
+	dma_cookie_t cookie = mxs_chan->chan.cookie;
+
+	if (++cookie < 0)
+		cookie = 1;
+
+	mxs_chan->chan.cookie = cookie;
+	mxs_chan->desc.cookie = cookie;
+
+	return cookie;
+}
+
+static struct mxs_dma_chan *to_mxs_dma_chan(struct dma_chan *chan)
+{
+	return container_of(chan, struct mxs_dma_chan, chan);
+}
+
+static dma_cookie_t mxs_dma_tx_submit(struct dma_async_tx_descriptor *tx)
+{
+	struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(tx->chan);
+	dma_cookie_t cookie;
+
+	spin_lock_irq(&mxs_chan->lock);
+
+	cookie = mxs_dma_assign_cookie(mxs_chan);
+
+	mxs_dma_enable_chan(mxs_chan);
+
+	spin_unlock_irq(&mxs_chan->lock);
+
+	return cookie;
+}
+
+static irqreturn_t mxs_dma_int_handler(int irq, void *dev_id)
+{
+	struct mxs_dma_engine *mxs_dma = dev_id;
+	u32 stat1, stat2;
+
+	/* completion status */
+	stat1 = __raw_readl(mxs_dma->base + HW_APBHX_CTRL1);
+	stat1 &= 0xffff;
+	__mxs_clrl(stat1, mxs_dma->base + HW_APBHX_CTRL1);
+
+	/* error status */
+	stat2 = __raw_readl(mxs_dma->base + HW_APBHX_CTRL2);
+	__mxs_clrl(stat2, mxs_dma->base + HW_APBHX_CTRL2);
+
+	/*
+	 * When both completion and error of termination bits set at the
+	 * same time, we do not take it as an error.  IOW, it only becomes
+	 * an error we need to handler here in case of ether it's an bus
+	 * error or a termination error with no completion.
+	 */
+	stat2 = ((stat2 >> 16) & stat2) |	   /* bus error */
+		(~(stat2 >> 16) & stat2 & ~stat1); /* termination with no completion */
+
+	/* combine error and completion status for checking */
+	stat1 = (stat2 << 16) | stat1;
+	while (stat1) {
+		int channel = fls(stat1) - 1;
+		struct mxs_dma_chan *mxs_chan =
+				&mxs_dma->mxs_chans[channel % 16];
+
+		if (channel >= 16) {
+			dev_dbg(mxs_dma->dev, "%s: error in channel %d\n",
+						__func__, channel - 16);
+			mxs_dma_reset_chan(mxs_chan);
+			mxs_chan->status = DMA_ERROR;
+		} else {
+			if (mxs_chan->flags & MXS_DMA_SG_LOOP)
+				mxs_chan->status = DMA_IN_PROGRESS;
+			else
+				mxs_chan->status = DMA_SUCCESS;
+		}
+
+		stat1 &= ~(1 << channel);
+
+		if (mxs_chan->desc.callback)
+			mxs_chan->desc.callback(mxs_chan->desc.callback_param);
+
+		if (mxs_chan->status == DMA_SUCCESS)
+			mxs_chan->last_completed = mxs_chan->desc.cookie;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int mxs_dma_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(chan);
+	struct mxs_dma_data *data = chan->private;
+	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
+	static unsigned long flags;
+	int ret;
+
+	if (!data)
+		return -EINVAL;
+
+	mxs_chan->chan_irq = data->chan_irq;
+
+	mxs_chan->ccw = dma_alloc_coherent(NULL, PAGE_SIZE,
+				&mxs_chan->ccw_phys, GFP_KERNEL);
+	if (!mxs_chan->ccw) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
+
+	memset(mxs_chan->ccw, 0, PAGE_SIZE);
+
+	ret = request_irq(mxs_chan->chan_irq, mxs_dma_int_handler,
+				flags, "mxs-dma", mxs_dma);
+	if (ret)
+		goto err_irq;
+
+	flags = IRQF_SHARED;
+
+	clk_enable(mxs_dma->clk);
+
+	mxs_dma_reset_chan(mxs_chan);
+
+	dma_async_tx_descriptor_init(&mxs_chan->desc, chan);
+	mxs_chan->desc.tx_submit = mxs_dma_tx_submit;
+
+	/* the descriptor is ready */
+	async_tx_ack(&mxs_chan->desc);
+
+	return 0;
+
+err_irq:
+	dma_free_coherent(NULL, PAGE_SIZE, mxs_chan->ccw, mxs_chan->ccw_phys);
+err_alloc:
+	return ret;
+}
+
+static void mxs_dma_free_chan_resources(struct dma_chan *chan)
+{
+	struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(chan);
+	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
+
+	mxs_dma_disable_chan(mxs_chan);
+
+	free_irq(mxs_chan->chan_irq, mxs_dma);
+
+	dma_free_coherent(NULL, PAGE_SIZE, mxs_chan->ccw, mxs_chan->ccw_phys);
+
+	clk_disable(mxs_dma->clk);
+}
+
+static struct dma_async_tx_descriptor *mxs_dma_prep_slave_sg(
+		struct dma_chan *chan, struct scatterlist *sgl,
+		unsigned int sg_len, enum dma_data_direction direction,
+		unsigned long flags)
+{
+	struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(chan);
+	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
+	struct mxs_dma_ccw *ccw;
+	struct scatterlist *sg;
+	int ret, i, j;
+	u32 *pio;
+
+	dev_dbg(mxs_dma->dev, "%s: channel %d\n", __func__, chan->chan_id);
+
+	if (mxs_chan->status == DMA_IN_PROGRESS)
+		return NULL;
+
+	mxs_chan->status = DMA_IN_PROGRESS;
+	mxs_chan->flags = 0;
+
+	dev_dbg(mxs_dma->dev, "%s: setting up %d entries\n", __func__, sg_len);
+
+	if (sg_len > ((direction == DMA_NONE) ? MXS_PIO_WORDS : NUM_CCW)) {
+		dev_err(mxs_dma->dev, "maximum number of sg exceeded: %d > %d\n",
+				sg_len, NUM_CCW);
+		ret = -EINVAL;
+		goto err_out;
+	}
+
+	if (direction == DMA_NONE) {
+		ccw = &mxs_chan->ccw[0];
+		pio = (u32 *) sgl;
+
+		for (j = 0; j < sg_len;)
+			ccw->pio_words[j++] = *pio++;
+
+		ccw->next = 0;
+		ccw->bits.chain = 0;
+		ccw->bits.irq = 1;
+		ccw->bits.dec_sem = 1;
+		ccw->bits.wait4end = flags;
+		ccw->bits.halt_on_terminate = 1;
+		ccw->bits.terminate_flush = 1;
+		ccw->bits.pio_num = sg_len;
+		ccw->bits.command = MXS_DMA_NO_XFER;
+	} else {
+		for_each_sg(sgl, sg, sg_len, i) {
+			if (sg->length > MAX_XFER_BYTES) {
+				dev_err(mxs_dma->dev, "maximum bytes for sg entry exceeded: %d > %d\n",
+						sg->length, MAX_XFER_BYTES);
+				ret = -EINVAL;
+				goto err_out;
+			}
+
+			ccw = &mxs_chan->ccw[i];
+
+			ccw->next = mxs_chan->ccw_phys + sizeof(*ccw) * (i + 1);
+			ccw->bufaddr = sg->dma_address;
+			ccw->bits.xfer_bytes = sg->length;
+			ccw->bits.chain = 1;
+			ccw->bits.irq = 0;
+			ccw->bits.dec_sem = 0;
+			ccw->bits.wait4end = 0;
+			ccw->bits.halt_on_terminate = 1;
+			ccw->bits.terminate_flush = 1;
+			ccw->bits.pio_num = 0;
+			ccw->bits.command = (direction == DMA_FROM_DEVICE) ?
+						MXS_DMA_WRITE : MXS_DMA_READ;
+
+			if (i + 1 == sg_len) {
+				ccw->next = 0;
+				ccw->bits.chain = 0;
+				ccw->bits.irq = 1;
+				ccw->bits.dec_sem = 1;
+				ccw->bits.wait4end = 1;
+			}
+		}
+	}
+
+	return &mxs_chan->desc;
+
+err_out:
+	mxs_chan->status = DMA_ERROR;
+	return NULL;
+}
+
+static struct dma_async_tx_descriptor *mxs_dma_prep_dma_cyclic(
+		struct dma_chan *chan, dma_addr_t dma_addr, size_t buf_len,
+		size_t period_len, enum dma_data_direction direction)
+{
+	struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(chan);
+	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
+	int num_periods = buf_len / period_len;
+	int i = 0, buf = 0;
+
+	dev_dbg(mxs_dma->dev, "%s: channel %d\n", __func__, chan->chan_id);
+
+	if (mxs_chan->status == DMA_IN_PROGRESS)
+		return NULL;
+
+	mxs_chan->status = DMA_IN_PROGRESS;
+	mxs_chan->flags |= MXS_DMA_SG_LOOP;
+
+	if (num_periods > NUM_CCW) {
+		dev_err(mxs_dma->dev, "maximum number of sg exceeded: %d > %d\n",
+				num_periods, NUM_CCW);
+		goto err_out;
+	}
+
+	if (period_len > MAX_XFER_BYTES) {
+		dev_err(mxs_dma->dev, "maximum period size exceeded: %d > %d\n",
+				period_len, MAX_XFER_BYTES);
+		goto err_out;
+	}
+
+	while (buf < buf_len) {
+		struct mxs_dma_ccw *ccw = &mxs_chan->ccw[i];
+
+		if (i + 1 == num_periods)
+			ccw->next = mxs_chan->ccw_phys;
+		else
+			ccw->next = mxs_chan->ccw_phys + sizeof(*ccw) * (i + 1);
+
+		ccw->bufaddr = dma_addr;
+		ccw->bits.xfer_bytes = period_len;
+		ccw->bits.chain = 1;
+		ccw->bits.irq = 1;
+		ccw->bits.dec_sem = 0;
+		ccw->bits.wait4end = 0;
+		ccw->bits.halt_on_terminate = 1;
+		ccw->bits.terminate_flush = 1;
+		ccw->bits.pio_num = 0;
+		ccw->bits.command = (direction == DMA_FROM_DEVICE) ?
+					MXS_DMA_WRITE : MXS_DMA_READ;
+
+		dma_addr += period_len;
+		buf += period_len;
+
+		i++;
+	}
+
+	return &mxs_chan->desc;
+
+err_out:
+	mxs_chan->status = DMA_ERROR;
+	return NULL;
+}
+
+static int mxs_dma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
+		unsigned long arg)
+{
+	struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(chan);
+
+	switch (cmd) {
+	case DMA_TERMINATE_ALL:
+		mxs_dma_disable_chan(mxs_chan);
+		return 0;
+	case DMA_PAUSE:
+		mxs_dma_pause_chan(mxs_chan);
+		return 0;
+	case DMA_RESUME:
+		mxs_dma_resume_chan(mxs_chan);
+		return 0;
+	default:
+		return -ENOSYS;
+	}
+
+	return -EINVAL;
+}
+
+static enum dma_status mxs_dma_tx_status(struct dma_chan *chan,
+			dma_cookie_t cookie, struct dma_tx_state *txstate)
+{
+	struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(chan);
+	dma_cookie_t last_used;
+	enum dma_status ret;
+
+	last_used = chan->cookie;
+
+	ret = dma_async_is_complete(cookie, mxs_chan->last_completed, last_used);
+	dma_set_tx_state(txstate, mxs_chan->last_completed, last_used, 0);
+
+	return ret;
+}
+
+static void mxs_dma_issue_pending(struct dma_chan *chan)
+{
+	/*
+	 * Nothing to do. We only have a single descriptor.
+	 */
+}
+
+static int __init mxs_dma_init(struct mxs_dma_engine *mxs_dma)
+{
+	int ret;
+
+	ret = clk_enable(mxs_dma->clk);
+	if (ret)
+		goto err_out;
+
+	ret = mxs_reset_block(mxs_dma->base);
+	if (ret)
+		goto err_out;
+
+	/* only major version matters */
+	mxs_dma->version = __raw_readl(mxs_dma->base +
+				((mxs_dma->dev_id == MXS_DMA_APBX) ?
+				HW_APBX_VERSION : HW_APBH_VERSION)) >>
+				BP_APBHX_VERSION_MAJOR;
+
+	/* enable apbh burst */
+	if (dma_is_apbh()) {
+		__mxs_setl(BM_APBH_CTRL0_APB_BURST_EN,
+				mxs_dma->base + HW_APBHX_CTRL0);
+		__mxs_setl(BM_APBH_CTRL0_APB_BURST8_EN,
+				mxs_dma->base + HW_APBHX_CTRL0);
+	}
+
+	/* enable irq for all the channels */
+	__mxs_setl(0xffff << 16, mxs_dma->base + HW_APBHX_CTRL1);
+
+	clk_disable(mxs_dma->clk);
+
+	return 0;
+
+err_out:
+	return ret;
+}
+
+static int __init mxs_dma_probe(struct platform_device *pdev)
+{
+	const struct platform_device_id *id_entry =
+				platform_get_device_id(pdev);
+	struct mxs_dma_engine *mxs_dma;
+	struct resource *iores;
+	int ret, i;
+
+	mxs_dma = kzalloc(sizeof(*mxs_dma), GFP_KERNEL);
+	if (!mxs_dma)
+		return -ENOMEM;
+
+	mxs_dma->dev = &pdev->dev;
+	mxs_dma->dev_id = id_entry->driver_data;
+
+	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	if (!request_mem_region(iores->start, resource_size(iores),
+				pdev->name)) {
+		ret = -EBUSY;
+		goto err_request_region;
+	}
+
+	mxs_dma->base = ioremap(iores->start, resource_size(iores));
+	if (!mxs_dma->base) {
+		ret = -ENOMEM;
+		goto err_ioremap;
+	}
+
+	mxs_dma->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(mxs_dma->clk)) {
+		ret = PTR_ERR(mxs_dma->clk);
+		goto err_clk;
+	}
+
+	dma_cap_set(DMA_SLAVE, mxs_dma->dma_device.cap_mask);
+	dma_cap_set(DMA_CYCLIC, mxs_dma->dma_device.cap_mask);
+
+	INIT_LIST_HEAD(&mxs_dma->dma_device.channels);
+
+	/* Initialize channel parameters */
+	for (i = 0; i < MXS_DMA_CHANNELS; i++) {
+		struct mxs_dma_chan *mxs_chan = &mxs_dma->mxs_chans[i];
+
+		mxs_chan->mxs_dma = mxs_dma;
+		spin_lock_init(&mxs_chan->lock);
+
+		mxs_chan->chan.device = &mxs_dma->dma_device;
+
+		/* Add the channel to mxs_chan list */
+		list_add_tail(&mxs_chan->chan.device_node, &mxs_dma->dma_device.channels);
+	}
+
+	ret = mxs_dma_init(mxs_dma);
+	if (ret)
+		goto err_init;
+
+	mxs_dma->dma_device.dev = &pdev->dev;
+
+	/* mxs_dma gets 65535 bytes maximum sg size */
+	mxs_dma->dma_device.dev->dma_parms = &mxs_dma->dma_parms;
+	dma_set_max_seg_size(mxs_dma->dma_device.dev, MAX_XFER_BYTES);
+
+	mxs_dma->dma_device.device_alloc_chan_resources = mxs_dma_alloc_chan_resources;
+	mxs_dma->dma_device.device_free_chan_resources = mxs_dma_free_chan_resources;
+	mxs_dma->dma_device.device_tx_status = mxs_dma_tx_status;
+	mxs_dma->dma_device.device_prep_slave_sg = mxs_dma_prep_slave_sg;
+	mxs_dma->dma_device.device_prep_dma_cyclic = mxs_dma_prep_dma_cyclic;
+	mxs_dma->dma_device.device_control = mxs_dma_control;
+	mxs_dma->dma_device.device_issue_pending = mxs_dma_issue_pending;
+
+	ret = dma_async_device_register(&mxs_dma->dma_device);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to register\n");
+		goto err_dma_register;
+	}
+
+	/*
+	 * dmaengine clients have to use dma_device.dev_id to filter
+	 * dma device between apbh and apbx, so need to ensure it is
+	 * identical to mxs_dma_engine.dev_id.
+	 */
+	if (mxs_dma->dma_device.dev_id != mxs_dma->dev_id) {
+		dev_err(&pdev->dev, "dev_id of dma_device %d differs from mxs_dma_engine %d\n",
+				mxs_dma->dma_device.dev_id, mxs_dma->dev_id);
+		goto err_init;
+	}
+
+	dev_info(mxs_dma->dev, "initialized\n");
+
+	return 0;
+
+err_init:
+	dma_async_device_unregister(&mxs_dma->dma_device);
+err_dma_register:
+	clk_put(mxs_dma->clk);
+err_clk:
+	iounmap(mxs_dma->base);
+err_ioremap:
+	release_mem_region(iores->start, resource_size(iores));
+err_request_region:
+	kfree(mxs_dma);
+	return ret;
+}
+
+static int __exit mxs_dma_remove(struct platform_device *pdev)
+{
+	return -EBUSY;
+}
+
+static struct platform_device_id mxs_dma_type[] = {
+	{
+		.name = "mxs-dma-apbh",
+		.driver_data = MXS_DMA_APBH,
+	}, {
+		.name = "mxs-dma-apbx",
+		.driver_data = MXS_DMA_APBX,
+	}
+};
+
+static struct platform_driver mxs_dma_driver = {
+	.driver		= {
+		.name	= "mxs-dma",
+	},
+	.id_table	= mxs_dma_type,
+	.remove		= __exit_p(mxs_dma_remove),
+};
+
+static int __init mxs_dma_module_init(void)
+{
+	return platform_driver_probe(&mxs_dma_driver, mxs_dma_probe);
+}
+subsys_initcall(mxs_dma_module_init);
-- 
1.7.1
