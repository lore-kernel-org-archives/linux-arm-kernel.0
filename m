From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 22 Apr 2011 19:42:00 +0200
Subject: [PATCH v2 4/5] dmaengine: at_hdmac: remove channel status testing in
	tasklet
In-Reply-To: <3ee5a0e314a22339ad7a15a5425045f5ed244eab.1301678094.git.nicolas.ferre@atmel.com>
References: <3ee5a0e314a22339ad7a15a5425045f5ed244eab.1301678094.git.nicolas.ferre@atmel.com>
Message-ID: <6800a7f7e8aba811b53e1d0ab4a6f52cb6682ee0.1303493836.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to test if channel is enabled in tasklet:
- in error path, channel is disabled in interrupt routine
- in normal path, this test is performed in sub functions to report
a misuse of the engine.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/dma/at_hdmac.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 8f50a0f..65bd52a 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -472,13 +472,6 @@ static void atc_tasklet(unsigned long data)
 {
 	struct at_dma_chan *atchan = (struct at_dma_chan *)data;
 
-	/* Channel cannot be enabled here */
-	if (atc_chan_is_enabled(atchan)) {
-		dev_err(chan2dev(&atchan->chan_common),
-			"BUG: channel enabled in tasklet\n");
-		return;
-	}
-
 	spin_lock(&atchan->lock);
 	if (test_and_clear_bit(ATC_IS_ERROR, &atchan->status))
 		atc_handle_error(atchan);
-- 
1.7.3
