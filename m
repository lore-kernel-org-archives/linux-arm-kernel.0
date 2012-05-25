From: zhangfei.gao@marvell.com (Zhangfei Gao)
Date: Fri, 25 May 2012 15:11:00 +0800
Subject: [PATCH] dmaengine: mmp_tdma: add mmp tdma support
In-Reply-To: <1337929863-31885-1-git-send-email-zhangfei.gao@marvell.com>
References: <1337929863-31885-1-git-send-email-zhangfei.gao@marvell.com>
Message-ID: <1337929863-31885-2-git-send-email-zhangfei.gao@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for two-channel dma under dmaengine
support: mmp-adma and pxa910-squ

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
Signed-off-by: Leo Yan <leoy@marvell.com>
Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
---
 drivers/dma/Kconfig                   |   10 +
 drivers/dma/Makefile                  |    1 +
 drivers/dma/mmp_tdma.c                |  677 +++++++++++++++++++++++++++++++++
 include/linux/platform_data/mmp_dma.h |   20 +
 4 files changed, 708 insertions(+), 0 deletions(-)
 create mode 100644 drivers/dma/mmp_tdma.c
 create mode 100644 include/linux/platform_data/mmp_dma.h

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index ef378b5..26d5b1b 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -259,6 +259,16 @@ config DMA_SA11X0
 	  SA-1110 SoCs.  This DMA engine can only be used with on-chip
 	  devices.
 
+config MMP_TDMA
+	bool "MMP Two-Channel DMA support"
+	default ARCH_MMP
+	select DMA_ENGINE
+	help
+	  Support the MMP Two-Channel DMA engine.
+	  This engine used for MMP Audio DMA and pxa910 SQU.
+
+	  Say Y here if you enabled MMP ADMA, otherwise say N.
+
 config DMA_ENGINE
 	bool
 
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 86b795b..37e9258 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -28,3 +28,4 @@ obj-$(CONFIG_PCH_DMA) += pch_dma.o
 obj-$(CONFIG_AMBA_PL08X) += amba-pl08x.o
 obj-$(CONFIG_EP93XX_DMA) += ep93xx_dma.o
 obj-$(CONFIG_DMA_SA11X0) += sa11x0-dma.o
