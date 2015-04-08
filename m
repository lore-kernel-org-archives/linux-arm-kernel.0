From: wxt@rock-chips.com (Caesar Wang)
Date: Wed,  8 Apr 2015 19:05:56 +0800
Subject: [PATCH v3] ASoC: max98090: add shutdown callback for max98090
Message-ID: <1428491156-31803-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To fix pop noise when shutdown,the pop noise during shutdown
is the pmic cutoff power of codec without any notice.

Signed-off-by: jay.xu <xjq@rock-chips.com>
Signed-off-by: zhengxing <zhengxing@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v3:
- modify the shutdown function before remove(..)
- fix the `Serien-cc`

Changes in v2:
- remove the dev_info(..)
- fix the comment style
- add the max98090_i2c_shutdown() in remove() fuction

 sound/soc/codecs/max98090.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index b112b1c..3e33ef2 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2605,8 +2605,24 @@ err_enable:
 	return ret;
 }
 
+static void max98090_i2c_shutdown(struct i2c_client *i2c)
+{
+	struct max98090_priv *max98090 = dev_get_drvdata(&i2c->dev);
+
+	/*
+	 * Enable volume smoothing, disable zero cross.  This will cause
+	 * a quick 40ms ramp to mute on shutdown.
+	 */
+	regmap_write(max98090->regmap,
+		M98090_REG_LEVEL_CONTROL, M98090_VSENN_MASK);
+	regmap_write(max98090->regmap,
+		M98090_REG_DEVICE_SHUTDOWN, 0x00);
+	msleep(40);
+}
+
 static int max98090_i2c_remove(struct i2c_client *client)
 {
+	max98090_i2c_shutdown(client);
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
 }
@@ -2696,6 +2712,7 @@ static struct i2c_driver max98090_i2c_driver = {
 		.acpi_match_table = ACPI_PTR(max98090_acpi_match),
 	},
 	.probe  = max98090_i2c_probe,
+	.shutdown = max98090_i2c_shutdown,
 	.remove = max98090_i2c_remove,
 	.id_table = max98090_i2c_id,
 };
-- 
1.9.1
