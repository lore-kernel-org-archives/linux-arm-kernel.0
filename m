From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Fri, 25 Nov 2016 01:54:31 +0100
Subject: [PATCH v2 1/2] firmware: arm_scpi: zero RX buffer before requesting
 data from the mbox
In-Reply-To: <20161125005432.1205-1-martin.blumenstingl@googlemail.com>
References: <20161124001845.20830-1-martin.blumenstingl@googlemail.com>
 <20161125005432.1205-1-martin.blumenstingl@googlemail.com>
Message-ID: <20161125005432.1205-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The original code was relying on the fact that the SCPI firmware
responds with the same number of bytes (or more, all extra data would be
ignored in that case) as requested.
However, we have some pre-v1.0 SCPI firmwares which are responding with
less data for some commands (sensor_value.hi_val did not exist in the
old implementation). This means that some data from the previous
command's RX buffer was leaked into the current command (as the RX
buffer is re-used for all commands on the same channel). Clearing the
RX buffer before (re-) using it ensures we get a consistent result, even
if the SCPI firmware returns less bytes than requested.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/firmware/arm_scpi.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 70e1323..8c183d8 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -259,6 +259,7 @@ struct scpi_chan {
 	struct mbox_chan *chan;
 	void __iomem *tx_payload;
 	void __iomem *rx_payload;
+	resource_size_t max_payload_len;
 	struct list_head rx_pending;
 	struct list_head xfers_list;
 	struct scpi_xfer *xfers;
@@ -470,6 +471,20 @@ static void scpi_tx_prepare(struct mbox_client *c, void *msg)
 	if (t->rx_buf) {
 		if (!(++ch->token))
 			++ch->token;
+
+		/* clear the RX buffer as it is shared across all commands on
+		 * the same channel (to make sure we're not leaking data from
+		 * the previous response into the current command if the SCPI
+		 * firmware writes less data than requested).
+		 * This is especially important for pre-v1.0 SCPI firmwares
+		 * where some fields in the responses do not exist (while they
+		 * exist but are optional in newer versions). One example for
+		 * this problem is sensor_value.hi_val, which would contain
+		 * ("leak") the second 4 bytes of the RX buffer from the
+		 * previous command.
+		 */
+		memset_io(ch->rx_payload, 0, ch->max_payload_len);
+
 		ADD_SCPI_TOKEN(t->cmd, ch->token);
 		spin_lock_irqsave(&ch->rx_lock, flags);
 		list_add_tail(&t->node, &ch->rx_pending);
@@ -921,7 +936,9 @@ static int scpi_probe(struct platform_device *pdev)
 			ret = -EADDRNOTAVAIL;
 			goto err;
 		}
-		pchan->tx_payload = pchan->rx_payload + (size >> 1);
+
+		pchan->max_payload_len = size / 2;
+		pchan->tx_payload = pchan->rx_payload + pchan->max_payload_len;
 
 		cl->dev = dev;
 		cl->rx_callback = scpi_handle_remote_msg;
-- 
2.10.2
