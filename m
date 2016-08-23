From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 23 Aug 2016 13:46:51 +0200
Subject: [PATCH v2 2/7] scpi: Use legacy variants command index calling
 scpi_send_message
In-Reply-To: <1471952816-30877-1-git-send-email-narmstrong@baylibre.com>
References: <1471952816-30877-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1471952816-30877-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support legacy SCP functions from kernel-wide driver, use legacy
command indexes calling scpi_send_message.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/firmware/arm_scpi.c | 126 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 107 insertions(+), 19 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 752e5b2..d24d1de 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -520,6 +520,9 @@ scpi_clk_get_range(u16 clk_id, unsigned long *min, unsigned long *max)
 	struct clk_get_info clk;
 	__le16 le_clk_id = cpu_to_le16(clk_id);
 
+	if (scpi_info->is_legacy)
+		return -EOPNOTSUPP;
+
 	ret = scpi_send_message(SCPI_CMD_GET_CLOCK_INFO, &le_clk_id,
 				sizeof(le_clk_id), &clk, sizeof(clk));
 	if (!ret) {
@@ -535,8 +538,14 @@ static unsigned long scpi_clk_get_val(u16 clk_id)
 	struct clk_get_value clk;
 	__le16 le_clk_id = cpu_to_le16(clk_id);
 
-	ret = scpi_send_message(SCPI_CMD_GET_CLOCK_VALUE, &le_clk_id,
-				sizeof(le_clk_id), &clk, sizeof(clk));
+	if (scpi_info->is_legacy)
+		ret = scpi_send_message(LEGACY_SCPI_CMD_GET_CLOCK_VALUE,
+					&le_clk_id, sizeof(le_clk_id),
+					&clk, sizeof(clk));
+	else
+		ret = scpi_send_message(SCPI_CMD_GET_CLOCK_VALUE, &le_clk_id,
+					sizeof(le_clk_id), &clk, sizeof(clk));
+
 	return ret ? ret : le32_to_cpu(clk.rate);
 }
 
@@ -552,13 +561,33 @@ static int scpi_clk_set_val(u16 clk_id, unsigned long rate)
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
+	return scpi_send_message(LEGACY_SCPI_CMD_SET_CLOCK_VALUE,
+				 &clk, sizeof(clk),
+				 &stat, sizeof(stat));
+}
+
 static int scpi_dvfs_get_idx(u8 domain)
 {
 	int ret;
 	u8 dvfs_idx;
 
-	ret = scpi_send_message(SCPI_CMD_GET_DVFS, &domain, sizeof(domain),
-				&dvfs_idx, sizeof(dvfs_idx));
+	if (scpi_info->is_legacy)
+		ret = scpi_send_message(LEGACY_SCPI_CMD_GET_DVFS,
+					&domain, sizeof(domain),
+					&dvfs_idx, sizeof(dvfs_idx));
+	else
+		ret = scpi_send_message(SCPI_CMD_GET_DVFS,
+					&domain, sizeof(domain),
+					&dvfs_idx, sizeof(dvfs_idx));
+
 	return ret ? ret : dvfs_idx;
 }
 
@@ -567,6 +596,11 @@ static int scpi_dvfs_set_idx(u8 domain, u8 index)
 	int stat;
 	struct dvfs_set dvfs = {domain, index};
 
+	if (scpi_info->is_legacy)
+		return scpi_send_message(LEGACY_SCPI_CMD_SET_DVFS,
+					 &dvfs, sizeof(dvfs),
+					 &stat, sizeof(stat));
+
 	return scpi_send_message(SCPI_CMD_SET_DVFS, &dvfs, sizeof(dvfs),
 				 &stat, sizeof(stat));
 }
@@ -591,9 +625,14 @@ static struct scpi_dvfs_info *scpi_dvfs_get_info(u8 domain)
 	if (scpi_info->dvfs[domain])	/* data already populated */
 		return scpi_info->dvfs[domain];
 
-	ret = scpi_send_message(SCPI_CMD_GET_DVFS_INFO, &domain, sizeof(domain),
-				&buf, sizeof(buf));
-
+	if (scpi_info->is_legacy)
+		ret = scpi_send_message(LEGACY_SCPI_CMD_GET_DVFS_INFO,
+					&domain, sizeof(domain),
+					&buf, sizeof(buf));
+	else
+		ret = scpi_send_message(SCPI_CMD_GET_DVFS_INFO,
+					&domain, sizeof(domain),
+					&buf, sizeof(buf));
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -626,8 +665,12 @@ static int scpi_sensor_get_capability(u16 *sensors)
 	struct sensor_capabilities cap_buf;
 	int ret;
 
-	ret = scpi_send_message(SCPI_CMD_SENSOR_CAPABILITIES, NULL, 0, &cap_buf,
-				sizeof(cap_buf));
+	if (scpi_info->is_legacy)
+		ret = scpi_send_message(LEGACY_SCPI_CMD_SENSOR_CAPABILITIES,
+					NULL, 0, &cap_buf, sizeof(cap_buf));
+	else
+		ret = scpi_send_message(SCPI_CMD_SENSOR_CAPABILITIES,
+					NULL, 0, &cap_buf, sizeof(cap_buf));
 	if (!ret)
 		*sensors = le16_to_cpu(cap_buf.sensors);
 
@@ -640,8 +683,13 @@ static int scpi_sensor_get_info(u16 sensor_id, struct scpi_sensor_info *info)
 	struct _scpi_sensor_info _info;
 	int ret;
 
