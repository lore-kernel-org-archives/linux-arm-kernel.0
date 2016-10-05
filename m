From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  5 Oct 2016 09:33:28 +0200
Subject: [PATCH v4 2/8] scpi: Add alternative legacy structures,
 functions and macros
In-Reply-To: <1475652814-30619-1-git-send-email-narmstrong@baylibre.com>
References: <1475652814-30619-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1475652814-30619-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the Legacy SCPI protocol in early JUNO versions and
shipped Amlogic ARMv8 based SoCs. Some Rockchip SoC are also known to use this
version of protocol with extended vendor commands
.
In order to support the legacy SCPI protocol variant, add back the structures
and macros that varies against the final specification.
Then add indirection table for legacy commands.
Finally Add bitmap field for channel selection since the Legacy protocol mandates to
send a selected subset of the commands on the high priority channel instead of the
low priority channel.

The message sending path differs from the final SCPI procotocol because the
Amlogic SCP firmware always reply 1 instead of a special value containing the command
byte and replied rx data length.
For this reason commands queuing cannot be used and we assume the reply command is
the head of the rx_pending list since we ensure sequential command sending with a
separate dedicated mutex.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/firmware/arm_scpi.c | 221 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 199 insertions(+), 22 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 498afa0..6244eb1 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -50,13 +50,20 @@
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
+#define CMD_LEGACY_SIZE(cmd)	(((cmd) >> CMD_LEGACY_DATA_SIZE_SHIFT) & \
+					CMD_LEGACY_DATA_SIZE_MASK)
 #define CMD_UNIQ_MASK	(CMD_TOKEN_ID_MASK << CMD_TOKEN_ID_SHIFT | CMD_ID_MASK)
 #define CMD_XTRACT_UNIQ(cmd)	((cmd) & CMD_UNIQ_MASK)
 