+obj-$(CONFIG_MMP_TDMA) += mmp_tdma.o
diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
new file mode 100644
index 0000000..043511b
--- /dev/null
+++ b/drivers/dma/mmp_tdma.c
@@ -0,0 +1,677 @@
+/*
+ * Driver For Marvell Two-channel DMA Engine
+ *
+ * Copyright:	Marvell International Ltd.
+ *		Leo Yan <leoy@marvell.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/dma-mapping.h>
+#include <linux/slab.h>
+#include <linux/dmaengine.h>
+#include <linux/platform_device.h>
+#include <linux/device.h>
+#include <linux/platform_data/mmp_dma.h>
+#include <mach/regs-icu.h>
+#include <mach/sram.h>
+
+/*
+ * Two-Channel DMA registers
+ */
+#define TDBCR		0x00	/* Byte Count */
+#define TDSAR		0x10	/* Src Addr */
+#define TDDAR		0x20	/* Dst Addr */
+#define TDNDPR		0x30	/* Next Desc */
+#define TDCR		0x40	/* Control */
+#define TDCP		0x60	/* Priority*/
+#define TDCDPR		0x70	/* Current Desc */
+#define TDIMR		0x80	/* Int Mask */
+#define TDISR		0xa0	/* Int Status */
+
+/* Two-Channel DMA Control Register */
+#define TDCR_SSZ_8_BITS		(0x0 << 22)	/* Sample Size */
+#define TDCR_SSZ_12_BITS	(0x1 << 22)
+#define TDCR_SSZ_16_BITS	(0x2 << 22)
+#define TDCR_SSZ_20_BITS	(0x3 << 22)
+#define TDCR_SSZ_24_BITS	(0x4 << 22)
+#define TDCR_SSZ_32_BITS	(0x5 << 22)
+#define TDCR_SSZ_SHIFT		(0x1 << 22)
+#define TDCR_SSZ_MASK		(0x7 << 22)
+#define TDCR_SSPMOD		(0x1 << 21)	/* SSP MOD */
+#define TDCR_ABR		(0x1 << 20)	/* Channel Abort */
+#define TDCR_CDE		(0x1 << 17)	/* Close Desc Enable */
+#define TDCR_PACKMOD		(0x1 << 16)	/* Pack Mode (ADMA Only) */
+#define TDCR_CHANACT		(0x1 << 14)	/* Channel Active */
+#define TDCR_FETCHND		(0x1 << 13)	/* Fetch Next Desc */
+#define TDCR_CHANEN		(0x1 << 12)	/* Channel Enable */
+#define TDCR_INTMODE		(0x1 << 10)	/* Interrupt Mode */
+#define TDCR_CHAINMOD		(0x1 << 9)	/* Chain Mode */
+#define TDCR_BURSTSZ_MSK	(0x7 << 6)	/* Burst Size */
+#define TDCR_BURSTSZ_4B		(0x0 << 6)
+#define TDCR_BURSTSZ_8B		(0x1 << 6)
+#define TDCR_BURSTSZ_16B	(0x3 << 6)
+#define TDCR_BURSTSZ_32B	(0x6 << 6)
+#define TDCR_BURSTSZ_64B	(0x7 << 6)
+#define TDCR_BURSTSZ_SQU_32B	(0x7 << 6)
+#define TDCR_BURSTSZ_128B	(0x5 << 6)
+#define TDCR_DSTDIR_MSK		(0x3 << 4)	/* Dst Direction */
+#define TDCR_DSTDIR_ADDR_HOLD	(0x2 << 4)	/* Dst Addr Hold */
+#define TDCR_DSTDIR_ADDR_INC	(0x0 << 4)	/* Dst Addr Increment */
+#define TDCR_SRCDIR_MSK		(0x3 << 2)	/* Src Direction */
+#define TDCR_SRCDIR_ADDR_HOLD	(0x2 << 2)	/* Src Addr Hold */
+#define TDCR_SRCDIR_ADDR_INC	(0x0 << 2)	/* Src Addr Increment */
+#define TDCR_DSTDESCCONT	(0x1 << 1)
+#define TDCR_SRCDESTCONT	(0x1 << 0)
+
+/* Two-Channel DMA Int Mask Register */
+#define TDIMR_COMP		(0x1 << 0)
+
+/* Two-Channel DMA Int Status Register */
+#define TDISR_COMP		(0x1 << 0)
+
+/*
+ * Two-Channel DMA Descriptor Struct
+ * NOTE: desc's buf must be aligned to 16 bytes.
+ */
+struct mmp_tdma_desc {
+	u32 byte_cnt;
+	u32 src_addr;
+	u32 dst_addr;
+	u32 nxt_desc;
+};
+
+enum mmp_tdma_type {
+	MMP_AUD_TDMA = 0,
+	PXA910_SQU,
+};
+
+#define TDMA_ALIGNMENT		3
+#define TDMA_MAX_XFER_BYTES    SZ_64K
+
+struct mmp_tdma_chan {
+	struct device			*dev;
+	struct dma_chan			chan;
+	struct dma_async_tx_descriptor	desc;
+	struct tasklet_struct		tasklet;
+
+	struct mmp_tdma_desc		*desc_arr;
+	phys_addr_t			desc_arr_phys;
+	int				desc_num;
+	enum dma_transfer_direction	dir;
+	dma_addr_t			dev_addr;
+	u32				burst_sz;
+	enum dma_status			status;
+
+	int				idx;
+	enum mmp_tdma_type		type;
+	int				irq;
+	unsigned long			reg_base;
+};
+
+#define TDMA_CHANNEL_NUM 2
+struct mmp_tdma_device {
+	struct device			*dev;
+	void __iomem			*base;
+	struct dma_device		device;
+	struct mmp_tdma_chan		*tdmac[TDMA_CHANNEL_NUM];
+	int				irq;
+};
+
+#define to_mmp_tdma_chan(dchan) container_of(dchan, struct mmp_tdma_chan, chan)
+
+static void mmp_tdma_chan_set_desc(struct mmp_tdma_chan *tdmac, dma_addr_t phys)
+{
+	writel(phys, tdmac->reg_base + TDNDPR);
+	writel(readl(tdmac->reg_base + TDCR) | TDCR_FETCHND,
+					tdmac->reg_base + TDCR);
+}
+
+static void mmp_tdma_enable_chan(struct mmp_tdma_chan *tdmac)
+{
+	/* enable irq */
+	writel(TDIMR_COMP, tdmac->reg_base + TDIMR);
+	/* enable dma chan */
+	writel(readl(tdmac->reg_base + TDCR) | TDCR_CHANEN,
+					tdmac->reg_base + TDCR);
+	tdmac->status = DMA_IN_PROGRESS;
+}
+
+static void mmp_tdma_disable_chan(struct mmp_tdma_chan *tdmac)
+{
+	writel(readl(tdmac->reg_base + TDCR) & ~TDCR_CHANEN,
+					tdmac->reg_base + TDCR);
+	tdmac->status = DMA_SUCCESS;
+}
+
+static void mmp_tdma_resume_chan(struct mmp_tdma_chan *tdmac)
+{
+	writel(readl(tdmac->reg_base + TDCR) | TDCR_CHANEN,
+					tdmac->reg_base + TDCR);
+	tdmac->status = DMA_IN_PROGRESS;
+}
+
+static void mmp_tdma_pause_chan(struct mmp_tdma_chan *tdmac)
+{
+	writel(readl(tdmac->reg_base + TDCR) & ~TDCR_CHANEN,
+					tdmac->reg_base + TDCR);
+	tdmac->status = DMA_PAUSED;
+}
+
+static int mmp_tdma_config_chan(struct mmp_tdma_chan *tdmac)
+{
+	struct mmp_tdma_data *tdma_data = tdmac->chan.private;
+	unsigned int tdcr;
+
+	mmp_tdma_disable_chan(tdmac);
+
+	if (tdmac->dir == DMA_MEM_TO_DEV)
+		tdcr = TDCR_DSTDIR_ADDR_HOLD | TDCR_SRCDIR_ADDR_INC;
+	else if (tdmac->dir == DMA_DEV_TO_MEM)
+		tdcr = TDCR_SRCDIR_ADDR_HOLD | TDCR_DSTDIR_ADDR_INC;
+	else if (tdmac->dir == DMA_MEM_TO_MEM)
+		tdcr = TDCR_SRCDIR_ADDR_INC  | TDCR_DSTDIR_ADDR_INC;
+	else
+		tdcr = TDCR_SRCDIR_ADDR_HOLD | TDCR_DSTDIR_ADDR_HOLD;
+
+	if (tdmac->type == MMP_AUD_TDMA) {
+		switch (tdmac->burst_sz) {
+		case 4:
+			tdcr |= TDCR_BURSTSZ_4B;
+			break;
+		case 8:
+			tdcr |= TDCR_BURSTSZ_8B;
+			break;
+		case 16:
+			tdcr |= TDCR_BURSTSZ_16B;
+			break;
+		case 32:
+			tdcr |= TDCR_BURSTSZ_32B;
+			break;
+		case 64:
+			tdcr |= TDCR_BURSTSZ_64B;
+			break;
+		case 128:
+			tdcr |= TDCR_BURSTSZ_128B;
+			break;
+		default:
+			dev_err(tdmac->dev, "mmp_tdma: unknown burst size.\n");
+			return -EINVAL;
+		}
+
+		if (tdma_data->pack_mod)
+			tdcr |= TDCR_PACKMOD;
+
+		switch (tdma_data->bus_size) {
+		case 8:
+			tdcr |= TDCR_SSZ_8_BITS;
+			break;
+		case 12:
+			tdcr |= TDCR_SSZ_12_BITS;
+			break;
+		case 16:
+			tdcr |= TDCR_SSZ_16_BITS;
+			break;
+		case 20:
+			tdcr |= TDCR_SSZ_20_BITS;
+			break;
+		case 24:
+			tdcr |= TDCR_SSZ_24_BITS;
+			break;
+		case 32:
+			tdcr |= TDCR_SSZ_32_BITS;
+			break;
+		default:
+			dev_err(tdmac->dev, "mmp_tdma: unknown bus size.\n");
+			return -EINVAL;
+		}
+	} else if (tdmac->type == PXA910_SQU) {
+		tdcr |= TDCR_BURSTSZ_SQU_32B;
+		tdcr |= TDCR_SSPMOD;
+	}
+
+	writel(tdcr, tdmac->reg_base + TDCR);
+	return 0;
+}
+
+static int mmp_tdma_clear_chan_irq(struct mmp_tdma_chan *tdmac)
+{
+	u32 reg = readl(tdmac->reg_base + TDISR);
+
+	if (reg & TDISR_COMP) {
+		/* clear irq */
+		reg &= ~TDISR_COMP;
+		writel(reg, tdmac->reg_base + TDISR);
+
+		return 1;
+	}
+	return 0;
+}
+
+static irqreturn_t mmp_tdma_chan_handler(int irq, void *dev_id)
+{
+	struct mmp_tdma_chan *tdmac = dev_id;
+
+	if (mmp_tdma_clear_chan_irq(tdmac)) {
+		tasklet_schedule(&tdmac->tasklet);
+		return IRQ_HANDLED;
+	} else
+		return IRQ_NONE;
+}
+
+static irqreturn_t mmp_tdma_int_handler(int irq, void *dev_id)
+{
+	struct mmp_tdma_device *tdev = dev_id;
+	int i, ret;
+	int irq_num = 0;
+
+	for (i = 0; i < TDMA_CHANNEL_NUM; i++) {
+		struct mmp_tdma_chan *tdmac = tdev->tdmac[i];
+
+		ret = mmp_tdma_chan_handler(irq, tdmac);
+		if (ret == IRQ_HANDLED)
+			irq_num++;
+	}
+
+	if (irq_num)
+		return IRQ_HANDLED;
+	else
+		return IRQ_NONE;
+}
+
+static void dma_do_tasklet(unsigned long data)
+{
+	struct mmp_tdma_chan *tdmac = (struct mmp_tdma_chan *)data;
+
+	if (tdmac->desc.callback)
+		tdmac->desc.callback(tdmac->desc.callback_param);
+
+}
+
+static void mmp_tdma_free_descriptor(struct mmp_tdma_chan *tdmac)
+{
+	struct gen_pool *gpool;
+	int size = tdmac->desc_num * sizeof(struct mmp_tdma_desc);
+
+	gpool = sram_get_gpool("asram");
+	gen_pool_free(gpool, (unsigned long)tdmac->desc_arr,
+			size);
+
+	return;
+}
+
+static dma_cookie_t mmp_tdma_tx_submit(struct dma_async_tx_descriptor *tx)
+{
+	struct mmp_tdma_chan *tdmac = to_mmp_tdma_chan(tx->chan);
+
+	mmp_tdma_chan_set_desc(tdmac, tdmac->desc_arr_phys);
+
+	return 0;
+}
+
+static int mmp_tdma_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct mmp_tdma_chan *tdmac = to_mmp_tdma_chan(chan);
+	int ret;
+
+	dev_dbg(tdmac->dev, "%s: enter\n", __func__);
+
+	dma_async_tx_descriptor_init(&tdmac->desc, chan);
+	tdmac->desc.tx_submit = mmp_tdma_tx_submit;
+
+	if (tdmac->irq) {
+		ret = devm_request_irq(tdmac->dev, tdmac->irq,
+			mmp_tdma_chan_handler, IRQF_DISABLED, "tdma", tdmac);
+		if (ret)
+			goto err_request_irq;
+	}
+
+	return 0;
+
+err_request_irq:
+	mmp_tdma_free_descriptor(tdmac);
+	return ret;
+}
+
+static void mmp_tdma_free_chan_resources(struct dma_chan *chan)
+{
+	struct mmp_tdma_chan *tdmac = to_mmp_tdma_chan(chan);
+
+	dev_dbg(tdmac->dev, "%s: enter\n", __func__);
+
+	if (tdmac->irq)
+		devm_free_irq(tdmac->dev, tdmac->irq, tdmac);
+	mmp_tdma_disable_chan(tdmac);
+	mmp_tdma_free_descriptor(tdmac);
+	return;
+}
+
+
+static struct dma_async_tx_descriptor *mmp_tdma_prep_slave_sg(
+		struct dma_chan *chan, struct scatterlist *sgl,
+		unsigned int sg_len, enum dma_transfer_direction direction,
+		unsigned long flags, void *context)
+{
+	/*
+	 * This operation is not supported on the TDMA controller
+	 *
+	 * However, we need to provide the function pointer to allow the
+	 * device_control() method to work.
+	 */
+	return NULL;
+}
+
+static int mmp_tdma_alloc_descriptor(struct mmp_tdma_chan *tdmac)
+{
+	struct gen_pool *gpool;
+	int size = tdmac->desc_num * sizeof(struct mmp_tdma_desc);
+
+	dev_dbg(tdmac->dev, "%s: enter\n", __func__);
+
+	gpool = sram_get_gpool("asram");
+	if (!gpool)
+		return -ENOMEM;
+
+	tdmac->desc_arr = (void *)gen_pool_alloc(gpool, size);
+	if (!tdmac->desc_arr)
+		return -ENOMEM;
+
+	tdmac->desc_arr_phys = gen_pool_virt_to_phys(gpool,
+			(unsigned long)tdmac->desc_arr);
+
+	return 0;
+}
+
+static struct dma_async_tx_descriptor *mmp_tdma_prep_dma_cyclic(
+		struct dma_chan *chan, dma_addr_t dma_addr, size_t buf_len,
+		size_t period_len, enum dma_transfer_direction direction,
+		void *context)
+{
+	struct mmp_tdma_chan *tdmac = to_mmp_tdma_chan(chan);
+	int num_periods = buf_len / period_len;
+	int i = 0, buf = 0;
+	int ret;
+
+	if (tdmac->status != DMA_SUCCESS)
+		return NULL;
+
+	if (period_len > TDMA_MAX_XFER_BYTES) {
+		dev_err(tdmac->dev,
+				"maximum period size exceeded: %d > %d\n",
+				period_len, TDMA_MAX_XFER_BYTES);
+		goto err_out;
+	}
+
+	tdmac->status = DMA_IN_PROGRESS;
+	tdmac->desc_num = num_periods;
+	ret = mmp_tdma_alloc_descriptor(tdmac);
+	if (ret < 0)
+		goto err_out;
+
+	while (buf < buf_len) {
+		struct mmp_tdma_desc *desc = &tdmac->desc_arr[i];
+
+		if (i + 1 == num_periods)
+			desc->nxt_desc = tdmac->desc_arr_phys;
+		else
+			desc->nxt_desc = tdmac->desc_arr_phys +
+				sizeof(*desc) * (i + 1);
+
+		if (direction == DMA_MEM_TO_DEV) {
+			desc->src_addr = dma_addr;
+			desc->dst_addr = tdmac->dev_addr;
+		} else {
+			desc->src_addr = tdmac->dev_addr;
+			desc->dst_addr = dma_addr;
+		}
+		desc->byte_cnt = period_len;
+		dma_addr += period_len;
+		buf += period_len;
+		i++;
+	}
+
+	return &tdmac->desc;
+
+err_out:
+	tdmac->status = DMA_ERROR;
+	return NULL;
+}
+
+static int mmp_tdma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
+		unsigned long arg)
+{
+	struct mmp_tdma_chan *tdmac = to_mmp_tdma_chan(chan);
+	struct dma_slave_config *dmaengine_cfg = (void *)arg;
+	int ret = 0;
+
+	switch (cmd) {
+	case DMA_TERMINATE_ALL:
+		mmp_tdma_disable_chan(tdmac);
+		break;
+	case DMA_PAUSE:
+		mmp_tdma_pause_chan(tdmac);
+		break;
+	case DMA_RESUME:
+		mmp_tdma_resume_chan(tdmac);
+		break;
+	case DMA_SLAVE_CONFIG:
+		if (dmaengine_cfg->direction == DMA_DEV_TO_MEM) {
+			tdmac->dev_addr = dmaengine_cfg->src_addr;
+			tdmac->burst_sz = dmaengine_cfg->src_maxburst;
+		} else {
+			tdmac->dev_addr = dmaengine_cfg->dst_addr;
+			tdmac->burst_sz = dmaengine_cfg->dst_maxburst;
+		}
+		tdmac->dir = dmaengine_cfg->direction;
+		return mmp_tdma_config_chan(tdmac);
+	default:
+		ret = -ENOSYS;
+	}
+
+	return ret;
+}
+
+static enum dma_status mmp_tdma_tx_status(struct dma_chan *chan,
+			dma_cookie_t cookie, struct dma_tx_state *txstate)
+{
+	struct mmp_tdma_chan *tdmac = to_mmp_tdma_chan(chan);
+
+	return tdmac->status;
+}
+
+static void mmp_tdma_issue_pending(struct dma_chan *chan)
+{
+	struct mmp_tdma_chan *tdmac = to_mmp_tdma_chan(chan);
+
+	mmp_tdma_enable_chan(tdmac);
+}
+
+static int __devexit mmp_tdma_remove(struct platform_device *pdev)
+{
+	struct mmp_tdma_device *tdev = platform_get_drvdata(pdev);
+	struct resource *iores;
+	int chan_num = TDMA_CHANNEL_NUM;
+	int i;
+
+	dma_async_device_unregister(&tdev->device);
+
+	if (tdev->irq)
+		devm_free_irq(tdev->dev, tdev->irq, tdev);
+
+	for (i = 0; i < chan_num; i++)
+		devm_kfree(&pdev->dev, tdev->tdmac[i]);
+
+	iounmap(tdev->base);
+	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (iores)
+		release_mem_region(iores->start, resource_size(iores));
+
+	devm_kfree(&pdev->dev, tdev);
+
+	return 0;
+}
+
+static int __devinit mmp_tdma_chan_init(struct mmp_tdma_device *tdev,
+						int idx, int irq, int type)
+{
+	struct mmp_tdma_chan *tdmac;
+
+	if (idx >= TDMA_CHANNEL_NUM) {
+		dev_err(tdev->dev, "too many channels for device!\n");
+		return -EINVAL;
+	}
+
+	/* alloc channel */
+	tdmac = devm_kzalloc(tdev->dev, sizeof(*tdmac), GFP_KERNEL);
+	if (!tdmac) {
+		dev_err(tdev->dev, "no free memory for DMA channels!\n");
+		return -ENOMEM;
+	}
+	if (irq)
+		tdmac->irq = irq + idx;
+	tdmac->dev	   = tdev->dev;
+	tdmac->chan.device = &tdev->device;
+	tdmac->idx	   = idx;
+	tdmac->type	   = type;
+	tdmac->reg_base	   = (unsigned long)tdev->base + idx * 4;
+	tdmac->status = DMA_SUCCESS;
+	tdev->tdmac[tdmac->idx] = tdmac;
+	tasklet_init(&tdmac->tasklet, dma_do_tasklet, (unsigned long)tdmac);
+
+	/* add the channel to tdma_chan list */
+	list_add_tail(&tdmac->chan.device_node,
+			&tdev->device.channels);
+
+	return 0;
+}
+
+static int __devinit mmp_tdma_probe(struct platform_device *pdev)
+{
+	const struct platform_device_id *id = platform_get_device_id(pdev);
+	enum mmp_tdma_type type = id->driver_data;
+	struct mmp_tdma_device *tdev;
+	struct resource *iores;
+	int i, ret;
+	int irq = 0;
+	int chan_num = TDMA_CHANNEL_NUM;
+
+	/* always have couple channels */
+	tdev = devm_kzalloc(&pdev->dev, sizeof(*tdev), GFP_KERNEL);
+	if (!tdev)
+		return -ENOMEM;
+
+	tdev->dev = &pdev->dev;
+	iores = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!iores) {
+		ret = -EINVAL;
+		goto err_irq;
+	}
+
+	if (resource_size(iores) != chan_num)
+		tdev->irq = iores->start;
+	else
+		irq = iores->start;
+
+	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!iores) {
+		ret = -EINVAL;
+		goto err_irq;
+	}
+
+	if (!request_mem_region(iores->start, resource_size(iores),
+				pdev->name)) {
+		ret = -EBUSY;
+		goto err_request_region;
+	}
+
+	tdev->base = ioremap(iores->start, resource_size(iores));
+	if (!tdev->base) {
+		ret = -ENOMEM;
+		goto err_ioremap;
+	}
+
+	if (tdev->irq) {
+		ret = devm_request_irq(&pdev->dev, tdev->irq,
+			mmp_tdma_int_handler, IRQF_DISABLED, "tdma", tdev);
+		if (ret)
+			goto err_req_irq;
+	}
+
+	dma_cap_set(DMA_SLAVE, tdev->device.cap_mask);
+	dma_cap_set(DMA_CYCLIC, tdev->device.cap_mask);
+
+	INIT_LIST_HEAD(&tdev->device.channels);
+
+	/* initialize channel parameters */
+	for (i = 0; i < chan_num; i++) {
+		ret = mmp_tdma_chan_init(tdev, i, irq, type);
+		if (ret)
+			goto err_init;
+	}
+
+	tdev->device.dev = &pdev->dev;
+	tdev->device.device_alloc_chan_resources =
+					mmp_tdma_alloc_chan_resources;
+	tdev->device.device_free_chan_resources =
+					mmp_tdma_free_chan_resources;
+	tdev->device.device_prep_slave_sg = mmp_tdma_prep_slave_sg;
+	tdev->device.device_prep_dma_cyclic = mmp_tdma_prep_dma_cyclic;
+	tdev->device.device_tx_status = mmp_tdma_tx_status;
+	tdev->device.device_issue_pending = mmp_tdma_issue_pending;
+	tdev->device.device_control = mmp_tdma_control;
+	tdev->device.copy_align = TDMA_ALIGNMENT;
+
+	dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
+	platform_set_drvdata(pdev, tdev);
+
+	ret = dma_async_device_register(&tdev->device);
+	if (ret) {
+		dev_err(tdev->device.dev, "unable to register\n");
+		goto err_init;
+	}
+
+	dev_info(tdev->device.dev, "initialized\n");
+	return 0;
+
+err_init:
+	for (i = 0; i < chan_num; i++)
+		devm_kfree(&pdev->dev, tdev->tdmac[i]);
+	if (tdev->irq)
+		devm_free_irq(tdev->dev, tdev->irq, tdev);
+err_req_irq:
+	iounmap(tdev->base);
+err_ioremap:
+	release_mem_region(iores->start, resource_size(iores));
+err_request_region:
+err_irq:
+	devm_kfree(&pdev->dev, tdev);
+	return ret;
+}
+
+static const struct platform_device_id mmp_tdma_id_table[] = {
+	{ "mmp-adma",	MMP_AUD_TDMA },
+	{ "pxa910-squ",	PXA910_SQU },
+	{ },
+};
+
+static struct platform_driver mmp_tdma_driver = {
+	.driver		= {
+		.name	= "mmp-tdma",
+		.owner  = THIS_MODULE,
+	},
+	.id_table	= mmp_tdma_id_table,
+	.probe		= mmp_tdma_probe,
+	.remove		= __devexit_p(mmp_tdma_remove),
+};
+
+module_platform_driver(mmp_tdma_driver);
+
+MODULE_DESCRIPTION("MMP Two-Channel DMA Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/platform_data/mmp_dma.h b/include/linux/platform_data/mmp_dma.h
new file mode 100644
index 0000000..4e21cf9
--- /dev/null
+++ b/include/linux/platform_data/mmp_dma.h
@@ -0,0 +1,20 @@
+/*
+ *  MMP Platform DMA Management
+ *
+ *  Copyright (c) 2011 Marvell Semiconductors Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ */
+
+#ifndef MMP_DMA_H
+#define MMP_DMA_H
+
+struct mmp_tdma_data {
+	u32 bus_size;
+	u32 pack_mod;
+};
+
+#endif /* MMP_DMA_H */
-- 
1.7.1
