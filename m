From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 18 Aug 2016 12:10:57 +0200
Subject: [PATCH 04/13] scpi: Add legacy SCP functions calling
 legacy_scpi_send_message
In-Reply-To: <1471515066-3626-1-git-send-email-narmstrong@baylibre.com>
References: <1471515066-3626-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1471515066-3626-5-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support legacy SCP functions from kernel-wide driver, add legacy
functions using the legacy command enums and calling legacy_scpi_send_message.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/firmware/arm_scpi.c | 118 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 50b1297..bb9965f 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -578,6 +578,8 @@ scpi_clk_get_range(u16 clk_id, unsigned long *min, unsigned long *max)
 	return ret;
 }
 
+/* scpi_clk_get_range not available for legacy */
+
 static unsigned long scpi_clk_get_val(u16 clk_id)
 {
 	int ret;
@@ -589,6 +591,18 @@ static unsigned long scpi_clk_get_val(u16 clk_id)
 	return ret ? ret : le32_to_cpu(clk.rate);
 }
 
+static unsigned long legacy_scpi_clk_get_val(u16 clk_id)
+{
+	int ret;
+	struct clk_get_value clk;
+	__le16 le_clk_id = cpu_to_le16(clk_id);
+
+	ret = legacy_scpi_send_message(LEGACY_SCPI_CMD_GET_CLOCK_VALUE,
+				       &le_clk_id, sizeof(le_clk_id),
+				       &clk, sizeof(clk));
+	return ret ? ret : le32_to_cpu(clk.rate);
+}
+
 static int scpi_clk_set_val(u16 clk_id, unsigned long rate)
 {
 	int stat;
@@ -601,6 +615,19 @@ static int scpi_clk_set_val(u16 clk_id, unsigned long rate)
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
+	return legacy_scpi_send_message(LEGACY_SCPI_CMD_SET_CLOCK_VALUE,
+					&clk, sizeof(clk),
+					&stat, sizeof(stat));
+}
+
 static int scpi_dvfs_get_idx(u8 domain)
 {
 	int ret;
@@ -611,6 +638,17 @@ static int scpi_dvfs_get_idx(u8 domain)
 	return ret ? ret : dvfs_idx;
 }
 
+static int legacy_scpi_dvfs_get_idx(u8 domain)
+{
+	int ret;
+	u8 dvfs_idx;
+
+	ret = legacy_scpi_send_message(LEGACY_SCPI_CMD_GET_DVFS,
+				       &domain, sizeof(domain),
+				       &dvfs_idx, sizeof(dvfs_idx));
+	return ret ? ret : dvfs_idx;
+}
+
 static int scpi_dvfs_set_idx(u8 domain, u8 index)
 {
 	int stat;
@@ -620,6 +658,16 @@ static int scpi_dvfs_set_idx(u8 domain, u8 index)
 				 &stat, sizeof(stat));
 }
 
+static int legacy_scpi_dvfs_set_idx(u8 domain, u8 index)
+{
+	int stat;
+	struct dvfs_set dvfs = {domain, index};
+
+	return legacy_scpi_send_message(LEGACY_SCPI_CMD_SET_DVFS,
+					&dvfs, sizeof(dvfs),
+					&stat, sizeof(stat));
+}
+
 static int opp_cmp_func(const void *opp1, const void *opp2)
 {
 	const struct scpi_opp *t1 = opp1, *t2 = opp2;
@@ -627,6 +675,13 @@ static int opp_cmp_func(const void *opp1, const void *opp2)
 	return t1->freq - t2->freq;
 }
 
+static int legacy_scpi_dvfs_get_info(u8 domain, struct dvfs_info *buf)
+{
+	return legacy_scpi_send_message(LEGACY_SCPI_CMD_GET_DVFS_INFO,
+					&domain, sizeof(domain),
+					buf, sizeof(*buf));
+}
+
 static struct scpi_dvfs_info *scpi_dvfs_get_info(u8 domain)
 {
 	struct scpi_dvfs_info *info;
@@ -683,6 +738,20 @@ static int scpi_sensor_get_capability(u16 *sensors)
 	return ret;
 }
 
+static int legacy_scpi_sensor_get_capability(u16 *sensors)
+{
+	struct sensor_capabilities cap_buf;
+	int ret;
+
+	ret = legacy_scpi_send_message(LEGACY_SCPI_CMD_SENSOR_CAPABILITIES,
+				       NULL, 0,
+				       &cap_buf, sizeof(cap_buf));
+	if (!ret)
+		*sensors = le16_to_cpu(cap_buf.sensors);
+
+	return ret;
+}
+
 static int scpi_sensor_get_info(u16 sensor_id, struct scpi_sensor_info *info)
 {
 	__le16 id = cpu_to_le16(sensor_id);
@@ -699,6 +768,24 @@ static int scpi_sensor_get_info(u16 sensor_id, struct scpi_sensor_info *info)
 	return ret;
 }
 
+static int legacy_scpi_sensor_get_info(u16 sensor_id,
+				       struct scpi_sensor_info *info)
+{
+	__le16 id = cpu_to_le16(sensor_id);
+	struct _scpi_sensor_info _info;
+	int ret;
+
+	ret = legacy_scpi_send_message(LEGACY_SCPI_CMD_SENSOR_INFO,
+				       &id, sizeof(id),
+				       &_info, sizeof(_info));
+	if (!ret) {
+		memcpy(info, &_info, sizeof(*info));
+		info->sensor_id = le16_to_cpu(_info.sensor_id);
+	}
+
+	return ret;
+}
+
 static int scpi_sensor_get_value(u16 sensor, u64 *val)
 {
 	__le16 id = cpu_to_le16(sensor);
@@ -714,6 +801,21 @@ static int scpi_sensor_get_value(u16 sensor, u64 *val)
 	return ret;
 }
 
+static int legacy_scpi_sensor_get_value(u16 sensor, u64 *val)
+{
+	__le16 id = cpu_to_le16(sensor);
+	struct legacy_sensor_value buf;
+	int ret;
+
+	ret = legacy_scpi_send_message(LEGACY_SCPI_CMD_SENSOR_VALUE,
+				       &id, sizeof(id),
+				       &buf, sizeof(buf));
+	if (!ret)
+		*val = (u64)le32_to_cpu(buf.val);
+
+	return ret;
+}
+
 static int scpi_device_get_power_state(u16 dev_id)
 {
 	int ret;
@@ -773,6 +875,22 @@ static int scpi_init_versions(struct scpi_drvinfo *info)
 	return ret;
 }
 
+static int legacy_scpi_init_versions(struct scpi_drvinfo *info)
+{
+	int ret;
+	struct scp_capabilities caps;
+
+	ret = legacy_scpi_send_message(LEGACY_SCPI_CMD_SCPI_CAPABILITIES,
+				       NULL, 0,
+				       &caps, sizeof(caps));
+	if (!ret) {
+		info->protocol_version = le32_to_cpu(caps.protocol_version);
+		info->firmware_version = le32_to_cpu(caps.platform_version);
+	}
+
+	return ret;
+}
+
 static ssize_t protocol_version_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
-- 
1.9.1
