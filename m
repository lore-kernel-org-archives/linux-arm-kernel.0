From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Wed, 4 Oct 2017 21:05:17 +0200
Subject: [PATCH 3/3] firmware: arm_scpi: improve struct sensor_value
In-Reply-To: <16d1cd8c-e124-cc94-ca29-d7cb04ff26d9@gmail.com>
References: <16d1cd8c-e124-cc94-ca29-d7cb04ff26d9@gmail.com>
Message-ID: <39b87656-dd9f-b24f-db41-5253d3a878ef@gmail.com>
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
index d305b926..c923d1eb 100644
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
@@ -785,11 +784,10 @@ static int scpi_sensor_get_value(u16 sensor, u64 *val)
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
2.14.2
