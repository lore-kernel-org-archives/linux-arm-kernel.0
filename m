From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 25 Jan 2016 11:37:15 -0300
Subject: [PATCH 1/2] regulator: mt6397: Add platform device ID table
In-Reply-To: <1453732637-20415-1-git-send-email-javier@osg.samsung.com>
References: <1453732637-20415-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1453732637-20415-2-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform bus_type .match callback attempts to match the platform device
name with an entry on the .id_table if provided and fallbacks to match with
the driver's name if a table is not provided.

Using a platform device ID to match is more explicit, allows the driver to
support more than one device and also the MODULE_DEVICE_TABLE macro can be
used to export the module aliases information instead of the MODULE_ALIAS.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/regulator/mt6397-regulator.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/mt6397-regulator.c b/drivers/regulator/mt6397-regulator.c
index a5b2f4762677..585f0399a36b 100644
--- a/drivers/regulator/mt6397-regulator.c
+++ b/drivers/regulator/mt6397-regulator.c
@@ -317,11 +317,18 @@ static int mt6397_regulator_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct platform_device_id mt6397_platform_ids[] = {
+	{"mt6397-regulator", 0},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(platform, mt6397_platform_ids);
+
 static struct platform_driver mt6397_regulator_driver = {
 	.driver = {
 		.name = "mt6397-regulator",
 	},
 	.probe = mt6397_regulator_probe,
+	.id_table = mt6397_platform_ids,
 };
 
 module_platform_driver(mt6397_regulator_driver);
@@ -329,4 +336,3 @@ module_platform_driver(mt6397_regulator_driver);
 MODULE_AUTHOR("Flora Fu <flora.fu@mediatek.com>");
 MODULE_DESCRIPTION("Regulator Driver for MediaTek MT6397 PMIC");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:mt6397-regulator");
-- 
2.5.0
