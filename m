From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu, 24 Nov 2016 01:18:45 +0100
Subject: [PATCH] firmware: arm_scpi: fix reading sensor values on pre-1.0 SCPI
 firmwares
In-Reply-To: <20161124001845.20830-1-martin.blumenstingl@googlemail.com>
References: <20161124001845.20830-1-martin.blumenstingl@googlemail.com>
Message-ID: <20161124001845.20830-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pre-1.0 SCPI firmwares are using one __le32 as sensor value, while
the 1.0 SCPI protocol uses two __le32 as sensor values (a total of
64bit, split into 32bit upper and 32bit lower value).
Using an "struct sensor_value" to read the sensor value on a pre-1.0
SCPI firmware gives garbage in the "hi_val" field. Introducing a
separate function which handles scpi_ops.sensor_get_value for pre-1.0
SCPI firmware implementations ensures that we do not read memory which
was not written by the SCPI firmware (which fixes for example the
temperature reported by scpi-hwmon).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/firmware/arm_scpi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 70e1323..19f750d 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -728,6 +728,20 @@ static int scpi_sensor_get_value(u16 sensor, u64 *val)
 	return ret;
 }
 
+static int legacy_scpi_sensor_get_value(u16 sensor, u64 *val)
+{
+	__le16 id = cpu_to_le16(sensor);
+	__le32 value;
+	int ret;
+
+	ret = scpi_send_message(CMD_SENSOR_VALUE, &id, sizeof(id),
+				&value, sizeof(value));
+	if (!ret)
+		*val = le32_to_cpu(value);
+
+	return ret;
+}
+
 static int scpi_device_get_power_state(u16 dev_id)
 {
 	int ret;
@@ -960,6 +974,7 @@ static int scpi_probe(struct platform_device *pdev)
 	if (scpi_info->is_legacy) {
 		/* Replace with legacy variants */
 		scpi_ops.clk_set_val = legacy_scpi_clk_set_val;
+		scpi_ops.sensor_get_value = legacy_scpi_sensor_get_value;
 		scpi_info->commands = scpi_legacy_commands;
 
 		/* Fill priority bitmap */
-- 
2.10.2
