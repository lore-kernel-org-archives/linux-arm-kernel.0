From: alexey.klimov@arm.com (Alexey Klimov)
Date: Wed, 29 Mar 2017 19:16:27 +0100
Subject: [PATCH] firmware: arm_scpi: reinit completion instead of full
 init_completion()
Message-ID: <1490811387-27366-1-git-send-email-alexey.klimov@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of performing full initialization of the completion structure
on each transfer in scpi_send_message(), we initialize it at boot time
(more specifically, in the relevant probe() function) and use
reinit_completion() to reset ->done counter on each message transfer
thus saving a little bit of cpu time.

Signed-off-by: Alexey Klimov <alexey.klimov@arm.com>
---
 drivers/firmware/arm_scpi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 9ad0b19..f6cfc31 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -538,7 +538,7 @@ static int scpi_send_message(u8 idx, void *tx_buf, unsigned int tx_len,
 	msg->tx_len = tx_len;
 	msg->rx_buf = rx_buf;
 	msg->rx_len = rx_len;
-	init_completion(&msg->done);
+	reinit_completion(&msg->done);
 
 	ret = mbox_send_message(scpi_chan->chan, msg);
 	if (ret < 0 || !rx_buf)
@@ -872,8 +872,11 @@ static int scpi_alloc_xfer_list(struct device *dev, struct scpi_chan *ch)
 		return -ENOMEM;
 
 	ch->xfers = xfers;
-	for (i = 0; i < MAX_SCPI_XFERS; i++, xfers++)
+	for (i = 0; i < MAX_SCPI_XFERS; i++, xfers++) {
+		init_completion(&xfers->done);
 		list_add_tail(&xfers->node, &ch->xfers_list);
+	}
+
 	return 0;
 }
 
-- 
1.9.1
