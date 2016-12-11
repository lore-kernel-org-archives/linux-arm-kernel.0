From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 11 Dec 2016 22:14:32 +0100
Subject: [PATCH v3] firmware: arm_scpi: fix reading sensor values on pre-1.0
 SCPI firmwares
In-Reply-To: <20161211211432.13252-1-martin.blumenstingl@googlemail.com>
References: <20161125005432.1205-1-martin.blumenstingl@googlemail.com>
 <20161211211432.13252-1-martin.blumenstingl@googlemail.com>
Message-ID: <20161211211432.13252-2-martin.blumenstingl@googlemail.com>
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

Suggested-by: Sudeep Holla <Sudeep.Holla@arm.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/firmware/arm_scpi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 70e1323..9ad0b19 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -721,11 +721,17 @@ static int scpi_sensor_get_value(u16 sensor, u64 *val)
 
 	ret = scpi_send_message(CMD_SENSOR_VALUE, &id, sizeof(id),
 				&buf, sizeof(buf));
-	if (!ret)
+	if (ret)
+		return ret;
+
+	if (scpi_info->is_legacy)
+		/* only 32-bits supported, hi_val can be junk */
+		*val = le32_to_cpu(buf.lo_val);
+	else
 		*val = (u64)le32_to_cpu(buf.hi_val) << 32 |
 			le32_to_cpu(buf.lo_val);
 
-	return ret;
+	return 0;
 }
 
 static int scpi_device_get_power_state(u16 dev_id)
-- 
2.10.2
