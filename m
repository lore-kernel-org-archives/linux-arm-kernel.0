From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 14 Oct 2016 09:53:35 +0200
Subject: [PATCH 4/6] misc: q8-hardwaremgr: Add rda599x wift/bt/fm radio combo
 detection
In-Reply-To: <20161014075337.10452-1-hdegoede@redhat.com>
References: <20161014075337.10452-1-hdegoede@redhat.com>
Message-ID: <20161014075337.10452-5-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some q8s have a rda599x sdio wifi/bt + i2c fm radio chip with its
i2c interface connected to the same i2c bus as the accelerometer.

There is no kernel driver for these devices yet, but it is useful to
know if one is present for the touchscreen variant selection heuristics.

And when in the future we do get a driver, this detection code will also
be useful to automatically register i2c client dt nodes for these devices.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/misc/q8-hardwaremgr.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/misc/q8-hardwaremgr.c b/drivers/misc/q8-hardwaremgr.c
index 8ed71a9..21754f5 100644
--- a/drivers/misc/q8-hardwaremgr.c
+++ b/drivers/misc/q8-hardwaremgr.c
@@ -144,6 +144,7 @@ struct q8_hardwaremgr_data {
 	int touchscreen_invert_y;
 	int touchscreen_swap_x_y;
 	const char *touchscreen_fw_name;
+	bool has_rda599x;
 };
 
 typedef int (*bus_probe_func)(struct q8_hardwaremgr_data *data,
@@ -454,6 +455,28 @@ static void q8_hardwaremgr_apply_touchscreen(struct q8_hardwaremgr_data *data)
 	of_node_put(np);
 }
 
+static int q8_hardwaremgr_probe_rda599x(struct q8_hardwaremgr_data *data,
+					struct i2c_client *client)
+{
+	int id;
+
+	/*
+	 * Check for the (integrated) rda580x / rda5820 fm receiver at 0x11
+	 *
+	 * Alternatively we could check for the wifi_rf i2c interface at
+	 * address 0x14, by selecting page/bank 1 through:
+	 * smbus_write_word_swapped(0x3f, 0x01)
+	 * and then doing a smbus_read_word_swapped(0x20) which will
+	 * return 0x5990 for a rda5990. We prefer the fm detect method since
+	 * we want to avoid doing any smbus_writes while probing.
+	 */
+	id = i2c_smbus_read_word_swapped(client, 0x0c);
+	if (id == 0x5802 || id == 0x5803 || id == 0x5805 || id == 0x5820)
+		data->has_rda599x = true;
+
+	return id == -ETIMEDOUT ? -ETIMEDOUT : -ENODEV;
+}
+
 static int q8_hardwaremgr_probe_mxc6225(struct q8_hardwaremgr_data *data,
 					struct i2c_client *client)
 {
@@ -594,6 +617,8 @@ static int q8_hardwaremgr_probe_da311(struct q8_hardwaremgr_data *data,
 static int q8_hardwaremgr_probe_accelerometer(struct q8_hardwaremgr_data *data,
 					      struct i2c_adapter *adap)
 {
+	/* The rda599x wifi/bt/fm shares the i2c bus with the accelerometer */
+	PROBE_CLIENT(NULL,		   0x11, q8_hardwaremgr_probe_rda599x);
 	PROBE_CLIENT(&data->accelerometer, 0x15, q8_hardwaremgr_probe_mxc6225);
 	PROBE_CLIENT(&data->accelerometer, 0x4c, q8_hardwaremgr_probe_mc3230);
 	PROBE_CLIENT(&data->accelerometer, 0x1c, q8_hardwaremgr_probe_dmard06);
@@ -749,6 +774,9 @@ static int q8_hardwaremgr_probe(struct platform_device *pdev)
 	if (ret)
 		goto error;
 
+	if (data->has_rda599x)
+		dev_info(data->dev, "Found a rda599x sdio/i2c wifi/bt/fm combo chip\n");
+
 	q8_hardwaremgr_apply_touchscreen(data);
 	q8_hardwaremgr_apply_accelerometer(data);
 
-- 
2.9.3
