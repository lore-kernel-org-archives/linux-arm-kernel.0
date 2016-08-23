From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 23 Aug 2016 13:46:50 +0200
Subject: [PATCH v2 1/7] scpi: Add alternative legacy structures,
 functions and macros
In-Reply-To: <1471952816-30877-1-git-send-email-narmstrong@baylibre.com>
References: <1471952816-30877-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1471952816-30877-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support the legacy SCPI protocol variant, add back the structures
and macros that varies against the final specification.
Add support for legacy in scpi_send_message.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/firmware/arm_scpi.c | 142 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 135 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 4388937..752e5b2 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -50,11 +50,16 @@
 #define CMD_TOKEN_ID_MASK	0xff
 #define CMD_DATA_SIZE_SHIFT	16
 #define CMD_DATA_SIZE_MASK	0x1ff
+#define CMD_LEGACY_DATA_SIZE_SHIFT	20
+#define CMD_LEGACY_DATA_SIZE_MASK	0x1ff
 #define PACK_SCPI_CMD(cmd_id, tx_sz)			\
 	((((cmd_id) & CMD_ID_MASK) << CMD_ID_SHIFT) |	\
 	(((tx_sz) & CMD_DATA_SIZE_MASK) << CMD_DATA_SIZE_SHIFT))
 #define ADD_SCPI_TOKEN(cmd, token)			\
 	((cmd) |= (((token) & CMD_TOKEN_ID_MASK) << CMD_TOKEN_ID_SHIFT))
+#define PACK_LEGACY_SCPI_CMD(cmd_id, tx_sz)				\
+	((((cmd_id) & CMD_ID_MASK) << CMD_ID_SHIFT) |			       \
+	(((tx_sz) & CMD_LEGACY_DATA_SIZE_MASK) << CMD_LEGACY_DATA_SIZE_SHIFT))
 
 #define CMD_SIZE(cmd)	(((cmd) >> CMD_DATA_SIZE_SHIFT) & CMD_DATA_SIZE_MASK)
 #define CMD_UNIQ_MASK	(CMD_TOKEN_ID_MASK << CMD_TOKEN_ID_SHIFT | CMD_ID_MASK)
@@ -132,6 +137,42 @@ enum scpi_std_cmd {
 	SCPI_CMD_COUNT
 };
 
