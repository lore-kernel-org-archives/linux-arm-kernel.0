From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Mon, 18 Dec 2017 15:36:36 +0100
Subject: [PATCH v4 05/12] thermal: armada: Use real status register name
In-Reply-To: <20171218143643.7714-1-miquel.raynal@free-electrons.com>
References: <20171218143643.7714-1-miquel.raynal@free-electrons.com>
Message-ID: <20171218143643.7714-6-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Three 32-bit registers are used to drive the thermal IP: control0,
control1 and status. The two control registers share the same name both
in the documentation and in the code, while the latter is referred as
"sensor" in the code. Rename this pointer to be called "status" in order
to be aligned with the documentation.

Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
---
 drivers/thermal/armada_thermal.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index f422563e617c..198485fa77f2 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -51,7 +51,7 @@ struct armada_thermal_data;
 
 /* Marvell EBU Thermal Sensor Dev Structure */
 struct armada_thermal_priv {
-	void __iomem *sensor;
+	void __iomem *status;
 	void __iomem *control0;
 	void __iomem *control1;
 	struct armada_thermal_data *data;
@@ -98,9 +98,9 @@ static void armadaxp_init_sensor(struct platform_device *pdev,
 	writel(reg, priv->control1);
 
 	/* Enable the sensor */
-	reg = readl_relaxed(priv->sensor);
+	reg = readl_relaxed(priv->status);
 	reg &= ~PMU_TM_DISABLE_MASK;
-	writel(reg, priv->sensor);
+	writel(reg, priv->status);
 }
 
 static void armada370_init_sensor(struct platform_device *pdev,
@@ -156,7 +156,7 @@ static void armada380_init_sensor(struct platform_device *pdev,
 
 static bool armada_is_valid(struct armada_thermal_priv *priv)
 {
-	u32 reg = readl_relaxed(priv->sensor);
+	u32 reg = readl_relaxed(priv->status);
 
 	return reg & priv->data->is_valid_bit;
 }
@@ -175,7 +175,7 @@ static int armada_get_temp(struct thermal_zone_device *thermal,
 		return -EIO;
 	}
 
-	reg = readl_relaxed(priv->sensor);
+	reg = readl_relaxed(priv->status);
 	reg = (reg >> priv->data->temp_shift) & priv->data->temp_mask;
 
 	/* Get formula coeficients */
@@ -277,9 +277,9 @@ static int armada_thermal_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->sensor = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(priv->sensor))
-		return PTR_ERR(priv->sensor);
+	priv->status = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->status))
+		return PTR_ERR(priv->status);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	control = devm_ioremap_resource(&pdev->dev, res);
-- 
2.11.0
