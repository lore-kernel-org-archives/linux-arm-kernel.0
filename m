From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 29 Jul 2013 17:05:09 +0200
Subject: [PATCH 1/2] dma: mv_xor: use readl/writel instead of __raw_{readl,
 writel}
In-Reply-To: <1375110310-26276-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375110310-26276-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1375110310-26276-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support big-endian execution, the mv_xor driver is changed
to use thhe readl() and writel() accessors that properly convert from
the CPU endianess to the device endianess (which in the case of
Marvell XOR hardware is always little-endian).

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 200f1a3..e98966a 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -114,25 +114,25 @@ static void mv_desc_set_src_addr(struct mv_xor_desc_slot *desc,
 
 static u32 mv_chan_get_current_desc(struct mv_xor_chan *chan)
 {
-	return __raw_readl(XOR_CURR_DESC(chan));
+	return readl(XOR_CURR_DESC(chan));
 }
 
 static void mv_chan_set_next_descriptor(struct mv_xor_chan *chan,
 					u32 next_desc_addr)
 {
-	__raw_writel(next_desc_addr, XOR_NEXT_DESC(chan));
+	writel(next_desc_addr, XOR_NEXT_DESC(chan));
 }
 
 static void mv_chan_unmask_interrupts(struct mv_xor_chan *chan)
 {
-	u32 val = __raw_readl(XOR_INTR_MASK(chan));
+	u32 val = readl(XOR_INTR_MASK(chan));
 	val |= XOR_INTR_MASK_VALUE << (chan->idx * 16);
-	__raw_writel(val, XOR_INTR_MASK(chan));
+	writel(val, XOR_INTR_MASK(chan));
 }
 
 static u32 mv_chan_get_intr_cause(struct mv_xor_chan *chan)
 {
-	u32 intr_cause = __raw_readl(XOR_INTR_CAUSE(chan));
+	u32 intr_cause = readl(XOR_INTR_CAUSE(chan));
 	intr_cause = (intr_cause >> (chan->idx * 16)) & 0xFFFF;
 	return intr_cause;
 }
@@ -149,13 +149,13 @@ static void mv_xor_device_clear_eoc_cause(struct mv_xor_chan *chan)
 {
 	u32 val = ~(1 << (chan->idx * 16));
 	dev_dbg(mv_chan_to_devp(chan), "%s, val 0x%08x\n", __func__, val);
-	__raw_writel(val, XOR_INTR_CAUSE(chan));
+	writel(val, XOR_INTR_CAUSE(chan));
 }
 
 static void mv_xor_device_clear_err_status(struct mv_xor_chan *chan)
 {
 	u32 val = 0xFFFF0000 >> (chan->idx * 16);
-	__raw_writel(val, XOR_INTR_CAUSE(chan));
+	writel(val, XOR_INTR_CAUSE(chan));
 }
 
 static int mv_can_chain(struct mv_xor_desc_slot *desc)
@@ -173,7 +173,7 @@ static void mv_set_mode(struct mv_xor_chan *chan,
 			       enum dma_transaction_type type)
 {
 	u32 op_mode;
-	u32 config = __raw_readl(XOR_CONFIG(chan));
+	u32 config = readl(XOR_CONFIG(chan));
 
 	switch (type) {
 	case DMA_XOR:
@@ -192,7 +192,7 @@ static void mv_set_mode(struct mv_xor_chan *chan,
 
 	config &= ~0x7;
 	config |= op_mode;
-	__raw_writel(config, XOR_CONFIG(chan));
+	writel(config, XOR_CONFIG(chan));
 	chan->current_type = type;
 }
 
@@ -201,14 +201,14 @@ static void mv_chan_activate(struct mv_xor_chan *chan)
 	u32 activation;
 
 	dev_dbg(mv_chan_to_devp(chan), " activate chan.\n");
-	activation = __raw_readl(XOR_ACTIVATION(chan));
+	activation = readl(XOR_ACTIVATION(chan));
 	activation |= 0x1;
-	__raw_writel(activation, XOR_ACTIVATION(chan));
+	writel(activation, XOR_ACTIVATION(chan));
 }
 
 static char mv_chan_is_busy(struct mv_xor_chan *chan)
 {
-	u32 state = __raw_readl(XOR_ACTIVATION(chan));
+	u32 state = readl(XOR_ACTIVATION(chan));
 
 	state = (state >> 4) & 0x3;
 
@@ -755,22 +755,22 @@ static void mv_dump_xor_regs(struct mv_xor_chan *chan)
 {
 	u32 val;
 
-	val = __raw_readl(XOR_CONFIG(chan));
+	val = readl(XOR_CONFIG(chan));
 	dev_err(mv_chan_to_devp(chan), "config       0x%08x\n", val);
 
-	val = __raw_readl(XOR_ACTIVATION(chan));
+	val = readl(XOR_ACTIVATION(chan));
 	dev_err(mv_chan_to_devp(chan), "activation   0x%08x\n", val);
 
-	val = __raw_readl(XOR_INTR_CAUSE(chan));
+	val = readl(XOR_INTR_CAUSE(chan));
 	dev_err(mv_chan_to_devp(chan), "intr cause   0x%08x\n", val);
 
-	val = __raw_readl(XOR_INTR_MASK(chan));
+	val = readl(XOR_INTR_MASK(chan));
 	dev_err(mv_chan_to_devp(chan), "intr mask    0x%08x\n", val);
 
-	val = __raw_readl(XOR_ERROR_CAUSE(chan));
+	val = readl(XOR_ERROR_CAUSE(chan));
 	dev_err(mv_chan_to_devp(chan), "error cause  0x%08x\n", val);
 
-	val = __raw_readl(XOR_ERROR_ADDR(chan));
+	val = readl(XOR_ERROR_ADDR(chan));
 	dev_err(mv_chan_to_devp(chan), "error addr   0x%08x\n", val);
 }
 
-- 
1.8.1.2
