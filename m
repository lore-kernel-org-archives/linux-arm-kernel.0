From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed,  1 Nov 2017 16:32:44 +0000
Subject: [PATCH] mailbox: add support for doorbell/signal mode controllers
Message-ID: <1509553964-4451-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some mailbox controllers are lack FIFOs or memory to transmit data.
They typically contains single doorbell registers to just signal the
remote. The actually data is transmitted/shared using some shared memory
which is not part of the mailbox.

Such controllers don't need to transmit any data, they just transmit
the signal. In such controllers the data pointer passed to
mbox_send_message is passed to client via it's tx_prepare callback.
Controller doesn't need any data to be passed from the client.

This patch introduce the new API send_signal to support such doorbell/
signal mode in mailbox controllers. This is useful to avoid another
layer of abstraction as typically multiple channels can be multiplexied
into single register.

Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/mailbox.c          | 11 ++++++++++-
 include/linux/mailbox_controller.h | 11 +++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

Hi Jassi, Arnd,

This is rough idea I have on extending mailbox interface to support
the doorbell requirements. The new API send_signal will eliminate the
issue Jassi has explained in earlier discussion with respect to generic
message format using Rockchip example.

Regards,
Sudeep

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 674b35f402f5..495b4574b954 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -77,7 +77,10 @@ static void msg_submit(struct mbox_chan *chan)
 	if (chan->cl->tx_prepare)
 		chan->cl->tx_prepare(chan->cl, data);
 	/* Try to submit a message to the MBOX controller */
-	err = chan->mbox->ops->send_data(chan, data);
+	if (chan->mbox->ops->send_data)
+		err = chan->mbox->ops->send_data(chan, data);
+	else
+		err = chan->mbox->ops->send_signal(chan);
 	if (!err) {
 		chan->active_req = data;
 		chan->msg_count--;
@@ -451,6 +454,12 @@ int mbox_controller_register(struct mbox_controller *mbox)
 	/* Sanity check */
 	if (!mbox || !mbox->dev || !mbox->ops || !mbox->num_chans)
 		return -EINVAL;
+	/*
+	 * A controller can support either doorbell mode or normal message
+	 * transmission mode but not both
+	 */
+	if (mbox->ops->send_data && mbox->ops->send_signal)
+		return -EINVAL;
 
 	if (mbox->txdone_irq)
 		txdone = TXDONE_BY_IRQ;
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index 74deadb42d76..bdbc5b74097e 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -24,6 +24,16 @@ struct mbox_chan;
  *		transmission of data is reported by the controller via
  *		mbox_chan_txdone (if it has some TX ACK irq). It must not
  *		sleep.
+ * @send_signal: The API asks the MBOX controller driver, in atomic
+ *		 context try to transmit a signal on the bus. Returns 0 if
+ *		 data is accepted for transmission, -EBUSY while rejecting
+ *		 if the remote hasn't yet absorbed the last signal sent. Actual
+ *		 transmission of data must be handled by the client and  is
+ *		 reported by the controller via mbox_chan_txdone (if it has
+ *		 some TX ACK irq). It must not sleep. Unlike send_data,
+ *		 send_signal doesn't handle any messages/data. It just sends
+ *		 notification signal(doorbell) and client needs to prepare all
+ *		 the data.
  * @startup:	Called when a client requests the chan. The controller
  *		could ask clients for additional parameters of communication
  *		to be provided via client's chan_data. This call may
@@ -46,6 +56,7 @@ struct mbox_chan;
  */
 struct mbox_chan_ops {
 	int (*send_data)(struct mbox_chan *chan, void *data);
+	int (*send_signal)(struct mbox_chan *chan);
 	int (*startup)(struct mbox_chan *chan);
 	void (*shutdown)(struct mbox_chan *chan);
 	bool (*last_tx_done)(struct mbox_chan *chan);
-- 
2.7.4
