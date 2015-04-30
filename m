From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 30 Apr 2015 09:35:42 +0000
Subject: [PATCH] dmaengine: sirf: add CSRatlas7 SoC support
Message-ID: <1430386542-31080-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hao Liu <Hao.Liu@csr.com>

add support for new CSR atlas7 SoC. atlas7 exists V1 and V2 IP.
V1 and V2 co-exist in the same chip. there are some HW configuration
differences(register offset etc.) with old prima2 chips, so we use
compatible string to differentiate old prima2 and new atlas7, then
results in different set in HW for them.
except that, atlas7 DMAv2 supports chain DMA by a chain table, this
patch also adds chain DMA support for atlas7.

Signed-off-by: Hao Liu <Hao.Liu@csr.com>
Signed-off-by: Yanchang Li <Yanchang.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/dma/sirf-dma.c | 350 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 276 insertions(+), 74 deletions(-)

diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index a1afda4..af0d65f 100644
--- a/drivers/dma/sirf-dma.c
+++ b/drivers/dma/sirf-dma.c
@@ -25,6 +25,7 @@
 
 #define SIRFSOC_DMA_DESCRIPTORS                 16
 #define SIRFSOC_DMA_CHANNELS                    16
+#define SIRFSOC_DMA_TABLE_NUM                   256
 
 #define SIRFSOC_DMA_CH_ADDR                     0x00
 #define SIRFSOC_DMA_CH_XLEN                     0x04
@@ -35,15 +36,41 @@
 #define SIRFSOC_DMA_CH_VALID                    0x140
 #define SIRFSOC_DMA_CH_INT                      0x144
 #define SIRFSOC_DMA_INT_EN                      0x148
-#define SIRFSOC_DMA_INT_EN_CLR			0x14C
+#define SIRFSOC_DMA_INT_EN_CLR                  0x14C
 #define SIRFSOC_DMA_CH_LOOP_CTRL                0x150
-#define SIRFSOC_DMA_CH_LOOP_CTRL_CLR            0x15C
+#define SIRFSOC_DMA_CH_LOOP_CTRL_CLR            0x154
+#define SIRFSOC_DMA_WIDTH_ATLAS7                0x10
+#define SIRFSOC_DMA_VALID_ATLAS7                0x14
+#define SIRFSOC_DMA_INT_ATLAS7                  0x18
+#define SIRFSOC_DMA_INT_EN_ATLAS7               0x1c
+#define SIRFSOC_DMA_LOOP_CTRL_ATLAS7            0x20
+#define SIRFSOC_DMA_CUR_DATA_ADDR               0x34
+#define SIRFSOC_DMA_MUL_ATLAS7                  0x38
+#define SIRFSOC_DMA_CH_LOOP_CTRL_ATLAS7         0x158
+#define SIRFSOC_DMA_CH_LOOP_CTRL_CLR_ATLAS7     0x15C
 
 #define SIRFSOC_DMA_MODE_CTRL_BIT               4
 #define SIRFSOC_DMA_DIR_CTRL_BIT                5
+#define SIRFSOC_DMA_MODE_CTRL_BIT_ATLAS7        2
+#define SIRFSOC_DMA_CHAIN_CTRL_BIT_ATLAS7       3
+#define SIRFSOC_DMA_DIR_CTRL_BIT_ATLAS7         4
+#define SIRFSOC_DMA_TAB_NUM_ATLAS7              7
+#define SIRFSOC_DMA_CHAIN_INT_BIT_ATLAS7        5
+#define SIRFSOC_DMA_CHAIN_FLAG_SHIFT_ATLAS7     25
+#define SIRFSOC_DMA_CHAIN_ADDR_SHIFT            32
+
+#define SIRFSOC_DMA_INT_FINI_INT_ATLAS7         BIT(0)
+#define SIRFSOC_DMA_INT_CNT_INT_ATLAS7          BIT(1)
+#define SIRFSOC_DMA_INT_PAU_INT_ATLAS7          BIT(2)
+#define SIRFSOC_DMA_INT_LOOP_INT_ATLAS7         BIT(3)
+#define SIRFSOC_DMA_INT_INV_INT_ATLAS7          BIT(4)
+#define SIRFSOC_DMA_INT_END_INT_ATLAS7          BIT(5)
+#define SIRFSOC_DMA_INT_ALL_ATLAS7              0x3F
 
 /* xlen and dma_width register is in 4 bytes boundary */
 #define SIRFSOC_DMA_WORD_LEN			4
