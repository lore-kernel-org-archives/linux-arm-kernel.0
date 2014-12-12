From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 12 Dec 2014 11:36:53 +0100
Subject: [PATCH v2 2/4] dmaengine: at_xdmac: introduce save_cc field
In-Reply-To: <1418380615-12171-1-git-send-email-ludovic.desroches@atmel.com>
References: <1418380615-12171-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1418380615-12171-3-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When suspending the device, read the channel configuration directly from
the register instead of relying on a software snapshot, it will be
safer.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/dma/at_xdmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index bc4b018..5c4f877 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -200,6 +200,7 @@ struct at_xdmac_chan {
 	u8				memif;		/* Memory Interface */
 	u32				per_src_addr;
 	u32				per_dst_addr;
+	u32				save_cc;
 	u32				save_cim;
 	u32				save_cnda;
 	u32				save_cndc;
@@ -1276,6 +1277,7 @@ static int atmel_xdmac_suspend(struct device *dev)
 	list_for_each_entry_safe(chan, _chan, &atxdmac->dma.channels, device_node) {
 		struct at_xdmac_chan	*atchan = to_at_xdmac_chan(chan);
 
+		atchan->save_cc = at_xdmac_chan_read(atchan, AT_XDMAC_CC);
 		if (at_xdmac_chan_is_cyclic(atchan)) {
 			if (!at_xdmac_chan_is_paused(atchan))
 				at_xdmac_device_pause(chan);
@@ -1298,7 +1300,6 @@ static int atmel_xdmac_resume(struct device *dev)
 	struct at_xdmac_chan	*atchan;
 	struct dma_chan		*chan, *_chan;
 	int			i;
-	u32			cfg;
 
 	clk_prepare_enable(atxdmac->clk);
 
@@ -1313,8 +1314,7 @@ static int atmel_xdmac_resume(struct device *dev)
 	at_xdmac_write(atxdmac, AT_XDMAC_GE, atxdmac->save_gs);
 	list_for_each_entry_safe(chan, _chan, &atxdmac->dma.channels, device_node) {
 		atchan = to_at_xdmac_chan(chan);
-		cfg = atchan->cfg[AT_XDMAC_CUR_CFG];
-		at_xdmac_chan_write(atchan, AT_XDMAC_CC, cfg);
+		at_xdmac_chan_write(atchan, AT_XDMAC_CC, atchan->save_cc);
 		if (at_xdmac_chan_is_cyclic(atchan)) {
 			at_xdmac_chan_write(atchan, AT_XDMAC_CNDA, atchan->save_cnda);
 			at_xdmac_chan_write(atchan, AT_XDMAC_CNDC, atchan->save_cndc);
-- 
2.0.3
