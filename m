From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Tue, 5 Dec 2017 23:16:58 +0100
Subject: [PATCH 06/12] firmware: arm_scpi: improve struct sensor_value
In-Reply-To: <99220c79-8b35-2978-11d1-6d101ccb6772@gmail.com>
References: <99220c79-8b35-2978-11d1-6d101ccb6772@gmail.com>
Message-ID: <d9278f12-9f3d-66fc-114d-f940388b6cf7@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

lo_val and hi_val together in this order are a little endian 64 bit value.
Therefore we can simplify struct sensor_value and the code by defining
it as a __le64 value and by using le64_to_cpu.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/firmware/arm_scpi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 63441e40..4447af48 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -347,9 +347,8 @@ struct _scpi_sensor_info {
 };
 
 struct sensor_value {
-	__le32 lo_val;
-	__le32 hi_val;
-} __packed;
+	__le64 val;
+};
 
 struct dev_pstate_set {
 	__le16 dev_id;
@@ -777,11 +776,10 @@ static int scpi_sensor_get_value(u16 sensor, u64 *val)
 		return ret;
 
 	if (scpi_info->is_legacy)
-		/* only 32-bits supported, hi_val can be junk */
-		*val = le32_to_cpu(buf.lo_val);
+		/* only 32-bits supported, upper 32 bits can be junk */
+		*val = le32_to_cpup((__le32 *)&buf.val);
 	else
-		*val = (u64)le32_to_cpu(buf.hi_val) << 32 |
-			le32_to_cpu(buf.lo_val);
+		*val = le64_to_cpu(buf.val);
 
 	return 0;
 }
-- 
2.15.1
