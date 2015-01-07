From: mchitale@apm.com (Mayuresh Chitale)
Date: Wed,  7 Jan 2015 10:58:57 +0530
Subject: [PATCH 4/4] dma: X-Gene PCIE DMA Driver
In-Reply-To: <1420608537-12296-1-git-send-email-mchitale@apm.com>
References: <1420608537-12296-1-git-send-email-mchitale@apm.com>
Message-ID: <1420608537-12296-5-git-send-email-mchitale@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements DMA engine API for DMA controller on APM
X-Gene PCIe controller. DMA engine can support up to 4 channels per port
and up to 2048 outstanding requests per channel.  This is intended
to be used on ports that are configured in EP mode or to transfer
data from a RC port that is connected to a X-Gene EP port.

Signed-off-by: Mayuresh Chitale <mchitale@apm.com>
Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
---
 drivers/dma/Kconfig          |  11 +
 drivers/dma/Makefile         |   1 +
 drivers/dma/xgene-pcie-dma.c | 709 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 721 insertions(+)
 create mode 100644 drivers/dma/xgene-pcie-dma.c

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index f2b2c4e..9f50759 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -464,4 +464,15 @@ config QCOM_BAM_DMA
 	  Enable support for the QCOM BAM DMA controller.  This controller
 	  provides DMA capabilities for a variety of on-chip devices.
 
+config XGENE_PCIE_DMA
+	tristate "X-Gene PCIe DMA support for PCIe Devices"
+	depends on PCI_XGENE
+	select DMA_ENGINE
+	default n
+	help
+	  Enable support for the X-Gene PCIe DMA engine. This can be used
+	  to transfer data between PCIe RC and PCIe endpoints only.
+
+	  If unsure, say N.
+
 endif
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 2022b54..6a75698 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -50,3 +50,4 @@ obj-y += xilinx/
 obj-$(CONFIG_INTEL_MIC_X100_DMA) += mic_x100_dma.o
 obj-$(CONFIG_NBPFAXI_DMA) += nbpfaxi.o
 obj-$(CONFIG_DMA_SUN6I) += sun6i-dma.o
