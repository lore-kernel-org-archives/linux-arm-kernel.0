From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 16 May 2015 02:23:34 +0200
Subject: [PATCH 05/14] reset: berlin: drop arch_initcall initialization
In-Reply-To: <1431735823-28006-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1431735823-28006-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1431735823-28006-6-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Antoine Tenart <antoine.tenart@free-electrons.com>

With proper platform driver probing for berlin reset driver, drop the
arch_initcall workaround.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/reset-berlin.c | 71 +-------------------------------------------
 1 file changed, 1 insertion(+), 70 deletions(-)

diff --git a/drivers/reset/reset-berlin.c b/drivers/reset/reset-berlin.c
index d43bc163dd02..3c922d37255c 100644
--- a/drivers/reset/reset-berlin.c
+++ b/drivers/reset/reset-berlin.c
@@ -27,8 +27,6 @@
 	container_of((p), struct berlin_reset_priv, rcdev)
 
 struct berlin_reset_priv {
-	void __iomem			*base;
-	unsigned int			size;
 	struct regmap			*regmap;
 	struct reset_controller_dev	rcdev;
 };
@@ -40,10 +38,7 @@ static int berlin_reset_reset(struct reset_controller_dev *rcdev,
 	int offset = id >> 8;
 	int mask = BIT(id & 0x1f);
 
-	if (priv->regmap)
-		regmap_write(priv->regmap, offset, mask);
-	else
-		writel(mask, priv->base + offset);
+	regmap_write(priv->regmap, offset, mask);
 
 	/* let the reset be effective */
 	udelay(10);
@@ -58,7 +53,6 @@ static struct reset_control_ops berlin_reset_ops = {
 static int berlin_reset_xlate(struct reset_controller_dev *rcdev,
 			      const struct of_phandle_args *reset_spec)
 {
-	struct berlin_reset_priv *priv = to_berlin_reset_priv(rcdev);
 	unsigned offset, bit;
 
 	if (WARN_ON(reset_spec->args_count != rcdev->of_reset_n_cells))
@@ -67,9 +61,6 @@ static int berlin_reset_xlate(struct reset_controller_dev *rcdev,
 	offset = reset_spec->args[0];
 	bit = reset_spec->args[1];
 
-	if (offset >= priv->size)
-		return -EINVAL;
-
 	if (bit >= BERLIN_MAX_RESETS)
 		return -EINVAL;
 
@@ -120,63 +111,3 @@ MODULE_AUTHOR("Antoine Tenart <antoine.tenart@free-electrons.com>");
 MODULE_AUTHOR("Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>");
 MODULE_DESCRIPTION("Marvell Berlin reset driver");
 MODULE_LICENSE("GPL");
-
-static int __berlin_reset_init(struct device_node *np)
-{
-	struct berlin_reset_priv *priv;
-	struct resource res;
-	resource_size_t size;
-	int ret;
-
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	ret = of_address_to_resource(np, 0, &res);
-	if (ret)
-		goto err;
-
-	size = resource_size(&res);
-	priv->base = ioremap(res.start, size);
-	if (!priv->base) {
-		ret = -ENOMEM;
-		goto err;
-	}
-	priv->size = size;
-
-	priv->rcdev.owner = THIS_MODULE;
-	priv->rcdev.ops = &berlin_reset_ops;
-	priv->rcdev.of_node = np;
-	priv->rcdev.of_reset_n_cells = 2;
-	priv->rcdev.of_xlate = berlin_reset_xlate;
-
-	reset_controller_register(&priv->rcdev);
-
-	return 0;
-
-err:
-	kfree(priv);
-	return ret;
-}
-
-static const struct of_device_id berlin_reset_of_match[] __initconst = {
-	{ .compatible = "marvell,berlin2-chip-ctrl" },
-	{ .compatible = "marvell,berlin2cd-chip-ctrl" },
-	{ .compatible = "marvell,berlin2q-chip-ctrl" },
-	{ },
-};
-
-static int __init berlin_reset_init(void)
-{
-	struct device_node *np;
-	int ret;
-
-	for_each_matching_node(np, berlin_reset_of_match) {
-		ret = __berlin_reset_init(np);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-arch_initcall(berlin_reset_init);
-- 
2.1.0
