From: voice.shen@atmel.com (Bo Shen)
Date: Tue, 27 Jan 2015 11:36:39 +0800
Subject: [PATCH v3 1/2] ASoC: codecs: wm8904: add dt ids table
Message-ID: <1422329800-28481-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexander Morozov <linux@meltdown.ru>

The WM8904 and WM8918 has the same data type, while the WM8912
has different data type. So, use the data in dt ids table to
distinguish them.

Signed-off-by: Alexander Morozov <linux@meltdown.ru>
[voice.shen at atmel.com: add code to distinguish device type]
Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
Changes in v3:
  - Get the device type from match data in probe function.
Changes in v2:
  - Add driver data for distinguish the device capability.

 sound/soc/codecs/wm8904.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 4d2d2b1..a80bc52 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -2098,6 +2098,24 @@ static const struct regmap_config wm8904_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(wm8904_reg_defaults),
 };
 
+#ifdef CONFIG_OF
+static enum wm8904_type wm8904_data = WM8904;
+static enum wm8904_type wm8912_data = WM8912;
+
+static const struct of_device_id wm8904_of_match[] = {
+	{
+		.compatible = "wlf,wm8904",
+		.data = &wm8904_data,
+	}, {
+		.compatible = "wlf,wm8912",
+		.data = &wm8912_data,
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(of, wm8904_of_match);
+#endif
+
 static int wm8904_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
@@ -2125,7 +2143,17 @@ static int wm8904_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	wm8904->devtype = id->driver_data;
+	if (i2c->dev.of_node) {
+		const struct of_device_id *match;
+
+		match = of_match_node(wm8904_of_match, i2c->dev.of_node);
+		if (match == NULL)
+			return -EINVAL;
+		wm8904->devtype = *((enum wm8904_type *)match->data);
+	} else {
+		wm8904->devtype = id->driver_data;
+	}
+
 	i2c_set_clientdata(i2c, wm8904);
 	wm8904->pdata = i2c->dev.platform_data;
 
@@ -2259,6 +2287,7 @@ static struct i2c_driver wm8904_i2c_driver = {
 	.driver = {
 		.name = "wm8904",
 		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(wm8904_of_match),
 	},
 	.probe =    wm8904_i2c_probe,
 	.remove =   wm8904_i2c_remove,
-- 
2.3.0.rc0
