From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 24 Mar 2016 11:23:50 +0000
Subject: [PATCH 1/3] [media] c8sectpfe: Fix broken circular buffer wp
 management
In-Reply-To: <1458818632-25552-1-git-send-email-peter.griffin@linaro.org>
References: <1458818632-25552-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1458818632-25552-2-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During the review process, a regression was intoduced in the
circular buffer write pointer management. This means that wp
doesn't get managed properly once the buffer becomes full.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
index 78e3cb9..875d384 100644
--- a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
+++ b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
@@ -130,7 +130,7 @@ static void channel_swdemux_tsklet(unsigned long data)
 		writel(channel->back_buffer_busaddr, channel->irec +
 			DMA_PRDS_BUSRP_TP(0));
 	else
-		writel(wp, channel->irec + DMA_PRDS_BUSWP_TP(0));
+		writel(wp, channel->irec + DMA_PRDS_BUSRP_TP(0));
 }
 
 static int c8sectpfe_start_feed(struct dvb_demux_feed *dvbdmxfeed)
-- 
1.9.1
