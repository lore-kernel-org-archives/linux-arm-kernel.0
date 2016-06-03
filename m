From: sr@denx.de (Stefan Roese)
Date: Fri,  3 Jun 2016 18:24:29 +0200
Subject: [RFC PATCH] dmaengine: mv_xor: Add support for IO (PCIe) src/dst areas
Message-ID: <20160603162429.8760-1-sr@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To enable the access to a specific area, the MVEBU XOR controllers needs
to have this area enabled / mapped via an address window. Right now,
only the DRAM memory area is enabled via such memory windows. So
using this driver to DMA to / from a e.g. PCIe memory region is
currently not supported.

This patch now adds support for such PCIe / IO regions by checking
if the src / dst address is located in an IO memory area in contrast
to being located in DRAM. This is done by using the newly introduced
MBus function mvebu_mbus_get_io_win_info(). If the src / dst address
is located in such an IO area, a new address window is created in
the XOR DMA controller. Enabling the controller to access this area.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Marcin Wojtas <mw@semihalf.com>
Cc: Vinod Koul <vinod.koul@intel.com>
---
 drivers/dma/mv_xor.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index f4c9f98..2671b11 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -470,12 +470,107 @@ static int mv_xor_alloc_chan_resources(struct dma_chan *chan)
 	return mv_chan->slots_allocated ? : -ENOMEM;
 }
 
+/*
+ * Check if source or destination is an PCIe/IO address (non-SDRAM) and add
+ * a new MBus window if necessary
+ */
+static int mv_xor_add_io_win(struct mv_xor_chan *mv_chan, u32 addr)
+{
+	void __iomem *base = mv_chan->mmr_high_base;
+	u32 win_enable;
+	u32 size;
+	u8 target, attr;
+	int ret;
+	int i;
+
+	/* If no IO window is found that addr has to be located in SDRAM */
+	ret = mvebu_mbus_get_io_win_info(addr, &size, &target, &attr);
+	if (ret < 0)
+		return 0;
+
+	/*
+	 * Mask the base addr 'addr' according to 'size' read back from the
+	 * MBus window. Otherwise we might end up with an address located
+	 * somewhere in the middle of this area here.
+	 */
+	size -= 1;
+	addr &= ~size;
+
+	/*
+	 * Reading one of both enabled register is enough, as they are always
+	 * programmed to the identical values
+	 */
+	win_enable = readl(base + WINDOW_BAR_ENABLE(0));
+
+	/*
+	 * Loop over all windows to find a matching window (area wise). If
+	 * one is found it will get disabled and later newly created.
+	 */
+	for (i = 0; i < 8; i++) {
+		u32 wbase;
+		u32 wsize;
+
+		/* Continue if the window is not enabled */
+		if (!(win_enable | (1 << i)))
+			continue;
+
+		wbase = readl(base + WINDOW_BASE(i)) & 0xffff0000;
+		wsize = readl(base + WINDOW_SIZE(i)) & 0xffff0000;
+
+		/* Continue if 'addr' is not in this window */
+		if (addr < wbase || addr > (wbase + wsize))
+			continue;
+
+		/*
+		 * If addr and size match, then this window is already
+		 * configured and we are done
+		 */
+		if (addr == wbase && (size & 0xffff0000) == wsize)
+			return 0;
+
+		/*
+		 * The window is already configured, but the size does not
+		 * match, so lets disable it
+		 */
+		writel(0, base + WINDOW_BASE(i));
+		writel(0, base + WINDOW_SIZE(i));
+		if (i < 4)
+			writel(0, base + WINDOW_REMAP_HIGH(i));
+		win_enable &= ~(1 << i);
+		win_enable &= ~(3 << (16 + (2 * i)));
+		writel(win_enable, base + WINDOW_BAR_ENABLE(0));
+		writel(win_enable, base + WINDOW_BAR_ENABLE(1));
+
+		/*
+		 * We can stop here since we have found and disabled the window
+		 */
+		break;
+	}
+
+	/* Set 'i' to the first free window to write the new values to */
+	i = ffs(~win_enable) - 1;
+	if (i >= 8)
+		return -ENOMEM;
+
+	writel((addr & 0xffff0000) | (attr << 8) | target,
+	       base + WINDOW_BASE(i));
+	writel(size & 0xffff0000, base + WINDOW_SIZE(i));
+
+	win_enable |= (1 << i);
+	win_enable |= 3 << (16 + (2 * i));
+	writel(win_enable, base + WINDOW_BAR_ENABLE(0));
+	writel(win_enable, base + WINDOW_BAR_ENABLE(1));
+
+	return 0;
+}
+
 static struct dma_async_tx_descriptor *
 mv_xor_prep_dma_xor(struct dma_chan *chan, dma_addr_t dest, dma_addr_t *src,
 		    unsigned int src_cnt, size_t len, unsigned long flags)
 {
 	struct mv_xor_chan *mv_chan = to_mv_xor_chan(chan);
 	struct mv_xor_desc_slot *sw_desc;
+	int ret;
 
 	if (unlikely(len < MV_XOR_MIN_BYTE_COUNT))
 		return NULL;
@@ -486,6 +581,11 @@ mv_xor_prep_dma_xor(struct dma_chan *chan, dma_addr_t dest, dma_addr_t *src,
 		"%s src_cnt: %d len: %zu dest %pad flags: %ld\n",
 		__func__, src_cnt, len, &dest, flags);
 
+	/* Check if a new window needs to get added for 'dest' */
+	ret = mv_xor_add_io_win(mv_chan, dest);
+	if (ret)
+		return NULL;
+
 	sw_desc = mv_chan_alloc_slot(mv_chan);
 	if (sw_desc) {
 		sw_desc->type = DMA_XOR;
@@ -493,8 +593,13 @@ mv_xor_prep_dma_xor(struct dma_chan *chan, dma_addr_t dest, dma_addr_t *src,
 		mv_desc_init(sw_desc, dest, len, flags);
 		if (mv_chan->op_in_desc == XOR_MODE_IN_DESC)
 			mv_desc_set_mode(sw_desc);
-		while (src_cnt--)
+		while (src_cnt--) {
+			/* Check if a new window needs to get added for 'src' */
+			ret = mv_xor_add_io_win(mv_chan, src[src_cnt]);
+			if (ret)
+				return NULL;
 			mv_desc_set_src_addr(sw_desc, src_cnt, src[src_cnt]);
+		}
 	}
 
 	dev_dbg(mv_chan_to_devp(mv_chan),
-- 
2.8.3
