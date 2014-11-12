From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 12 Nov 2014 15:40:44 +0100
Subject: [PATCHv2] ASoC: cs42l51: re-hook of_match_table pointer
Message-ID: <1415803244-7010-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit a1253ef6d3fa ("ASoC: cs42l51: split i2c from codec driver"),
the I2C part of the CS42L51 was moved to a separate file, but the
definition of the of_device_id array was left in the driver file
itself, no longer connected to the platform_driver structure using the
.of_match_table pointer.

This commit exports the of_device_id array in cs42l51, and uses it as
.of_match_able in cs42l51-i2c.c. This solution was suggested by Brian
Austin.

Fixes: a1253ef6d3fa ("ASoC: cs42l51: split i2c from codec driver")
Cc: <stable@vger.kernel.org> # v3.16+
Cc: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Cc: Brian Austin <brian.austin@cirrus.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 sound/soc/codecs/cs42l51-i2c.c | 1 +
 sound/soc/codecs/cs42l51.c     | 4 +++-
 sound/soc/codecs/cs42l51.h     | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)
---
Changes since v1:

 - Instead of moving the of_device_id array definition to the I2C
   specific file, keep it in the core file, and export it so it can be
   used by the I2C specific file. Suggested by Brian Austin.

diff --git a/sound/soc/codecs/cs42l51-i2c.c b/sound/soc/codecs/cs42l51-i2c.c
index cee51ae..c40428f 100644
--- a/sound/soc/codecs/cs42l51-i2c.c
+++ b/sound/soc/codecs/cs42l51-i2c.c
@@ -46,6 +46,7 @@ static struct i2c_driver cs42l51_i2c_driver = {
 	.driver = {
 		.name = "cs42l51",
 		.owner = THIS_MODULE,
+		.of_match_table = cs42l51_of_match,
 	},
 	.probe = cs42l51_i2c_probe,
 	.remove = cs42l51_i2c_remove,
diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 09488d9..669c38f 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -558,11 +558,13 @@ error:
 }
 EXPORT_SYMBOL_GPL(cs42l51_probe);
 
-static const struct of_device_id cs42l51_of_match[] = {
+const struct of_device_id cs42l51_of_match[] = {
 	{ .compatible = "cirrus,cs42l51", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, cs42l51_of_match);
+EXPORT_SYMBOL_GPL(cs42l51_of_match);
+
 MODULE_AUTHOR("Arnaud Patard <arnaud.patard@rtp-net.org>");
 MODULE_DESCRIPTION("Cirrus Logic CS42L51 ALSA SoC Codec Driver");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/cs42l51.h b/sound/soc/codecs/cs42l51.h
index 8c55bf3..0ca8054 100644
--- a/sound/soc/codecs/cs42l51.h
+++ b/sound/soc/codecs/cs42l51.h
@@ -22,6 +22,7 @@ struct device;
 
 extern const struct regmap_config cs42l51_regmap;
 int cs42l51_probe(struct device *dev, struct regmap *regmap);
+extern const struct of_device_id cs42l51_of_match[];
 
 #define CS42L51_CHIP_ID			0x1B
 #define CS42L51_CHIP_REV_A		0x00
-- 
2.0.0
