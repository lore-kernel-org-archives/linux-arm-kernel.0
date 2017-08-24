From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 24 Aug 2017 18:24:11 +0100
Subject: [PATCH] gpio: xgene-sb: Tidy up fwnode usage
Message-ID: <2ccfa46003fb5cf5970dc5cd8771953d375fed77.1503594687.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since f94277af03ea ("of/platform: Initialise dev->fwnode appropriately"),
of_platform_device_create() already initialises dev->fwnode to that of
the appropriate device_node, so within the driver we shouldn't need to
care whether we probed via DT or ACPI.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Not tested, just an opportunity I happened to spot whilst looking
at something else.

 drivers/gpio/gpio-xgene-sb.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-xgene-sb.c b/drivers/gpio/gpio-xgene-sb.c
index 033258634b8c..82c3ee6da66a 100644
--- a/drivers/gpio/gpio-xgene-sb.c
+++ b/drivers/gpio/gpio-xgene-sb.c
@@ -130,10 +130,7 @@ static int xgene_gpio_sb_to_irq(struct gpio_chip *gc, u32 gpio)
 			(gpio > HWIRQ_TO_GPIO(priv, priv->nirq)))
 		return -ENXIO;
 
-	if (gc->parent->of_node)
-		fwspec.fwnode = of_node_to_fwnode(gc->parent->of_node);
-	else
-		fwspec.fwnode = gc->parent->fwnode;
+	fwspec.fwnode = gc->parent->fwnode;
 	fwspec.param_count = 2;
 	fwspec.param[0] = GPIO_TO_HWIRQ(priv, gpio);
 	fwspec.param[1] = IRQ_TYPE_NONE;
@@ -231,7 +228,6 @@ static int xgene_gpio_sb_probe(struct platform_device *pdev)
 	struct resource *res;
 	void __iomem *regs;
 	struct irq_domain *parent_domain = NULL;
-	struct fwnode_handle *fwnode;
 	u32 val32;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -285,13 +281,8 @@ static int xgene_gpio_sb_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	if (pdev->dev.of_node)
-		fwnode = of_node_to_fwnode(pdev->dev.of_node);
-	else
-		fwnode = pdev->dev.fwnode;
-
 	priv->irq_domain = irq_domain_create_hierarchy(parent_domain,
-					0, priv->nirq, fwnode,
+					0, priv->nirq, pdev->dev.fwnode,
 					&xgene_gpio_sb_domain_ops, priv);
 	if (!priv->irq_domain)
 		return -ENODEV;
-- 
2.13.4.dirty