@@ -133,6 +140,61 @@ enum scpi_std_cmd {
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
@@ -165,6 +227,21 @@ enum scpi_drv_cmds {
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
@@ -187,14 +264,17 @@ struct scpi_chan {
 	struct scpi_xfer *xfers;
 	spinlock_t rx_lock; /* locking for the rx pending list */
 	struct mutex xfers_lock;
+	struct mutex legacy_lock;
 	u8 token;
 };
 
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
@@ -211,6 +291,11 @@ struct scpi_shared_mem {
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
@@ -236,6 +321,12 @@ struct clk_set_value {
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
@@ -307,21 +398,46 @@ static void scpi_process_cmd(struct scpi_chan *ch, u32 cmd)
 		return;
 	}
 
-	list_for_each_entry(t, &ch->rx_pending, node)
-		if (CMD_XTRACT_UNIQ(t->cmd) == CMD_XTRACT_UNIQ(cmd)) {
-			list_del(&t->node);
-			match = t;
-			break;
-		}
+	/* Command type is not replied by the SCP Firmware in legacy Mode
+	 * We should consider that command is the head of pending RX commands
+	 * if the list is not empty. In TX only mode, the list would be empty.
+	 */
+	if (scpi_info->is_legacy) {
+		match = list_first_entry(&ch->rx_pending, struct scpi_xfer,
+					 node);
+		list_del(&match->node);
+	} else {
+		list_for_each_entry(t, &ch->rx_pending, node)
+			if (CMD_XTRACT_UNIQ(t->cmd) == CMD_XTRACT_UNIQ(cmd)) {
+				list_del(&t->node);
+				match = t;
+				break;
+			}
+	}
 	/* check if wait_for_completion is in progress or timed-out */
 	if (match && !completion_done(&match->done)) {
-		struct scpi_shared_mem *mem = ch->rx_payload;
-		unsigned int len = min(match->rx_len, CMD_SIZE(cmd));
+		unsigned int len;
+
+		if (scpi_info->is_legacy) {
+			struct legacy_scpi_shared_mem *mem = ch->rx_payload;
+
+			/* RX Length is not replied by the lagcy Firmware */
+			len = match->rx_len;
+
+			match->status = le32_to_cpu(mem->status);
+			memcpy_fromio(match->rx_buf, mem->payload, len);
+		} else {
+			struct scpi_shared_mem *mem = ch->rx_payload;
+
+			len = min(match->rx_len, CMD_SIZE(cmd));
+
+			match->status = le32_to_cpu(mem->status);
+			memcpy_fromio(match->rx_buf, mem->payload, len);
+		}
 
-		match->status = le32_to_cpu(mem->status);
-		memcpy_fromio(match->rx_buf, mem->payload, len);
 		if (match->rx_len > len)
 			memset(match->rx_buf + len, 0, match->rx_len - len);
+
 		complete(&match->done);
 	}
 	spin_unlock_irqrestore(&ch->rx_lock, flags);
@@ -331,7 +447,12 @@ static void scpi_handle_remote_msg(struct mbox_client *c, void *msg)
 {
 	struct scpi_chan *ch = container_of(c, struct scpi_chan, cl);
 	struct scpi_shared_mem *mem = ch->rx_payload;
-	u32 cmd = le32_to_cpu(mem->command);
+	u32 cmd;
+
+	if (scpi_info->is_legacy)
+		cmd = *(u32 *)msg;
+	else
+		cmd = le32_to_cpu(mem->command);
 
 	scpi_process_cmd(ch, cmd);
 }
@@ -343,17 +464,26 @@ static void scpi_tx_prepare(struct mbox_client *c, void *msg)
 	struct scpi_chan *ch = container_of(c, struct scpi_chan, cl);
 	struct scpi_shared_mem *mem = (struct scpi_shared_mem *)ch->tx_payload;
 
-	if (t->tx_buf)
-		memcpy_toio(mem->payload, t->tx_buf, t->tx_len);
+	if (t->tx_buf) {
+		if (scpi_info->is_legacy)
+			memcpy_toio(ch->tx_payload, t->tx_buf, t->tx_len);
+		else
+			memcpy_toio(mem->payload, t->tx_buf, t->tx_len);
+	}
+
 	if (t->rx_buf) {
 		if (!(++ch->token))
 			++ch->token;
 		ADD_SCPI_TOKEN(t->cmd, ch->token);
+		if (scpi_info->is_legacy)
+			t->slot = t->cmd;
 		spin_lock_irqsave(&ch->rx_lock, flags);
 		list_add_tail(&t->node, &ch->rx_pending);
 		spin_unlock_irqrestore(&ch->rx_lock, flags);
 	}
-	mem->command = cpu_to_le32(t->cmd);
+
+	if (!scpi_info->is_legacy)
+		mem->command = cpu_to_le32(t->cmd);
 }
 
 static struct scpi_xfer *get_scpi_xfer(struct scpi_chan *ch)
@@ -396,21 +526,37 @@ static int scpi_send_message(unsigned int offset, void *tx_buf,
 
 	cmd = scpi_info->scpi_cmds[offset];
 
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
+		msg->cmd = PACK_LEGACY_SCPI_CMD(cmd, tx_len);
+		msg->slot = msg->cmd;
+	} else {
+		msg->slot = BIT(SCPI_SLOT);
+		msg->cmd = PACK_SCPI_CMD(cmd, tx_len);
+	}
 	msg->tx_buf = tx_buf;
 	msg->tx_len = tx_len;
 	msg->rx_buf = rx_buf;
 	msg->rx_len = rx_len;
 	init_completion(&msg->done);
 
+	/* Since we cannot distinguish the original command in the
+	 * MHU reply stat value from a Legacy SCP firmware, ensure
+	 * sequential command sending to the firmware.
+	 */
+	if (scpi_info->is_legacy)
+		mutex_lock(&scpi_chan->legacy_lock);
+
 	ret = mbox_send_message(scpi_chan->chan, msg);
 	if (ret < 0 || !rx_buf)
 		goto out;
@@ -421,9 +567,13 @@ static int scpi_send_message(unsigned int offset, void *tx_buf,
 		/* first status word */
 		ret = msg->status;
 out:
-	if (ret < 0 && rx_buf) /* remove entry from the list if timed-out */
+	if (ret < 0 && rx_buf)
+		/* remove entry from the list if timed-out */
 		scpi_process_cmd(scpi_chan, msg->cmd);
 
+	if (scpi_info->is_legacy)
+		mutex_unlock(&scpi_chan->legacy_lock);
+
 	put_scpi_xfer(msg, scpi_chan);
 	/* SCPI error codes > 0, translate them to Linux scale*/
 	return ret > 0 ? scpi_to_linux_errno(ret) : ret;
@@ -474,6 +624,18 @@ static int scpi_clk_set_val(u16 clk_id, unsigned long rate)
 				 &stat, sizeof(stat));
 }
 
+static int legacy_scpi_clk_set_val(u16 clk_id, unsigned long rate)
+{
+	int stat;
+	struct legacy_clk_set_value clk = {
+		.id = cpu_to_le16(clk_id),
+		.rate = cpu_to_le32(rate)
+	};
+
+	return scpi_send_message(CMD_SET_CLOCK_VALUE, &clk, sizeof(clk),
+				 &stat, sizeof(stat));
+}
+
 static int scpi_dvfs_get_idx(u8 domain)
 {
 	int ret;
@@ -525,7 +687,6 @@ static struct scpi_dvfs_info *scpi_dvfs_get_info(u8 domain)
 
 	info->count = DVFS_OPP_COUNT(buf.header);
 	info->latency = DVFS_LATENCY(buf.header) * 1000; /* uS to nS */
-
 	info->opps = kcalloc(info->count, sizeof(*opp), GFP_KERNEL);
 	if (!info->opps) {
 		kfree(info);
@@ -580,9 +741,13 @@ static int scpi_sensor_get_value(u16 sensor, u64 *val)
 
 	ret = scpi_send_message(CMD_SENSOR_VALUE, &id, sizeof(id),
 				&buf, sizeof(buf));
-	if (!ret)
-		*val = (u64)le32_to_cpu(buf.hi_val) << 32 |
-			le32_to_cpu(buf.lo_val);
+	if (!ret) {
+		if (scpi_info->is_legacy)
+			*val = (u64)le32_to_cpu(buf.lo_val);
+		else
+			*val = (u64)le32_to_cpu(buf.hi_val) << 32 |
+				le32_to_cpu(buf.lo_val);
+	}
 
 	return ret;
 }
@@ -781,6 +946,7 @@ static int scpi_probe(struct platform_device *pdev)
 		INIT_LIST_HEAD(&pchan->xfers_list);
 		spin_lock_init(&pchan->rx_lock);
 		mutex_init(&pchan->xfers_lock);
+		mutex_init(&pchan->legacy_lock);
 
 		ret = scpi_alloc_xfer_list(dev, pchan);
 		if (!ret) {
@@ -804,6 +970,17 @@ static int scpi_probe(struct platform_device *pdev)
 
 	scpi_info->scpi_cmds = scpi_std_commands;
 
+	if (scpi_info->is_legacy) {
+		/* Replace with legacy variants */
+		scpi_ops.clk_set_val = legacy_scpi_clk_set_val;
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
