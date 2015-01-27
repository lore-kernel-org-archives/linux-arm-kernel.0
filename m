From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Tue, 27 Jan 2015 16:30:29 +0100
Subject: [RESEND PATCH v2 1/4] dmaengine: at_xdmac: wait for in-progress
 transaction to complete after pausing a channel
In-Reply-To: <1422372632-21659-1-git-send-email-ludovic.desroches@atmel.com>
References: <1422372632-21659-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1422372632-21659-2-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyrille Pitchen <cyrille.pitchen@atmel.com>

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/dma/at_xdmac.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 8c799f6..5e3f072 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1136,9 +1136,14 @@ static int at_xdmac_device_pause(struct dma_chan *chan)
 
 	dev_dbg(chan2dev(chan), "%s\n", __func__);
 
+	if (test_and_set_bit(AT_XDMAC_CHAN_IS_PAUSED, &atchan->status))
+		return 0;
+
 	spin_lock_bh(&atchan->lock);
 	at_xdmac_write(atxdmac, AT_XDMAC_GRWS, atchan->mask);
-	set_bit(AT_XDMAC_CHAN_IS_PAUSED, &atchan->status);
+	while (at_xdmac_chan_read(atchan, AT_XDMAC_CC)
+	       & (AT_XDMAC_CC_WRIP | AT_XDMAC_CC_RDIP))
+		cpu_relax();
 	spin_unlock_bh(&atchan->lock);
 
 	return 0;
-- 
2.2.0
