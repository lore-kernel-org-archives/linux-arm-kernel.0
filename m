From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Fri,  5 Aug 2016 10:53:21 +0800
Subject: [PATCH 2/3] dmaengine: pl330: enable burst mode by parsing dt
In-Reply-To: <1470365602-32586-1-git-send-email-shawn.lin@rock-chips.com>
References: <1470365602-32586-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <1470365602-32586-3-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently pl330 use single mode defaultly. But burst
mode can improve efficiency of memory accessing. We
couldn't enable it by defalut in case of breaking any
Socs which don't support it.

With burst mode supported, we could see the improvement
significantly when tesing SPI transfer etc.

default single mode
[   88.292550] spi write 65536*1 cost 32402us speed:2022KB/S

After applied with burst mode(len 16)
[   17.625296] spi write 65536*1 cost 17830us speed:3675KB/S

Cc: Huibin Hong <huibin.hong@rock-chips.com>
Cc: Xing Zheng <zhengxing@rock-chips.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/dma/pl330.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 4fc3ffb..a09bf22 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -491,6 +491,8 @@ struct pl330_dmac {
 	/* Peripheral channels connected to this DMAC */
 	unsigned int num_peripherals;
 	struct dma_pl330_chan *peripherals; /* keep at end */
+	/* set peripherals request type according to soc config */
+	enum pl330_cond peripherals_req_type;
 	int quirks;
 };
 
@@ -1156,12 +1158,7 @@ static inline int _ldst_devtomem(struct pl330_dmac *pl330, unsigned dry_run,
 				 int cyc)
 {
 	int off = 0;
-	enum pl330_cond cond;
-
-	if (pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP)
-		cond = BURST;
-	else
-		cond = SINGLE;
+	enum pl330_cond cond = pl330->peripherals_req_type;
 
 	while (cyc--) {
 		off += _emit_WFP(dry_run, &buf[off], cond, pxs->desc->peri);
@@ -1181,12 +1178,7 @@ static inline int _ldst_memtodev(struct pl330_dmac *pl330,
 				 const struct _xfer_spec *pxs, int cyc)
 {
 	int off = 0;
-	enum pl330_cond cond;
-
-	if (pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP)
-		cond = BURST;
-	else
-		cond = SINGLE;
+	enum pl330_cond cond = pl330->peripherals_req_type;
 
 	while (cyc--) {
 		off += _emit_WFP(dry_run, &buf[off], cond, pxs->desc->peri);
@@ -2597,7 +2589,12 @@ static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
 
 		desc->rqtype = direction;
 		desc->rqcfg.brst_size = pch->burst_sz;
-		desc->rqcfg.brst_len = 1;
+
+		if (pl330->peripherals_req_type == BURST)
+			desc->rqcfg.brst_len = pch->burst_len;
+		else
+			desc->rqcfg.brst_len = 1;
+
 		desc->bytes_requested = period_len;
 		fill_px(&desc->px, dst, src, period_len);
 
@@ -2742,7 +2739,12 @@ pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		}
 
 		desc->rqcfg.brst_size = pch->burst_sz;
-		desc->rqcfg.brst_len = 1;
+
+		if (pch->dmac->peripherals_req_type == BURST)
+			desc->rqcfg.brst_len = pch->burst_len;
+		else
+			desc->rqcfg.brst_len = 1;
+
 		desc->rqtype = direction;
 		desc->bytes_requested = sg_dma_len(sg);
 	}
@@ -2836,6 +2838,11 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 
 	pl330->mcbufsz = pdat ? pdat->mcbuf_sz : 0;
 
+	if (of_find_property(np, "arm,pl330-periph-burst", NULL))
+		pl330->peripherals_req_type = BURST;
+	else
+		pl330->peripherals_req_type = SINGLE;
+
 	/* get quirk */
 	for (i = 0; i < ARRAY_SIZE(of_quirks); i++)
 		if (of_property_read_bool(np, of_quirks[i].quirk))
-- 
2.3.7
