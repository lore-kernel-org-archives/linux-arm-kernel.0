From: pbrobinson@gmail.com (Peter Robinson)
Date: Tue, 30 Dec 2014 11:36:20 +0000
Subject: [PATCH] drivers/rtc/rtc-em3027.c: add device tree support
Message-ID: <1419939380-4439-1-git-send-email-pbrobinson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set the of_match_table for this driver so that devices can be described
in the device tree. This device is used in the Trimslice and is already
defined in the Trimslice device tree.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 drivers/rtc/rtc-em3027.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/rtc/rtc-em3027.c b/drivers/rtc/rtc-em3027.c
index fccf366..7fbb051 100644
--- a/drivers/rtc/rtc-em3027.c
+++ b/drivers/rtc/rtc-em3027.c
@@ -15,6 +15,7 @@
 #include <linux/rtc.h>
 #include <linux/bcd.h>
 #include <linux/module.h>
+#include <linux/of.h>
 
 /* Registers */
 #define EM3027_REG_ON_OFF_CTRL	0x00
@@ -135,10 +136,21 @@ static struct i2c_device_id em3027_id[] = {
 	{ "em3027", 0 },
 	{ }
 };
+MODULE_DEVICE_TABLE(i2c, em3027_id);
+
+#ifdef CONFIG_OF
+static const struct of_device_id em3027_of_match[] = {
+	{ .compatible = "emmicro,em3027", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, em3027_of_match);
+#endif
 
 static struct i2c_driver em3027_driver = {
 	.driver = {
 		   .name = "rtc-em3027",
+		   .owner  = THIS_MODULE,
+		   .of_match_table = of_match_ptr(em3027_of_match),
 	},
 	.probe = &em3027_probe,
 	.id_table = em3027_id,
-- 
2.1.0
