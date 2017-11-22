From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 22 Nov 2017 16:42:05 +0200
Subject: [PATCH 3/3] thermal: armada: add support for CP110
In-Reply-To: <7102bb32704ac9f70ef3ae61682d50de8af61b57.1511361725.git.baruch@tkos.co.il>
References: <7102bb32704ac9f70ef3ae61682d50de8af61b57.1511361725.git.baruch@tkos.co.il>
Message-ID: <adccb0e7b20cc128663701eadcf6ebce412dfe5e.1511361725.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CP110 component is integrated in the Armada 8k and 7k lines of processors.

This patch also adds an option of offset to the MSB of the control
register. The existing DT binding for Armada 38x refers to a single 32 bit
control register. It turns out that this is actually only the MSB of the
control area. Changing the binding to fix that would break existing DT files,
so the Armada 38x binding is left as is.

The new CP110 binding increases the size of the control area to 64 bits, thus
moving the MSB to offset 4.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/thermal/armada_thermal.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 1f7f81628040..542db578ce36 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -72,6 +72,7 @@ struct armada_thermal_data {
 	unsigned int temp_shift;
 	unsigned int temp_mask;
 	unsigned int is_valid_shift;
+	unsigned int control_msb_offset;
 };
 
 static void armadaxp_init_sensor(struct platform_device *pdev,
@@ -141,12 +142,14 @@ static void armada375_init_sensor(struct platform_device *pdev,
 static void armada380_init_sensor(struct platform_device *pdev,
 				  struct armada_thermal_priv *priv)
 {
-	unsigned long reg = readl_relaxed(priv->control);
+	void __iomem *control_msb =
+		priv->control + priv->data->control_msb_offset;
+	unsigned long reg = readl_relaxed(control_msb);
 
 	/* Reset hardware once */
 	if (!(reg & A380_HW_RESET)) {
 		reg |= A380_HW_RESET;
-		writel(reg, priv->control);
+		writel(reg, control_msb);
 		mdelay(10);
 	}
 }
@@ -258,6 +261,19 @@ static const struct armada_thermal_data armada_ap806_data = {
 	.inverted = true,
 };
 
+static const struct armada_thermal_data armada_cp110_data = {
+	.is_valid = armada_is_valid,
+	.init_sensor = armada380_init_sensor,
+	.is_valid_shift = 10,
+	.temp_shift = 0,
+	.temp_mask = 0x3ff,
+	.control_msb_offset = 4,
+	.coef_b = 1172499100UL,
+	.coef_m = 2000096UL,
+	.coef_div = 4201,
+	.inverted = true,
+};
+
 static const struct of_device_id armada_thermal_id_table[] = {
 	{
 		.compatible = "marvell,armadaxp-thermal",
@@ -279,6 +295,10 @@ static const struct of_device_id armada_thermal_id_table[] = {
 		.compatible = "marvell,armada-ap806-thermal",
 		.data       = &armada_ap806_data,
 	},
+	{
+		.compatible = "marvell,armada-cp110-thermal",
+		.data       = &armada_cp110_data,
+	},
 	{
 		/* sentinel */
 	},
-- 
2.15.0
