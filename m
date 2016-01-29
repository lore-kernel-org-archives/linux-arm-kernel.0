From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 29 Jan 2016 18:19:35 +0000
Subject: [PATCH 1/2] firmware: arm_scpi: fix send_message and sensor_get_value
 for big-endian
Message-ID: <1454091576-27816-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

scpi_process_cmd converts the status word from little endian to cpu
endianness. However scpi_send_message again does the conversion which is
wrong and shows up as a bug only when running in big-endian kernel.

Similarly scpi_sensor_get_value passes the sensor index in the cpu
endianness to SCP which results in SCPI_ERR_RANGE in big-endian mode.

This patch fixes the above mentioned issue for big-endian kernel.

Acked-by: Punit Agrawal <punit.agrawal@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scpi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 6174db80c663..3cb591eca951 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -373,7 +373,7 @@ static int scpi_send_message(u8 cmd, void *tx_buf, unsigned int tx_len,
 		ret = -ETIMEDOUT;
 	else
 		/* first status word */
-		ret = le32_to_cpu(msg->status);
+		ret = msg->status;
 out:
 	if (ret < 0 && rx_buf) /* remove entry from the list if timed-out */
 		scpi_process_cmd(scpi_chan, msg->cmd);
@@ -527,10 +527,11 @@ static int scpi_sensor_get_info(u16 sensor_id, struct scpi_sensor_info *info)
 
 int scpi_sensor_get_value(u16 sensor, u32 *val)
 {
+	__le16 id = cpu_to_le16(sensor);
 	struct sensor_value buf;
 	int ret;
 
-	ret = scpi_send_message(SCPI_CMD_SENSOR_VALUE, &sensor, sizeof(sensor),
+	ret = scpi_send_message(SCPI_CMD_SENSOR_VALUE, &id, sizeof(id),
 				&buf, sizeof(buf));
 	if (!ret)
 		*val = le32_to_cpu(buf.val);
-- 
1.9.1