+enum legacy_scpi_std_cmd {
+	LEGACY_SCPI_CMD_INVALID			= 0x00,
+	LEGACY_SCPI_CMD_SCPI_READY		= 0x01,
+	LEGACY_SCPI_CMD_SCPI_CAPABILITIES	= 0x02,
+	LEGACY_SCPI_CMD_EVENT			= 0x03,
+	LEGACY_SCPI_CMD_SET_CSS_PWR_STATE	= 0x04,
+	LEGACY_SCPI_CMD_GET_CSS_PWR_STATE	= 0x05,
+	LEGACY_SCPI_CMD_CFG_PWR_STATE_STAT	= 0x06,
+	LEGACY_SCPI_CMD_GET_PWR_STATE_STAT	= 0x07,
+	LEGACY_SCPI_CMD_SYS_PWR_STATE		= 0x08,
+	LEGACY_SCPI_CMD_L2_READY		= 0x09,
+	LEGACY_SCPI_CMD_SET_AP_TIMER		= 0x0a,
+	LEGACY_SCPI_CMD_CANCEL_AP_TIME		= 0x0b,
+	LEGACY_SCPI_CMD_DVFS_CAPABILITIES	= 0x0c,
+	LEGACY_SCPI_CMD_GET_DVFS_INFO		= 0x0d,
+	LEGACY_SCPI_CMD_SET_DVFS		= 0x0e,
+	LEGACY_SCPI_CMD_GET_DVFS		= 0x0f,
+	LEGACY_SCPI_CMD_GET_DVFS_STAT		= 0x10,
+	LEGACY_SCPI_CMD_SET_RTC			= 0x11,
+	LEGACY_SCPI_CMD_GET_RTC			= 0x12,
+	LEGACY_SCPI_CMD_CLOCK_CAPABILITIES	= 0x13,
+	LEGACY_SCPI_CMD_SET_CLOCK_INDEX		= 0x14,
+	LEGACY_SCPI_CMD_SET_CLOCK_VALUE		= 0x15,
+	LEGACY_SCPI_CMD_GET_CLOCK_VALUE		= 0x16,
+	LEGACY_SCPI_CMD_PSU_CAPABILITIES	= 0x17,
+	LEGACY_SCPI_CMD_SET_PSU			= 0x18,
+	LEGACY_SCPI_CMD_GET_PSU			= 0x19,
+	LEGACY_SCPI_CMD_SENSOR_CAPABILITIES	= 0x1a,
+	LEGACY_SCPI_CMD_SENSOR_INFO		= 0x1b,
+	LEGACY_SCPI_CMD_SENSOR_VALUE		= 0x1c,
+	LEGACY_SCPI_CMD_SENSOR_CFG_PERIODIC	= 0x1d,
+	LEGACY_SCPI_CMD_SENSOR_CFG_BOUNDS	= 0x1e,
+	LEGACY_SCPI_CMD_SENSOR_ASYNC_VALUE	= 0x1f,
+	LEGACY_SCPI_CMD_COUNT
+};
+
 struct scpi_xfer {
 	u32 slot; /* has to be first element */
 	u32 cmd;
@@ -155,11 +196,13 @@ struct scpi_chan {
 	spinlock_t rx_lock; /* locking for the rx pending list */
 	struct mutex xfers_lock;
 	u8 token;
+	struct scpi_xfer *t;
 };
 
 struct scpi_drvinfo {
 	u32 protocol_version;
 	u32 firmware_version;
+	bool is_legacy;
 	int num_chans;
 	atomic_t next_chan;
 	struct scpi_ops *scpi_ops;
@@ -177,6 +220,11 @@ struct scpi_shared_mem {
 	u8 payload[0];
 } __packed;
 
+struct legacy_scpi_shared_mem {
+	__le32 status;
+	u8 payload[0];
+} __packed;
+
 struct scp_capabilities {
 	__le32 protocol_version;
 	__le32 event_version;
@@ -202,6 +250,12 @@ struct clk_set_value {
 	__le32 rate;
 } __packed;
 
+struct legacy_clk_set_value {
+	__le32 rate;
+	__le16 id;
+	__le16 reserved;
+} __packed;
+
 struct dvfs_info {
 	__le32 header;
 	struct {
@@ -302,6 +356,23 @@ static void scpi_handle_remote_msg(struct mbox_client *c, void *msg)
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
@@ -322,6 +393,43 @@ static void scpi_tx_prepare(struct mbox_client *c, void *msg)
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
+static int legacy_high_priority_cmds[] = {
+	LEGACY_SCPI_CMD_GET_CSS_PWR_STATE,
+	LEGACY_SCPI_CMD_CFG_PWR_STATE_STAT,
+	LEGACY_SCPI_CMD_GET_PWR_STATE_STAT,
+	LEGACY_SCPI_CMD_SET_DVFS,
+	LEGACY_SCPI_CMD_GET_DVFS,
+	LEGACY_SCPI_CMD_SET_RTC,
+	LEGACY_SCPI_CMD_GET_RTC,
+	LEGACY_SCPI_CMD_SET_CLOCK_INDEX,
+	LEGACY_SCPI_CMD_SET_CLOCK_VALUE,
+	LEGACY_SCPI_CMD_GET_CLOCK_VALUE,
+	LEGACY_SCPI_CMD_SET_PSU,
+	LEGACY_SCPI_CMD_GET_PSU,
+	LEGACY_SCPI_CMD_SENSOR_CFG_PERIODIC,
+	LEGACY_SCPI_CMD_SENSOR_CFG_BOUNDS,
+};
+
+static int legacy_scpi_get_chan(u8 cmd)
+{
+	int idx;
+
+	for (idx = 0; idx < ARRAY_SIZE(legacy_high_priority_cmds); idx++)
+		if (cmd == legacy_high_priority_cmds[idx])
+			return 1;
+
+	return 0;
+}
+
 static struct scpi_xfer *get_scpi_xfer(struct scpi_chan *ch)
 {
 	struct scpi_xfer *t;
@@ -352,15 +460,27 @@ static int scpi_send_message(u8 cmd, void *tx_buf, unsigned int tx_len,
 	struct scpi_xfer *msg;
 	struct scpi_chan *scpi_chan;
 
-	chan = atomic_inc_return(&scpi_info->next_chan) % scpi_info->num_chans;
+	if (scpi_info->is_legacy)
+		chan = legacy_scpi_get_chan(cmd);
+	else
+		chan = atomic_inc_return(&scpi_info->next_chan) %
+			scpi_info->num_chans;
 	scpi_chan = scpi_info->channels + chan;
 
 	msg = get_scpi_xfer(scpi_chan);
 	if (!msg)
 		return -ENOMEM;
 
-	msg->slot = BIT(SCPI_SLOT);
-	msg->cmd = PACK_SCPI_CMD(cmd, tx_len);
+	if (scpi_info->is_legacy) {
+		mutex_lock(&scpi_chan->xfers_lock);
+
+		scpi_chan->t = msg;
+		msg->cmd = PACK_LEGACY_SCPI_CMD(cmd, tx_len);
+		msg->slot = msg->cmd;
+	} else {
+		msg->slot = BIT(SCPI_SLOT);
+		msg->cmd = PACK_SCPI_CMD(cmd, tx_len);
+	}
 	msg->tx_buf = tx_buf;
 	msg->tx_len = tx_len;
 	msg->rx_buf = rx_buf;
@@ -368,7 +488,7 @@ static int scpi_send_message(u8 cmd, void *tx_buf, unsigned int tx_len,
 	init_completion(&msg->done);
 
 	ret = mbox_send_message(scpi_chan->chan, msg);
-	if (ret < 0 || !rx_buf)
+	if (ret < 0 || (!scpi_info->is_legacy && !rx_buf))
 		goto out;
 
 	if (!wait_for_completion_timeout(&msg->done, MAX_RX_TIMEOUT))
@@ -377,7 +497,10 @@ static int scpi_send_message(u8 cmd, void *tx_buf, unsigned int tx_len,
 		/* first status word */
 		ret = msg->status;
 out:
-	if (ret < 0 && rx_buf) /* remove entry from the list if timed-out */
+	if (scpi_info->is_legacy)
+		mutex_unlock(&scpi_chan->xfers_lock);
+	else if (ret < 0 && rx_buf)
+		/* remove entry from the list if timed-out */
 		scpi_process_cmd(scpi_chan, msg->cmd);
 
 	put_scpi_xfer(msg, scpi_chan);
@@ -725,8 +848,13 @@ static int scpi_probe(struct platform_device *pdev)
 		pchan->tx_payload = pchan->rx_payload + (size >> 1);
 
 		cl->dev = dev;
-		cl->rx_callback = scpi_handle_remote_msg;
-		cl->tx_prepare = scpi_tx_prepare;
+		if (scpi_info->is_legacy) {
+			cl->rx_callback = legacy_scpi_handle_remote_msg;
+			cl->tx_prepare = legacy_scpi_tx_prepare;
+		} else {
+			cl->rx_callback = scpi_handle_remote_msg;
+			cl->tx_prepare = scpi_tx_prepare;
+		}
 		cl->tx_block = true;
 		cl->tx_tout = 20;
 		cl->knows_txdone = false; /* controller can't ack */
-- 
1.9.1
