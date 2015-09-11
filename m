From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 11 Sep 2015 15:14:24 +0100
Subject: [PATCH v2 2/9] dmaengine: st_fdma: Add st fdma platform specific
 header
In-Reply-To: <1441980871-24475-1-git-send-email-peter.griffin@linaro.org>
References: <1441980871-24475-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1441980871-24475-3-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 include/linux/platform_data/dma-st_fdma.h | 72 +++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 include/linux/platform_data/dma-st_fdma.h

diff --git a/include/linux/platform_data/dma-st_fdma.h b/include/linux/platform_data/dma-st_fdma.h
new file mode 100644
index 0000000..ea2523b
--- /dev/null
+++ b/include/linux/platform_data/dma-st_fdma.h
@@ -0,0 +1,72 @@
+/*
+ * dma-st-fdma.h
+ *
+ * Copyright (C) 2014 STMicroelectronics
+ * Author: Ludovic Barre <Ludovic.barre@st.com>
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+#ifndef __PLAT_ST_FDMA_H
+#define __PLAT_ST_FDMA_H
+
+#include <linux/dmaengine.h>
+
+/*
+ * Channel type
+ */
+enum st_fdma_type {
+	ST_FDMA_TYPE_FREE_RUN,
+	ST_FDMA_TYPE_PACED,
+};
+
+struct st_fdma_cfg {
+	struct device_node *of_node;
+	enum st_fdma_type type;
+	dma_addr_t dev_addr;
+	enum dma_transfer_direction dir;
+	int req_line; /* request line */
+	u32 req_ctrl; /* Request control */
+};
+
+#define FW_NAME_SIZE 30
+
+/**
+ * struct st_fdma_platform_data - platform specific data for FDMA engine
+ *
+ * @nr_channels:	Number of channels supported by hardware
+ * @fw_name:		The firmware name
+ */
+struct st_fdma_platform_data {
+	u32 nr_channels;
+	u32 id;
+	char fw_name[FW_NAME_SIZE];
+};
+
+/*
+ * request control bits
+ */
+#define REQ_CTRL_NUM_OPS_MASK		GENMASK(31, 24)
+#define REQ_CTRL_NUM_OPS(n)		(REQ_CTRL_NUM_OPS_MASK & ((n) << 24))
+#define REQ_CTRL_INITIATOR_MASK		BIT(22)
+#define	REQ_CTRL_INIT0			(0x0 << 22)
+#define	REQ_CTRL_INIT1			(0x1 << 22)
+#define REQ_CTRL_INC_ADDR_ON		BIT(21)
+#define REQ_CTRL_DATA_SWAP_ON		BIT(17)
+#define REQ_CTRL_WNR			BIT(14)
+#define REQ_CTRL_OPCODE_MASK		GENMASK(7, 4)
+#define REQ_CTRL_OPCODE_LD_ST1		(0x0 << 4)
+#define REQ_CTRL_OPCODE_LD_ST2		(0x1 << 4)
+#define REQ_CTRL_OPCODE_LD_ST4		(0x2 << 4)
+#define REQ_CTRL_OPCODE_LD_ST8		(0x3 << 4)
+#define REQ_CTRL_OPCODE_LD_ST16		(0x4 << 4)
+#define REQ_CTRL_OPCODE_LD_ST32		(0x5 << 4)
+#define REQ_CTRL_OPCODE_LD_ST64		(0x6 << 4)
+#define REQ_CTRL_HOLDOFF_MASK		GENMASK(2, 0)
+#define REQ_CTRL_HOLDOFF(n)		((n) & REQ_CTRL_HOLDOFF_MASK)
+
+/* bits used by client to configure request control */
+#define REQ_CTRL_CFG_MASK (REQ_CTRL_HOLDOFF_MASK | REQ_CTRL_DATA_SWAP_ON \
+			| REQ_CTRL_INC_ADDR_ON | REQ_CTRL_INITIATOR_MASK)
+
+bool st_fdma_filter_fn(struct dma_chan *chan, void *param);
+
+#endif	/* __PLAT_ST_FDMA_H */
-- 
1.9.1
