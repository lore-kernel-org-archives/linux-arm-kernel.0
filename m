From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Thu, 13 Nov 2014 11:52:41 +0100
Subject: [PATCH 3/7] dmaengine: at_xdmac: fix software lockup
 at_xdmac_tx_status()
In-Reply-To: <1415875965-6905-1-git-send-email-ludovic.desroches@atmel.com>
References: <1415875965-6905-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1415875965-6905-4-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyrille Pitchen <cyrille.pitchen@atmel.com>

According to the Atmel eXtended DMA controller datasheet, requesting a
DMA transfer flush for a channel is only revelant when this transfer is
source peripheral synchronized.

So we have to check this condition before requesting a channel flush by
writing the channel bit into the Global channel SoftWare Flush (GSWF)
register then waiting for flush to complete by monitoring the end of
Flush Interrupt Status (FIS) bit in the Channel Interrupt Status (CIS)
register.

Indeed, for non source peripheral synchronized transfer, writing the
channel bit into the GSWF register does nothing. Especially, the FIS bit
is never set into the CIS register. The former code looped forever
waiting for this bit to be set.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/dma/at_xdmac.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index fcecbad..fa9d75a 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -879,7 +879,7 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 	struct list_head	*descs_list;
 	enum dma_status		ret;
 	int			residue;
-	u32			cur_nda;
+	u32			cur_nda, mask, value;
 	u8			dwidth = at_xdmac_get_dwidth(atchan->cfg[AT_XDMAC_CUR_CFG]);
 
 	ret = dma_cookie_status(chan, cookie, txstate);
@@ -903,10 +903,17 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 	}
 
 	residue = desc->xfer_size;
-	/* Flush FIFO. */
-	at_xdmac_write(atxdmac, AT_XDMAC_GSWF, atchan->mask);
-	while (!(at_xdmac_chan_read(atchan, AT_XDMAC_CIS) & AT_XDMAC_CIS_FIS))
-		cpu_relax();
+	/*
+	 * Flush FIFO: only relevant when the transfer is source peripheral
+	 * synchronized.
+	 */
+	mask = AT_XDMAC_CC_TYPE | AT_XDMAC_CC_DSYNC;
+	value = AT_XDMAC_CC_TYPE_PER_TRAN | AT_XDMAC_CC_DSYNC_PER2MEM;
+	if ((atchan->cfg[AT_XDMAC_CUR_CFG] & mask) == value) {
+		at_xdmac_write(atxdmac, AT_XDMAC_GSWF, atchan->mask);
+		while (!(at_xdmac_chan_read(atchan, AT_XDMAC_CIS) & AT_XDMAC_CIS_FIS))
+			cpu_relax();
+	}
 
 	cur_nda = at_xdmac_chan_read(atchan, AT_XDMAC_CNDA) & 0xfffffffc;
 	/*
-- 
2.0.3
