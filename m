From: samuel@sholland.org (Samuel Holland)
Date: Tue, 27 Feb 2018 20:27:13 -0600
Subject: [PATCH 2/3] mailbox: Avoid NULL dereference in mbox_chan_received_data
In-Reply-To: <20180228022714.30068-1-samuel@sholland.org>
References: <20180228022714.30068-1-samuel@sholland.org>
Message-ID: <20180228022714.30068-3-samuel@sholland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a reception IRQ is pending when a mailbox channel is shut down (for
example, if the controller uses threaded interrupts), it is possible for
mbox_chan_received_data to be called while chan->cl is NULL.

This was found while developing a mailbox controller driver for use with
SCPI. The SCPI protocol driver frees its mailbox channel during probing
if the SCP firmware does not respond within a specified timeout. In this
case, if the SCP firmware takes slightly too long to respond,
mbox_chan_received_data races with mbox_free_channel clearing chan->cl.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/mailbox/mailbox.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 674b35f402f5..a0258d8672d5 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -152,9 +152,11 @@ static enum hrtimer_restart txdone_hrtimer(struct hrtimer *hrtimer)
  */
 void mbox_chan_received_data(struct mbox_chan *chan, void *mssg)
 {
+	struct mbox_client *cl = READ_ONCE(chan->cl);
+
 	/* No buffering the received data */
-	if (chan->cl->rx_callback)
-		chan->cl->rx_callback(chan->cl, mssg);
+	if (cl && cl->rx_callback)
+		cl->rx_callback(cl, mssg);
 }
 EXPORT_SYMBOL_GPL(mbox_chan_received_data);
 
-- 
2.13.6
