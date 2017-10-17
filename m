From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 17 Oct 2017 15:03:03 +0200
Subject: [PATCH v4 2/5] reset: sunxi: use reset-simple driver
In-Reply-To: <20171017130306.881-1-p.zabel@pengutronix.de>
References: <20171017130306.881-1-p.zabel@pengutronix.de>
Message-ID: <20171017130306.881-3-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the newly created copies in the reset-simple driver to replace the
sunxi platform driver code and reset operations. The separate sunxi
driver still remains to register the early reset controllers, but it
reuses the reset operations in reset-simple.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Alexandru Gagniuc <alex.g@adaptrum.com>
---
Changes since v3:
 - Split patch 1 into reset-simple and reset-sunxi parts.
---
 drivers/reset/Kconfig       |   1 +
 drivers/reset/reset-sunxi.c | 104 +++-----------------------------------------
 2 files changed, 7 insertions(+), 98 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 392e65187cd5a..a14c0fe498771 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -100,6 +100,7 @@ config RESET_STM32
 config RESET_SUNXI
 	bool "Allwinner SoCs Reset Driver" if COMPILE_TEST && !ARCH_SUNXI
 	default ARCH_SUNXI
+	select RESET_SIMPLE
 	help
 	  This enables the reset driver for Allwinner SoCs.
 
diff --git a/drivers/reset/reset-sunxi.c b/drivers/reset/reset-sunxi.c
index 2c7dd1fd08df6..db9a1a75523f4 100644
--- a/drivers/reset/reset-sunxi.c
+++ b/drivers/reset/reset-sunxi.c
@@ -22,64 +22,11 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
-struct sunxi_reset_data {
-	spinlock_t			lock;
-	void __iomem			*membase;
-	struct reset_controller_dev	rcdev;
-};
-
-static int sunxi_reset_assert(struct reset_controller_dev *rcdev,
-			      unsigned long id)
-{
-	struct sunxi_reset_data *data = container_of(rcdev,
-						     struct sunxi_reset_data,
-						     rcdev);
-	int reg_width = sizeof(u32);
-	int bank = id / (reg_width * BITS_PER_BYTE);
-	int offset = id % (reg_width * BITS_PER_BYTE);
-	unsigned long flags;
-	u32 reg;
-
-	spin_lock_irqsave(&data->lock, flags);
-
-	reg = readl(data->membase + (bank * reg_width));
-	writel(reg & ~BIT(offset), data->membase + (bank * reg_width));
-
-	spin_unlock_irqrestore(&data->lock, flags);
-
-	return 0;
-}
-
-static int sunxi_reset_deassert(struct reset_controller_dev *rcdev,
-				unsigned long id)
-{
-	struct sunxi_reset_data *data = container_of(rcdev,
-						     struct sunxi_reset_data,
-						     rcdev);
-	int reg_width = sizeof(u32);
-	int bank = id / (reg_width * BITS_PER_BYTE);
-	int offset = id % (reg_width * BITS_PER_BYTE);
-	unsigned long flags;
-	u32 reg;
-
-	spin_lock_irqsave(&data->lock, flags);
-
-	reg = readl(data->membase + (bank * reg_width));
-	writel(reg | BIT(offset), data->membase + (bank * reg_width));
-
-	spin_unlock_irqrestore(&data->lock, flags);
-
-	return 0;
-}
-
-static const struct reset_control_ops sunxi_reset_ops = {
-	.assert		= sunxi_reset_assert,
-	.deassert	= sunxi_reset_deassert,
-};
+#include "reset-simple.h"
 
 static int sunxi_reset_init(struct device_node *np)
 {
-	struct sunxi_reset_data *data;
+	struct reset_simple_data *data;
 	struct resource res;
 	resource_size_t size;
 	int ret;
@@ -108,8 +55,9 @@ static int sunxi_reset_init(struct device_node *np)
 
 	data->rcdev.owner = THIS_MODULE;
 	data->rcdev.nr_resets = size * 8;
-	data->rcdev.ops = &sunxi_reset_ops;
+	data->rcdev.ops = &reset_simple_ops;
 	data->rcdev.of_node = np;
+	data->active_low = true;
 
 	return reset_controller_register(&data->rcdev);
 
@@ -122,6 +70,8 @@ static int sunxi_reset_init(struct device_node *np)
  * These are the reset controller we need to initialize early on in
  * our system, before we can even think of using a regular device
  * driver for it.
+ * The controllers that we can register through the regular device
+ * model are handled by the simple reset driver directly.
  */
 static const struct of_device_id sunxi_early_reset_dt_ids[] __initconst = {
 	{ .compatible = "allwinner,sun6i-a31-ahb1-reset", },
@@ -135,45 +85,3 @@ void __init sun6i_reset_init(void)
 	for_each_matching_node(np, sunxi_early_reset_dt_ids)
 		sunxi_reset_init(np);
 }
-
-/*
- * And these are the controllers we can register through the regular
- * device model.
- */
-static const struct of_device_id sunxi_reset_dt_ids[] = {
-	 { .compatible = "allwinner,sun6i-a31-clock-reset", },
-	 { /* sentinel */ },
-};
-
-static int sunxi_reset_probe(struct platform_device *pdev)
-{
-	struct sunxi_reset_data *data;
-	struct resource *res;
-
-	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->membase = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(data->membase))
-		return PTR_ERR(data->membase);
-
-	spin_lock_init(&data->lock);
-
-	data->rcdev.owner = THIS_MODULE;
-	data->rcdev.nr_resets = resource_size(res) * 8;
-	data->rcdev.ops = &sunxi_reset_ops;
-	data->rcdev.of_node = pdev->dev.of_node;
-
-	return devm_reset_controller_register(&pdev->dev, &data->rcdev);
-}
-
-static struct platform_driver sunxi_reset_driver = {
-	.probe	= sunxi_reset_probe,
-	.driver = {
-		.name		= "sunxi-reset",
-		.of_match_table	= sunxi_reset_dt_ids,
-	},
-};
-builtin_platform_driver(sunxi_reset_driver);
-- 
2.11.0
