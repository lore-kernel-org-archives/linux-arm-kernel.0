From: anilkumar@ti.com (AnilKumar Ch)
Date: Mon, 24 Sep 2012 14:53:49 +0530
Subject: [PATCH] lis3lv02d: fix some comments specific to lis331dlh driver
Message-ID: <1348478629-16983-1-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix some minor problems in comments of lis331dlh driver
  * correct comments with respect to 2G sensitivity
  * correct typo lis3331dlh mistake to lis331dlh
  * add comment to say only 2G range is supported
  * change the function name from lis3lv02d_read_16 to
    lis331dlh_read_data.
  * update i2c_device_id table entry to maintaine consistancy
  * update sensor display message

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
This patch is created based on Eric Piel's review comments on
"lis3lv02d: Add STMicroelectronics lis331dlh digital accelerometer"
v2 patch.

 drivers/misc/lis3lv02d/lis3lv02d.c     |   13 +++++++------
 drivers/misc/lis3lv02d/lis3lv02d.h     |    2 +-
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c |    2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/lis3lv02d/lis3lv02d.c b/drivers/misc/lis3lv02d/lis3lv02d.c
index 026021e..67fe4a1 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d.c
@@ -82,9 +82,10 @@
 #define LIS3_SENSITIVITY_8B		(18 * LIS3_ACCURACY)
 
 /*
- * LIS3331DLH spec says 1LSBs corresponds 4G/1024 -> 1LSB is 1000/1024 mG.
- * Sensitivity values for +/-2G, outdata in 12 bits for +/-2G scale. so 4
- * bits adjustment is required
+ * LIS331DLH spec says 1LSBs corresponds 4G/4096 -> 1LSB is 1000/1024 mG.
+ * Below macros defines sensitivity values for +/-2G. Dataout bits for
+ * +/-2G range is 12 bits so 4 bits adjustment must be done to get 12bit
+ * data from 16bit value. Currently this driver supports only 2G range.
  */
 #define LIS3DLH_SENSITIVITY_2G		((LIS3_ACCURACY * 1000) / 1024)
 #define SHIFT_ADJ_2G			4
@@ -145,7 +146,7 @@ static s16 lis3lv02d_read_12(struct lis3lv02d *lis3, int reg)
 }
 
 /* 12bits for 2G range, 13 bits for 4G range and 14 bits for 8G range */
-static s16 lis3lv02d_read_16(struct lis3lv02d *lis3, int reg)
+static s16 lis331dlh_read_data(struct lis3lv02d *lis3, int reg)
 {
 	u8 lo, hi;
 	int v;
@@ -1135,8 +1136,8 @@ int lis3lv02d_init_device(struct lis3lv02d *lis3)
 		lis3->scale = LIS3_SENSITIVITY_8B;
 		break;
 	case WAI_3DLH:
-		pr_info("16 bits 3DLH sensor found\n");
-		lis3->read_data = lis3lv02d_read_16;
+		pr_info("16 bits lis331dlh sensor found\n");
+		lis3->read_data = lis331dlh_read_data;
 		lis3->mdps_max_val = 2048; /* 12 bits for 2G */
 		lis3->shift_adj = SHIFT_ADJ_2G;
 		lis3->pwron_delay = LIS3_PWRON_DELAY_WAI_8B;
diff --git a/drivers/misc/lis3lv02d/lis3lv02d.h b/drivers/misc/lis3lv02d/lis3lv02d.h
index b5505fa..c439c82 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d.h
+++ b/drivers/misc/lis3lv02d/lis3lv02d.h
@@ -104,9 +104,9 @@ enum lis3_who_am_i {
 };
 
 enum lis3_type {
+	LIS3LV02D,
 	LIS3DC,
 	HP3DC,
-	LIS3LV02D,
 	LIS2302D,
 	LIS331DLF,
 	LIS331DLH,
diff --git a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
index 43e3f29..02104a9 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
@@ -252,7 +252,7 @@ static int lis3_i2c_runtime_resume(struct device *dev)
 #endif /* CONFIG_PM_RUNTIME */
 
 static const struct i2c_device_id lis3lv02d_id[] = {
-	{"lis3lv02d", 0 },
+	{"lis3lv02d", LIS3LV02D},
 	{"lis331dlh", LIS331DLH},
 	{}
 };
-- 
1.7.9.5
