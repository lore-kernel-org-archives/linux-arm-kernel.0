From: maninder1.s@samsung.com (Maninder Singh)
Date: Fri, 26 Jun 2015 16:04:48 +0530
Subject: [PATCH 1/1] dmaengine: Use Pointer xt after NULL check.
Message-ID: <1435314888-20491-1-git-send-email-maninder1.s@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removing static analysis error:-
Possible null pointer dereference: xt

Because currently xt is dereferenced before NULL check,
Thus Use it after NULL Check.

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Reviewed-by: Vaneet Narang <v.narang@samsung.com>
---
 drivers/dma/at_hdmac.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 59892126..d313acb 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -659,14 +659,14 @@ atc_prep_dma_interleaved(struct dma_chan *chan,
 	size_t			len = 0;
 	int			i;
 
+	if (unlikely(!xt || xt->numf != 1 || !xt->frame_size))
+		return NULL;
+
 	dev_info(chan2dev(chan),
 		 "%s: src=0x%08x, dest=0x%08x, numf=%d, frame_size=%d, flags=0x%lx\n",
 		__func__, xt->src_start, xt->dst_start, xt->numf,
 		xt->frame_size, flags);
 
-	if (unlikely(!xt || xt->numf != 1 || !xt->frame_size))
-		return NULL;
-
 	/*
 	 * The controller can only "skip" X bytes every Y bytes, so we
 	 * need to make sure we are given a template that fit that
-- 
1.7.9.5