+#define SIRFSOC_DMA_XLEN_MAX_V1         0x800
+#define SIRFSOC_DMA_XLEN_MAX_V2         0x1000
 
 struct sirfsoc_dma_desc {
 	struct dma_async_tx_descriptor	desc;
@@ -56,7 +83,9 @@ struct sirfsoc_dma_desc {
 	int             width;          /* DMA width */
 	int             dir;
 	bool            cyclic;         /* is loop DMA? */
+	bool            chain;          /* is chain DMA? */
 	u32             addr;		/* DMA buffer address */
+	u64 chain_table[SIRFSOC_DMA_TABLE_NUM]; /* chain tbl */
 };
 
 struct sirfsoc_dma_chan {
@@ -87,10 +116,18 @@ struct sirfsoc_dma {
 	void __iomem			*base;
 	int				irq;
 	struct clk			*clk;
-	bool				is_marco;
+	bool				is_atlas7_dma_v1;
+	bool				is_atlas7_dma_v2;
 	struct sirfsoc_dma_regs		regs_save;
 };
 
+enum sirfsoc_dma_chain_flag {
+	SIRFSOC_DMA_CHAIN_NORMAL = 0x01,
+	SIRFSOC_DMA_CHAIN_PAUSE = 0x02,
+	SIRFSOC_DMA_CHAIN_LOOP = 0x03,
+	SIRFSOC_DMA_CHAIN_END = 0x04
+};
+
 #define DRV_NAME	"sirfsoc_dma"
 
 static int sirfsoc_dma_runtime_suspend(struct device *dev);
@@ -126,29 +163,91 @@ static void sirfsoc_dma_execute(struct sirfsoc_dma_chan *schan)
 	/* Move the first queued descriptor to active list */
 	list_move_tail(&sdesc->node, &schan->active);
 
+	if (sdma->is_atlas7_dma_v2)
+		cid = 0;
+
 	/* Start the DMA transfer */
-	writel_relaxed(sdesc->width, sdma->base + SIRFSOC_DMA_WIDTH_0 +
-		cid * 4);
-	writel_relaxed(cid | (schan->mode << SIRFSOC_DMA_MODE_CTRL_BIT) |
-		(sdesc->dir << SIRFSOC_DMA_DIR_CTRL_BIT),
-		sdma->base + cid * 0x10 + SIRFSOC_DMA_CH_CTRL);
-	writel_relaxed(sdesc->xlen, sdma->base + cid * 0x10 +
-		SIRFSOC_DMA_CH_XLEN);
-	writel_relaxed(sdesc->ylen, sdma->base + cid * 0x10 +
-		SIRFSOC_DMA_CH_YLEN);
-	writel_relaxed(readl_relaxed(sdma->base + SIRFSOC_DMA_INT_EN) |
-		(1 << cid), sdma->base + SIRFSOC_DMA_INT_EN);
 
+	if (sdma->is_atlas7_dma_v2) {
+		if (sdesc->chain) {
+			/* DMA v2 HW chain mode */
+			writel_relaxed(
+				(sdesc->dir <<
+					SIRFSOC_DMA_DIR_CTRL_BIT_ATLAS7) |
+				(sdesc->chain <<
+					SIRFSOC_DMA_CHAIN_CTRL_BIT_ATLAS7) |
+				(0x8 << SIRFSOC_DMA_TAB_NUM_ATLAS7) | 0x3,
+				sdma->base + SIRFSOC_DMA_CH_CTRL);
+		} else {
+			/* DMA v2 legacy mode */
+			writel_relaxed(sdesc->xlen, sdma->base +
+				SIRFSOC_DMA_CH_XLEN);
+			writel_relaxed(sdesc->ylen, sdma->base +
+				SIRFSOC_DMA_CH_YLEN);
+			writel_relaxed(sdesc->width,
+				sdma->base + SIRFSOC_DMA_WIDTH_ATLAS7);
+			writel_relaxed((sdesc->width*((sdesc->ylen+1)>>1)),
+				sdma->base + SIRFSOC_DMA_MUL_ATLAS7);
+			writel_relaxed((
+				sdesc->dir << SIRFSOC_DMA_DIR_CTRL_BIT_ATLAS7) |
+				(sdesc->chain <<
+				SIRFSOC_DMA_CHAIN_CTRL_BIT_ATLAS7) |
+				0x3, sdma->base + SIRFSOC_DMA_CH_CTRL);
+		}
+	} else {
+		writel_relaxed(sdesc->width,
+			sdma->base + SIRFSOC_DMA_WIDTH_0 +
+			cid * 4);
+		writel_relaxed(cid |
+			(schan->mode << SIRFSOC_DMA_MODE_CTRL_BIT) |
+			(sdesc->dir << SIRFSOC_DMA_DIR_CTRL_BIT),
+			sdma->base + cid * 0x10 +
+			SIRFSOC_DMA_CH_CTRL);
+		writel_relaxed(sdesc->xlen,
+			sdma->base + cid * 0x10 +
+			SIRFSOC_DMA_CH_XLEN);
+		writel_relaxed(sdesc->ylen,
+			sdma->base + cid * 0x10 +
+			SIRFSOC_DMA_CH_YLEN);
+	}
+
+	if (sdma->is_atlas7_dma_v2) {
+		writel_relaxed(sdesc->chain ? SIRFSOC_DMA_INT_END_INT_ATLAS7 :
+				(SIRFSOC_DMA_INT_FINI_INT_ATLAS7 |
+				 SIRFSOC_DMA_INT_LOOP_INT_ATLAS7),
+					sdma->base + SIRFSOC_DMA_INT_EN_ATLAS7);
+	} else {
+		writel_relaxed(readl_relaxed(sdma->base + SIRFSOC_DMA_INT_EN) |
+				(1 << cid), sdma->base + SIRFSOC_DMA_INT_EN);
+	}
 	/*
 	 * writel has an implict memory write barrier to make sure data is
 	 * flushed into memory before starting DMA
 	 */
-	writel(sdesc->addr >> 2, sdma->base + cid * 0x10 + SIRFSOC_DMA_CH_ADDR);
+	if (sdma->is_atlas7_dma_v2)
+		writel(sdesc->addr,
+			sdma->base + SIRFSOC_DMA_CH_ADDR);
+	else
+		writel(sdesc->addr >> 2,
+			sdma->base + cid * 0x10 + SIRFSOC_DMA_CH_ADDR);
 
 	if (sdesc->cyclic) {
-		writel((1 << cid) | 1 << (cid + 16) |
-			readl_relaxed(sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL),
-			sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL);
+		if (sdma->is_atlas7_dma_v2) {
+			writel(0x10001,
+			sdma->base + SIRFSOC_DMA_LOOP_CTRL_ATLAS7);
+		} else if (sdma->is_atlas7_dma_v1) {
+			writel(
+				(1 << cid) | 1 << (cid + 16) |
+				readl_relaxed(sdma->base
+				+ SIRFSOC_DMA_CH_LOOP_CTRL_ATLAS7),
+				sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL_ATLAS7);
+		} else {
+			writel(
+				(1 << cid) | 1 << (cid + 16) |
+				readl_relaxed(sdma->base
+					+ SIRFSOC_DMA_CH_LOOP_CTRL),
+					sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL);
+		}
 		schan->happened_cyclic = schan->completed_cyclic = 0;
 	}
 }
@@ -160,27 +259,64 @@ static irqreturn_t sirfsoc_dma_irq(int irq, void *data)
 	struct sirfsoc_dma_chan *schan;
 	struct sirfsoc_dma_desc *sdesc = NULL;
 	u32 is;
+	bool chain;
 	int ch;
+	u32 reg;
 
-	is = readl(sdma->base + SIRFSOC_DMA_CH_INT);
-	while ((ch = fls(is) - 1) >= 0) {
-		is &= ~(1 << ch);
-		writel_relaxed(1 << ch, sdma->base + SIRFSOC_DMA_CH_INT);
-		schan = &sdma->channels[ch];
+	if (sdma->is_atlas7_dma_v2) {
+		is = readl(sdma->base + SIRFSOC_DMA_INT_ATLAS7);
 
+		reg = sdma->base + SIRFSOC_DMA_INT_ATLAS7;
+		writel_relaxed(SIRFSOC_DMA_INT_ALL_ATLAS7, reg);
+		schan = &sdma->channels[0];
 		spin_lock(&schan->lock);
-
-		sdesc = list_first_entry(&schan->active, struct sirfsoc_dma_desc,
-			node);
+		sdesc = list_first_entry(&schan->active,
+					 struct sirfsoc_dma_desc, node);
 		if (!sdesc->cyclic) {
-			/* Execute queued descriptors */
-			list_splice_tail_init(&schan->active, &schan->completed);
-			if (!list_empty(&schan->queued))
-				sirfsoc_dma_execute(schan);
-		} else
+			chain = sdesc->chain;
+			if (chain && (is & SIRFSOC_DMA_INT_END_INT_ATLAS7) ||
+				!(chain) &&
+				(is & SIRFSOC_DMA_INT_FINI_INT_ATLAS7)) {
+				/* Execute queued descriptors */
+				list_splice_tail_init(&schan->active,
+						      &schan->completed);
+				dma_cookie_complete(&sdesc->desc);
+				if (!list_empty(&schan->queued))
+					sirfsoc_dma_execute(schan);
+			}
+		} else if (sdesc->cyclic && (is &
+					SIRFSOC_DMA_INT_LOOP_INT_ATLAS7))
 			schan->happened_cyclic++;
 
 		spin_unlock(&schan->lock);
+
+	} else {
+		is = readl(sdma->base + SIRFSOC_DMA_CH_INT);
+		reg = sdma->base + SIRFSOC_DMA_CH_INT;
+
+		while ((ch = fls(is) - 1) >= 0) {
+			is &= ~(1 << ch);
+
+			writel_relaxed(1 << ch, reg);
+
+			schan = &sdma->channels[ch];
+
+			spin_lock(&schan->lock);
+
+			sdesc = list_first_entry(&schan->active,
+						 struct sirfsoc_dma_desc, node);
+			if (!sdesc->cyclic) {
+				/* Execute queued descriptors */
+				list_splice_tail_init(&schan->active,
+						      &schan->completed);
+				dma_cookie_complete(&sdesc->desc);
+				if (!list_empty(&schan->queued))
+					sirfsoc_dma_execute(schan);
+			} else
+				schan->happened_cyclic++;
+
+			spin_unlock(&schan->lock);
+		}
 	}
 
 	/* Schedule tasklet */
@@ -227,16 +363,15 @@ static void sirfsoc_dma_process_completed(struct sirfsoc_dma *sdma)
 			schan->chan.completed_cookie = last_cookie;
 			spin_unlock_irqrestore(&schan->lock, flags);
 		} else {
-			/* for cyclic channel, desc is always in active list */
-			sdesc = list_first_entry(&schan->active, struct sirfsoc_dma_desc,
-				node);
-
-			if (!sdesc || (sdesc && !sdesc->cyclic)) {
-				/* without active cyclic DMA */
+			if (list_empty(&schan->active)) {
 				spin_unlock_irqrestore(&schan->lock, flags);
 				continue;
 			}
 
+			/* for cyclic channel, desc is always in active list */
+			sdesc = list_first_entry(&schan->active,
+				struct sirfsoc_dma_desc, node);
+
 			/* cyclic DMA */
 			happened_cyclic = schan->happened_cyclic;
 			spin_unlock_irqrestore(&schan->lock, flags);
@@ -307,20 +442,28 @@ static int sirfsoc_dma_terminate_all(struct dma_chan *chan)
 
 	spin_lock_irqsave(&schan->lock, flags);
 
-	if (!sdma->is_marco) {
+	if (sdma->is_atlas7_dma_v1) {
+		writel_relaxed(1 << cid, sdma->base + SIRFSOC_DMA_INT_EN_CLR);
+		writel_relaxed(1 << cid, sdma->base + SIRFSOC_DMA_CH_INT);
+		writel_relaxed((1 << cid) | 1 << (cid + 16),
+			sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL_CLR_ATLAS7);
+		writel_relaxed(1 << cid, sdma->base + SIRFSOC_DMA_CH_VALID);
+	} else if (sdma->is_atlas7_dma_v2) {
+		writel_relaxed(0, sdma->base + SIRFSOC_DMA_INT_EN_ATLAS7);
+		writel_relaxed(SIRFSOC_DMA_INT_ALL_ATLAS7,
+				sdma->base + SIRFSOC_DMA_INT_ATLAS7);
+		writel_relaxed(0, sdma->base + SIRFSOC_DMA_LOOP_CTRL_ATLAS7);
+		writel_relaxed(0, sdma->base + SIRFSOC_DMA_VALID_ATLAS7);
+	} else {
 		writel_relaxed(readl_relaxed(sdma->base + SIRFSOC_DMA_INT_EN) &
 			~(1 << cid), sdma->base + SIRFSOC_DMA_INT_EN);
-		writel_relaxed(readl_relaxed(sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL)
-			& ~((1 << cid) | 1 << (cid + 16)),
+		writel_relaxed(readl_relaxed(sdma->base +
+			SIRFSOC_DMA_CH_LOOP_CTRL) &
+			~((1 << cid) | 1 << (cid + 16)),
 			sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL);
-	} else {
-		writel_relaxed(1 << cid, sdma->base + SIRFSOC_DMA_INT_EN_CLR);
-		writel_relaxed((1 << cid) | 1 << (cid + 16),
-			sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL_CLR);
+		writel_relaxed(1 << cid, sdma->base + SIRFSOC_DMA_CH_VALID);
 	}
 
-	writel_relaxed(1 << cid, sdma->base + SIRFSOC_DMA_CH_VALID);
-
 	list_splice_tail_init(&schan->active, &schan->free);
 	list_splice_tail_init(&schan->queued, &schan->free);
 
@@ -338,13 +481,17 @@ static int sirfsoc_dma_pause_chan(struct dma_chan *chan)
 
 	spin_lock_irqsave(&schan->lock, flags);
 
-	if (!sdma->is_marco)
-		writel_relaxed(readl_relaxed(sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL)
+	if (sdma->is_atlas7_dma_v1) {
+		writel_relaxed((1 << cid) | 1 << (cid + 16),
+			sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL_CLR_ATLAS7);
+	} else if (sdma->is_atlas7_dma_v2) {
+		writel_relaxed(0, sdma->base + SIRFSOC_DMA_LOOP_CTRL_ATLAS7);
+	} else {
+		writel_relaxed(
+			readl_relaxed(sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL)
 			& ~((1 << cid) | 1 << (cid + 16)),
 			sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL);
-	else
-		writel_relaxed((1 << cid) | 1 << (cid + 16),
-			sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL_CLR);
+	}
 
 	spin_unlock_irqrestore(&schan->lock, flags);
 
@@ -360,13 +507,18 @@ static int sirfsoc_dma_resume_chan(struct dma_chan *chan)
 
 	spin_lock_irqsave(&schan->lock, flags);
 
-	if (!sdma->is_marco)
-		writel_relaxed(readl_relaxed(sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL)
-			| ((1 << cid) | 1 << (cid + 16)),
-			sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL);
-	else
+	if (sdma->is_atlas7_dma_v1) {
 		writel_relaxed((1 << cid) | 1 << (cid + 16),
+			sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL_ATLAS7);
+	} else if (sdma->is_atlas7_dma_v2) {
+		writel_relaxed(0x10001,
+			sdma->base + SIRFSOC_DMA_LOOP_CTRL_ATLAS7);
+	} else {
+		writel_relaxed(
+			readl_relaxed(sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL)
+			| ((1 << cid) | 1 << (cid + 16)),
 			sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL);
+	}
 
 	spin_unlock_irqrestore(&schan->lock, flags);
 
@@ -473,14 +625,31 @@ sirfsoc_dma_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 
 	spin_lock_irqsave(&schan->lock, flags);
 
-	sdesc = list_first_entry(&schan->active, struct sirfsoc_dma_desc,
-			node);
-	dma_request_bytes = (sdesc->xlen + 1) * (sdesc->ylen + 1) *
-		(sdesc->width * SIRFSOC_DMA_WORD_LEN);
+	if (list_empty(&schan->active)) {
+		ret = dma_cookie_status(chan, cookie, txstate);
+		dma_set_residue(txstate, 0);
+		spin_unlock_irqrestore(&schan->lock, flags);
+		return ret;
+	}
+	sdesc = list_first_entry(&schan->active, struct sirfsoc_dma_desc, node);
+	if (sdesc->cyclic)
+		dma_request_bytes = (sdesc->xlen + 1) * (sdesc->ylen + 1) *
+			(sdesc->width * SIRFSOC_DMA_WORD_LEN);
+	else
+		dma_request_bytes = sdesc->xlen * SIRFSOC_DMA_WORD_LEN;
 
 	ret = dma_cookie_status(chan, cookie, txstate);
-	dma_pos = readl_relaxed(sdma->base + cid * 0x10 + SIRFSOC_DMA_CH_ADDR)
-		<< 2;
+
+	if (sdma->is_atlas7_dma_v2)
+		cid = 0;
+
+	if (sdma->is_atlas7_dma_v2) {
+		dma_pos = readl_relaxed(sdma->base + SIRFSOC_DMA_CUR_DATA_ADDR);
+	} else {
+		dma_pos = readl_relaxed(
+			sdma->base + cid * 0x10 + SIRFSOC_DMA_CH_ADDR) << 2;
+	}
+
 	residue = dma_request_bytes - (dma_pos - sdesc->addr);
 	dma_set_residue(txstate, residue);
 
@@ -658,8 +827,11 @@ static int sirfsoc_dma_probe(struct platform_device *op)
 		return -ENOMEM;
 	}
 
-	if (of_device_is_compatible(dn, "sirf,marco-dmac"))
-		sdma->is_marco = true;
+	if (of_device_is_compatible(dn, "sirf,atlas7-dmac"))
+		sdma->is_atlas7_dma_v1 = true;
+
+	if (of_device_is_compatible(dn, "sirf,atlas7-dmac-v2"))
+		sdma->is_atlas7_dma_v2 = true;
 
 	if (of_property_read_u32(dn, "cell-index", &id)) {
 		dev_err(dev, "Fail to get DMAC index\n");
@@ -816,6 +988,8 @@ static int sirfsoc_dma_pm_suspend(struct device *dev)
 	struct sirfsoc_dma_chan *schan;
 	int ch;
 	int ret;
+	int count;
+	u32 int_offset;
 
 	/*
 	 * if we were runtime-suspended before, resume to enable clock
@@ -827,11 +1001,19 @@ static int sirfsoc_dma_pm_suspend(struct device *dev)
 			return ret;
 	}
 
+	if (sdma->is_atlas7_dma_v2) {
+		count = 1;
+		int_offset = SIRFSOC_DMA_INT_EN_ATLAS7;
+	} else {
+		count = SIRFSOC_DMA_CHANNELS;
+		int_offset = SIRFSOC_DMA_INT_EN;
+	}
+
 	/*
 	 * DMA controller will lose all registers while suspending
 	 * so we need to save registers for active channels
 	 */
-	for (ch = 0; ch < SIRFSOC_DMA_CHANNELS; ch++) {
+	for (ch = 0; ch < count; ch++) {
 		schan = &sdma->channels[ch];
 		if (list_empty(&schan->active))
 			continue;
@@ -841,7 +1023,7 @@ static int sirfsoc_dma_pm_suspend(struct device *dev)
 		save->ctrl[ch] = readl_relaxed(sdma->base +
 			ch * 0x10 + SIRFSOC_DMA_CH_CTRL);
 	}
-	save->interrupt_en = readl_relaxed(sdma->base + SIRFSOC_DMA_INT_EN);
+	save->interrupt_en = readl_relaxed(sdma->base + int_offset);
 
 	/* Disable clock */
 	sirfsoc_dma_runtime_suspend(dev);
@@ -857,14 +1039,27 @@ static int sirfsoc_dma_pm_resume(struct device *dev)
 	struct sirfsoc_dma_chan *schan;
 	int ch;
 	int ret;
+	int count;
+	u32 int_offset;
+	u32 width_offset;
 
 	/* Enable clock before accessing register */
 	ret = sirfsoc_dma_runtime_resume(dev);
 	if (ret < 0)
 		return ret;
 
-	writel_relaxed(save->interrupt_en, sdma->base + SIRFSOC_DMA_INT_EN);
-	for (ch = 0; ch < SIRFSOC_DMA_CHANNELS; ch++) {
+	if (sdma->is_atlas7_dma_v2) {
+		count = 1;
+		int_offset = SIRFSOC_DMA_INT_EN_ATLAS7;
+		width_offset = SIRFSOC_DMA_WIDTH_ATLAS7;
+	} else {
+		count = SIRFSOC_DMA_CHANNELS;
+		int_offset = SIRFSOC_DMA_INT_EN;
+		width_offset = SIRFSOC_DMA_WIDTH_0;
+	}
+
+	writel_relaxed(save->interrupt_en, sdma->base + int_offset);
+	for (ch = 0; ch < count; ch++) {
 		schan = &sdma->channels[ch];
 		if (list_empty(&schan->active))
 			continue;
@@ -872,15 +1067,21 @@ static int sirfsoc_dma_pm_resume(struct device *dev)
 			struct sirfsoc_dma_desc,
 			node);
 		writel_relaxed(sdesc->width,
-			sdma->base + SIRFSOC_DMA_WIDTH_0 + ch * 4);
+			sdma->base + width_offset + ch * 4);
 		writel_relaxed(sdesc->xlen,
 			sdma->base + ch * 0x10 + SIRFSOC_DMA_CH_XLEN);
 		writel_relaxed(sdesc->ylen,
 			sdma->base + ch * 0x10 + SIRFSOC_DMA_CH_YLEN);
 		writel_relaxed(save->ctrl[ch],
 			sdma->base + ch * 0x10 + SIRFSOC_DMA_CH_CTRL);
-		writel_relaxed(sdesc->addr >> 2,
-			sdma->base + ch * 0x10 + SIRFSOC_DMA_CH_ADDR);
+		if (sdma->is_atlas7_dma_v2) {
+			writel_relaxed(sdesc->addr,
+				sdma->base + SIRFSOC_DMA_CH_ADDR);
+		} else {
+			writel_relaxed(sdesc->addr >> 2,
+				sdma->base + ch * 0x10 + SIRFSOC_DMA_CH_ADDR);
+
+		}
 	}
 
 	/* if we were runtime-suspended before, suspend again */
@@ -898,7 +1099,8 @@ static const struct dev_pm_ops sirfsoc_dma_pm_ops = {
 
 static const struct of_device_id sirfsoc_dma_match[] = {
 	{ .compatible = "sirf,prima2-dmac", },
-	{ .compatible = "sirf,marco-dmac", },
+	{ .compatible = "sirf,atlas7-dmac", },
+	{ .compatible = "sirf,atlas7-dmac-v2", },
 	{},
 };
 
@@ -925,7 +1127,7 @@ static void __exit sirfsoc_dma_exit(void)
 subsys_initcall(sirfsoc_dma_init);
 module_exit(sirfsoc_dma_exit);
 
-MODULE_AUTHOR("Rongjun Ying <rongjun.ying@csr.com>, "
-	"Barry Song <baohua.song@csr.com>");
+MODULE_AUTHOR("Rongjun Ying <rongjun.ying@csr.com>");
+MODULE_AUTHOR("Barry Song <baohua.song@csr.com>");
 MODULE_DESCRIPTION("SIRFSOC DMA control driver");
 MODULE_LICENSE("GPL v2");
-- 
2.3.5
