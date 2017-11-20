From: garsilva@embeddedor.com (Gustavo A. R. Silva)
Date: Mon, 20 Nov 2017 08:00:55 -0600
Subject: [PATCH] c8sectpfe: fix potential NULL pointer dereference in
 c8sectpfe_timer_interrupt
Message-ID: <20171120140055.GA728@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

_channel_ is being dereferenced before it is null checked, hence there is a
potential null pointer dereference. Fix this by moving the pointer dereference
after _channel_ has been null checked.

This issue was detected with the help of Coccinelle.

Fixes: c5f5d0f99794 ("[media] c8sectpfe: STiH407/10 Linux DVB demux support")
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
index 59280ac..23d0ced 100644
--- a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
+++ b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
@@ -83,7 +83,7 @@ static void c8sectpfe_timer_interrupt(unsigned long ac8sectpfei)
 static void channel_swdemux_tsklet(unsigned long data)
 {
 	struct channel_info *channel = (struct channel_info *)data;
-	struct c8sectpfei *fei = channel->fei;
+	struct c8sectpfei *fei;
 	unsigned long wp, rp;
 	int pos, num_packets, n, size;
 	u8 *buf;
@@ -91,6 +91,8 @@ static void channel_swdemux_tsklet(unsigned long data)
 	if (unlikely(!channel || !channel->irec))
 		return;
 
+	fei = channel->fei;
+
 	wp = readl(channel->irec + DMA_PRDS_BUSWP_TP(0));
 	rp = readl(channel->irec + DMA_PRDS_BUSRP_TP(0));
 
-- 
2.7.4