+obj-$(CONFIG_XGENE_PCIE_DMA) += xgene-pcie-dma.o
diff --git a/drivers/dma/xgene-pcie-dma.c b/drivers/dma/xgene-pcie-dma.c
new file mode 100644
index 0000000..f5dfcad
--- /dev/null
+++ b/drivers/dma/xgene-pcie-dma.c
@@ -0,0 +1,709 @@
+/*
+ *  Copyright (c) 2014, 2015 Applied Micro Circuits Corporation.
+ *  Author: Tanmay Inamdar <tinamdar@apm.com>
+ *          Mayuresh Chitale <mchitale@apm.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ */
+#include <linux/circ_buf.h>
+#include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include "dmaengine.h"
+
+#define CHAN_REG_BASE			0x20000
+#define CHAN_REG_SIZE			0x40
+#define MAX_DMA_CHAN			4
+#define MAX_DMA_REQ			2048
+#define SRC_Q_PTR_LO			0x00
+#define SRC_Q_PTR_HI			0x04
+#define SRC_Q_SIZE			0x08
+#define SRC_Q_LIMIT			0x0C
+#define DST_Q_PTR_LO			0x10
+#define DST_Q_PTR_HI			0x14
+#define DST_Q_SIZE			0x18
+#define DST_Q_LIMIT			0x1C
+#define STA_Q_PTR_LO			0x20
+#define STA_Q_PTR_HI			0x24
+#define STA_Q_SIZE			0x28
+#define STA_Q_LIMIT			0x2C
+#define SRC_Q_NEXT			0x30
+#define DST_Q_NEXT			0x34
+#define STA_Q_NEXT			0x38
+#define DMA_CONTROL			0x3C
+#define AXI_DESC_COHERENCY		(1U << 3)
+#define PCI_DESC_COHERENCY		(1U << 2)
+#define DMA_READ_ATTR			0x20000000
+#define DMA_ENABLE			0x00000001
+#define DMA_RESET			0x00000004
+#define DMA_PRESENT			0x00008000
+#define PCIE_INTERRUPT			0x00010000
+#define AXI_INTERRUPT			0x01000000
+#define AXI_INTERRUPT_STATUS		0x02000000
+#define BUS_MASTER_EN_INT		0x4
+#define BUS_MASTER_DIS_INT		0x8
+#define BYTE_CNT_MASK			0xFFFFFF
+#define PORT_CFGCTL			0x8
+#define PORT_CFG_HI			0x4
+#define INTR_MASK			0x4
+#define DMA_ERROR			0xE
+#define DMA_COMPLETE			0x1
+#define PCIE_DMA_INT			0x100
+#define PCI_MEM				0
+#define AXI_MEM				1
+#define MAKE_U64(h, l)			((((u64) (h)) << 32) | (l))
+
+struct xpdma_qdesc {
+	u64 addr;
+	u64 metadata;
+};
+
+struct xpdma_desc {
+	atomic_t busy;
+	int id;
+	int src;
+	int slen;
+	int dst;
+	int dlen;
+	struct dma_async_tx_descriptor txd;
+};
+
+struct xpdma_chan {
+	struct dma_chan chan;
+	struct dma_slave_config cfg;
+	struct device *dev;
+	short id;
+	void __iomem *base;
+	spinlock_t lock;
+	u32 max_elems;
+	/* Queue descriptor addresses and circ_bufs*/
+	dma_addr_t src_elem_addr_phys;
+	struct circ_buf src;
+	dma_addr_t dst_elem_addr_phys;
+	struct circ_buf dst;
+	dma_addr_t sts_elem_addr_phys;
+	struct circ_buf sts;
+	struct circ_buf desc;
+};
+
+struct xpdma_port {
+	struct dma_device dma_dev;
+	void __iomem *dma;
+	void __iomem *cfg;
+	void __iomem *intr;
+	struct tasklet_struct completion_tasklet;
+};
+
+static void xpdma_chan_set(void __iomem *base, u32 bits)
+{
+	u32 val;
+
+	val = readl(base + DMA_CONTROL);
+	val |= bits;
+	writel(val, base + DMA_CONTROL);
+	readl(base + DMA_CONTROL);
+}
+
+static void xpdma_chan_clr(void __iomem *base, u32 bits)
+{
+	u32 val;
+
+	val = readl(base + DMA_CONTROL);
+	val &= ~bits;
+	writel(val, base + DMA_CONTROL);
+	readl(base + DMA_CONTROL);
+}
+
+static struct xpdma_chan *to_xpdma_chan(struct dma_chan *chan)
+{
+	return container_of(chan, struct xpdma_chan, chan);
+}
+
+static int xpdma_chan_present(struct xpdma_chan *chan)
+{
+	return  readl(chan->base + DMA_CONTROL) & DMA_PRESENT;
+}
+
+static void xpdma_reset_chan(void *base)
+{
+	xpdma_chan_set(base, DMA_RESET);
+	xpdma_chan_clr(base, DMA_RESET);
+}
+
+static void xpdma_disable_chan(void *base)
+{
+	xpdma_chan_clr(base, DMA_ENABLE);
+}
+
+static void xpdma_enable_chan(void *base)
+{
+	xpdma_chan_set(base, DMA_ENABLE);
+}
+
+static void xpdma_disable_axi_int(void *base)
+{
+	xpdma_chan_clr(base, AXI_INTERRUPT);
+}
+
+static void xpdma_enable_axi_int(void *base)
+{
+	xpdma_chan_set(base, AXI_INTERRUPT);
+}
+
+static void xpdma_disable_pci_int(void *base)
+{
+	xpdma_chan_clr(base, PCIE_INTERRUPT);
+}
+
+static void xpdma_setup_src_q_desc(struct xpdma_chan *chan, int pos, u64 addr,
+		u32 byte_cnt, bool eop, bool intr, bool location)
+{
+	struct xpdma_qdesc *src_desc = (struct xpdma_qdesc *)
+		chan->src.buf + pos;
+
+	src_desc->addr = addr;
+	src_desc->metadata = (byte_cnt & BYTE_CNT_MASK) | location << 24 |
+		eop << 25 | intr << 26 | DMA_READ_ATTR;
+}
+
+static void xpdma_setup_dst_q_desc(struct xpdma_chan *chan, int pos, u64 addr,
+		u32 byte_cnt, bool location)
+{
+	struct xpdma_qdesc *dst_desc = (struct xpdma_qdesc *)
+		chan->dst.buf + pos;
+
+	dst_desc->addr = addr;
+	dst_desc->metadata = (byte_cnt & BYTE_CNT_MASK) | location << 24 |
+		DMA_READ_ATTR;
+}
+
+static struct xpdma_desc *xpdma_desc_get(struct xpdma_chan *chan,
+		int src_elems, int dst_elems)
+{
+	struct xpdma_desc *desc = NULL;
+
+	spin_lock_bh(&chan->lock);
+	desc = (struct xpdma_desc *) chan->desc.buf + chan->desc.head;
+	if (!CIRC_SPACE(chan->desc.head, chan->desc.tail, chan->max_elems) ||
+			atomic_read(&desc->busy)) {
+		dev_err(chan->dev, "No free descriptors found.\n");
+		goto out_error;
+	}
+
+	if (CIRC_SPACE(chan->src.head, chan->src.tail, chan->max_elems)
+			< src_elems) {
+		dev_err(chan->dev, "No free source elems src elements found.\n");
+		goto out_error;
+	}
+
+	if (CIRC_SPACE(chan->dst.head, chan->dst.tail, chan->max_elems)
+			< dst_elems) {
+		dev_err(chan->dev, "No free dst elements found.\n");
+		goto out_error;
+	}
+
+	atomic_set(&desc->busy, 1);
+	desc->src = chan->src.head;
+	desc->slen = src_elems;
+	desc->dst = chan->dst.head;
+	desc->dlen = dst_elems;
+	chan->desc.head = (chan->desc.head + 1) & (chan->max_elems - 1);
+	chan->src.head = (chan->src.head + src_elems) & (chan->max_elems - 1);
+	chan->dst.head = (chan->dst.head + dst_elems) & (chan->max_elems - 1);
+	chan->sts.head = (chan->sts.head + 1) & (chan->max_elems - 1);
+	spin_unlock_bh(&chan->lock);
+
+	return desc;
+
+out_error:
+	spin_unlock_bh(&chan->lock);
+	dev_err(chan->dev, "Failed to get desc\n");
+
+	return NULL;
+}
+
+static void xpdma_desc_put(struct xpdma_chan *chan, struct xpdma_desc *desc)
+{
+	spin_lock_bh(&chan->lock);
+	chan->src.tail = (chan->src.tail + desc->slen) & (chan->max_elems - 1);
+	chan->dst.tail = (chan->dst.tail + desc->dlen) & (chan->max_elems - 1);
+	chan->sts.tail = (chan->sts.tail + 1) & (chan->max_elems - 1);
+	chan->desc.tail = (chan->desc.tail + 1) & (chan->max_elems - 1);
+	atomic_set(&desc->busy, 0);
+	spin_unlock_bh(&chan->lock);
+}
+
+static int xpdma_desc_complete(struct xpdma_chan *chan, struct xpdma_desc *desc)
+{
+	u32 *sts_desc, status;
+	struct dma_async_tx_descriptor *txd = NULL;
+
+	sts_desc = (u32 *) chan->sts.buf + chan->sts.tail;
+	status = *sts_desc;
+	txd = &desc->txd;
+	if (!txd) {
+		dev_err(chan->dev, "Chan %d, Desc %d, txd %p\n",
+				chan->id, desc->id, txd);
+		return -EINVAL;
+	}
+
+	if (!(status & DMA_COMPLETE)) {
+		dev_dbg(chan->dev,
+				"Chan %d, Desc %d, DMA pending\n",
+				chan->id, desc->id);
+		return -EAGAIN;
+	}
+
+	if (status & DMA_ERROR)
+		dev_err(chan->dev, "Chan %d, Desc %d, DMA error 0x%08X\n",
+				chan->id, desc->id, status);
+	else {
+		dma_cookie_complete(txd);
+		dma_descriptor_unmap(txd);
+	}
+
+	if (txd->callback)
+		txd->callback(txd->callback_param);
+
+	/* Clear the status descriptor and mark elements as free */
+	*sts_desc = 0;
+	xpdma_desc_put(chan, desc);
+
+	return 0;
+}
+
+static dma_cookie_t xpdma_tx_submit(struct dma_async_tx_descriptor *tx)
+{
+	return dma_cookie_assign(tx);
+}
+
+static int xpdma_alloc_chan_resources(struct dma_chan *dchan)
+{
+	int i;
+	struct xpdma_desc *desc;
+	struct xpdma_chan *chan = to_xpdma_chan(dchan);
+
+	chan->desc.buf = devm_kzalloc(chan->dev, chan->max_elems *
+			sizeof(struct xpdma_desc), GFP_KERNEL);
+	if (!chan->desc.buf)
+		return -ENOMEM;
+
+	for (i = 0; i < chan->max_elems; i++) {
+		desc = (struct xpdma_desc *) chan->desc.buf + i;
+		dma_async_tx_descriptor_init(&desc->txd, dchan);
+		desc->txd.tx_submit = xpdma_tx_submit;
+		desc->id = i;
+		atomic_set(&desc->busy, 0);
+	}
+
+	dma_cookie_init(dchan);
+	xpdma_enable_axi_int(chan->base);
+
+	return i;
+}
+
+static void xpdma_free_chan_resources(struct dma_chan *dchan)
+{
+	struct xpdma_chan *chan = to_xpdma_chan(dchan);
+
+	devm_kfree(chan->dev, chan->desc.buf);
+	xpdma_disable_axi_int(chan);
+}
+
+static int xpdma_device_control(struct dma_chan *dchan,
+		enum dma_ctrl_cmd cmd, unsigned long arg)
+{
+	struct xpdma_chan *chan = to_xpdma_chan(dchan);
+	struct dma_slave_config *cfg = (struct dma_slave_config *) arg;
+
+	if (cmd == DMA_SLAVE_CONFIG) {
+		memcpy(&chan->cfg, cfg, sizeof(chan->cfg));
+		return 0;
+	}
+
+	return -ENXIO;
+}
+
+static struct dma_async_tx_descriptor *xpdma_prep_slave_sg(
+		struct dma_chan *dchan, struct scatterlist *sgl,
+		u32 sg_len, enum dma_transfer_direction dir,
+		unsigned long flags, void *context)
+{
+	int i, len = 0;
+	struct scatterlist  *sg;
+	struct xpdma_desc *desc;
+	struct xpdma_chan *chan = to_xpdma_chan(dchan);
+	struct dma_slave_config cfg = chan->cfg;
+	u8 eop_intr = 0;
+
+	if (!is_slave_direction(dir)) {
+		dev_err(chan->dev, "Incorrect DMA Transfer direction %d\n",
+				dir);
+		return NULL;
+	}
+
+	if (dir == DMA_MEM_TO_DEV)
+		desc = xpdma_desc_get(chan, sg_len, 1);
+	else
+		desc = xpdma_desc_get(chan, 1, sg_len);
+
+	if (!desc)
+		return NULL;
+
+	for_each_sg(sgl, sg, sg_len, i) {
+		if (dir == DMA_MEM_TO_DEV) {
+			if (i == (sg_len - 1))
+				eop_intr = 1;
+			xpdma_setup_src_q_desc(chan, desc->src + i,
+					sg_dma_address(sg), sg_dma_len(sg),
+					eop_intr, eop_intr, AXI_MEM);
+			len += sg_dma_len(sg);
+		} else {
+			xpdma_setup_dst_q_desc(chan, desc->dst + i,
+					sg_dma_address(sg), sg_dma_len(sg),
+					AXI_MEM);
+			len += sg_dma_len(sg);
+		}
+	}
+
+	if (dir == DMA_MEM_TO_DEV)
+		xpdma_setup_dst_q_desc(chan, desc->dst, cfg.dst_addr, len,
+				PCI_MEM);
+	else
+		xpdma_setup_src_q_desc(chan, desc->src, cfg.src_addr, len,
+				1, 1, PCI_MEM);
+	return &desc->txd;
+
+}
+
+static enum dma_status xpdma_tx_status(struct dma_chan *dchan,
+		dma_cookie_t cookie,
+		struct dma_tx_state *txstate)
+{
+	return dma_cookie_status(dchan, cookie, txstate);
+}
+
+static void xpdma_issue_pending(struct dma_chan *dchan)
+{
+	struct xpdma_chan *chan = to_xpdma_chan(dchan);
+
+	spin_lock_bh(&chan->lock);
+	writel(chan->src.head, chan->base + SRC_Q_LIMIT);
+	writel(chan->dst.head, chan->base + DST_Q_LIMIT);
+	writel(chan->sts.head, chan->base + STA_Q_LIMIT);
+	spin_unlock_bh(&chan->lock);
+}
+
+static void xpdma_setup_dma_dev(struct dma_device *dev)
+{
+	dma_cap_zero(dev->cap_mask);
+	dma_cap_set(DMA_SLAVE, dev->cap_mask);
+	dma_cap_set(DMA_PRIVATE, dev->cap_mask);
+
+	dev->device_alloc_chan_resources = xpdma_alloc_chan_resources;
+	dev->device_free_chan_resources = xpdma_free_chan_resources;
+	dev->device_tx_status = xpdma_tx_status;
+	dev->device_issue_pending = xpdma_issue_pending;
+	dev->device_prep_slave_sg = xpdma_prep_slave_sg;
+	dev->device_control = xpdma_device_control;
+}
+
+static void xpdma_init_channel(struct xpdma_chan *chan)
+{
+	xpdma_disable_axi_int(chan->base);
+	xpdma_disable_pci_int(chan->base);
+	xpdma_disable_chan(chan->base);
+	xpdma_reset_chan(chan->base);
+	/*
+	 * Setup queue management registers
+	 */
+	writel(0, chan->base + SRC_Q_NEXT);
+	writel(0, chan->base + DST_Q_NEXT);
+	writel(0, chan->base + STA_Q_NEXT);
+	writel(0, chan->base + SRC_Q_LIMIT);
+	writel(0, chan->base + DST_Q_LIMIT);
+	writel(0, chan->base + STA_Q_LIMIT);
+	writel(lower_32_bits(chan->src_elem_addr_phys) | AXI_MEM |
+		AXI_DESC_COHERENCY, chan->base + SRC_Q_PTR_LO);
+	writel(upper_32_bits(chan->src_elem_addr_phys),
+			chan->base + SRC_Q_PTR_HI);
+	writel(chan->max_elems, chan->base + SRC_Q_SIZE);
+
+	writel(lower_32_bits(chan->dst_elem_addr_phys) | AXI_MEM |
+			AXI_DESC_COHERENCY, chan->base + DST_Q_PTR_LO);
+	writel(upper_32_bits(chan->dst_elem_addr_phys),
+			chan->base + DST_Q_PTR_HI);
+	writel(chan->max_elems, chan->base + DST_Q_SIZE);
+
+	writel(lower_32_bits(chan->sts_elem_addr_phys) | AXI_MEM |
+			AXI_DESC_COHERENCY, chan->base + STA_Q_PTR_LO);
+	writel(upper_32_bits(chan->sts_elem_addr_phys),
+			chan->base + STA_Q_PTR_HI);
+	writel(chan->max_elems, chan->base + STA_Q_SIZE);
+	xpdma_enable_chan(chan->base);
+}
+
+static irqreturn_t xpdma_isr(int irq, void *data)
+{
+	u32 imask, status;
+	struct xpdma_chan *chan;
+	struct dma_chan *dchan;
+	struct xpdma_port *port = (struct xpdma_port *) data;
+
+	status = readl(port->intr);
+	imask = readl(port->intr + INTR_MASK);
+	if ((status & BUS_MASTER_DIS_INT) && !(imask & BUS_MASTER_DIS_INT)) {
+		imask |= BUS_MASTER_DIS_INT;
+		imask &= ~BUS_MASTER_EN_INT;
+		writel(imask, port->intr + INTR_MASK);
+	}
+
+	if ((status & BUS_MASTER_EN_INT) && !(imask & BUS_MASTER_EN_INT)) {
+		/*
+		 * As per spec few registers should be programmed only
+		 * after bus master enable.
+		 */
+		list_for_each_entry(dchan, &port->dma_dev.channels,
+				device_node) {
+			chan = to_xpdma_chan(dchan);
+			xpdma_init_channel(chan);
+		}
+		imask |= BUS_MASTER_EN_INT;
+		imask &= ~BUS_MASTER_DIS_INT;
+		writel(imask, port->intr + INTR_MASK);
+	}
+
+	if (status & PCIE_DMA_INT) {
+		imask |= PCIE_DMA_INT;
+		writel(imask, port->intr + INTR_MASK);
+		tasklet_schedule(&port->completion_tasklet);
+	}
+	return IRQ_HANDLED;
+}
+
+static void xpdma_tasklet(unsigned long data)
+{
+	u32 status, imask;
+	struct xpdma_desc *desc;
+	struct xpdma_port *port = (struct xpdma_port *) data;
+	struct xpdma_chan *chan;
+	struct dma_chan *dchan;
+
+	list_for_each_entry(dchan, &port->dma_dev.channels, device_node) {
+		chan = to_xpdma_chan(dchan);
+		status = readl(chan->base + DMA_CONTROL);
+		if (!(status & AXI_INTERRUPT_STATUS))
+			continue;
+		status |= AXI_INTERRUPT_STATUS;
+		writel(status, chan->base + DMA_CONTROL);
+		do {
+			desc = (struct xpdma_desc *) chan->desc.buf +
+				chan->desc.tail;
+		} while (atomic_read(&desc->busy) &&
+				!xpdma_desc_complete(chan, desc));
+	}
+	imask = readl(port->intr + INTR_MASK);
+	imask &= ~PCIE_DMA_INT;
+	writel(imask, port->intr + INTR_MASK);
+}
+
+static int xpdma_alloc_sglists(struct xpdma_chan *chan)
+{
+	unsigned long len;
+	void *addr;
+
+	len = chan->max_elems * sizeof(struct xpdma_qdesc);
+	chan->src.buf = addr = dmam_alloc_coherent(chan->dev, len,
+			&chan->src_elem_addr_phys, GFP_KERNEL);
+	if (!chan->src.buf) {
+		dev_err(chan->dev, "Failed to allocate source sg descriptors\n");
+		return -ENOMEM;
+	}
+
+	chan->dst.buf = dmam_alloc_coherent(chan->dev, len,
+			&chan->dst_elem_addr_phys, GFP_KERNEL);
+	if (!chan->dst.buf) {
+		dev_err(chan->dev, "Failed to allocate destination sg descriptors\n");
+		return -ENOMEM;
+	}
+
+	chan->sts.buf = dmam_alloc_coherent(chan->dev, chan->max_elems,
+			&chan->sts_elem_addr_phys, GFP_KERNEL);
+	if (!chan->sts.buf) {
+		dev_err(chan->dev, "Failed to allocate source sg descriptors\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int xpdma_setup_dma_channel(struct platform_device *pdev,
+		struct xpdma_port *port)
+{
+	int i, ret = 0;
+	struct xpdma_chan *chan;
+	resource_size_t dma_base;
+
+	dma_base = MAKE_U64(readl(port->cfg + PORT_CFG_HI), readl(port->cfg)) +
+		CHAN_REG_BASE;
+	port->dma = devm_ioremap(&pdev->dev, dma_base,
+			CHAN_REG_SIZE * MAX_DMA_CHAN);
+	if (port->dma == NULL) {
+		dev_err(&pdev->dev, "Could not get base addressc$\n");
+		return -ENOMEM;
+	}
+
+	INIT_LIST_HEAD(&port->dma_dev.channels);
+	for (i = 0; i < MAX_DMA_CHAN; i++) {
+		chan = devm_kzalloc(&pdev->dev, sizeof(struct xpdma_chan),
+				GFP_KERNEL);
+		if (!chan)
+			return -ENOMEM;
+		memset(chan, 0, sizeof(*chan));
+		chan->id = i;
+		chan->dev = port->dma_dev.dev;
+		chan->base = port->dma + (i * CHAN_REG_SIZE);
+		chan->chan.device = &port->dma_dev;
+		if (!xpdma_chan_present(chan)) {
+			dev_err(chan->dev, "DMA Chan %d is disabled\n",
+					chan->id);
+			continue;
+		}
+
+		chan->max_elems = MAX_DMA_REQ;
+		ret = xpdma_alloc_sglists(chan);
+		if (ret)
+			return -ENOMEM;
+		spin_lock_init(&chan->lock);
+		list_add_tail(&chan->chan.device_node,
+				&port->dma_dev.channels);
+	}
+	return 0;
+}
+
+static int xpdma_probe(struct platform_device *pdev)
+{
+	int err;
+	u32 mask;
+	struct resource *res;
+	struct xpdma_port *port;
+
+	port = devm_kzalloc(&pdev->dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	port->dma_dev.dev = &pdev->dev;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "No cfg resource\n");
+		return -EINVAL;
+	}
+
+	port->cfg = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (IS_ERR(port->cfg))
+		return PTR_ERR(port->cfg);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res) {
+		dev_err(&pdev->dev, "No intr resource\n");
+		return -EINVAL;
+	}
+
+	port->intr = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (IS_ERR(port->intr))
+		return PTR_ERR(port->intr);
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "No irq resource\n");
+		return -EINVAL;
+	}
+
+	if (!readl(port->cfg + PORT_CFGCTL)) {
+		dev_err(&pdev->dev, "Port not enabled\n");
+		return -EINVAL;
+	}
+
+	err = xpdma_setup_dma_channel(pdev, port);
+	if (err) {
+		dev_err(&pdev->dev, "Setup channel failed\n");
+		return -EINVAL;
+	}
+
+	tasklet_init(&port->completion_tasklet, xpdma_tasklet,
+			(unsigned long)port);
+
+	err = devm_request_irq(&pdev->dev, res->start, xpdma_isr,
+			IRQF_SHARED, "PCIEDMA", port);
+	if (err) {
+		dev_err(&pdev->dev, "Request IRQ failed for XGENE PCIe DMA\n");
+		return -EINVAL;
+	}
+
+	xpdma_setup_dma_dev(&port->dma_dev);
+	/* Setup DMA mask - 32 for 32-bit system and 64 for 64-bit system */
+	err = dma_set_mask_and_coherent(&pdev->dev,
+			DMA_BIT_MASK(8*sizeof(void *)));
+	if (err) {
+		dev_err(&pdev->dev, "Unable to set dma mask\n");
+		return err;
+	}
+
+	err = dma_async_device_register(&port->dma_dev);
+	if (err) {
+		dev_err(&pdev->dev,
+				"XGENE PCIe DMA device_register failed: %d\n",
+				err);
+		return -EINVAL;
+	}
+
+	platform_set_drvdata(pdev, port);
+	mask = readl(port->intr + INTR_MASK);
+	mask &= ~(BUS_MASTER_EN_INT | PCIE_DMA_INT);
+	writel(mask, port->intr + INTR_MASK);
+	dev_info(&pdev->dev, "X-Gene PCIE DMA driver v1.0");
+	return 0;
+}
+
+static int xpdma_remove(struct platform_device *pdev)
+{
+	struct xpdma_port *port = platform_get_drvdata(pdev);
+
+	dma_async_device_unregister(&port->dma_dev);
+	return 0;
+}
+
+static const struct of_device_id xpdma_match_table[] = {
+	{.compatible = "apm,xgene-pciedma",},
+	{},
+};
+
+static struct platform_driver xpdma_driver = {
+	.driver = {
+		.name = "xgene-pciedma",
+		.of_match_table = of_match_ptr(xpdma_match_table),
+	},
+	.probe = xpdma_probe,
+	.remove = xpdma_remove,
+};
+module_platform_driver(xpdma_driver);
+
+MODULE_AUTHOR("Tanmay Inamdar <tinamdar@apm.com>");
+MODULE_AUTHOR("Mayuresh Chitale <mchitale@apm.com>");
+MODULE_DESCRIPTION("XGENE X-Gene PCIe DMA Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.2.1.212.gc5b9256
