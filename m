From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Tue, 19 Dec 2017 14:57:19 +0100
Subject: [PATCH v5 11/11] thermal: armada: Give meaningful names to the
 thermal zones
In-Reply-To: <20171219135719.9531-1-miquel.raynal@free-electrons.com>
References: <20171219135719.9531-1-miquel.raynal@free-electrons.com>
Message-ID: <20171219135719.9531-12-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After registration to the thermal core, sysfs will make one entry
per instance of the driver in /sys/class/thermal_zoneX and
/sys/class/hwmon/hwmonX, X being the index of the instance, all of them
having the type/name "armada_thermal".

Until now there was only one thermal zone per SoC but SoCs like Armada
A7K and Armada A8K have respectively two and three thermal zones (one
per AP and one per CP) and this number is subject to grow in the future.

Use dev_name() instead of the "armada_thermal" string to get a
meaningful name and be able to identify the thermal zones from
userspace.

Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/thermal/armada_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 346a0c781057..362d2e356696 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -404,8 +404,8 @@ static int armada_thermal_probe(struct platform_device *pdev)
 
 	priv->data->init_sensor(pdev, priv);
 
-	thermal = thermal_zone_device_register("armada_thermal", 0, 0,
-					       priv, &ops, NULL, 0, 0);
+	thermal = thermal_zone_device_register(dev_name(&pdev->dev), 0, 0, priv,
+					       &ops, NULL, 0, 0);
 	if (IS_ERR(thermal)) {
 		dev_err(&pdev->dev,
 			"Failed to register thermal zone device\n");
-- 
2.11.0
