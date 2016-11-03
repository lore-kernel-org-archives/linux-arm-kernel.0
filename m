From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed,  2 Nov 2016 22:52:04 -0600
Subject: [PATCH v5 1/8] firmware: arm_scpi: add command indirection to support
 legacy commands
In-Reply-To: <1478148731-11712-1-git-send-email-sudeep.holla@arm.com>
References: <1478148731-11712-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1478148731-11712-2-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the legacy SCPI and the SCPI v1.0 differ in the command values,
it's better to create some sort of command indirection in the driver
to avoid repeated version check at multiple places.

This patch adds the indirection command table to allow different values
of the command across SCPI versions.

[narmstrong at baylibre.com: added cmd check in scpi_send_message]
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scpi.c | 71 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 57 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index ce2bc2a38101..9e9b022450eb 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -99,6 +99,7 @@ enum scpi_error_codes {
 	SCPI_ERR_MAX
 };
 
+/* SCPI Standard commands */
 enum scpi_std_cmd {
 	SCPI_CMD_INVALID		= 0x00,
 	SCPI_CMD_SCPI_READY		= 0x01,
@@ -132,6 +133,38 @@ enum scpi_std_cmd {
 	SCPI_CMD_COUNT
 };
 
+/* List of all commands used by this driver, used as indices */
+enum scpi_drv_cmds {
+	CMD_SCPI_CAPABILITIES = 0,
+	CMD_GET_CLOCK_INFO,
+	CMD_GET_CLOCK_VALUE,
+	CMD_SET_CLOCK_VALUE,
+	CMD_GET_DVFS,
+	CMD_SET_DVFS,
+	CMD_GET_DVFS_INFO,
+	CMD_SENSOR_CAPABILITIES,
+	CMD_SENSOR_INFO,
+	CMD_SENSOR_VALUE,
+	CMD_SET_DEVICE_PWR_STATE,
+	CMD_GET_DEVICE_PWR_STATE,
+	CMD_MAX_COUNT,
+};
+
+static int scpi_std_commands[CMD_MAX_COUNT] = {
+	SCPI_CMD_SCPI_CAPABILITIES,
+	SCPI_CMD_GET_CLOCK_INFO,
+	SCPI_CMD_GET_CLOCK_VALUE,
+	SCPI_CMD_SET_CLOCK_VALUE,
+	SCPI_CMD_GET_DVFS,
+	SCPI_CMD_SET_DVFS,
+	SCPI_CMD_GET_DVFS_INFO,
+	SCPI_CMD_SENSOR_CAPABILITIES,
+	SCPI_CMD_SENSOR_INFO,
+	SCPI_CMD_SENSOR_VALUE,
+	SCPI_CMD_SET_DEVICE_PWR_STATE,
+	SCPI_CMD_GET_DEVICE_PWR_STATE,
+};
+
 struct scpi_xfer {
 	u32 slot; /* has to be first element */
 	u32 cmd;
@@ -161,6 +194,7 @@ struct scpi_drvinfo {
 	u32 protocol_version;
 	u32 firmware_version;
 	int num_chans;
+	int *commands;
 	atomic_t next_chan;
 	struct scpi_ops *scpi_ops;
 	struct scpi_chan *channels;
@@ -344,14 +378,20 @@ static void put_scpi_xfer(struct scpi_xfer *t, struct scpi_chan *ch)
 	mutex_unlock(&ch->xfers_lock);
 }
 
-static int scpi_send_message(u8 cmd, void *tx_buf, unsigned int tx_len,
+static int scpi_send_message(u8 idx, void *tx_buf, unsigned int tx_len,
 			     void *rx_buf, unsigned int rx_len)
 {
 	int ret;
 	u8 chan;
+	u8 cmd;
 	struct scpi_xfer *msg;
 	struct scpi_chan *scpi_chan;
 
+	if (scpi_info->commands[idx] < 0)
+		return -EOPNOTSUPP;
+
+	cmd = scpi_info->commands[idx];
+
 	chan = atomic_inc_return(&scpi_info->next_chan) % scpi_info->num_chans;
 	scpi_chan = scpi_info->channels + chan;
 
@@ -397,7 +437,7 @@ static u32 scpi_get_version(void)
 	struct clk_get_info clk;
 	__le16 le_clk_id = cpu_to_le16(clk_id);
 
-	ret = scpi_send_message(SCPI_CMD_GET_CLOCK_INFO, &le_clk_id,
+	ret = scpi_send_message(CMD_GET_CLOCK_INFO, &le_clk_id,
 				sizeof(le_clk_id), &clk, sizeof(clk));
 	if (!ret) {
 		*min = le32_to_cpu(clk.min_rate);
@@ -412,8 +452,9 @@ static unsigned long scpi_clk_get_val(u16 clk_id)
 	struct clk_get_value clk;
 	__le16 le_clk_id = cpu_to_le16(clk_id);
 
-	ret = scpi_send_message(SCPI_CMD_GET_CLOCK_VALUE, &le_clk_id,
+	ret = scpi_send_message(CMD_GET_CLOCK_VALUE, &le_clk_id,
 				sizeof(le_clk_id), &clk, sizeof(clk));
+
 	return ret ? ret : le32_to_cpu(clk.rate);
 }
 
@@ -425,7 +466,7 @@ static int scpi_clk_set_val(u16 clk_id, unsigned long rate)
 		.rate = cpu_to_le32(rate)
 	};
 
-	return scpi_send_message(SCPI_CMD_SET_CLOCK_VALUE, &clk, sizeof(clk),
+	return scpi_send_message(CMD_SET_CLOCK_VALUE, &clk, sizeof(clk),
 				 &stat, sizeof(stat));
 }
 
@@ -434,8 +475,9 @@ static int scpi_dvfs_get_idx(u8 domain)
 	int ret;
 	u8 dvfs_idx;
 
-	ret = scpi_send_message(SCPI_CMD_GET_DVFS, &domain, sizeof(domain),
+	ret = scpi_send_message(CMD_GET_DVFS, &domain, sizeof(domain),
 				&dvfs_idx, sizeof(dvfs_idx));
+
 	return ret ? ret : dvfs_idx;
 }
 
@@ -444,7 +486,7 @@ static int scpi_dvfs_set_idx(u8 domain, u8 index)
 	int stat;
 	struct dvfs_set dvfs = {domain, index};
 
-	return scpi_send_message(SCPI_CMD_SET_DVFS, &dvfs, sizeof(dvfs),
+	return scpi_send_message(CMD_SET_DVFS, &dvfs, sizeof(dvfs),
 				 &stat, sizeof(stat));
 }
 
@@ -468,9 +510,8 @@ static struct scpi_dvfs_info *scpi_dvfs_get_info(u8 domain)
 	if (scpi_info->dvfs[domain])	/* data already populated */
 		return scpi_info->dvfs[domain];
 
-	ret = scpi_send_message(SCPI_CMD_GET_DVFS_INFO, &domain, sizeof(domain),
+	ret = scpi_send_message(CMD_GET_DVFS_INFO, &domain, sizeof(domain),
 				&buf, sizeof(buf));
-
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -503,7 +544,7 @@ static int scpi_sensor_get_capability(u16 *sensors)
 	struct sensor_capabilities cap_buf;
 	int ret;
 
-	ret = scpi_send_message(SCPI_CMD_SENSOR_CAPABILITIES, NULL, 0, &cap_buf,
+	ret = scpi_send_message(CMD_SENSOR_CAPABILITIES, NULL, 0, &cap_buf,
 				sizeof(cap_buf));
 	if (!ret)
 		*sensors = le16_to_cpu(cap_buf.sensors);
@@ -517,7 +558,7 @@ static int scpi_sensor_get_info(u16 sensor_id, struct scpi_sensor_info *info)
 	struct _scpi_sensor_info _info;
 	int ret;
 
-	ret = scpi_send_message(SCPI_CMD_SENSOR_INFO, &id, sizeof(id),
+	ret = scpi_send_message(CMD_SENSOR_INFO, &id, sizeof(id),
 				&_info, sizeof(_info));
 	if (!ret) {
 		memcpy(info, &_info, sizeof(*info));
@@ -533,7 +574,7 @@ static int scpi_sensor_get_value(u16 sensor, u64 *val)
 	struct sensor_value buf;
 	int ret;
 
-	ret = scpi_send_message(SCPI_CMD_SENSOR_VALUE, &id, sizeof(id),
+	ret = scpi_send_message(CMD_SENSOR_VALUE, &id, sizeof(id),
 				&buf, sizeof(buf));
 	if (!ret)
 		*val = (u64)le32_to_cpu(buf.hi_val) << 32 |
@@ -548,7 +589,7 @@ static int scpi_device_get_power_state(u16 dev_id)
 	u8 pstate;
 	__le16 id = cpu_to_le16(dev_id);
 
-	ret = scpi_send_message(SCPI_CMD_GET_DEVICE_PWR_STATE, &id,
+	ret = scpi_send_message(CMD_GET_DEVICE_PWR_STATE, &id,
 				sizeof(id), &pstate, sizeof(pstate));
 	return ret ? ret : pstate;
 }
@@ -561,7 +602,7 @@ static int scpi_device_set_power_state(u16 dev_id, u8 pstate)
 		.pstate = pstate,
 	};
 
-	return scpi_send_message(SCPI_CMD_SET_DEVICE_PWR_STATE, &dev_set,
+	return scpi_send_message(CMD_SET_DEVICE_PWR_STATE, &dev_set,
 				 sizeof(dev_set), &stat, sizeof(stat));
 }
 
@@ -591,7 +632,7 @@ static int scpi_init_versions(struct scpi_drvinfo *info)
 	int ret;
 	struct scp_capabilities caps;
 
-	ret = scpi_send_message(SCPI_CMD_SCPI_CAPABILITIES, NULL, 0,
+	ret = scpi_send_message(CMD_SCPI_CAPABILITIES, NULL, 0,
 				&caps, sizeof(caps));
 	if (!ret) {
 		info->protocol_version = le32_to_cpu(caps.protocol_version);
@@ -755,6 +796,8 @@ static int scpi_probe(struct platform_device *pdev)
 
 	scpi_info->channels = scpi_chan;
 	scpi_info->num_chans = count;
+	scpi_info->commands = scpi_std_commands;
+
 	platform_set_drvdata(pdev, scpi_info);
 
 	ret = scpi_init_versions(scpi_info);
-- 
1.9.1
