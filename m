From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon,  6 Jun 2016 16:53:57 +0100
Subject: [PATCH 1/3] firmware: arm_scpi: add support for device power state
 management
In-Reply-To: <1465228439-13457-1-git-send-email-sudeep.holla@arm.com>
References: <1465228439-13457-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1465228439-13457-2-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SCPI protocol supports device power state management. This deals with
power states of various peripheral devices in the system other than the
core compute subsystem.

This patch adds support for the power state management of those
peripheral devices.

Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scpi.c   | 29 +++++++++++++++++++++++++++++
 include/linux/scpi_protocol.h |  2 ++
 2 files changed, 31 insertions(+)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 51c6db0774cc..ca6afd2217a8 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -231,6 +231,11 @@ struct sensor_value {
 	__le32 hi_val;
 } __packed;

+struct dev_pstate_set {
+	u16 dev_id;
+	u8 pstate;
+} __packed;
+
 static struct scpi_drvinfo *scpi_info;

 static int scpi_linux_errmap[SCPI_ERR_MAX] = {
@@ -537,6 +542,28 @@ static int scpi_sensor_get_value(u16 sensor, u64 *val)
 	return ret;
 }

+static int scpi_device_get_power_state(u16 dev_id)
+{
+	int ret;
+	u8 pstate;
+
+	ret = scpi_send_message(SCPI_CMD_GET_DEVICE_PWR_STATE, &dev_id,
+				sizeof(dev_id), &pstate, sizeof(pstate));
+	return ret ? ret : pstate;
+}
+
+static int scpi_device_set_power_state(u16 dev_id, u8 pstate)
+{
+	int stat;
+	struct dev_pstate_set dev_set = {
+		.dev_id = cpu_to_le16(dev_id),
+		.pstate = pstate,
+	};
+
+	return scpi_send_message(SCPI_CMD_SET_DEVICE_PWR_STATE, &dev_set,
+				 sizeof(dev_set), &stat, sizeof(stat));
+}
+
 static struct scpi_ops scpi_ops = {
 	.get_version = scpi_get_version,
 	.clk_get_range = scpi_clk_get_range,
@@ -548,6 +575,8 @@ static struct scpi_ops scpi_ops = {
 	.sensor_get_capability = scpi_sensor_get_capability,
 	.sensor_get_info = scpi_sensor_get_info,
 	.sensor_get_value = scpi_sensor_get_value,
+	.device_get_power_state = scpi_device_get_power_state,
+	.device_set_power_state = scpi_device_set_power_state,
 };

 struct scpi_ops *get_scpi_ops(void)
diff --git a/include/linux/scpi_protocol.h b/include/linux/scpi_protocol.h
index 35de50a65665..dc5f989be226 100644
--- a/include/linux/scpi_protocol.h
+++ b/include/linux/scpi_protocol.h
@@ -70,6 +70,8 @@ struct scpi_ops {
 	int (*sensor_get_capability)(u16 *sensors);
 	int (*sensor_get_info)(u16 sensor_id, struct scpi_sensor_info *);
 	int (*sensor_get_value)(u16, u64 *);
+	int (*device_get_power_state)(u16);
+	int (*device_set_power_state)(u16, u8);
 };

 #if IS_REACHABLE(CONFIG_ARM_SCPI_PROTOCOL)
--
2.7.4
