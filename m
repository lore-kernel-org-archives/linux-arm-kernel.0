From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  7 Sep 2016 17:34:31 +0200
Subject: [PATCH v3 2/8] scpi: Add alternative legacy structures,
 functions and macros
In-Reply-To: <1473262477-18045-1-git-send-email-narmstrong@baylibre.com>
References: <1473262477-18045-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1473262477-18045-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support the legacy SCPI protocol variant, add back the structures
and macros that varies against the final specification.
Add indirection table for legacy commands.
Add bitmap field for channel selection
Add support for legacy in scpi_send_message.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/firmware/arm_scpi.c | 218 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 211 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 9a87687..9ba1020 100644
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
@@ -133,6 +138,61 @@ enum scpi_std_cmd {
 	SCPI_CMD_COUNT
 };
 
+/* SCPI Legacy Commands */
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
+/* List all commands that are required to go through the high priority link */
+static int legacy_hpriority_cmds[] = {
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
 /* List all commands used by this driver, used as indexes */
 enum scpi_drv_cmds {
 	CMD_SCPI_CAPABILITIES = 0,
@@ -165,6 +225,21 @@ static int scpi_std_commands[CMD_MAX_COUNT] = {
 	SCPI_CMD_GET_DEVICE_PWR_STATE,
 };
 
+static int scpi_legacy_commands[CMD_MAX_COUNT] = {
+	LEGACY_SCPI_CMD_SCPI_CAPABILITIES,
+	-1, /* GET_CLOCK_INFO */
+	LEGACY_SCPI_CMD_GET_CLOCK_VALUE,
+	LEGACY_SCPI_CMD_SET_CLOCK_VALUE,
+	LEGACY_SCPI_CMD_GET_DVFS,
+	LEGACY_SCPI_CMD_SET_DVFS,
+	LEGACY_SCPI_CMD_GET_DVFS_INFO,
+	LEGACY_SCPI_CMD_SENSOR_CAPABILITIES,
+	LEGACY_SCPI_CMD_SENSOR_INFO,
+	LEGACY_SCPI_CMD_SENSOR_VALUE,
+	-1, /* SET_DEVICE_PWR_STATE */
+	-1, /* GET_DEVICE_PWR_STATE */
+};
+
 struct scpi_xfer {
 	u32 slot; /* has to be first element */
 	u32 cmd;
@@ -193,8 +268,10 @@ struct scpi_chan {
 struct scpi_drvinfo {
 	u32 protocol_version;
 	u32 firmware_version;
+	bool is_legacy;
 	int num_chans;
 	int *scpi_cmds;
+	DECLARE_BITMAP(cmd_priority, LEGACY_SCPI_CMD_COUNT);
 	atomic_t next_chan;
 	struct scpi_ops *scpi_ops;
 	struct scpi_chan *channels;
@@ -211,6 +288,11 @@ struct scpi_shared_mem {
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
@@ -236,6 +318,12 @@ struct clk_set_value {
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
@@ -336,6 +424,39 @@ static void scpi_handle_remote_msg(struct mbox_client *c, void *msg)
 	scpi_process_cmd(ch, cmd);
 }
 
+static void legacy_scpi_process_cmd(struct scpi_chan *ch)
+{
+	unsigned long flags;
+	struct scpi_xfer *t;
+
+	spin_lock_irqsave(&ch->rx_lock, flags);
+	if (list_empty(&ch->rx_pending)) {
+		spin_unlock_irqrestore(&ch->rx_lock, flags);
+		return;
+	}
+
+	t = list_first_entry(&ch->rx_pending, struct scpi_xfer, node);
+	list_del(&t->node);
+
+	/* check if wait_for_completion is in progress or timed-out */
+	if (t && !completion_done(&t->done)) {
+		struct legacy_scpi_shared_mem *mem = ch->rx_payload;
+		unsigned int len = t->rx_len;
+
+		t->status = le32_to_cpu(mem->status);
+		memcpy_fromio(t->rx_buf, mem->payload, len);
+		complete(&t->done);
+	}
+	spin_unlock_irqrestore(&ch->rx_lock, flags);
+}
+
+static void legacy_scpi_handle_remote_msg(struct mbox_client *c, void *_msg)
+{
+	struct scpi_chan *ch = container_of(c, struct scpi_chan, cl);
+
+	legacy_scpi_process_cmd(ch);
+}
+
 static void scpi_tx_prepare(struct mbox_client *c, void *msg)
 {
 	unsigned long flags;
@@ -356,6 +477,21 @@ static void scpi_tx_prepare(struct mbox_client *c, void *msg)
 	mem->command = cpu_to_le32(t->cmd);
 }
 
+static void legacy_scpi_tx_prepare(struct mbox_client *c, void *msg)
+{
+	unsigned long flags;
+	struct scpi_xfer *t = msg;
+	struct scpi_chan *ch = container_of(c, struct scpi_chan, cl);
+
+	if (t->tx_buf)
+		memcpy_toio(ch->tx_payload, t->tx_buf, t->tx_len);
+	if (t->rx_buf) {
+		spin_lock_irqsave(&ch->rx_lock, flags);
+		list_add_tail(&t->node, &ch->rx_pending);
+		spin_unlock_irqrestore(&ch->rx_lock, flags);
+	}
+}
+
 static struct scpi_xfer *get_scpi_xfer(struct scpi_chan *ch)
 {
 	struct scpi_xfer *t;
@@ -386,15 +522,25 @@ static int scpi_send_message(u8 cmd, void *tx_buf, unsigned int tx_len,
 	struct scpi_xfer *msg;
 	struct scpi_chan *scpi_chan;
 
-	chan = atomic_inc_return(&scpi_info->next_chan) % scpi_info->num_chans;
+	if (scpi_info->is_legacy)
+		chan = test_bit(cmd, scpi_info->cmd_priority) ? 1 : 0;
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
+		msg->cmd = PACK_LEGACY_SCPI_CMD(cmd, tx_len);
+		msg->slot = msg->cmd;
+	} else {
+		msg->slot = BIT(SCPI_SLOT);
+		msg->cmd = PACK_SCPI_CMD(cmd, tx_len);
+	}
 	msg->tx_buf = tx_buf;
 	msg->tx_len = tx_len;
 	msg->rx_buf = rx_buf;
@@ -402,7 +548,7 @@ static int scpi_send_message(u8 cmd, void *tx_buf, unsigned int tx_len,
 	init_completion(&msg->done);
 
 	ret = mbox_send_message(scpi_chan->chan, msg);
-	if (ret < 0 || !rx_buf)
+	if (ret < 0 || (!scpi_info->is_legacy && !rx_buf))
 		goto out;
 
 	if (!wait_for_completion_timeout(&msg->done, MAX_RX_TIMEOUT))
@@ -411,7 +557,12 @@ static int scpi_send_message(u8 cmd, void *tx_buf, unsigned int tx_len,
 		/* first status word */
 		ret = msg->status;
 out:
-	if (ret < 0 && rx_buf) /* remove entry from the list if timed-out */
+	if (scpi_info->is_legacy) {
+		if (ret < 0)
+			legacy_scpi_process_cmd(scpi_chan);
+		mutex_unlock(&scpi_chan->xfers_lock);
+	} else if (ret < 0 && rx_buf)
+		/* remove entry from the list if timed-out */
 		scpi_process_cmd(scpi_chan, msg->cmd);
 
 	put_scpi_xfer(msg, scpi_chan);
@@ -493,6 +644,24 @@ static int scpi_clk_set_val(u16 clk_id, unsigned long rate)
 				 &stat, sizeof(stat));
 }
 
+static int legacy_scpi_clk_set_val(u16 clk_id, unsigned long rate)
+{
+	int ret;
+	int stat;
+	struct legacy_clk_set_value clk = {
+		.id = cpu_to_le16(clk_id),
+		.rate = cpu_to_le32(rate)
+	};
+
+	ret = check_cmd(CMD_SET_CLOCK_VALUE);
+	if (ret)
+		return ret;
+
+	return scpi_send_message(scpi_info->scpi_cmds[CMD_SET_CLOCK_VALUE],
+				 &clk, sizeof(clk),
+				 &stat, sizeof(stat));
+}
+
 static int scpi_dvfs_get_idx(u8 domain)
 {
 	int ret;
@@ -635,6 +804,24 @@ static int scpi_sensor_get_value(u16 sensor, u64 *val)
 	return ret;
 }
 
+static int legacy_scpi_sensor_get_value(u16 sensor, u64 *val)
+{
+	__le16 id = cpu_to_le16(sensor);
+	struct sensor_value buf;
+	int ret;
+
+	ret = check_cmd(CMD_SENSOR_VALUE);
+	if (ret)
+		return ret;
+
+	ret = scpi_send_message(scpi_info->scpi_cmds[CMD_SENSOR_VALUE],
+				&id, sizeof(id), &buf, sizeof(buf));
+	if (!ret)
+		*val = (u64)le32_to_cpu(buf.lo_val);
+
+	return ret;
+}
+
 static int scpi_device_get_power_state(u16 dev_id)
 {
 	int ret;
@@ -832,8 +1019,13 @@ static int scpi_probe(struct platform_device *pdev)
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
@@ -865,6 +1057,18 @@ err:
 
 	scpi_info->scpi_cmds = scpi_std_commands;
 
+	if (scpi_info->is_legacy) {
+		/* Replace with legacy variants */
+		scpi_ops.clk_set_val = legacy_scpi_clk_set_val;
+		scpi_ops.sensor_get_value = legacy_scpi_sensor_get_value;
+		scpi_info->scpi_cmds = scpi_legacy_commands;
+
+		/* Fill priority bitmap */
+		for (idx = 0; idx < ARRAY_SIZE(legacy_hpriority_cmds); idx++)
+			set_bit(legacy_hpriority_cmds[idx],
+				scpi_info->cmd_priority);
+	}
+
 	ret = scpi_init_versions(scpi_info);
 	if (ret) {
 		dev_err(dev, "incorrect or no SCP firmware found\n");
-- 
1.9.1
