From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Tue, 5 Dec 2017 23:17:09 +0100
Subject: [PATCH 08/12] firmware: arm_scpi: remove all single element structures
In-Reply-To: <99220c79-8b35-2978-11d1-6d101ccb6772@gmail.com>
References: <99220c79-8b35-2978-11d1-6d101ccb6772@gmail.com>
Message-ID: <2ec9d59c-9dd5-2e5d-26f2-c4e4407e5af7@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep Holla <sudeep.holla@arm.com>
Both clk_get_value and sensor_value structures contains a single element
and hence needs no packing making the whole structure defination
unnecessary.

This patch gets rid of both those unnecessary structures.

Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scpi.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index e02d5820..3a722e5a 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -304,10 +304,6 @@ struct clk_get_info {
 	u8 name[20];
 } __packed;
 
-struct clk_get_value {
-	__le32 rate;
-} __packed;
-
 struct clk_set_value {
 	__le16 id;
 	__le16 reserved;
@@ -346,10 +342,6 @@ struct _scpi_sensor_info {
 	char name[20];
 };
 
-struct sensor_value {
-	__le64 val;
-};
-
 struct dev_pstate_set {
 	__le16 dev_id;
 	u8 pstate;
@@ -577,13 +569,13 @@ scpi_clk_get_range(u16 clk_id, unsigned long *min, unsigned long *max)
 static unsigned long scpi_clk_get_val(u16 clk_id)
 {
 	int ret;
-	struct clk_get_value clk;
+	__le32 rate;
 	__le16 le_clk_id = cpu_to_le16(clk_id);
 
 	ret = scpi_send_message(CMD_GET_CLOCK_VALUE, &le_clk_id,
-				sizeof(le_clk_id), &clk, sizeof(clk));
+				sizeof(le_clk_id), &rate, sizeof(rate));
 
-	return ret ? ret : le32_to_cpu(clk.rate);
+	return ret ? ret : le32_to_cpu(rate);
 }
 
 static int scpi_clk_set_val(u16 clk_id, unsigned long rate)
@@ -767,19 +759,19 @@ static int scpi_sensor_get_info(u16 sensor_id, struct scpi_sensor_info *info)
 static int scpi_sensor_get_value(u16 sensor, u64 *val)
 {
 	__le16 id = cpu_to_le16(sensor);
-	struct sensor_value buf;
+	__le64 value;
 	int ret;
 
 	ret = scpi_send_message(CMD_SENSOR_VALUE, &id, sizeof(id),
-				&buf, sizeof(buf));
+				&value, sizeof(value));
 	if (ret)
 		return ret;
 
 	if (scpi_info->is_legacy)
 		/* only 32-bits supported, upper 32 bits can be junk */
-		*val = le32_to_cpup((__le32 *)&buf.val);
+		*val = le32_to_cpup((__le32 *)&value);
 	else
-		*val = le64_to_cpu(buf.val);
+		*val = le64_to_cpu(value);
 
 	return 0;
 }
-- 
2.15.1
