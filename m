From: abrestic@chromium.org (Andrew Bresticker)
Date: Thu, 30 Oct 2014 13:01:06 -0700
Subject: [PATCH 1/2] mailbox: Avoid NULL-pointer dereference in
 mbox_chan_received_data()
Message-ID: <1414699267-17970-1-git-send-email-abrestic@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a message has been received on a channel, but no client has yet bound
to it, mbox_chan_received_data() will dereference a NULL client pointer.
Check for the presence of a client first.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/mailbox/mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index afcb430..5008028 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -142,7 +142,7 @@ static void poll_txdone(unsigned long data)
 void mbox_chan_received_data(struct mbox_chan *chan, void *mssg)
 {
 	/* No buffering the received data */
-	if (chan->cl->rx_callback)
+	if (chan->cl && chan->cl->rx_callback)
 		chan->cl->rx_callback(chan->cl, mssg);
 }
 EXPORT_SYMBOL_GPL(mbox_chan_received_data);
-- 
2.1.0.rc2.206.gedb03e5
