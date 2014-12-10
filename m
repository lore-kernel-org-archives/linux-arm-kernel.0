From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Wed, 10 Dec 2014 15:16:12 -0500
Subject: [PATCH] Mailbox: Complete wait event only if Tx was successful
Message-ID: <1418242572-20998-1-git-send-email-ashwin.chaugule@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a wait_for_completion_timeout() call returns due to a timeout,
the mbox code can still call complete() after returning from the wait.
This can cause subsequent transmissions on a channel to fail, since
the wait_for_completion_timeout() sees the completion variable
is !=0, caused by the erroneous complete() call, and immediately
returns without waiting for the time as expected by the client.

Fix this by calling complete() only if the TX was successful.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/mailbox/mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 17e9e4a..4acaddb 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -101,7 +101,7 @@ static void tx_tick(struct mbox_chan *chan, int r)
 	if (mssg && chan->cl->tx_done)
 		chan->cl->tx_done(chan->cl, mssg, r);
 
-	if (chan->cl->tx_block)
+	if ((!r) && chan->cl->tx_block)
 		complete(&chan->tx_complete);
 }
 
-- 
1.9.1
