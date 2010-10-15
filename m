From: h-kanigeri2@ti.com (Hari Kanigeri)
Date: Thu, 14 Oct 2010 21:13:25 -0500
Subject: [PATCH 4/7] omap:mailbox-send message in process context
In-Reply-To: <1287108808-32119-1-git-send-email-h-kanigeri2@ti.com>
References: <1287108808-32119-1-git-send-email-h-kanigeri2@ti.com>
Message-ID: <1287108808-32119-5-git-send-email-h-kanigeri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Schedule the Tasklet to send only when mailbox fifo is full, else
send the message in the Process context. This would avoid
needless scheduling of Tasklet for every message transfer

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/plat-omap/mailbox.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index ed960c1..a4170c7 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -92,20 +92,25 @@ int omap_mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg)
 	struct omap_mbox_queue *mq = mbox->txq;
 	int ret = 0, len;
 
-	spin_lock(&mq->lock);
+	spin_lock_bh(&mq->lock);
 
 	if (kfifo_avail(&mq->fifo) < sizeof(msg)) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
+	if (!__mbox_poll_for_space(mbox)) {
+		mbox_fifo_write(mbox, msg);
+		goto out;
+	}
+
 	len = kfifo_in(&mq->fifo, (unsigned char *)&msg, sizeof(msg));
 	WARN_ON(len != sizeof(msg));
 
 	tasklet_schedule(&mbox->txq->tasklet);
 
 out:
-	spin_unlock(&mq->lock);
+	spin_unlock_bh(&mq->lock);
 	return ret;
 }
 EXPORT_SYMBOL(omap_mbox_msg_send);
-- 
1.7.0
