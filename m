From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Tue, 15 Sep 2015 15:36:00 +0200
Subject: [PATCH 2/4] dmaengine: at_xdmac: change block increment addressing
 mode
In-Reply-To: <1442323770-20266-1-git-send-email-ludovic.desroches@atmel.com>
References: <1442323770-20266-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1442324163-20389-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

The addressing mode we were using was not only incrementing the address at
each microblock, but also at each data boundary, which was severely slowing
the transfer, without any benefit since we were not using the data stride.

Switch to the micro block increment only in order to get back to an
acceptable performance level.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Fixes: 6007ccb57744 ("dmaengine: xdmac: Add interleaved transfer support")
Cc: stable at vger.kernel.org #4.2
---
 drivers/dma/at_xdmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 0190d1c..3952bff 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -875,14 +875,14 @@ at_xdmac_interleaved_queue_desc(struct dma_chan *chan,
 
 	if (xt->src_inc) {
 		if (xt->src_sgl)
-			chan_cc |=  AT_XDMAC_CC_SAM_UBS_DS_AM;
+			chan_cc |=  AT_XDMAC_CC_SAM_UBS_AM;
 		else
 			chan_cc |=  AT_XDMAC_CC_SAM_INCREMENTED_AM;
 	}
 
 	if (xt->dst_inc) {
 		if (xt->dst_sgl)
-			chan_cc |=  AT_XDMAC_CC_DAM_UBS_DS_AM;
+			chan_cc |=  AT_XDMAC_CC_DAM_UBS_AM;
 		else
 			chan_cc |=  AT_XDMAC_CC_DAM_INCREMENTED_AM;
 	}
-- 
2.5.0
