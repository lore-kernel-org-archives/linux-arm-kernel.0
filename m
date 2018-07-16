From: nm@ti.com (Nishanth Menon)
Date: Mon, 16 Jul 2018 13:06:04 -0500
Subject: [PATCH V2 3/6] mailbox: ti-msgmgr: Change message count mask to be
 descriptor based
In-Reply-To: <20180716180607.16526-1-nm@ti.com>
References: <20180716180607.16526-1-nm@ti.com>
Message-ID: <20180716180607.16526-4-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change mask used to extract the message count to be descriptor based.

This is to support changes for count location for various SoC
solutions.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since V1: None
V1: https://patchwork.kernel.org/patch/10475341/
RFC:  https://patchwork.kernel.org/patch/10447671/

 drivers/mailbox/ti-msgmgr.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/mailbox/ti-msgmgr.c b/drivers/mailbox/ti-msgmgr.c
index 91c955979008..7d2eb4b359ba 100644
--- a/drivers/mailbox/ti-msgmgr.c
+++ b/drivers/mailbox/ti-msgmgr.c
@@ -44,6 +44,7 @@ struct ti_msgmgr_valid_queue_desc {
  * @max_messages:	Number of messages
  * @data_first_reg:	First data register for proxy data region
  * @data_last_reg:	Last data register for proxy data region
+ * @status_cnt_mask:	Mask for getting the status value
  * @tx_polled:		Do I need to use polled mechanism for tx
  * @tx_poll_timeout_ms: Timeout in ms if polled
  * @valid_queues:	List of Valid queues that the processor can access
@@ -58,6 +59,7 @@ struct ti_msgmgr_desc {
 	u8 max_messages;
 	u8 data_first_reg;
 	u8 data_last_reg;
+	u32 status_cnt_mask;
 	bool tx_polled;
 	int tx_poll_timeout_ms;
 	const struct ti_msgmgr_valid_queue_desc *valid_queues;
@@ -116,20 +118,24 @@ struct ti_msgmgr_inst {
 
 /**
  * ti_msgmgr_queue_get_num_messages() - Get the number of pending messages
+ * @d:		Description of message manager
  * @qinst:	Queue instance for which we check the number of pending messages
  *
  * Return: number of messages pending in the queue (0 == no pending messages)
  */
-static inline int ti_msgmgr_queue_get_num_messages(struct ti_queue_inst *qinst)
+static inline int
+ti_msgmgr_queue_get_num_messages(const struct ti_msgmgr_desc *d,
+				 struct ti_queue_inst *qinst)
 {
 	u32 val;
+	u32 status_cnt_mask = d->status_cnt_mask;
 
 	/*
 	 * We cannot use relaxed operation here - update may happen
 	 * real-time.
 	 */
-	val = readl(qinst->queue_state) & Q_STATE_ENTRY_COUNT_MASK;
-	val >>= __ffs(Q_STATE_ENTRY_COUNT_MASK);
+	val = readl(qinst->queue_state) & status_cnt_mask;
+	val >>= __ffs(status_cnt_mask);
 
 	return val;
 }
@@ -167,8 +173,9 @@ static irqreturn_t ti_msgmgr_queue_rx_interrupt(int irq, void *p)
 		return IRQ_NONE;
 	}
 
+	desc = inst->desc;
 	/* Do I actually have messages to read? */
-	msg_count = ti_msgmgr_queue_get_num_messages(qinst);
+	msg_count = ti_msgmgr_queue_get_num_messages(desc, qinst);
 	if (!msg_count) {
 		/* Shared IRQ? */
 		dev_dbg(dev, "Spurious event - 0 pending data!\n");
@@ -181,7 +188,6 @@ static irqreturn_t ti_msgmgr_queue_rx_interrupt(int irq, void *p)
 	 * of how many bytes I should be reading. Let the client figure this
 	 * out.. I just read the full message and pass it on..
 	 */
-	desc = inst->desc;
 	message.len = desc->max_message_size;
 	message.buf = (u8 *)qinst->rx_buff;
 
@@ -224,12 +230,14 @@ static irqreturn_t ti_msgmgr_queue_rx_interrupt(int irq, void *p)
 static bool ti_msgmgr_queue_peek_data(struct mbox_chan *chan)
 {
 	struct ti_queue_inst *qinst = chan->con_priv;
+	struct device *dev = chan->mbox->dev;
+	struct ti_msgmgr_inst *inst = dev_get_drvdata(dev);
 	int msg_count;
 
 	if (qinst->is_tx)
 		return false;
 
-	msg_count = ti_msgmgr_queue_get_num_messages(qinst);
+	msg_count = ti_msgmgr_queue_get_num_messages(inst->desc, qinst);
 
 	return msg_count ? true : false;
 }
@@ -243,12 +251,14 @@ static bool ti_msgmgr_queue_peek_data(struct mbox_chan *chan)
 static bool ti_msgmgr_last_tx_done(struct mbox_chan *chan)
 {
 	struct ti_queue_inst *qinst = chan->con_priv;
+	struct device *dev = chan->mbox->dev;
+	struct ti_msgmgr_inst *inst = dev_get_drvdata(dev);
 	int msg_count;
 
 	if (!qinst->is_tx)
 		return false;
 
-	msg_count = ti_msgmgr_queue_get_num_messages(qinst);
+	msg_count = ti_msgmgr_queue_get_num_messages(inst->desc, qinst);
 
 	/* if we have any messages pending.. */
 	return msg_count ? false : true;
@@ -523,6 +533,7 @@ static const struct ti_msgmgr_desc k2g_desc = {
 	.max_messages = 128,
 	.data_first_reg = 16,
 	.data_last_reg = 31,
+	.status_cnt_mask = Q_STATE_ENTRY_COUNT_MASK,
 	.tx_polled = false,
 	.valid_queues = k2g_valid_queues,
 	.num_valid_queues = ARRAY_SIZE(k2g_valid_queues),
-- 
2.15.1
