From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 14 Oct 2016 09:53:36 +0200
Subject: [PATCH 5/6] misc: q8-hardwaremgr: Better touchscreen defaults based
 on heuristics
In-Reply-To: <20161014075337.10452-1-hdegoede@redhat.com>
References: <20161014075337.10452-1-hdegoede@redhat.com>
Message-ID: <20161014075337.10452-6-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some q8s with gsl1680 touchscreens need to use an alterternative
firmware file and/or need their x/y axis inverted.

This commit adds some heuristics to pick defaults based on other detected
tablet properties (mostly which accelerometer is detected) and sets
defaults based on this.

Although there is not necessarily any relationship between these
settings, this does give us the right defaults on all known model q8
tablets, making the touchscreen work out of the box without requiring
any kernel commandline options to be set.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/misc/q8-hardwaremgr.c | 81 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 74 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/q8-hardwaremgr.c b/drivers/misc/q8-hardwaremgr.c
index 21754f5..95cdaf2 100644
--- a/drivers/misc/q8-hardwaremgr.c
+++ b/drivers/misc/q8-hardwaremgr.c
@@ -84,7 +84,12 @@ enum {
 };
 
 #define DA280_REG_CHIP_ID		0x01
+#define DA280_REG_ACC_Z_LSB		0x06
+#define DA280_REG_MODE_BW		0x11
 #define DA280_CHIP_ID			0x13
+#define DA280_MODE_ENABLE		0x1e
+#define DA280_MODE_DISABLE		0x9e
+
 #define DA311_REG_CHIP_ID		0x0f
 #define DA311_CHIP_ID			0x13
 
@@ -112,6 +117,7 @@ enum {
 
 enum {
 	accel_unknown,
+	da226,
 	da280,
 	da311,
 	dmard05,
@@ -313,8 +319,23 @@ static int q8_hardwaremgr_probe_touchscreen(struct q8_hardwaremgr_data *data,
 static void q8_hardwaremgr_apply_gsl1680_a082_variant(
 	struct q8_hardwaremgr_data *data)
 {
-	if (touchscreen_variant != -1)
+	if (touchscreen_variant != -1) {
 		data->touchscreen_variant = touchscreen_variant;
+	} else {
+		/*
+		 * These accelerometer based heuristics select the best
+		 * default based on known q8 tablets.
+		 */
+		switch (data->accelerometer.model) {
+		case mc3230:
+			data->touchscreen_invert_x = 1;
+			break;
+		case dmard10:
+		case mxc6225:
+			data->touchscreen_variant = 1;
+			break;
+		}
+	}
 
 	switch (data->touchscreen_variant) {
 	default:
@@ -338,8 +359,30 @@ static void q8_hardwaremgr_apply_gsl1680_a082_variant(
 static void q8_hardwaremgr_apply_gsl1680_b482_variant(
 	struct q8_hardwaremgr_data *data)
 {
-	if (touchscreen_variant != -1)
+	if (touchscreen_variant != -1) {
 		data->touchscreen_variant = touchscreen_variant;
+	} else {
+		/*
+		 * These accelerometer based heuristics select the best
+		 * default based on known q8 tablets.
+		 */
+		switch (data->accelerometer.model) {
+		case da280:
+			if (data->accelerometer.addr == 0x27)
+				; /* No-op */
+			else if (data->has_rda599x)
+				data->touchscreen_invert_x = 1;
+			else
+				data->touchscreen_invert_y = 1;
+			break;
+		case dmard09:
+			data->touchscreen_invert_x = 1;
+			break;
+		case mxc6225:
+			data->touchscreen_variant = 1;
+			break;
+		}
+	}
 
 	switch (data->touchscreen_variant) {
 	default:
@@ -587,16 +630,39 @@ static int q8_hardwaremgr_probe_dmard10(struct q8_hardwaremgr_data *data,
 static int q8_hardwaremgr_probe_da280(struct q8_hardwaremgr_data *data,
 				      struct i2c_client *client)
 {
-	int id;
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(client, DA280_REG_CHIP_ID);
+	if (ret != DA280_CHIP_ID)
+		return ret == -ETIMEDOUT ? -ETIMEDOUT : -ENODEV;
 
-	id = i2c_smbus_read_byte_data(client, DA280_REG_CHIP_ID);
-	if (id == DA280_CHIP_ID) {
+	/* da226 (2-axis) or da280 (3-axis) ? measure once to detect */
+	ret = i2c_smbus_write_byte_data(client, DA280_REG_MODE_BW,
+					DA280_MODE_ENABLE);
+	if (ret)
+		return ret == -ETIMEDOUT ? -ETIMEDOUT : -ENODEV;
+
+	msleep(10);
+
+	ret = i2c_smbus_read_word_data(client, DA280_REG_ACC_Z_LSB);
+	if (ret < 0)
+		return ret == -ETIMEDOUT ? -ETIMEDOUT : -ENODEV;
+
+	/* If not present Z reports max pos value (14 bits, 2 low bits 0) */
+	if (ret == 32764) {
+		data->accelerometer.compatible = "miramems,da226";
+		data->accelerometer.model = da226;
+	} else {
 		data->accelerometer.compatible = "miramems,da280";
 		data->accelerometer.model = da280;
-		return 0;
 	}
 
-	return id == -ETIMEDOUT ? -ETIMEDOUT : -ENODEV;
+	ret = i2c_smbus_write_byte_data(client, DA280_REG_MODE_BW,
+					DA280_MODE_DISABLE);
+	if (ret)
+		return ret == -ETIMEDOUT ? -ETIMEDOUT : -ENODEV;
+
+	return 0;
 }
 
 static int q8_hardwaremgr_probe_da311(struct q8_hardwaremgr_data *data,
@@ -625,6 +691,7 @@ static int q8_hardwaremgr_probe_accelerometer(struct q8_hardwaremgr_data *data,
 	PROBE_CLIENT(&data->accelerometer, 0x1d, q8_hardwaremgr_probe_dmard09);
 	PROBE_CLIENT(&data->accelerometer, 0x18, q8_hardwaremgr_probe_dmard10);
 	PROBE_CLIENT(&data->accelerometer, 0x26, q8_hardwaremgr_probe_da280);
+	PROBE_CLIENT(&data->accelerometer, 0x27, q8_hardwaremgr_probe_da280);
 	PROBE_CLIENT(&data->accelerometer, 0x27, q8_hardwaremgr_probe_da311);
 
 	return -ENODEV;
-- 
2.9.3
