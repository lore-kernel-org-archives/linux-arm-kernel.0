From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 15 Dec 2014 11:31:11 +0800
Subject: [PATCH v2 1/3] ASoC: codecs: wm8904: add dt ids table
Message-ID: <1418614273-2303-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexander Morozov <linux@meltdown.ru>

Signed-off-by: Alexander Morozov <linux@meltdown.ru>
[Add driver data to distinguish device type]
Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

Changes in v2:
- Add driver data for distinguish the device capability.

 sound/soc/codecs/wm8904.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 4d2d2b1..6e3f175 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -2255,10 +2255,32 @@ static const struct i2c_device_id wm8904_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, wm8904_i2c_id);
 
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
+		.compatible = "wlf,wm8918",
+		.data = &wm8904_data,
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(of, wm8904_of_match);
+#endif
+
 static struct i2c_driver wm8904_i2c_driver = {
 	.driver = {
 		.name = "wm8904",
 		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(wm8904_of_match),
 	},
 	.probe =    wm8904_i2c_probe,
 	.remove =   wm8904_i2c_remove,
-- 
2.1.0.24.g4109c28
