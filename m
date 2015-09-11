From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 11 Sep 2015 15:14:25 +0100
Subject: [PATCH v2 3/9] dmaengine: st_fdma: Add STMicroelectronics FDMA driver
 header file
In-Reply-To: <1441980871-24475-1-git-send-email-peter.griffin@linaro.org>
References: <1441980871-24475-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1441980871-24475-4-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/dma/st_fdma.h | 237 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 237 insertions(+)
 create mode 100644 drivers/dma/st_fdma.h

diff --git a/drivers/dma/st_fdma.h b/drivers/dma/st_fdma.h
new file mode 100644
index 0000000..5841a301
--- /dev/null
+++ b/drivers/dma/st_fdma.h
@@ -0,0 +1,237 @@
+/*
+ * st_fdma.h
+ *
+ * Copyright (C) 2014 STMicroelectronics
+ * Author: Ludovic Barre <Ludovic.barre@st.com>
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+#ifndef __DMA_ST_FDMA_H
+#define __DMA_ST_FDMA_H
+
+#include <linux/dmaengine.h>
+#include <linux/interrupt.h>
+#include <linux/platform_data/dma-st_fdma.h>
+
+#include "virt-dma.h"
+
+#define ST_FDMA_NR_DREQS 32
+#define EM_SLIM	102	/* No official SLIM ELF ID */
+
+enum {
+	CLK_SLIM,
+	CLK_HI,
+	CLK_LOW,
+	CLK_IC,
+	CLK_MAX_NUM,
+};
+
+#define NAME_SZ 10
+
+struct st_fdma_ram {
+	char name[NAME_SZ];
+	u32 offset;
+	u32 size;
+};
+
+/**
+ * struct st_fdma_generic_node - Free running/paced generic node
+ *
+ * @length: Length in bytes of a line in a 2D mem to mem
+ * @sstride: Stride, in bytes, between source lines in a 2D data move
+ * @dstride: Stride, in bytes, between destination lines in a 2D data move
+ */
+struct st_fdma_generic_node {
+	u32 length;
+	u32 sstride;
+	u32 dstride;
+};
+
+/**
+ * struct st_fdma_hw_node - Node structure used by fdma hw
+ *
+ * @next: Pointer to next node
+ * @control: Transfer Control Parameters
+ * @nbytes: Number of Bytes to read
+ * @saddr: Source address
+ * @daddr: Destination address
+ *
+ * @generic: generic node for free running/paced transfert type
+ * 2 others transfert type are possible, but not yet implemented
+ *
+ * The NODE structures must be aligned to a 32 byte boundary
+ */
+struct st_fdma_hw_node {
+	u32 next;
+	u32 control;
+	u32 nbytes;
+	u32 saddr;
+	u32 daddr;
+	union {
+		struct st_fdma_generic_node generic;
+	};
+} __aligned(32);
+
+/*
+ * node control parameters
+ */
+#define NODE_CTRL_REQ_MAP_MASK		GENMASK(4, 0)
+#define NODE_CTRL_REQ_MAP_FREE_RUN	0x0
+#define NODE_CTRL_REQ_MAP_DREQ(n)	((n) & NODE_CTRL_REQ_MAP_MASK)
+#define NODE_CTRL_REQ_MAP_EXT		NODE_CTRL_REQ_MAP_MASK
+#define NODE_CTRL_SRC_MASK		GENMASK(6, 5)
+#define NODE_CTRL_SRC_STATIC		BIT(5)
+#define NODE_CTRL_SRC_INCR		BIT(6)
+#define NODE_CTRL_DST_MASK		GENMASK(8, 7)
+#define NODE_CTRL_DST_STATIC		BIT(7)
+#define NODE_CTRL_DST_INCR		BIT(8)
+#define NODE_CTRL_SECURE		BIT(15)
+#define NODE_CTRL_PAUSE_EON		BIT(30)
+#define NODE_CTRL_INT_EON		BIT(31)
+
+/**
+ * struct st_fdma_sw_node - descriptor structure for link list
+ *
+ * @pdesc: Physical address of desc
+ * @node: link used for putting this into a channel queue
+ */
+struct st_fdma_sw_node {
+	dma_addr_t pdesc;
+	struct st_fdma_hw_node *desc;
+};
+
+struct st_fdma_driverdata {
+	const struct st_fdma_ram *fdma_mem;
+	u32 num_mem;
+	char name[NAME_SZ];
+};
+
+struct st_fdma_desc {
+	struct virt_dma_desc vdesc;
+	struct st_fdma_chan *fchan;
+	bool iscyclic;
+	unsigned int n_nodes;
+	struct st_fdma_sw_node node[];
+};
+
+struct st_fdma_chan {
+	struct st_fdma_dev *fdev;
+	struct dma_pool *node_pool;
+	struct dma_slave_config scfg;
+	struct st_fdma_cfg cfg;
+
+	int dreq_line;
+
+	struct virt_dma_chan vchan;
+	struct st_fdma_desc *fdesc;
+	enum dma_status	status;
+};
+
+struct st_fdma_dev {
+	struct device *dev;
+	const struct st_fdma_driverdata *drvdata;
+	const struct st_fdma_platform_data *pdata;
+	struct dma_device dma_device;
+
+	void __iomem *io_base;
+	struct resource *io_res;
+	struct clk *clks[CLK_MAX_NUM];
+
+	struct st_fdma_chan *chans;
+
+	spinlock_t dreq_lock;
+	unsigned long dreq_mask;
+
+	struct completion fw_ack;
+	atomic_t fw_loaded;
+};
+
+/* Registers*/
+/* FDMA interface */
+#define FDMA_ID_OFST		0x00000
+#define FDMA_VER_OFST		0x00004
+
+#define FDMA_EN_OFST		0x00008
+#define FDMA_EN_RUN			BIT(0)
+
+#define FDMA_CLK_GATE_OFST	0x0000C
+#define FDMA_CLK_GATE_DIS		BIT(0)
+#define FDMA_CLK_GATE_RESET		BIT(2)
+
+#define FDMA_SLIM_PC_OFST	0x00020
+
+#define FDMA_REV_ID_OFST	0x10000
+#define FDMA_REV_ID_MIN_MASK		GENMASK(15, 8)
+#define FDMA_REV_ID_MIN(id)		((id & FDMA_REV_ID_MIN_MASK) >> 8)
+#define FDMA_REV_ID_MAJ_MASK		GENMASK(23, 16)
+#define FDMA_REV_ID_MAJ(id)		((id & FDMA_REV_ID_MAJ_MASK) >> 16)
+
+#define FDMA_STBUS_SYNC_OFST	0x17F88
+#define FDMA_STBUS_SYNC_DIS		BIT(0)
+
+#define FDMA_CMD_STA_OFST	0x17FC0
+#define FDMA_CMD_SET_OFST	0x17FC4
+#define FDMA_CMD_CLR_OFST	0x17FC8
+#define FDMA_CMD_MASK_OFST	0x17FCC
+#define FDMA_CMD_START(ch)		(0x1 << (ch << 1))
+#define FDMA_CMD_PAUSE(ch)		(0x2 << (ch << 1))
+#define FDMA_CMD_FLUSH(ch)		(0x3 << (ch << 1))
+
+#define FDMA_INT_STA_OFST	0x17FD0
+#define FDMA_INT_STA_CH			0x1
+#define FDMA_INT_STA_ERR		0x2
+
+#define FDMA_INT_SET_OFST	0x17FD4
+#define FDMA_INT_CLR_OFST	0x17FD8
+#define FDMA_INT_MASK_OFST	0x17FDC
+
+#define fdma_read(fdev, name) \
+	readl_relaxed((fdev)->io_base + FDMA_##name##_OFST)
+
+#define fdma_write(fdev, val, name) \
+	writel_relaxed((val), (fdev)->io_base + FDMA_##name##_OFST)
+
+/* fchan interface */
+#define FDMA_CH_CMD_OFST	0x10200
+#define FDMA_CH_CMD_STA_MASK		GENMASK(1, 0)
+#define FDMA_CH_CMD_STA_IDLE		(0x0)
+#define FDMA_CH_CMD_STA_START		(0x1)
+#define FDMA_CH_CMD_STA_RUNNING		(0x2)
+#define FDMA_CH_CMD_STA_PAUSED		(0x3)
+#define FDMA_CH_CMD_ERR_MASK		GENMASK(4, 2)
+#define FDMA_CH_CMD_ERR_INT		(0x0 << 2)
+#define FDMA_CH_CMD_ERR_NAND		(0x1 << 2)
+#define FDMA_CH_CMD_ERR_MCHI		(0x2 << 2)
+#define FDMA_CH_CMD_DATA_MASK		GENMASK(31, 5)
+#define fchan_read(fchan, name) \
+	readl_relaxed((fchan)->fdev->io_base \
+			+ (fchan)->vchan.chan.chan_id * 0x4 \
+			+ FDMA_##name##_OFST)
+
+#define fchan_write(fchan, val, name) \
+	writel_relaxed((val), (fchan)->fdev->io_base \
+			+ (fchan)->vchan.chan.chan_id * 0x4 \
+			+ FDMA_##name##_OFST)
+
+/* req interface */
+#define FDMA_REQ_CTRL_OFST	0x10240
+#define dreq_write(fchan, val, name) \
+	writel_relaxed((val), (fchan)->fdev->io_base \
+			+ fchan->dreq_line * 0x04 \
+			+ FDMA_##name##_OFST)
+/* node interface */
+#define FDMA_NODE_SZ 128
+#define FDMA_PTRN_OFST		0x10800
+#define FDMA_CNTN_OFST		0x10808
+#define FDMA_SADDRN_OFST	0x1080c
+#define FDMA_DADDRN_OFST	0x10810
+#define fnode_read(fchan, name) \
+	readl_relaxed((fchan)->fdev->io_base \
+			+ (fchan)->vchan.chan.chan_id * FDMA_NODE_SZ \
+			+ FDMA_##name##_OFST)
+
+#define fnode_write(fchan, val, name) \
+	writel_relaxed((val), (fchan)->fdev->io_base \
+			+ (fchan)->vchan.chan.chan_id * FDMA_NODE_SZ \
+			+ FDMA_##name##_OFST)
+
+#endif	/* __DMA_ST_FDMA_H */
-- 
1.9.1
