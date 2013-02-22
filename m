From: boojin.kim@samsung.com (Boojin Kim)
Date: Fri, 22 Feb 2013 17:04:15 +0900
Subject: [PATCH v2 1/4] DMA: pl330: support burst mode for dev-to-mem and
 mem-to-dev transmit
Message-ID: <000001ce10d3$354dd440$9fe97cc0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds to support burst mode for dev-to-mem and mem-to-dev transmit

Change-Id: I9723e49383416773699cf7735168177c8d036f30
Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
---
 drivers/dma/pl330.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 80680ee..c67f037 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -1271,10 +1271,11 @@ static inline int _ldst_devtomem(unsigned dry_run, u8 buf[],
 		const struct _xfer_spec *pxs, int cyc)
 {
 	int off = 0;
+	enum pl330_cond cond = (pxs->r->cfg->brst_len == 1) ? SINGLE : BURST;

 	while (cyc--) {
-		off += _emit_WFP(dry_run, &buf[off], SINGLE, pxs->r->peri);
-		off += _emit_LDP(dry_run, &buf[off], SINGLE, pxs->r->peri);
+		off += _emit_WFP(dry_run, &buf[off], cond, pxs->r->peri);
+		off += _emit_LDP(dry_run, &buf[off], cond, pxs->r->peri);
 		off += _emit_ST(dry_run, &buf[off], ALWAYS);
 		off += _emit_FLUSHP(dry_run, &buf[off], pxs->r->peri);
 	}
@@ -1286,11 +1287,12 @@ static inline int _ldst_memtodev(unsigned dry_run, u8 buf[],
 		const struct _xfer_spec *pxs, int cyc)
 {
 	int off = 0;
+	enum pl330_cond cond = (pxs->r->cfg->brst_len == 1) ? SINGLE : BURST;

 	while (cyc--) {
-		off += _emit_WFP(dry_run, &buf[off], SINGLE, pxs->r->peri);
+		off += _emit_WFP(dry_run, &buf[off], cond, pxs->r->peri);
 		off += _emit_LD(dry_run, &buf[off], ALWAYS);
-		off += _emit_STP(dry_run, &buf[off], SINGLE, pxs->r->peri);
+		off += _emit_STP(dry_run, &buf[off], cond, pxs->r->peri);
 		off += _emit_FLUSHP(dry_run, &buf[off], pxs->r->peri);
 	}

@@ -2835,7 +2837,7 @@ pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		}

 		desc->rqcfg.brst_size = pch->burst_sz;
-		desc->rqcfg.brst_len = 1;
+		desc->rqcfg.brst_len = pch->burst_len;
 	}

 	/* Return the last desc in the chain */
--
1.7.5.4
