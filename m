From: linux@roeck-us.net (Guenter Roeck)
Date: Tue,  5 Jul 2016 09:44:32 -0700
Subject: [PATCH 2/3] hwmon: (jc42) Add support for generic JC-42.4 devicetree
 binding
In-Reply-To: <1467737073-7949-1-git-send-email-linux@roeck-us.net>
References: <1467737073-7949-1-git-send-email-linux@roeck-us.net>
Message-ID: <1467737073-7949-2-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With this change, JC-42.4 compatible temperature sensors can be configured
in devicetree by providing a generic "jedec,jc-42.4-temp" binding.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/jc42.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
index 9887d3224a86..374630bab137 100644
--- a/drivers/hwmon/jc42.c
+++ b/drivers/hwmon/jc42.c
@@ -31,6 +31,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = {
@@ -537,11 +538,20 @@ static const struct i2c_device_id jc42_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, jc42_id);
 
+#ifdef CONFIG_OF
+static const struct of_device_id jc42_of_ids[] = {
+	{ .compatible = "jedec,jc-42.4-temp", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, jc42_of_ids);
+#endif
+
 static struct i2c_driver jc42_driver = {
 	.class		= I2C_CLASS_SPD,
 	.driver = {
 		.name	= "jc42",
 		.pm = JC42_DEV_PM_OPS,
+		.of_match_table = of_match_ptr(jc42_of_ids),
 	},
 	.probe		= jc42_probe,
 	.remove		= jc42_remove,
-- 
2.5.0
