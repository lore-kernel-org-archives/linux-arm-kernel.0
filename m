From: stefan.bruens@rwth-aachen.de (=?UTF-8?q?Stefan=20Br=C3=BCns?=)
Date: Mon, 4 Sep 2017 00:40:59 +0200
Subject: [PATCH 08/10] dmaengine: sun6i: Add support for Allwinner A64 and
 compatibles
In-Reply-To: <20170903224100.17893-1-stefan.bruens@rwth-aachen.de>
References: <20170903224100.17893-1-stefan.bruens@rwth-aachen.de>
Message-ID: <20170903224100.17893-9-stefan.bruens@rwth-aachen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A64 SoC has the same dma engine as the H3 (sun8i), with a
reduced amount of physical channels. To allow future reuse of the
compatible, leave the channel count etc. in the config data blank
and retrieve it from the devicetree.

Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
---
 drivers/dma/sun6i-dma.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index bd4c2e4a759b..4fae7ffad549 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -1076,6 +1076,16 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg = {
 	.nr_max_vchans   = 34,
 	.dmac_variant    = DMAC_VARIANT_H3,
 };
+
+/*
+ * The A64 binding uses the number of dma channels from the
+ * device tree node.
+ */
+static struct sun6i_dma_config sun50i_a64_dma_cfg = {
+	.nr_max_channels = 0,
+	.nr_max_requests = 0,
+	.nr_max_vchans   = 0,
+	.dmac_variant    = DMAC_VARIANT_H3,
 };
 
 static const struct of_device_id sun6i_dma_match[] = {
@@ -1083,6 +1093,7 @@ static const struct of_device_id sun6i_dma_match[] = {
 	{ .compatible = "allwinner,sun8i-a23-dma", .data = &sun8i_a23_dma_cfg },
 	{ .compatible = "allwinner,sun8i-a83t-dma", .data = &sun8i_a83t_dma_cfg },
 	{ .compatible = "allwinner,sun8i-h3-dma", .data = &sun8i_h3_dma_cfg },
+	{ .compatible = "allwinner,sun50i-a64-dma", .data = &sun50i_a64_dma_cfg },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun6i_dma_match);
@@ -1090,6 +1101,7 @@ MODULE_DEVICE_TABLE(of, sun6i_dma_match);
 static int sun6i_dma_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *device;
+	struct device_node *np = pdev->dev.of_node;
 	struct sun6i_dma_dev *sdc;
 	struct resource *res;
 	int ret, i;
-- 
2.14.1
