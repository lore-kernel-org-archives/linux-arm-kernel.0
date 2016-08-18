From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 18 Aug 2016 12:10:55 +0200
Subject: [PATCH 02/13] scpi: Add alternative legacy structures and macros
In-Reply-To: <1471515066-3626-1-git-send-email-narmstrong@baylibre.com>
References: <1471515066-3626-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1471515066-3626-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support the legacy SCPI protocol variant, add back the structures
and macros that varies against the final specification.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
I checked against Amlogic implementation documentation and on-device, the channel selection
via legacy_scpi_get_chan() is needed and fails without it.
The sender_id is not needed so it was dropped.

 drivers/firmware/arm_scpi.c | 84 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 403783a..0bb6134 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -52,6 +52,8 @@
 #define CMD_TOKEN_ID_MASK	0xff
 #define CMD_DATA_SIZE_SHIFT	16
 #define CMD_DATA_SIZE_MASK	0x1ff
+#define CMD_LEGACY_DATA_SIZE_SHIFT	20
+#define CMD_LEGACY_DATA_SIZE_MASK	0x1ff
 #define PACK_SCPI_CMD(cmd_id, tx_sz)			\
 	((((cmd_id) & CMD_ID_MASK) << CMD_ID_SHIFT) |	\
 	(((tx_sz) & CMD_DATA_SIZE_MASK) << CMD_DATA_SIZE_SHIFT))
@@ -61,6 +63,9 @@
 	(((tx_sz) & CMD_DATA_SIZE_MASK) << CMD_DATA_SIZE_SHIFT))
 #define ADD_SCPI_TOKEN(cmd, token)			\
 	((cmd) |= (((token) & CMD_TOKEN_ID_MASK) << CMD_TOKEN_ID_SHIFT))
+#define PACK_LEGACY_SCPI_CMD(cmd_id, tx_sz)				\
+	((((cmd_id) & CMD_ID_MASK) << CMD_ID_SHIFT) |			       \
+	(((tx_sz) & CMD_LEGACY_DATA_SIZE_MASK) << CMD_LEGACY_DATA_SIZE_SHIFT))
 
 #define CMD_SIZE(cmd)	(((cmd) >> CMD_DATA_SIZE_SHIFT) & CMD_DATA_SIZE_MASK)
 #define CMD_UNIQ_MASK	(CMD_TOKEN_ID_MASK << CMD_TOKEN_ID_SHIFT | CMD_ID_MASK)
@@ -138,6 +143,42 @@ enum scpi_std_cmd {
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
@@ -183,6 +224,11 @@ struct scpi_shared_mem {
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
@@ -208,6 +254,12 @@ struct clk_set_value {
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
@@ -237,6 +289,10 @@ struct sensor_value {
 	__le32 hi_val;
 } __packed;
 
+struct legacy_sensor_value {
+	__le32 val;
+} __packed;
+
 struct dev_pstate_set {
 	u16 dev_id;
 	u8 pstate;
@@ -328,6 +384,34 @@ static void scpi_tx_prepare(struct mbox_client *c, void *msg)
 	mem->command = cpu_to_le32(t->cmd);
 }
 
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
-- 
1.9.1
