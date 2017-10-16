From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 16 Oct 2017 17:26:13 +0200
Subject: [PATCH] reset: meson: add level reset support for GX SoC family
Message-ID: <1508167573-17396-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Amlogic GX SoC family embeds alternate registers to drive the reset
levels next to the pulse registers.

This patch adds support for level reset handling on the GX family only.

The Meson8 family has an alternate way to handle level reset.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/reset/reset-meson.c | 57 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index a8b915e..d55e440 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -62,9 +62,11 @@
 #include <linux/reset-controller.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/of_device.h>
 
 #define REG_COUNT	8
 #define BITS_PER_REG	32
+#define LEVEL_OFFSET	0x7c
 
 struct meson_reset {
 	void __iomem *reg_base;
@@ -88,18 +90,61 @@ static int meson_reset_reset(struct reset_controller_dev *rcdev,
 	return 0;
 }
 
-static const struct reset_control_ops meson_reset_ops = {
+static int meson_reset_level(struct reset_controller_dev *rcdev,
+			    unsigned long id, bool assert)
+{
+	struct meson_reset *data =
+		container_of(rcdev, struct meson_reset, rcdev);
+	unsigned int bank = id / BITS_PER_REG;
+	unsigned int offset = id % BITS_PER_REG;
+	void __iomem *reg_addr = data->reg_base + LEVEL_OFFSET + (bank << 2);
+	u32 reg;
+
+	if (bank >= REG_COUNT)
+		return -EINVAL;
+
+	reg = readl(reg_addr);
+	if (assert)
+		writel(reg & ~BIT(offset), reg_addr);
+	else
+		writel(reg | BIT(offset), reg_addr);
+
+	return 0;
+}
+
+static int meson_reset_assert(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	return meson_reset_level(rcdev, id, true);
+}
+
+static int meson_reset_deassert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	return meson_reset_level(rcdev, id, false);
+}
+
+static const struct reset_control_ops meson_reset_meson8_ops = {
+	.reset		= meson_reset_reset,
+};
+
+static const struct reset_control_ops meson_reset_gx_ops = {
 	.reset		= meson_reset_reset,
+	.assert		= meson_reset_assert,
+	.deassert	= meson_reset_deassert,
 };
 
 static const struct of_device_id meson_reset_dt_ids[] = {
-	 { .compatible = "amlogic,meson8b-reset", },
-	 { .compatible = "amlogic,meson-gxbb-reset", },
+	 { .compatible = "amlogic,meson8b-reset",
+	   .data = (void *) &meson_reset_meson8_ops, },
+	 { .compatible = "amlogic,meson-gxbb-reset",
+	   .data = (void *) &meson_reset_gx_ops, },
 	 { /* sentinel */ },
 };
 
 static int meson_reset_probe(struct platform_device *pdev)
 {
+	const struct reset_control_ops *ops;
 	struct meson_reset *data;
 	struct resource *res;
 
@@ -107,6 +152,10 @@ static int meson_reset_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
+	ops = of_device_get_match_data(&pdev->dev);
+	if (!ops)
+		return -EINVAL;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	data->reg_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(data->reg_base))
@@ -116,7 +165,7 @@ static int meson_reset_probe(struct platform_device *pdev)
 
 	data->rcdev.owner = THIS_MODULE;
 	data->rcdev.nr_resets = REG_COUNT * BITS_PER_REG;
-	data->rcdev.ops = &meson_reset_ops;
+	data->rcdev.ops = ops;
 	data->rcdev.of_node = pdev->dev.of_node;
 
 	return devm_reset_controller_register(&pdev->dev, &data->rcdev);
-- 
2.7.4
