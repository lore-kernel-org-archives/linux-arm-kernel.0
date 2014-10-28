From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 28 Oct 2014 17:08:39 +0100
Subject: [PATCH 1/6] ASoC: cs42l51: re-add of_match_table pointer
In-Reply-To: <1414512524-24466-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414512524-24466-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1414512524-24466-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit a1253ef6d3fa ("ASoC: cs42l51: split i2c from codec driver"),
the I2C part of the CS42L51 was moved to a separate file, but the
definition of the of_device_id array was left in the driver file
itself, no longer connected to the platform_driver structure using the
.of_match_table pointer.

This commit therefore moves the of_device_id array into the
cs42l51-i2c.c file, and restore the proper .of_match_table pointer.

Fixes: a1253ef6d3fa ("ASoC: cs42l51: split i2c from codec driver")
Cc: <stable@vger.kernel.org> # v3.16+
Cc: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Cc: Brian Austin <brian.austin@cirrus.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 sound/soc/codecs/cs42l51-i2c.c | 7 +++++++
 sound/soc/codecs/cs42l51.c     | 5 -----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs42l51-i2c.c b/sound/soc/codecs/cs42l51-i2c.c
index cee51ae..216a610 100644
--- a/sound/soc/codecs/cs42l51-i2c.c
+++ b/sound/soc/codecs/cs42l51-i2c.c
@@ -17,6 +17,12 @@
 
 #include "cs42l51.h"
 
+static const struct of_device_id cs42l51_of_match[] = {
+	{ .compatible = "cirrus,cs42l51", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, cs42l51_of_match);
+
 static struct i2c_device_id cs42l51_i2c_id[] = {
 	{"cs42l51", 0},
 	{}
@@ -46,6 +52,7 @@ static struct i2c_driver cs42l51_i2c_driver = {
 	.driver = {
 		.name = "cs42l51",
 		.owner = THIS_MODULE,
+		.of_match_table = cs42l51_of_match,
 	},
 	.probe = cs42l51_i2c_probe,
 	.remove = cs42l51_i2c_remove,
diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 09488d9..56ecc1e 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -558,11 +558,6 @@ error:
 }
 EXPORT_SYMBOL_GPL(cs42l51_probe);
 
-static const struct of_device_id cs42l51_of_match[] = {
-	{ .compatible = "cirrus,cs42l51", },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, cs42l51_of_match);
 MODULE_AUTHOR("Arnaud Patard <arnaud.patard@rtp-net.org>");
 MODULE_DESCRIPTION("Cirrus Logic CS42L51 ALSA SoC Codec Driver");
 MODULE_LICENSE("GPL");
-- 
2.0.0
