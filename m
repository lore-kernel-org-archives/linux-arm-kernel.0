From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 18 Aug 2016 12:11:01 +0200
Subject: [PATCH 08/13] scpi: add a vendor_msg mechanism in case the mailbox
 message differs
In-Reply-To: <1471515066-3626-1-git-send-email-narmstrong@baylibre.com>
References: <1471515066-3626-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1471515066-3626-9-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case the mailbox message pointer must contain a specific structure.
add a mechanism to override the pointer sent to the mailbox by a
vendor specific data initialized by a vendor speficic function.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/firmware/arm_scpi.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index d3be4c5..275feef 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -189,6 +189,7 @@ struct scpi_xfer {
 	unsigned int rx_len;
 	struct list_head node;
 	struct completion done;
+	void *vendor_msg;
 };
 
 struct scpi_chan {
@@ -203,6 +204,7 @@ struct scpi_chan {
 	struct mutex xfers_lock;
 	u8 token;
 	struct scpi_xfer *t;
+	void *vendor_data;
 };
 
 struct scpi_drvinfo {
@@ -302,6 +304,8 @@ struct dev_pstate_set {
 
 struct priv_scpi_ops {
 	/* Internal Specific Ops */
+	int (*init)(struct device *dev, struct scpi_chan *chan);
+	int (*prepare)(struct scpi_chan *chan);
 	void (*handle_remote_msg)(struct mbox_client *c, void *msg);
 	void (*tx_prepare)(struct mbox_client *c, void *msg);
 	/* Message Specific Ops */
@@ -498,7 +502,18 @@ static int legacy_scpi_send_message(u8 cmd, void *tx_buf, unsigned int tx_len,
 	init_completion(&msg->done);
 	scpi_chan->t = msg;
 
-	ret = mbox_send_message(scpi_chan->chan, &msg->cmd);
+	/* Call the prepare hook to eventually set the vendor_msg */
+	if (scpi_info->ops &&
+	    scpi_info->ops->prepare) {
+		ret = scpi_info->ops->prepare(scpi_chan);
+		if (ret) {
+			mutex_unlock(&scpi_chan->xfers_lock);
+			return ret;
+		}
+	} else
+		msg->vendor_msg = &msg->cmd;
+
+	ret = mbox_send_message(scpi_chan->chan, msg->vendor_msg);
 	if (ret < 0)
 		goto out;
 
@@ -1069,6 +1084,12 @@ static int scpi_probe(struct platform_device *pdev)
 		}
 		pchan->tx_payload = pchan->rx_payload + (size >> 1);
 
+		if (scpi_info->ops && scpi_info->ops->init) {
+			ret = scpi_info->ops->init(dev, pchan);
+			if (ret)
+				goto err;
+		}
+
 		cl->dev = dev;
 		if (scpi_info->ops && scpi_info->ops->handle_remote_msg)
 			cl->rx_callback = scpi_info->ops->handle_remote_msg;
-- 
1.9.1
