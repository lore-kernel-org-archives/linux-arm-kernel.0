From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Thu,  5 Jul 2018 18:04:25 +0200
Subject: [PATCH v3 11/23] thermal: armada: move validity check out of the read
 function
In-Reply-To: <20180705160437.12325-1-miquel.raynal@bootlin.com>
References: <20180705160437.12325-1-miquel.raynal@bootlin.com>
Message-ID: <20180705160437.12325-12-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sensor selection when using multiple sensors already checks for the
sensor validity. Move it to the legacy ->get_temp() hook, where it is
still needed.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/thermal/armada_thermal.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 7eafc9400fbe..7f8185e5816e 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -328,13 +328,6 @@ static int armada_read_sensor(struct armada_thermal_priv *priv, int *temp)
 	u32 reg, div;
 	s64 sample, b, m;
 
-	/* Valid check */
-	if (priv->data->is_valid && !priv->data->is_valid(priv)) {
-		dev_err(priv->dev,
-			"Temperature sensor reading not valid\n");
-		return -EIO;
-	}
-
 	regmap_read(priv->syscon, priv->data->syscon_status_off, &reg);
 	reg = (reg >> priv->data->temp_shift) & priv->data->temp_mask;
 	if (priv->data->signed_sample)
@@ -362,6 +355,13 @@ static int armada_get_temp_legacy(struct thermal_zone_device *thermal,
 	struct armada_thermal_priv *priv = thermal->devdata;
 	int ret;
 
+	/* Valid check */
+	if (priv->data->is_valid && !priv->data->is_valid(priv)) {
+		dev_err(priv->dev,
+			"Temperature sensor reading not valid\n");
+		return -EIO;
+	}
+
 	/* Do the actual reading */
 	ret = armada_read_sensor(priv, temp);
 
-- 
2.14.1
