From: alvaro.moran@parrot.com (Alvaro Moran)
Date: Tue, 5 Mar 2013 14:43:35 +0100
Subject: [PATCH 1/1] DMA: PL330: No latency implementation of cyclic transfers
In-Reply-To: <y>
References: <y>
Message-ID: <1362491015-14298-1-git-send-email-alvaro.moran@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far the cyclic implementation was limited to recycling over submitted
requests. This patch uses the total buffer length and the period length
to define a set of periods. A microcode with a "loop forever" instruction
is then generated to have the DMA constantly running. (If there is enough
space to generate the microcode).
This removes the latency between each period transferred, since the
period callback is executed at the same time as the copy of the next
period goes on.

Signed-off-by: Alvaro Moran <alvaro.moran@parrot.com>
---
 drivers/dma/pl330.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 7181531..e8d494e 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -367,6 +367,8 @@ struct pl330_xfer {
 	 * The last xfer in the req must point to NULL.
 	 */
 	struct pl330_xfer *next;
+	/* Number of periods to execute in cyclic mode */
+	u32 periods;
 };
 
 /* The xfer callbacks are made with one of these arguments. */
@@ -1439,6 +1441,42 @@ static inline int _setup_xfer(unsigned dry_run, u8 buf[],
 	return off;
 }
 
+static inline int _setup_xfer_cyclic(unsigned dry_run, u8 buf[],
+		const struct _xfer_spec *pxs, int ev)
+{
+	struct pl330_xfer *x = pxs->x;
+	int off = 0;
+	int lfe, i;
+	struct _arg_LPEND lpend;
+
+	/* Mark loop forever start */
+	lfe = off;
+
+	/* DMAMOV SAR, x->src_addr */
+	off += _emit_MOV(dry_run, &buf[off], SAR, x->src_addr);
+	/* DMAMOV DAR, x->dst_addr */
+	off += _emit_MOV(dry_run, &buf[off], DAR, x->dst_addr);
+
+	/* Setup Loop(s) */
+	for (i = 0; i < x->periods; i++) {
+		off += _setup_loops(dry_run, &buf[off], pxs);
+
+		/* Signal event */
+		off += _emit_SEV(dry_run, &buf[off], ev);
+	}
+
+	lpend.cond = ALWAYS;
+	lpend.forever = true;
+	lpend.loop = 1;
+	lpend.bjump = off - lfe;
+	off = _emit_LPEND(dry_run, &buf[off], &lpend);
+
+	/* It shold never go here, it's just for security */
+	off = _emit_END(dry_run, &buf[off]);
+
+	return off;
+}
+
 /*
  * A req is a sequence of one or more xfer units.
  * Returns the number of bytes taken to setup the MC for the req.
@@ -1463,7 +1501,12 @@ static int _setup_req(unsigned dry_run, struct pl330_thread *thrd,
 			return -EINVAL;
 
 		pxs->x = x;
-		off += _setup_xfer(dry_run, &buf[off], pxs);
+		if (x->periods) {
+			off += _setup_xfer_cyclic(dry_run, &buf[off], pxs,
+					thrd->ev);
+			return off;
+		} else
+			off += _setup_xfer(dry_run, &buf[off], pxs);
 
 		x = x->next;
 	} while (x);
@@ -1757,12 +1800,13 @@ static int pl330_update(const struct pl330_info *pi)
 
 			/* Detach the req */
 			rqdone = thrd->req[active].r;
-			thrd->req[active].r = NULL;
-
-			mark_free(thrd, active);
+			if (!rqdone->x->periods) {
+				thrd->req[active].r = NULL;
 
-			/* Get going again ASAP */
-			_start(thrd);
+				mark_free(thrd, active);
+				/* Get going again ASAP */
+				_start(thrd);
+			}
 
 			/* For now, just make a list of callbacks to be done */
 			list_add_tail(&rqdone->rqd, &pl330->req_done);
@@ -2652,6 +2696,7 @@ static inline void fill_px(struct pl330_xfer *px,
 	px->bytes = len;
 	px->dst_addr = dst;
 	px->src_addr = src;
+	px->periods = 0;
 }
 
 static struct dma_pl330_desc *
@@ -2721,6 +2766,11 @@ static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
 			__func__, __LINE__);
 		return NULL;
 	}
+	if (len % period_len) {
+		dev_err(pch->dmac->pif.dev, "%s:%d Invalid period %d for cycle length %d\n",
+			__func__, __LINE__, period_len, len);
+		return NULL;
+	}
 
 	switch (direction) {
 	case DMA_MEM_TO_DEV:
@@ -2749,6 +2799,8 @@ static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
 	pch->cyclic = true;
 
 	fill_px(&desc->px, dst, src, period_len);
+	/* Set number of periods */
+	desc->px.periods = len / period_len;
 
 	return &desc->txd;
 }
-- 
1.7.10.4
