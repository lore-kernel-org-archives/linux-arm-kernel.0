From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  7 Sep 2016 17:34:30 +0200
Subject: [PATCH v3 1/8] scpi: Add cmd indirection table to prepare for legacy
 commands
In-Reply-To: <1473262477-18045-1-git-send-email-narmstrong@baylibre.com>
References: <1473262477-18045-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1473262477-18045-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add indirection table to permit multiple command values for legacy support.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/firmware/arm_scpi.c | 145 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 127 insertions(+), 18 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 4388937..9a87687 100644
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
 
+/* List all commands used by this driver, used as indexes */
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
+	int *scpi_cmds;
 	atomic_t next_chan;
 	struct scpi_ops *scpi_ops;
 	struct scpi_chan *channels;
@@ -390,6 +424,19 @@ static u32 scpi_get_version(void)
 	return scpi_info->protocol_version;
 }
 
+static inline int check_cmd(unsigned int offset)
+{
+	if (offset >= CMD_MAX_COUNT ||
+	    !scpi_info ||
+	    !scpi_info->scpi_cmds)
+		return -EINVAL;
+
+	if (scpi_info->scpi_cmds[offset] < 0)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 static int
 scpi_clk_get_range(u16 clk_id, unsigned long *min, unsigned long *max)
 {
@@ -397,8 +444,13 @@ scpi_clk_get_range(u16 clk_id, unsigned long *min, unsigned long *max)
 	struct clk_get_info clk;
 	__le16 le_clk_id = cpu_to_le16(clk_id);
 
-	ret = scpi_send_message(SCPI_CMD_GET_CLOCK_INFO, &le_clk_id,
-				sizeof(le_clk_id), &clk, sizeof(clk));
+	ret = check_cmd(CMD_GET_CLOCK_INFO);
+	if (ret)
+		return ret;
+
+	ret = scpi_send_message(scpi_info->scpi_cmds[CMD_GET_CLOCK_INFO],
+				&le_clk_id, sizeof(le_clk_id),
+				&clk, sizeof(clk));
 	if (!ret) {
 		*min = le32_to_cpu(clk.min_rate);
 		*max = le32_to_cpu(clk.max_rate);
@@ -412,20 +464,32 @@ static unsigned long scpi_clk_get_val(u16 clk_id)
 	struct clk_get_value clk;
 	__le16 le_clk_id = cpu_to_le16(clk_id);
 
-	ret = scpi_send_message(SCPI_CMD_GET_CLOCK_VALUE, &le_clk_id,
-				sizeof(le_clk_id), &clk, sizeof(clk));
+	ret = check_cmd(CMD_GET_CLOCK_VALUE);
+	if (ret)
+		return ret;
+
+	ret = scpi_send_message(scpi_info->scpi_cmds[CMD_GET_CLOCK_VALUE],
+				&le_clk_id, sizeof(le_clk_id),
+				&clk, sizeof(clk));
+
 	return ret ? ret : le32_to_cpu(clk.rate);
 }
 
 static int scpi_clk_set_val(u16 clk_id, unsigned long rate)
 {
+	int ret;
 	int stat;
 	struct clk_set_value clk = {
 		.id = cpu_to_le16(clk_id),
 		.rate = cpu_to_le32(rate)
 	};
 
-	return scpi_send_message(SCPI_CMD_SET_CLOCK_VALUE, &clk, sizeof(clk),
+	ret = check_cmd(CMD_SET_CLOCK_VALUE);
+	if (ret)
+		return ret;
+
+	return scpi_send_message(scpi_info->scpi_cmds[CMD_SET_CLOCK_VALUE],
+				 &clk, sizeof(clk),
 				 &stat, sizeof(stat));
 }
 
@@ -434,17 +498,29 @@ static int scpi_dvfs_get_idx(u8 domain)
 	int ret;
 	u8 dvfs_idx;
 
-	ret = scpi_send_message(SCPI_CMD_GET_DVFS, &domain, sizeof(domain),
+	ret = check_cmd(CMD_GET_DVFS);
+	if (ret)
+		return ret;
+
+	ret = scpi_send_message(scpi_info->scpi_cmds[CMD_GET_DVFS],
+				&domain, sizeof(domain),
 				&dvfs_idx, sizeof(dvfs_idx));
+
 	return ret ? ret : dvfs_idx;
 }
 
 static int scpi_dvfs_set_idx(u8 domain, u8 index)
 {
+	int ret;
 	int stat;
 	struct dvfs_set dvfs = {domain, index};
 
-	return scpi_send_message(SCPI_CMD_SET_DVFS, &dvfs, sizeof(dvfs),
+	ret = check_cmd(CMD_SET_DVFS);
+	if (ret)
+		return ret;
+
+	return scpi_send_message(scpi_info->scpi_cmds[CMD_SET_DVFS],
+				 &dvfs, sizeof(dvfs),
 				 &stat, sizeof(stat));
 }
 
@@ -468,9 +544,13 @@ static struct scpi_dvfs_info *scpi_dvfs_get_info(u8 domain)
 	if (scpi_info->dvfs[domain])	/* data already populated */
 		return scpi_info->dvfs[domain];
 
-	ret = scpi_send_message(SCPI_CMD_GET_DVFS_INFO, &domain, sizeof(domain),
-				&buf, sizeof(buf));
+	ret = check_cmd(CMD_GET_DVFS_INFO);
+	if (ret)
+		return ERR_PTR(ret);
 
+	ret = scpi_send_message(scpi_info->scpi_cmds[CMD_GET_DVFS_INFO],
+				&domain, sizeof(domain),
+				&buf, sizeof(buf));
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -503,8 +583,12 @@ static int scpi_sensor_get_capability(u16 *sensors)
 	struct sensor_capabilities cap_buf;
 	int ret;
 
-	ret = scpi_send_message(SCPI_CMD_SENSOR_CAPABILITIES, NULL, 0, &cap_buf,
-				sizeof(cap_buf));
+	ret = check_cmd(CMD_SENSOR_CAPABILITIES);
+	if (ret)
+		return ret;
+
+	ret = scpi_send_message(scpi_info->scpi_cmds[CMD_SENSOR_CAPABILITIES],
+				NULL, 0, &cap_buf, sizeof(cap_buf));
 	if (!ret)
 		*sensors = le16_to_cpu(cap_buf.sensors);
 
@@ -517,7 +601,12 @@ static int scpi_sensor_get_info(u16 sensor_id, struct scpi_sensor_info *info)
 	struct _scpi_sensor_info _info;
 	int ret;
 
-	ret = scpi_send_message(SCPI_CMD_SENSOR_INFO, &id, sizeof(id),
+	ret = check_cmd(CMD_SENSOR_INFO);
+	if (ret)
+		return ret;
+
+	ret = scpi_send_message(scpi_info->scpi_cmds[CMD_SENSOR_INFO],
+				&id, sizeof(id),
 				&_info, sizeof(_info));
 	if (!ret) {
 		memcpy(info, &_info, sizeof(*info));
@@ -533,8 +622,12 @@ static int scpi_sensor_get_value(u16 sensor, u64 *val)
 	struct sensor_value buf;
 	int ret;
 
-	ret = scpi_send_message(SCPI_CMD_SENSOR_VALUE, &id, sizeof(id),
-				&buf, sizeof(buf));
+	ret = check_cmd(CMD_SENSOR_VALUE);
+	if (ret)
+		return ret;
+
+	ret = scpi_send_message(scpi_info->scpi_cmds[CMD_SENSOR_VALUE],
+				&id, sizeof(id), &buf, sizeof(buf));
 	if (!ret)
 		*val = (u64)le32_to_cpu(buf.hi_val) << 32 |
 			le32_to_cpu(buf.lo_val);
@@ -548,21 +641,31 @@ static int scpi_device_get_power_state(u16 dev_id)
 	u8 pstate;
 	__le16 id = cpu_to_le16(dev_id);
 
-	ret = scpi_send_message(SCPI_CMD_GET_DEVICE_PWR_STATE, &id,
-				sizeof(id), &pstate, sizeof(pstate));
+	ret = check_cmd(CMD_GET_DEVICE_PWR_STATE);
+	if (ret)
+		return ret;
+
+	ret = scpi_send_message(scpi_info->scpi_cmds[CMD_GET_DEVICE_PWR_STATE],
+				&id, sizeof(id), &pstate, sizeof(pstate));
 	return ret ? ret : pstate;
 }
 
 static int scpi_device_set_power_state(u16 dev_id, u8 pstate)
 {
+	int ret;
 	int stat;
 	struct dev_pstate_set dev_set = {
 		.dev_id = cpu_to_le16(dev_id),
 		.pstate = pstate,
 	};
 
-	return scpi_send_message(SCPI_CMD_SET_DEVICE_PWR_STATE, &dev_set,
-				 sizeof(dev_set), &stat, sizeof(stat));
+	ret = check_cmd(CMD_SET_DEVICE_PWR_STATE);
+	if (ret)
+		return ret;
+
+	return scpi_send_message(scpi_info->scpi_cmds[CMD_SET_DEVICE_PWR_STATE],
+				 &dev_set, sizeof(dev_set),
+				 &stat, sizeof(stat));
 }
 
 static struct scpi_ops scpi_ops = {
@@ -591,6 +694,10 @@ static int scpi_init_versions(struct scpi_drvinfo *info)
 	int ret;
 	struct scp_capabilities caps;
 
+	ret = check_cmd(CMD_SCPI_CAPABILITIES);
+	if (ret)
+		return ret;
+
 	ret = scpi_send_message(SCPI_CMD_SCPI_CAPABILITIES, NULL, 0,
 				&caps, sizeof(caps));
 	if (!ret) {
@@ -756,6 +863,8 @@ err:
 	scpi_info->num_chans = count;
 	platform_set_drvdata(pdev, scpi_info);
 
+	scpi_info->scpi_cmds = scpi_std_commands;
+
 	ret = scpi_init_versions(scpi_info);
 	if (ret) {
 		dev_err(dev, "incorrect or no SCP firmware found\n");
-- 
1.9.1
