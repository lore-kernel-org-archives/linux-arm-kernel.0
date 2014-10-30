From: abrestic@chromium.org (Andrew Bresticker)
Date: Thu, 30 Oct 2014 13:01:07 -0700
Subject: [PATCH 2/2] mailbox: Don't unnecessarily re-arm the polling timer
In-Reply-To: <1414699267-17970-1-git-send-email-abrestic@chromium.org>
References: <1414699267-17970-1-git-send-email-abrestic@chromium.org>
Message-ID: <1414699267-17970-2-git-send-email-abrestic@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

poll_txdone() will unconditionally re-arm the polling timer if there was
an active request, even if the active request completed and no other
requests were submitted.  This is fixed by:
 - only re-arming the timer if the controller reported that the current
   transmission has not completed, and,
 - moving the call to poll_txdone() into msg_submit() so that the
   controller gets polled (and the timer re-armed, if necessary) whenever
   a new message is submitted.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/mailbox/mailbox.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 5008028..26f74ad 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -28,6 +28,8 @@
 static LIST_HEAD(mbox_cons);
 static DEFINE_MUTEX(con_mutex);
 
+static void poll_txdone(unsigned long data);
+
 static int add_to_rbuf(struct mbox_chan *chan, void *mssg)
 {
 	int idx;
@@ -60,7 +62,7 @@ static void msg_submit(struct mbox_chan *chan)
 	unsigned count, idx;
 	unsigned long flags;
 	void *data;
-	int err;
+	int err = -EBUSY;
 
 	spin_lock_irqsave(&chan->lock, flags);
 
@@ -84,6 +86,9 @@ static void msg_submit(struct mbox_chan *chan)
 	}
 exit:
 	spin_unlock_irqrestore(&chan->lock, flags);
+
+	if (!err && chan->txdone_method == TXDONE_BY_POLL)
+		poll_txdone((unsigned long)chan->mbox);
 }
 
 static void tx_tick(struct mbox_chan *chan, int r)
@@ -117,10 +122,11 @@ static void poll_txdone(unsigned long data)
 		struct mbox_chan *chan = &mbox->chans[i];
 
 		if (chan->active_req && chan->cl) {
-			resched = true;
 			txdone = chan->mbox->ops->last_tx_done(chan);
 			if (txdone)
 				tx_tick(chan, 0);
+			else
+				resched = true;
 		}
 	}
 
@@ -252,9 +258,6 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
 
 	msg_submit(chan);
 
-	if (chan->txdone_method	== TXDONE_BY_POLL)
-		poll_txdone((unsigned long)chan->mbox);
-
 	if (chan->cl->tx_block && chan->active_req) {
 		unsigned long wait;
 		int ret;
-- 
2.1.0.rc2.206.gedb03e5
