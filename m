From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 06 Mar 2012 22:33:46 +0000
Subject: [PATCH 1/9] dmaengine: mv_xor: remove write-only is_complete_cookie
In-Reply-To: <20120306223321.GD15201@n2100.arm.linux.org.uk>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
Message-ID: <E1S52x0-0002Mf-5s@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mv_xor's is_complete_cookie is only ever written to, but never read.
This is silly, remove the write-only structure member.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/mv_xor.c |    1 -
 drivers/dma/mv_xor.h |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index e779b43..ad7d03f 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -826,7 +826,6 @@ static enum dma_status mv_xor_status(struct dma_chan *chan,
 
 	last_used = chan->cookie;
 	last_complete = mv_chan->completed_cookie;
-	mv_chan->is_complete_cookie = cookie;
 	dma_set_tx_state(txstate, last_complete, last_used, 0);
 
 	ret = dma_async_is_complete(cookie, last_complete, last_used);
diff --git a/drivers/dma/mv_xor.h b/drivers/dma/mv_xor.h
index 977b592..da04ac2 100644
--- a/drivers/dma/mv_xor.h
+++ b/drivers/dma/mv_xor.h
@@ -109,7 +109,6 @@ struct mv_xor_chan {
 #ifdef USE_TIMER
 	unsigned long		cleanup_time;
 	u32			current_on_last_cleanup;
-	dma_cookie_t		is_complete_cookie;
 #endif
 };
 
-- 
1.7.4.4
