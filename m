From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 14 Oct 2016 09:53:34 +0200
Subject: [PATCH 3/6] misc: q8-hardwaremgr: Add accelerometer detection
In-Reply-To: <20161014075337.10452-1-hdegoede@redhat.com>
References: <20161014075337.10452-1-hdegoede@redhat.com>
Message-ID: <20161014075337.10452-4-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend the q8-hardwaremgr with accelerometer detection.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/misc/Kconfig          |   2 +-
 drivers/misc/q8-hardwaremgr.c | 219 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 220 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index d6c1529..11b05b0 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -801,7 +801,7 @@ config Q8_HARDWAREMGR
 	default	n
 	help
 	  This option enables support for autodetecting the touchscreen
-	  on Allwinner Q8 tablets.
+	  and accelerometer on Allwinner Q8 tablets.
 
 	  If unsure, say N.
 
diff --git a/drivers/misc/q8-hardwaremgr.c b/drivers/misc/q8-hardwaremgr.c
index 346102d..8ed71a9 100644
--- a/drivers/misc/q8-hardwaremgr.c
+++ b/drivers/misc/q8-hardwaremgr.c
@@ -83,6 +83,48 @@ enum {
 	zet6251,
 };
 
+#define DA280_REG_CHIP_ID		0x01
+#define DA280_CHIP_ID			0x13
+#define DA311_REG_CHIP_ID		0x0f
+#define DA311_CHIP_ID			0x13
+
+#define DMARD06_CHIP_ID_REG		0x0f
+#define DMARD05_CHIP_ID			0x05
+#define DMARD06_CHIP_ID			0x06
+#define DMARD07_CHIP_ID			0x07
+#define DMARD09_REG_CHIPID		0x18
+#define DMARD09_CHIPID			0x95
+#define DMARD10_REG_STADR		0x12
+#define DMARD10_REG_STAINT		0x1c
+#define DMARD10_VALUE_STADR		0x55
+#define DMARD10_VALUE_STAINT		0xaa
+
+#define MC3230_REG_CHIP_ID		0x18
+#define MC3230_CHIP_ID			0x01
+#define MMA7660_CHIP_ID			0x00 /* Factory reserved on MMA7660 */
+#define MC3230_REG_PRODUCT_CODE		0x3b
+#define MMA7660_PRODUCT_CODE		0x00 /* Factory reserved on MMA7660 */
+#define MC3210_PRODUCT_CODE		0x90
+#define MC3230_PRODUCT_CODE		0x19
+
+#define MXC6225_REG_CHIP_ID		0x08
+#define MXC6225_CHIP_ID			0x05
+
+enum {
+	accel_unknown,
+	da280,
+	da311,
+	dmard05,
+	dmard06,
+	dmard07,
+	dmard09,
+	dmard10,
+	mc3210,
+	mc3230,
+	mma7660,
+	mxc6225,
+};
+
 struct q8_hardwaremgr_device {
 	int model;
 	int addr;
@@ -94,6 +136,7 @@ struct q8_hardwaremgr_data {
 	struct device *dev;
 	enum soc soc;
 	struct q8_hardwaremgr_device touchscreen;
+	struct q8_hardwaremgr_device accelerometer;
 	int touchscreen_variant;
 	int touchscreen_width;
 	int touchscreen_height;
@@ -411,6 +454,175 @@ static void q8_hardwaremgr_apply_touchscreen(struct q8_hardwaremgr_data *data)
 	of_node_put(np);
 }
 
+static int q8_hardwaremgr_probe_mxc6225(struct q8_hardwaremgr_data *data,
+					struct i2c_client *client)
+{
+	int id;
+
+	id = i2c_smbus_read_byte_data(client, MXC6225_REG_CHIP_ID);
+	/* Bits 7 - 5 of the chip-id register are undefined */
+	if (id >= 0 && (id & 0x1f) == MXC6225_CHIP_ID) {
+		data->accelerometer.compatible = "memsic,mxc6225";
+		data->accelerometer.model = mxc6225;
+		return 0;
+	}
+
+	return id == -ETIMEDOUT ? -ETIMEDOUT : -ENODEV;
+}
+
+static int q8_hardwaremgr_probe_mc3230(struct q8_hardwaremgr_data *data,
+				       struct i2c_client *client)
+{
+	int id, pc = 0;
+
+	/* First check chip-id, then product-id */
+	id = i2c_smbus_read_byte_data(client, MC3230_REG_CHIP_ID);
+	if (id == MC3230_CHIP_ID || id == MMA7660_CHIP_ID) {
+		pc = i2c_smbus_read_byte_data(client, MC3230_REG_PRODUCT_CODE);
+		switch (pc) {
+		case MMA7660_PRODUCT_CODE:
+			data->accelerometer.compatible = "fsl,mma7660";
+			data->accelerometer.model = mma7660;
+			return 0;
+		case MC3210_PRODUCT_CODE:
+			data->accelerometer.compatible = "mcube,mc3210";
+			data->accelerometer.model = mc3210;
+			return 0;
+		case MC3230_PRODUCT_CODE:
+			data->accelerometer.compatible = "mcube,mc3230";
+			data->accelerometer.model = mc3230;
+			return 0;
+		case -ETIMEDOUT:
+			return -ETIMEDOUT; /* Bus stuck bail immediately */
+		}
+	}
+
+	return id == -ETIMEDOUT ? -ETIMEDOUT : -ENODEV;
+}
+
+static int q8_hardwaremgr_probe_dmard06(struct q8_hardwaremgr_data *data,
+					struct i2c_client *client)
+{
+	int id;
+
+	id = i2c_smbus_read_byte_data(client, DMARD06_CHIP_ID_REG);
+	switch (id) {
+	case DMARD05_CHIP_ID:
+		data->accelerometer.compatible = "domintech,dmard05";
+		data->accelerometer.model = dmard05;
+		return 0;
+	case DMARD06_CHIP_ID:
+		data->accelerometer.compatible = "domintech,dmard06";
+		data->accelerometer.model = dmard06;
+		return 0;
+	case DMARD07_CHIP_ID:
+		data->accelerometer.compatible = "domintech,dmard07";
+		data->accelerometer.model = dmard07;
+		return 0;
+	}
+
+	return id == -ETIMEDOUT ? -ETIMEDOUT : -ENODEV;
+}
+
+static int q8_hardwaremgr_probe_dmard09(struct q8_hardwaremgr_data *data,
+					struct i2c_client *client)
+{
+	int id;
+
+	id = i2c_smbus_read_byte_data(client, DMARD09_REG_CHIPID);
+	if (id == DMARD09_CHIPID) {
+		data->accelerometer.compatible = "domintech,dmard09";
+		data->accelerometer.model = dmard09;
+		return 0;
+	}
+
+	return id == -ETIMEDOUT ? -ETIMEDOUT : -ENODEV;
+}
+
+static int q8_hardwaremgr_probe_dmard10(struct q8_hardwaremgr_data *data,
+					struct i2c_client *client)
+{
+	int stadr, staint = 0;
+
+	/* These 2 registers have special POR reset values used for id */
+	stadr = i2c_smbus_read_byte_data(client, DMARD10_REG_STADR);
+	if (stadr == DMARD10_VALUE_STADR) {
+		staint = i2c_smbus_read_byte_data(client, DMARD10_REG_STAINT);
+		switch (staint) {
+		case DMARD10_VALUE_STAINT:
+			data->accelerometer.compatible = "domintech,dmard10";
+			data->accelerometer.model = dmard10;
+			return 0;
+		case -ETIMEDOUT:
+			return -ETIMEDOUT; /* Bus stuck bail immediately */
+		}
+	}
+
+	return stadr == -ETIMEDOUT ? -ETIMEDOUT : -ENODEV;
+}
+
+static int q8_hardwaremgr_probe_da280(struct q8_hardwaremgr_data *data,
+				      struct i2c_client *client)
+{
+	int id;
+
+	id = i2c_smbus_read_byte_data(client, DA280_REG_CHIP_ID);
+	if (id == DA280_CHIP_ID) {
+		data->accelerometer.compatible = "miramems,da280";
+		data->accelerometer.model = da280;
+		return 0;
+	}
+
+	return id == -ETIMEDOUT ? -ETIMEDOUT : -ENODEV;
+}
+
+static int q8_hardwaremgr_probe_da311(struct q8_hardwaremgr_data *data,
+				      struct i2c_client *client)
+{
+	int id;
+
+	id = i2c_smbus_read_byte_data(client, DA311_REG_CHIP_ID);
+	if (id == DA311_CHIP_ID) {
+		data->accelerometer.compatible = "miramems,da311";
+		data->accelerometer.model = da311;
+		return 0;
+	}
+
+	return id == -ETIMEDOUT ? -ETIMEDOUT : -ENODEV;
+}
+
+static int q8_hardwaremgr_probe_accelerometer(struct q8_hardwaremgr_data *data,
+					      struct i2c_adapter *adap)
+{
+	PROBE_CLIENT(&data->accelerometer, 0x15, q8_hardwaremgr_probe_mxc6225);
+	PROBE_CLIENT(&data->accelerometer, 0x4c, q8_hardwaremgr_probe_mc3230);
+	PROBE_CLIENT(&data->accelerometer, 0x1c, q8_hardwaremgr_probe_dmard06);
+	PROBE_CLIENT(&data->accelerometer, 0x1d, q8_hardwaremgr_probe_dmard09);
+	PROBE_CLIENT(&data->accelerometer, 0x18, q8_hardwaremgr_probe_dmard10);
+	PROBE_CLIENT(&data->accelerometer, 0x26, q8_hardwaremgr_probe_da280);
+	PROBE_CLIENT(&data->accelerometer, 0x27, q8_hardwaremgr_probe_da311);
+
+	return -ENODEV;
+}
+
+static void q8_hardwaremgr_apply_accelerometer(struct q8_hardwaremgr_data *data)
+{
+	struct of_changeset cset;
+	struct device_node *np;
+
+	if (data->accelerometer.model == accel_unknown)
+		return;
+
+	np = q8_hardware_mgr_apply_common(&data->accelerometer, &cset,
+					  "accelerometer");
+	if (!np)
+		return;
+
+	of_changeset_apply(&cset);
+
+	of_node_put(np);
+}
+
 static int q8_hardwaremgr_do_probe(struct q8_hardwaremgr_data *data,
 				   struct q8_hardwaremgr_device *dev,
 				   const char *prefix, bus_probe_func func)
@@ -531,7 +743,14 @@ static int q8_hardwaremgr_probe(struct platform_device *pdev)
 	if (ret)
 		goto error;
 
+	ret = q8_hardwaremgr_do_probe(data, &data->accelerometer,
+				      "accelerometer",
+				      q8_hardwaremgr_probe_accelerometer);
+	if (ret)
+		goto error;
+
 	q8_hardwaremgr_apply_touchscreen(data);
+	q8_hardwaremgr_apply_accelerometer(data);
 
 error:
 	kfree(data);
-- 
2.9.3
