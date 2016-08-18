From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 18 Aug 2016 12:10:56 +0200
Subject: [PATCH 03/13] scpi: Add legacy send,
 prepare and handle remote functions
In-Reply-To: <1471515066-3626-1-git-send-email-narmstrong@baylibre.com>
References: <1471515066-3626-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1471515066-3626-4-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support the legacy SCPI procotol, add specific message_send,
prepare_tx and handle_remote functions since the legacy procotol
do not support message queuing and does not store the command word in the
tx_payload data.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/firmware/arm_scpi.c | 69 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 0bb6134..50b1297 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -202,6 +202,7 @@ struct scpi_chan {
 	spinlock_t rx_lock; /* locking for the rx pending list */
 	struct mutex xfers_lock;
 	u8 token;
+	struct scpi_xfer *t;
 };
 
 struct scpi_drvinfo {
@@ -364,6 +365,23 @@ static void scpi_handle_remote_msg(struct mbox_client *c, void *msg)
 	scpi_process_cmd(ch, cmd);
 }
 
+static void legacy_scpi_handle_remote_msg(struct mbox_client *c, void *__msg)
+{
+	struct scpi_chan *ch =
+		container_of(c, struct scpi_chan, cl);
+	struct legacy_scpi_shared_mem *mem = ch->rx_payload;
+	unsigned int len;
+
+	len = ch->t->rx_len;
+
+	ch->t->status = le32_to_cpu(mem->status);
+
+	if (len)
+		memcpy_fromio(ch->t->rx_buf, mem->payload, len);
+
+	complete(&ch->t->done);
+}
+
 static void scpi_tx_prepare(struct mbox_client *c, void *msg)
 {
 	unsigned long flags;
@@ -384,6 +402,15 @@ static void scpi_tx_prepare(struct mbox_client *c, void *msg)
 	mem->command = cpu_to_le32(t->cmd);
 }
 
+static void legacy_scpi_tx_prepare(struct mbox_client *c, void *__msg)
+{
+	struct scpi_chan *ch =
+		container_of(c, struct scpi_chan, cl);
+
+	if (ch->t->tx_buf && ch->t->tx_len)
+		memcpy_toio(ch->tx_payload, ch->t->tx_buf, ch->t->tx_len);
+}
+
 static int legacy_high_priority_cmds[] = {
 	LEGACY_SCPI_CMD_GET_CSS_PWR_STATE,
 	LEGACY_SCPI_CMD_CFG_PWR_STATE_STAT,
@@ -434,6 +461,48 @@ static void put_scpi_xfer(struct scpi_xfer *t, struct scpi_chan *ch)
 	mutex_unlock(&ch->xfers_lock);
 }
 
+static int legacy_scpi_send_message(u8 cmd, void *tx_buf, unsigned int tx_len,
+				void *rx_buf, unsigned int rx_len)
+{
+	int ret;
+	u8 chan;
+	struct scpi_xfer *msg;
+	struct scpi_chan *scpi_chan;
+
+	chan = legacy_scpi_get_chan(cmd);
+	scpi_chan = scpi_info->channels + chan;
+
+	msg = get_scpi_xfer(scpi_chan);
+	if (!msg)
+		return -ENOMEM;
+
+	mutex_lock(&scpi_chan->xfers_lock);
+
+	msg->cmd = PACK_LEGACY_SCPI_CMD(cmd, tx_len);
+	msg->tx_buf = tx_buf;
+	msg->tx_len = tx_len;
+	msg->rx_buf = rx_buf;
+	msg->rx_len = rx_len;
+	init_completion(&msg->done);
+	scpi_chan->t = msg;
+
+	ret = mbox_send_message(scpi_chan->chan, &msg->cmd);
+	if (ret < 0)
+		goto out;
+
+	if (!wait_for_completion_timeout(&msg->done, MAX_RX_TIMEOUT))
+		ret = -ETIMEDOUT;
+	else
+		/* first status word */
+		ret = msg->status;
+out:
+	mutex_unlock(&scpi_chan->xfers_lock);
+
+	put_scpi_xfer(msg, scpi_chan);
+	/* SCPI error codes > 0, translate them to Linux scale*/
+	return ret > 0 ? scpi_to_linux_errno(ret) : ret;
+}
+
 static int __scpi_send_message(u8 cmd, void *tx_buf, unsigned int tx_len,
 			       void *rx_buf, unsigned int rx_len, bool extn)
 {
-- 
1.9.1