-	ret = scpi_send_message(SCPI_CMD_SENSOR_INFO, &id, sizeof(id),
-				&_info, sizeof(_info));
+	if (scpi_info->is_legacy)
+		ret = scpi_send_message(LEGACY_SCPI_CMD_SENSOR_INFO,
+					&id, sizeof(id),
+					&_info, sizeof(_info));
+	else
+		ret = scpi_send_message(SCPI_CMD_SENSOR_INFO, &id, sizeof(id),
+					&_info, sizeof(_info));
 	if (!ret) {
 		memcpy(info, &_info, sizeof(*info));
 		info->sensor_id = le16_to_cpu(_info.sensor_id);
@@ -656,11 +704,18 @@ static int scpi_sensor_get_value(u16 sensor, u64 *val)
 	struct sensor_value buf;
 	int ret;
 
-	ret = scpi_send_message(SCPI_CMD_SENSOR_VALUE, &id, sizeof(id),
-				&buf, sizeof(buf));
-	if (!ret)
-		*val = (u64)le32_to_cpu(buf.hi_val) << 32 |
-			le32_to_cpu(buf.lo_val);
+	if (scpi_info->is_legacy) {
+		ret = scpi_send_message(LEGACY_SCPI_CMD_SENSOR_VALUE,
+					&id, sizeof(id), &buf, sizeof(buf));
+		if (!ret)
+			*val = (u64)le32_to_cpu(buf.lo_val);
+	} else {
+		ret = scpi_send_message(SCPI_CMD_SENSOR_VALUE, &id, sizeof(id),
+					&buf, sizeof(buf));
+		if (!ret)
+			*val = (u64)le32_to_cpu(buf.hi_val) << 32 |
+				le32_to_cpu(buf.lo_val);
+	}
 
 	return ret;
 }
@@ -671,6 +726,9 @@ static int scpi_device_get_power_state(u16 dev_id)
 	u8 pstate;
 	__le16 id = cpu_to_le16(dev_id);
 
+	if (scpi_info->is_legacy)
+		return -EOPNOTSUPP;
+
 	ret = scpi_send_message(SCPI_CMD_GET_DEVICE_PWR_STATE, &id,
 				sizeof(id), &pstate, sizeof(pstate));
 	return ret ? ret : pstate;
@@ -684,6 +742,9 @@ static int scpi_device_set_power_state(u16 dev_id, u8 pstate)
 		.pstate = pstate,
 	};
 
+	if (scpi_info->is_legacy)
+		return -EOPNOTSUPP;
+
 	return scpi_send_message(SCPI_CMD_SET_DEVICE_PWR_STATE, &dev_set,
 				 sizeof(dev_set), &stat, sizeof(stat));
 }
@@ -703,6 +764,21 @@ static struct scpi_ops scpi_ops = {
 	.device_set_power_state = scpi_device_set_power_state,
 };
 
+static struct scpi_ops legacy_scpi_ops = {
+	.get_version = scpi_get_version,
+	.clk_get_range = NULL,
+	.clk_get_val = scpi_clk_get_val,
+	.clk_set_val = legacy_scpi_clk_set_val,
+	.dvfs_get_idx = scpi_dvfs_get_idx,
+	.dvfs_set_idx = scpi_dvfs_set_idx,
+	.dvfs_get_info = scpi_dvfs_get_info,
+	.sensor_get_capability = scpi_sensor_get_capability,
+	.sensor_get_info = scpi_sensor_get_info,
+	.sensor_get_value = scpi_sensor_get_value,
+	.device_get_power_state = NULL,
+	.device_set_power_state = NULL,
+};
+
 struct scpi_ops *get_scpi_ops(void)
 {
 	return scpi_info ? scpi_info->scpi_ops : NULL;
@@ -714,12 +790,20 @@ static int scpi_init_versions(struct scpi_drvinfo *info)
 	int ret;
 	struct scp_capabilities caps;
 
-	ret = scpi_send_message(SCPI_CMD_SCPI_CAPABILITIES, NULL, 0,
-				&caps, sizeof(caps));
+	if (scpi_info->is_legacy)
+		ret = scpi_send_message(LEGACY_SCPI_CMD_SCPI_CAPABILITIES,
+					NULL, 0, &caps, sizeof(caps));
+	else
+		ret = scpi_send_message(SCPI_CMD_SCPI_CAPABILITIES, NULL, 0,
+					&caps, sizeof(caps));
 	if (!ret) {
 		info->protocol_version = le32_to_cpu(caps.protocol_version);
 		info->firmware_version = le32_to_cpu(caps.platform_version);
 	}
+	/* Ignore error if not implemented */
+	if (scpi_info->is_legacy && ret == -EOPNOTSUPP)
+		return 0;
+
 	return ret;
 }
 
@@ -897,7 +981,11 @@ err:
 		  FW_REV_MAJOR(scpi_info->firmware_version),
 		  FW_REV_MINOR(scpi_info->firmware_version),
 		  FW_REV_PATCH(scpi_info->firmware_version));
-	scpi_info->scpi_ops = &scpi_ops;
+
+	if (scpi_info->is_legacy)
+		scpi_info->scpi_ops = &legacy_scpi_ops;
+	else
+		scpi_info->scpi_ops = &scpi_ops;
 
 	ret = sysfs_create_groups(&dev->kobj, versions_groups);
 	if (ret)
-- 
1.9.1
