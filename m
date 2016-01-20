From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Jan 2016 12:05:55 +0100
Subject: [PATCH v2] ASoC: avoid unused variable warning for rt5659_acpi_match
Message-ID: <1477393.QDzvbob2TI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added rt5659 codec driver unconditionally defines an
ACPI device match table but then uses ACPI_PTR() to remove the
only reference to it, so we get a harmless build warning:

sound/soc/codecs/rt5659.c:4200:30: warning: 'rt5659_acpi_match' defined but not used [-Wunused-variable]
 static struct acpi_device_id rt5659_acpi_match[] = {

This changes both the OF match table and the ACPI match table
to follow the same style, using ACPI_PTR/of_match_ptr to
make the reference conditional, and using an #ifdef to hide
the table. This also adds the missing MODULE_DEVICE_TABLE for
the OF case and adapts the formatting to the same style.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I still want to give this some time in the random build testing to avoid
introducing a stupid mistake, please apply after tomorrow unless you
hear from me otherwise.

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index c166d9394c69..efe87af33f8f 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -4183,24 +4183,29 @@ void rt5659_i2c_shutdown(struct i2c_client *client)
 	regmap_write(rt5659->regmap, RT5659_RESET, 0);
 }
 
+#ifdef CONFIG_OF
 static const struct of_device_id rt5659_of_match[] = {
 	{ .compatible = "realtek,rt5658", },
 	{ .compatible = "realtek,rt5659", },
-	{},
+	{ },
 };
+MODULE_DEVICE_TABLE(of, rt5659_of_match)
+#endif
 
+#ifdef CONFIG_ACPI
 static struct acpi_device_id rt5659_acpi_match[] = {
-		{ "10EC5658", 0},
-		{ "10EC5659", 0},
-		{ },
+	{ "10EC5658", 0, },
+	{ "10EC5659", 0, },
+	{ },
 };
 MODULE_DEVICE_TABLE(acpi, rt5659_acpi_match);
+#endif
 
 struct i2c_driver rt5659_i2c_driver = {
 	.driver = {
 		.name = "rt5659",
 		.owner = THIS_MODULE,
-		.of_match_table = rt5659_of_match,
+		.of_match_table = of_match_ptr(rt5659_of_match),
 		.acpi_match_table = ACPI_PTR(rt5659_acpi_match),
 	},
 	.probe = rt5659_i2c_probe,
