From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Thu, 14 Dec 2017 11:30:10 +0100
Subject: [PATCH v3 10/11] thermal: armada: Give useful names to the thermal
 zone
In-Reply-To: <20171214103011.24713-1-miquel.raynal@free-electrons.com>
References: <20171214103011.24713-1-miquel.raynal@free-electrons.com>
Message-ID: <20171214103011.24713-11-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After registration to the thermal core, sysfs will make one entry
per instance of the driver in /sys/class/thermal_zoneX and
/sys/class/hwmon/hwmonX, X being the index of the instance, all of them
having the type/name "armada_thermal".

Until now there was only one thermal zone per SoC but SoCs like Armada
A7K and Armada A8K have respectively two and three thermal zones (one
per AP and one per CP) and this number is subject to grow in the future.

Because there is no easy way to name them effectively, use the new DT
property "marvell,thermal-zone-name" if it is available.

Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
---
 drivers/thermal/armada_thermal.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 1c4122f7377c..b31d03dde44b 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -357,6 +357,8 @@ MODULE_DEVICE_TABLE(of, armada_thermal_id_table);
 
 static int armada_thermal_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
+	const char *zone_name = "armada_thermal";
 	void __iomem *control = NULL;
 	struct thermal_zone_device *thermal;
 	const struct of_device_id *match;
@@ -398,8 +400,14 @@ static int armada_thermal_probe(struct platform_device *pdev)
 	priv->data = (struct armada_thermal_data *)match->data;
 	priv->data->init_sensor(pdev, priv);
 
-	thermal = thermal_zone_device_register("armada_thermal", 0, 0,
-					       priv, &ops, NULL, 0, 0);
+	/*
+	 * Some platforms use several instances of this driver without any way
+	 * to identify them. Use a new property to gave the thermal zone name a
+	 * valid meaning (used by hwmon too).
+	 */
+	of_property_read_string(np, "marvell,thermal-zone-name", &zone_name);
+	thermal = thermal_zone_device_register(zone_name, 0, 0, priv, &ops,
+					       NULL, 0, 0);
 	if (IS_ERR(thermal)) {
 		dev_err(&pdev->dev,
 			"Failed to register thermal zone device\n");
-- 
2.11.0
