From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Tue, 27 Nov 2018 20:37:36 -0800
Subject: [PATCH v2 1/3] reset: imx7: Add plubming to support multiple IP
 variants
In-Reply-To: <20181128043738.12714-1-andrew.smirnov@gmail.com>
References: <20181128043738.12714-1-andrew.smirnov@gmail.com>
Message-ID: <20181128043738.12714-2-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to enable supporting i.MX8MQ with this driver, convert it to
expect variant specific bits to be passed via driver data.

Cc: p.zabel at pengutronix.de
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: cphealy at gmail.com
Cc: l.stach at pengutronix.de
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree at vger.kernel.org
Cc: linux-imx at nxp.com
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/reset/reset-imx7.c | 62 +++++++++++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 17 deletions(-)

diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
index 77911fa8f31d..cfbb6346a72e 100644
--- a/drivers/reset/reset-imx7.c
+++ b/drivers/reset/reset-imx7.c
@@ -17,14 +17,29 @@
 
 #include <linux/mfd/syscon.h>
 #include <linux/mod_devicetable.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 #include <linux/regmap.h>
 #include <dt-bindings/reset/imx7-reset.h>
 
+struct imx7_src_signal {
+	unsigned int offset, bit;
+};
+
+struct imx7_src;
+
+struct imx7_src_variant {
+	const struct imx7_src_signal *signals;
+	unsigned int signals_num;
+	unsigned int (*prepare)(struct imx7_src *imx7src, unsigned long id,
+				bool assert);
+};
+
 struct imx7_src {
 	struct reset_controller_dev rcdev;
 	struct regmap *regmap;
+	struct imx7_src_variant *variant;
 };
 
 enum imx7_src_registers {
@@ -39,10 +54,6 @@ enum imx7_src_registers {
 	SRC_DDRC_RCR		= 0x1000,
 };
 
-struct imx7_src_signal {
-	unsigned int offset, bit;
-};
-
 static const struct imx7_src_signal imx7_src_signals[IMX7_RESET_NUM] = {
 	[IMX7_RESET_A7_CORE_POR_RESET0] = { SRC_A7RCR0, BIT(0) },
 	[IMX7_RESET_A7_CORE_POR_RESET1] = { SRC_A7RCR0, BIT(1) },
@@ -72,17 +83,11 @@ static const struct imx7_src_signal imx7_src_signals[IMX7_RESET_NUM] = {
 	[IMX7_RESET_DDRC_CORE_RST]	= { SRC_DDRC_RCR, BIT(1) },
 };
 
-static struct imx7_src *to_imx7_src(struct reset_controller_dev *rcdev)
+static unsigned int
+imx7_src_prepare(struct imx7_src *imx7src, unsigned long id, bool assert)
 {
-	return container_of(rcdev, struct imx7_src, rcdev);
-}
-
-static int imx7_reset_set(struct reset_controller_dev *rcdev,
-			  unsigned long id, bool assert)
-{
-	struct imx7_src *imx7src = to_imx7_src(rcdev);
-	const struct imx7_src_signal *signal = &imx7_src_signals[id];
-	unsigned int value = assert ? signal->bit : 0;
+	const unsigned int bit = imx7src->variant->signals[id].bit;
+	unsigned int value = assert ? bit : 0;
 
 	switch (id) {
 	case IMX7_RESET_PCIEPHY:
@@ -95,10 +100,32 @@ static int imx7_reset_set(struct reset_controller_dev *rcdev,
 		break;
 
 	case IMX7_RESET_PCIE_CTRL_APPS_EN:
-		value = (assert) ? 0 : signal->bit;
+		value = assert ? 0 : bit;
 		break;
 	}
 
+	return value;
+}
+
+static const struct imx7_src_variant variant_imx7 = {
+	.signals = imx7_src_signals,
+	.signals_num = ARRAY_SIZE(imx7_src_signals),
+	.prepare = imx7_src_prepare,
+};
+
+static struct imx7_src *to_imx7_src(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct imx7_src, rcdev);
+}
+
+static int imx7_reset_set(struct reset_controller_dev *rcdev,
+			  unsigned long id, bool assert)
+{
+	struct imx7_src *imx7src = to_imx7_src(rcdev);
+	const struct imx7_src_variant *variant = imx7src->variant;
+	const struct imx7_src_signal *signal = &variant->signals[id];
+	const unsigned int value = variant->prepare(imx7src, id, assert);
+
 	return regmap_update_bits(imx7src->regmap,
 				  signal->offset, signal->bit, value);
 }
@@ -130,6 +157,7 @@ static int imx7_reset_probe(struct platform_device *pdev)
 	if (!imx7src)
 		return -ENOMEM;
 
+	imx7src->variant = of_device_get_match_data(dev);
 	imx7src->regmap = syscon_node_to_regmap(dev->of_node);
 	if (IS_ERR(imx7src->regmap)) {
 		dev_err(dev, "Unable to get imx7-src regmap");
@@ -138,7 +166,7 @@ static int imx7_reset_probe(struct platform_device *pdev)
 	regmap_attach_dev(dev, imx7src->regmap, &config);
 
 	imx7src->rcdev.owner     = THIS_MODULE;
-	imx7src->rcdev.nr_resets = IMX7_RESET_NUM;
+	imx7src->rcdev.nr_resets = imx7src->variant->signals_num;
 	imx7src->rcdev.ops       = &imx7_reset_ops;
 	imx7src->rcdev.of_node   = dev->of_node;
 
@@ -146,7 +174,7 @@ static int imx7_reset_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id imx7_reset_dt_ids[] = {
-	{ .compatible = "fsl,imx7d-src", },
+	{ .compatible = "fsl,imx7d-src", .data = &variant_imx7 },
 	{ /* sentinel */ },
 };
 
-- 
2.19.1
