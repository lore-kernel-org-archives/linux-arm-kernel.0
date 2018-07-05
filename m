From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Thu,  5 Jul 2018 18:04:24 +0200
Subject: [PATCH v3 10/23] thermal: armada: remove sensors validity from the IP
 initialization
In-Reply-To: <20180705160437.12325-1-miquel.raynal@bootlin.com>
References: <20180705160437.12325-1-miquel.raynal@bootlin.com>
Message-ID: <20180705160437.12325-11-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using new bindings with multiple sensors, sensor validity is
checked twice because sensor selection also checks for the validity.

Remove the redundant call from the IP initialization helper and move it
to the legacy probe section where it is still needed.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/thermal/armada_thermal.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index eef8947b9b20..7eafc9400fbe 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -221,9 +221,6 @@ static void armada380_init(struct platform_device *pdev,
 	reg &= ~CONTROL0_TSEN_TC_TRIM_MASK;
 	reg |= CONTROL0_TSEN_TC_TRIM_VAL;
 	regmap_write(priv->syscon, data->syscon_control0_off, reg);
-
-	/* Wait the sensors to be valid or the core will warn the user */
-	armada_wait_sensor_validity(priv);
 }
 
 static void armada_ap806_init(struct platform_device *pdev,
@@ -243,9 +240,6 @@ static void armada_ap806_init(struct platform_device *pdev,
 	reg &= ~CONTROL0_TSEN_AVG_BYPASS;
 
 	regmap_write(priv->syscon, data->syscon_control0_off, reg);
-
-	/* Wait the sensors to be valid or the core will warn the user */
-	armada_wait_sensor_validity(priv);
 }
 
 static void armada_cp110_init(struct platform_device *pdev,
@@ -650,6 +644,9 @@ static int armada_thermal_probe(struct platform_device *pdev)
 
 		priv->data->init(pdev, priv);
 
+		/* Wait the sensors to be valid */
+		armada_wait_sensor_validity(priv);
+
 		tz = thermal_zone_device_register(priv->zone_name, 0, 0, priv,
 						  &legacy_ops, NULL, 0, 0);
 		if (IS_ERR(tz)) {
-- 
2.14.1
