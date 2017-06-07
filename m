From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Wed,  7 Jun 2017 12:32:41 +0200
Subject: [PATCH 3/4] regulator: tps65217: Fix module autoload for devices
 registered via OF
In-Reply-To: <20170607103242.16008-1-enric.balletbo@collabora.com>
References: <20170607103242.16008-1-enric.balletbo@collabora.com>
Message-ID: <20170607103242.16008-3-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver doesn't have a OF device ID table and so if devices are
registered via OF, module autoloading won't work.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 drivers/regulator/tps65217-regulator.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/regulator/tps65217-regulator.c b/drivers/regulator/tps65217-regulator.c
index 5324dc9..2c05360 100644
--- a/drivers/regulator/tps65217-regulator.c
+++ b/drivers/regulator/tps65217-regulator.c
@@ -263,9 +263,16 @@ static int tps65217_regulator_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id tps65217_regulator_match_table[] = {
+	{ .compatible = "ti,tps65217-pmic", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, tps65217_regulator_match_table);
+
 static struct platform_driver tps65217_regulator_driver = {
 	.driver = {
 		.name = "tps65217-pmic",
+		.of_match_table = tps65217_regulator_match_table,
 	},
 	.probe = tps65217_regulator_probe,
 };
-- 
2.9.3
