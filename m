From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Thu,  5 Jul 2018 18:04:19 +0200
Subject: [PATCH v3 05/23] thermal: armada: dissociate a380 and cp110 ->init()
 hooks
In-Reply-To: <20180705160437.12325-1-miquel.raynal@bootlin.com>
References: <20180705160437.12325-1-miquel.raynal@bootlin.com>
Message-ID: <20180705160437.12325-6-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Until now, Armada 380 and CP110 could share the same ->init() function
because their use was identical.

Prepare the support of multi-sensors support and overheat interrupt
feature by separating the initialization paths before they actually
diverge.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/thermal/armada_thermal.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 3d22a6016b04..9291ea3ad2f7 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -200,6 +200,12 @@ static void armada_ap806_init(struct platform_device *pdev,
 	armada_wait_sensor_validity(priv);
 }
 
+static void armada_cp110_init(struct platform_device *pdev,
+			      struct armada_thermal_priv *priv)
+{
+	armada380_init(pdev, priv);
+}
+
 static bool armada_is_valid(struct armada_thermal_priv *priv)
 {
 	u32 reg = readl_relaxed(priv->status);
@@ -306,7 +312,7 @@ static const struct armada_thermal_data armada_ap806_data = {
 
 static const struct armada_thermal_data armada_cp110_data = {
 	.is_valid = armada_is_valid,
-	.init = armada380_init,
+	.init = armada_cp110_init,
 	.is_valid_bit = BIT(10),
 	.temp_shift = 0,
 	.temp_mask = 0x3ff,
-- 
2.14.1
