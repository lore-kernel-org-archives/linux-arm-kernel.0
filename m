From: anup.patel@broadcom.com (Anup Patel)
Date: Wed, 19 Jul 2017 15:25:40 +0530
Subject: [PATCH 4/6] mailbox: Make message send queue size dynamic in Linux
 mailbox
In-Reply-To: <1500458142-19243-1-git-send-email-anup.patel@broadcom.com>
References: <1500458142-19243-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1500458142-19243-5-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the message send queue size in Linux mailbox framework
is hard-coded to MBOX_TX_QUEUE_LEN which is defined as 20.

This message send queue can easily overflow if mbox_send_message()
is called for same mailbox channel several times. The size of message
send queue should not be hard-coded in Linux mailbox framework and
instead mailbox controller driver should have a mechanism to specify
message send queue size for each mailbox channel.

This patch makes message send queue size dynamic in Linux mailbox
framework and provides a mechanism to set message send queue size
for each mailbox channel. If mailbox controller driver does not set
message send queue size then we assume the hard-coded value of 20.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/mailbox/mailbox.c          | 15 ++++++++++++---
 include/linux/mailbox_controller.h |  5 +++--
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 537f4f6..ccc2aea 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -34,7 +34,7 @@ static int add_to_rbuf(struct mbox_chan *chan, void *mssg)
 	spin_lock_irqsave(&chan->lock, flags);
 
 	/* See if there is any space left */
-	if (chan->msg_count == MBOX_TX_QUEUE_LEN) {
+	if (chan->msg_count == chan->msg_queue_len) {
 		spin_unlock_irqrestore(&chan->lock, flags);
 		return -ENOBUFS;
 	}
@@ -43,7 +43,7 @@ static int add_to_rbuf(struct mbox_chan *chan, void *mssg)
 	chan->msg_data[idx] = mssg;
 	chan->msg_count++;
 
-	if (idx == MBOX_TX_QUEUE_LEN - 1)
+	if (idx == chan->msg_queue_len - 1)
 		chan->msg_free = 0;
 	else
 		chan->msg_free++;
@@ -70,7 +70,7 @@ static void msg_submit(struct mbox_chan *chan)
 	if (idx >= count)
 		idx -= count;
 	else
-		idx += MBOX_TX_QUEUE_LEN - count;
+		idx += chan->msg_queue_len - count;
 
 	data = chan->msg_data[idx];
 
@@ -346,6 +346,12 @@ struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
 	spin_lock_irqsave(&chan->lock, flags);
 	chan->msg_free = 0;
 	chan->msg_count = 0;
+	chan->msg_data = kcalloc(chan->msg_queue_len,
+				 sizeof(void *), GFP_ATOMIC);
+	if (!chan->msg_data) {
+		spin_unlock_irqrestore(&chan->lock, flags);
+		return ERR_PTR(-ENOMEM);
+	}
 	chan->active_req = NULL;
 	chan->cl = cl;
 	init_completion(&chan->tx_complete);
@@ -420,6 +426,7 @@ void mbox_free_channel(struct mbox_chan *chan)
 	chan->active_req = NULL;
 	if (chan->txdone_method == (TXDONE_BY_POLL | TXDONE_BY_ACK))
 		chan->txdone_method = TXDONE_BY_POLL;
+	kfree(chan->msg_data);
 
 	module_put(chan->mbox->dev->driver->owner);
 	spin_unlock_irqrestore(&chan->lock, flags);
@@ -477,6 +484,8 @@ int mbox_controller_register(struct mbox_controller *mbox)
 		chan->cl = NULL;
 		chan->mbox = mbox;
 		chan->txdone_method = txdone;
+		if (chan->msg_queue_len < MBOX_TX_QUEUE_LEN)
+			chan->msg_queue_len = MBOX_TX_QUEUE_LEN;
 		spin_lock_init(&chan->lock);
 	}
 
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index 74deadb..eba3fed 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -110,6 +110,7 @@ struct mbox_controller {
  * @active_req:		Currently active request hook
  * @msg_count:		No. of mssg currently queued
  * @msg_free:		Index of next available mssg slot
+ * @msg_queue_len:	Max number of mssg which can be queued
  * @msg_data:		Hook for data packet
  * @lock:		Serialise access to the channel
  * @con_priv:		Hook for controller driver to attach private data
@@ -120,8 +121,8 @@ struct mbox_chan {
 	struct mbox_client *cl;
 	struct completion tx_complete;
 	void *active_req;
-	unsigned msg_count, msg_free;
-	void *msg_data[MBOX_TX_QUEUE_LEN];
+	unsigned int msg_count, msg_free, msg_queue_len;
+	void **msg_data;
 	spinlock_t lock; /* Serialise access to the channel */
 	void *con_priv;
 };
-- 
2.7.4
