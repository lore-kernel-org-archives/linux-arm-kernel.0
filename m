From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Thu, 10 Mar 2016 10:17:55 +0100
Subject: [RESEND PATCH] dmaengine: at_xdmac: fix residue computation
Message-ID: <1457601481-17405-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When computing the residue we need two pieces of information: the current
descriptor and the remaining data of the current descriptor. To get
that information, we need to read consecutively two registers but we
can't do it in an atomic way. For that reason, we have to check manually
that current descriptor has not changed.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Suggested-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Reported-by: David Engraf <david.engraf@sysgo.com>
Tested-by: David Engraf <david.engraf@sysgo.com>
Fixes: e1f7c9eee707 ("dmaengine: at_xdmac: creation of the atmel
eXtended DMA Controller driver")
Cc: stable at vger.kernel.org #4.1 and later
---
 drivers/dma/at_xdmac.c | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 64f5d1b..8e304b1 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -176,6 +176,7 @@
 #define AT_XDMAC_MAX_CHAN	0x20
 #define AT_XDMAC_MAX_CSIZE	16	/* 16 data */
 #define AT_XDMAC_MAX_DWIDTH	8	/* 64 bits */
+#define AT_XDMAC_RESIDUE_MAX_RETRIES	5
 
 #define AT_XDMAC_DMA_BUSWIDTHS\
 	(BIT(DMA_SLAVE_BUSWIDTH_UNDEFINED) |\
@@ -1395,8 +1396,8 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 	struct at_xdmac_desc	*desc, *_desc;
 	struct list_head	*descs_list;
 	enum dma_status		ret;
-	int			residue;
-	u32			cur_nda, mask, value;
+	int			residue, retry;
+	u32			cur_nda, check_nda, cur_ubc, mask, value;
 	u8			dwidth = 0;
 	unsigned long		flags;
 
@@ -1433,7 +1434,42 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 			cpu_relax();
 	}
 
+	/*
+	 * When processing the residue, we need to read two registers but we
+	 * can't do it in an atomic way. AT_XDMAC_CNDA is used to find where
+	 * we stand in the descriptor list and AT_XDMAC_CUBC is used
+	 * to know how many data are remaining for the current descriptor.
+	 * Since the dma channel is not paused to not loose data, between the
+	 * AT_XDMAC_CNDA and AT_XDMAC_CUBC read, we may have change of
+	 * descriptor.
+	 * For that reason, after reading AT_XDMAC_CUBC, we check if we are
+	 * still using the same descriptor by reading a second time
+	 * AT_XDMAC_CNDA. If AT_XDMAC_CNDA has changed, it means we have to
+	 * read again AT_XDMAC_CUBC.
+	 * Memory barriers are used to ensure the read order of the registers.
+	 * A max number of retries is set because unlikely it can never ends if
+	 * we are transferring a lot of data with small buffers.
+	 */
 	cur_nda = at_xdmac_chan_read(atchan, AT_XDMAC_CNDA) & 0xfffffffc;
+	rmb();
+	cur_ubc = at_xdmac_chan_read(atchan, AT_XDMAC_CUBC);
+	for (retry = 0; retry < AT_XDMAC_RESIDUE_MAX_RETRIES; retry++) {
+		rmb();
+		check_nda = at_xdmac_chan_read(atchan, AT_XDMAC_CNDA) & 0xfffffffc;
+
+		if (likely(cur_nda == check_nda))
+			break;
+
+		cur_nda = check_nda;
+		rmb();
+		cur_ubc = at_xdmac_chan_read(atchan, AT_XDMAC_CUBC);
+	}
+
+	if (unlikely(retry >= AT_XDMAC_RESIDUE_MAX_RETRIES)) {
+		ret = DMA_ERROR;
+		goto spin_unlock;
+	}
+
 	/*
 	 * Remove size of all microblocks already transferred and the current
 	 * one. Then add the remaining size to transfer of the current
@@ -1446,7 +1482,7 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 		if ((desc->lld.mbr_nda & 0xfffffffc) == cur_nda)
 			break;
 	}
-	residue += at_xdmac_chan_read(atchan, AT_XDMAC_CUBC) << dwidth;
+	residue += cur_ubc << dwidth;
 
 	dma_set_residue(txstate, residue);
 
-- 
2.5.0
