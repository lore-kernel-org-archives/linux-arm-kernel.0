From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 25 Jan 2016 11:37:16 -0300
Subject: [PATCH 2/2] regulator: mt6397: Add OF match table
In-Reply-To: <1453732637-20415-1-git-send-email-javier@osg.samsung.com>
References: <1453732637-20415-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1453732637-20415-3-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Documentation/devicetree/bindings/regulator/mt6397-regulator.txt doc
mentions that a compatible "mediatek,mt6397-regulator" is required for
the MT6397 device node but the driver doesn't provide a OF match table so
the platform bus .match fallbacks to match using the driver name instead.

This also means that module auto-loading is broken for this driver since
the MFD driver that register the device, has a .of_compatible set so the
platform .uevent callback reports a OF modalias that's not in the module.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/regulator/mt6397-regulator.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/regulator/mt6397-regulator.c b/drivers/regulator/mt6397-regulator.c
index 585f0399a36b..17a5b6c2d6a9 100644
--- a/drivers/regulator/mt6397-regulator.c
+++ b/drivers/regulator/mt6397-regulator.c
@@ -323,9 +323,16 @@ static const struct platform_device_id mt6397_platform_ids[] = {
 };
 MODULE_DEVICE_TABLE(platform, mt6397_platform_ids);
 
+static const struct of_device_id mt6397_of_match[] = {
+	{ .compatible = "mediatek,mt6397-regulator", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, mt6397_of_match);
+
 static struct platform_driver mt6397_regulator_driver = {
 	.driver = {
 		.name = "mt6397-regulator",
+		.of_match_table = of_match_ptr(mt6397_of_match),
 	},
 	.probe = mt6397_regulator_probe,
 	.id_table = mt6397_platform_ids,
-- 
2.5.0
