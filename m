From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 16 May 2015 02:23:32 +0200
Subject: [PATCH 03/14] reset: berlin: convert to a platform driver
In-Reply-To: <1431735823-28006-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1431735823-28006-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1431735823-28006-4-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Antoine Tenart <antoine.tenart@free-electrons.com>

The Berlin reset controller was introduced without being a platform
driver because of a needed DT rework: the node describing the reset
controller also describes the pinctrl and clk controllers...

Prepare conversion by adding a platform driver probe to a new
compatible "marvell,berlin2-reset" with syscon regmap.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/reset-berlin.c | 53 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/reset-berlin.c b/drivers/reset/reset-berlin.c
index f8b48a13cf0b..d43bc163dd02 100644
--- a/drivers/reset/reset-berlin.c
+++ b/drivers/reset/reset-berlin.c
@@ -11,10 +11,12 @@
 
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/reset-controller.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -27,6 +29,7 @@
 struct berlin_reset_priv {
 	void __iomem			*base;
 	unsigned int			size;
+	struct regmap			*regmap;
 	struct reset_controller_dev	rcdev;
 };
 
@@ -37,7 +40,10 @@ static int berlin_reset_reset(struct reset_controller_dev *rcdev,
 	int offset = id >> 8;
 	int mask = BIT(id & 0x1f);
 
-	writel(mask, priv->base + offset);
+	if (priv->regmap)
+		regmap_write(priv->regmap, offset, mask);
+	else
+		writel(mask, priv->base + offset);
 
 	/* let the reset be effective */
 	udelay(10);
@@ -70,6 +76,51 @@ static int berlin_reset_xlate(struct reset_controller_dev *rcdev,
 	return (offset << 8) | bit;
 }
 
+static int berlin2_reset_probe(struct platform_device *pdev)
+{
+	struct device_node *parent_np = of_get_parent(pdev->dev.of_node);
+	struct berlin_reset_priv *priv;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->regmap = syscon_node_to_regmap(parent_np);
+	of_node_put(parent_np);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+	priv->rcdev.owner = THIS_MODULE;
+	priv->rcdev.ops = &berlin_reset_ops;
+	priv->rcdev.of_node = pdev->dev.of_node;
+	priv->rcdev.of_reset_n_cells = 2;
+	priv->rcdev.of_xlate = berlin_reset_xlate;
+
+	reset_controller_register(&priv->rcdev);
+
+	return 0;
+}
+
+static const struct of_device_id berlin_reset_dt_match[] = {
+	{ .compatible = "marvell,berlin2-reset" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, berlin_reset_dt_match);
+
+static struct platform_driver berlin_reset_driver = {
+	.probe	= berlin2_reset_probe,
+	.driver	= {
+		.name = "berlin2-reset",
+		.of_match_table = berlin_reset_dt_match,
+	},
+};
+module_platform_driver(berlin_reset_driver);
+
+MODULE_AUTHOR("Antoine Tenart <antoine.tenart@free-electrons.com>");
+MODULE_AUTHOR("Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>");
+MODULE_DESCRIPTION("Marvell Berlin reset driver");
+MODULE_LICENSE("GPL");
+
 static int __berlin_reset_init(struct device_node *np)
 {
 	struct berlin_reset_priv *priv;
-- 
2.1.0
