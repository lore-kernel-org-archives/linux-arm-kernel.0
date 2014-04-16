From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 16 Apr 2014 11:15:17 -0300
Subject: [PATCH 3/6] thermal: armada: Add generic infrastructure to handle the
 sensor
In-Reply-To: <1397657720-10893-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1397657720-10893-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1397657720-10893-4-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support similar SoC where the sensor value and valid
bit can have different offset and/or mask, we add such fields to the
per-variant structure, instead of having the values hardcoded.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/thermal/armada_thermal.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 4de6e56..3e4d8ef 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -24,10 +24,7 @@
 #include <linux/of_device.h>
 #include <linux/thermal.h>
 
-#define THERMAL_VALID_OFFSET		9
 #define THERMAL_VALID_MASK		0x1
-#define THERMAL_TEMP_OFFSET		10
-#define THERMAL_TEMP_MASK		0x1ff
 
 /* Thermal Manager Control and Status Register */
 #define PMU_TDC0_SW_RST_MASK		(0x1 << 1)
@@ -58,6 +55,11 @@ struct armada_thermal_data {
 	unsigned long coef_b;
 	unsigned long coef_m;
 	unsigned long coef_div;
+
+	/* Offset and mask to access the sensor temperature */
+	unsigned int temp_offset;
+	unsigned int temp_mask;
+	unsigned int is_valid_offset;
 };
 
 static void armadaxp_init_sensor(struct armada_thermal_priv *priv)
@@ -108,7 +110,7 @@ static bool armada_is_valid(struct armada_thermal_priv *priv)
 {
 	unsigned long reg = readl_relaxed(priv->sensor);
 
-	return (reg >> THERMAL_VALID_OFFSET) & THERMAL_VALID_MASK;
+	return (reg >> priv->data->is_valid_offset) & THERMAL_VALID_MASK;
 }
 
 static int armada_get_temp(struct thermal_zone_device *thermal,
@@ -126,7 +128,7 @@ static int armada_get_temp(struct thermal_zone_device *thermal,
 	}
 
 	reg = readl_relaxed(priv->sensor);
-	reg = (reg >> THERMAL_TEMP_OFFSET) & THERMAL_TEMP_MASK;
+	reg = (reg >> priv->data->temp_offset) & priv->data->temp_mask;
 
 	/* Get formula coeficients */
 	b = priv->data->coef_b;
@@ -143,6 +145,8 @@ static struct thermal_zone_device_ops ops = {
 
 static const struct armada_thermal_data armadaxp_data = {
 	.init_sensor = armadaxp_init_sensor,
+	.temp_offset = 10,
+	.temp_mask = 0x1ff,
 	.coef_b = 3153000000UL,
 	.coef_m = 10000000UL,
 	.coef_div = 13825,
@@ -151,6 +155,9 @@ static const struct armada_thermal_data armadaxp_data = {
 static const struct armada_thermal_data armada370_data = {
 	.is_valid = armada_is_valid,
 	.init_sensor = armada370_init_sensor,
+	.is_valid_offset = 9,
+	.temp_offset = 10,
+	.temp_mask = 0x1ff,
 	.coef_b = 3153000000UL,
 	.coef_m = 10000000UL,
 	.coef_div = 13825,
-- 
1.9.1
