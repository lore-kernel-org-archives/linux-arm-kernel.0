From: loic.pallardy-ext@stericsson.com (Loic Pallardy)
Date: Tue, 18 Dec 2012 14:10:08 +0100
Subject: [PATCH 5/9] mailbox: change protection mechanisms
In-Reply-To: <1355836212-17956-1-git-send-email-loic.pallardy-ext@stericsson.com>
References: <1355836212-17956-1-git-send-email-loic.pallardy-ext@stericsson.com>
Message-ID: <1355836212-17956-6-git-send-email-loic.pallardy-ext@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TX: replace spin by mutex
RX: replace spin_lock_irq by spin_lock_irqsave

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/mailbox/mailbox.c | 10 ++++++----
 drivers/mailbox/mailbox.h |  1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 727e67e..8b7d7bd 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -95,7 +95,7 @@ int mailbox_msg_send(struct mailbox *mbox, struct mailbox_msg *msg)
 	struct mailbox_queue *mq = mbox->txq;
 	int ret = 0, len;
 
-	spin_lock_bh(&mq->lock);
+	mutex_lock(&mq->mlock);
 
 	if (kfifo_avail(&mq->fifo) < (sizeof(msg) + msg->size)) {
 		ret = -ENOMEM;
@@ -118,7 +118,7 @@ int mailbox_msg_send(struct mailbox *mbox, struct mailbox_msg *msg)
 	tasklet_schedule(&mbox->txq->tasklet);
 
 out:
-	spin_unlock_bh(&mq->lock);
+	mutex_unlock(&mq->mlock);
 	return ret;
 }
 EXPORT_SYMBOL(mailbox_msg_send);
@@ -198,6 +198,7 @@ static void mbox_rx_work(struct work_struct *work)
 	int len;
 	struct mailbox *mbox = mq->mbox;
 	struct mailbox_msg msg;
+	unsigned long flags;
 
 	while (kfifo_len(&mq->fifo) >= sizeof(msg)) {
 		len = kfifo_out(&mq->fifo, (unsigned char *)&msg, sizeof(msg));
@@ -210,12 +211,12 @@ static void mbox_rx_work(struct work_struct *work)
 		}
 
 		blocking_notifier_call_chain(&mbox->notifier, len, (void *)&msg);
-		spin_lock_irq(&mq->lock);
+		spin_lock_irqsave(&mq->lock, flags);
 		if (mq->full) {
 			mq->full = false;
 			mailbox_enable_irq(mbox, IRQ_RX);
 		}
-		spin_unlock_irq(&mq->lock);
+		spin_unlock_irqrestore(&mq->lock, flags);
 	}
 }
 
@@ -288,6 +289,7 @@ static struct mailbox_queue *mbox_queue_alloc(struct mailbox *mbox,
 		return NULL;
 
 	spin_lock_init(&mq->lock);
+	mutex_init(&mq->mlock);
 
 	if (kfifo_alloc(&mq->fifo, mbox_kfifo_size, GFP_KERNEL))
 		goto error;
diff --git a/drivers/mailbox/mailbox.h b/drivers/mailbox/mailbox.h
index 23ac551..0a31c99 100644
--- a/drivers/mailbox/mailbox.h
+++ b/drivers/mailbox/mailbox.h
@@ -37,6 +37,7 @@ struct mailbox_ops {
 
 struct mailbox_queue {
 	spinlock_t              lock;
+	struct mutex		mlock;
 	struct kfifo            fifo;
 	struct work_struct      work;
 	struct tasklet_struct   tasklet;
-- 
1.7.11.1
