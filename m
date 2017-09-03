From: stefan.bruens@rwth-aachen.de (=?UTF-8?q?Stefan=20Br=C3=BCns?=)
Date: Mon, 4 Sep 2017 00:40:52 +0200
Subject: [PATCH 01/10] dmaengine: sun6i: Correct setting of clock autogating
 register for A83T/H3
In-Reply-To: <20170903224100.17893-1-stefan.bruens@rwth-aachen.de>
References: <20170903224100.17893-1-stefan.bruens@rwth-aachen.de>
Message-ID: <20170903224100.17893-2-stefan.bruens@rwth-aachen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The H83T uses a compatible string different from the A23, but requires
the same clock autogating register setting.

The H3 also requires setting the clock autogating register, but has
the register at a different offset.

Some currently available SoCs not yet supported by the sun6i-dma driver
will require new compatible strings. These SoCs either follow the A23
register model (e.g. V3s) or the H3 register model (A64, R40), so a new
variable is added to the config struct to group SoCs with common register
models.

Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
---
 drivers/dma/sun6i-dma.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index a2358780ab2c..1d9b3be30d22 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -48,6 +48,9 @@
 #define SUN8I_DMA_GATE		0x20
 #define SUN8I_DMA_GATE_ENABLE	0x4
 
+#define SUNXI_H3_SECURITE_REG		0x20
+#define SUNXI_H3_DMA_GATE		0x28
+#define SUNXI_H3_DMA_GATE_ENABLE	0x4
 /*
  * Channels specific registers
  */
@@ -90,6 +93,21 @@
 #define NORMAL_WAIT	8
 #define DRQ_SDRAM	1
 
+/*
+ * DMA Controller generations
+ *
+ * Newer SoC generations changed or added some register definitions:
+ * - A23 added a clock gate register
+ * - H3 has a different offset for the clock gating register,
+ *   the burst length field has a different offset in the channel
+ *   configuration register, also additional burst lengths/widths.
+ */
+enum dmac_variant {
+	DMAC_VARIANT_A31,
+	DMAC_VARIANT_A23,
+	DMAC_VARIANT_H3,
+};
+
 /*
  * Hardware channels / ports representation
  *
@@ -101,6 +119,7 @@ struct sun6i_dma_config {
 	u32 nr_max_channels;
 	u32 nr_max_requests;
 	u32 nr_max_vchans;
+	enum dmac_variant dmac_variant;
 };
 
 /*
@@ -998,6 +1017,7 @@ static struct sun6i_dma_config sun6i_a31_dma_cfg = {
 	.nr_max_channels = 16,
 	.nr_max_requests = 30,
 	.nr_max_vchans   = 53,
+	.dmac_variant    = DMAC_VARIANT_A31,
 };
 
 /*
@@ -1009,23 +1029,29 @@ static struct sun6i_dma_config sun8i_a23_dma_cfg = {
 	.nr_max_channels = 8,
 	.nr_max_requests = 24,
 	.nr_max_vchans   = 37,
+	.dmac_variant    = DMAC_VARIANT_A23,
 };
 
 static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
 	.nr_max_channels = 8,
 	.nr_max_requests = 28,
 	.nr_max_vchans   = 39,
+	.dmac_variant    = DMAC_VARIANT_A23,
 };
 
 /*
  * The H3 has 12 physical channels, a maximum DRQ port id of 27,
  * and a total of 34 usable source and destination endpoints.
+ * It also supports additional burst lengths and bus widths,
+ * and the burst length fields have different offsets.
  */
 
 static struct sun6i_dma_config sun8i_h3_dma_cfg = {
 	.nr_max_channels = 12,
 	.nr_max_requests = 27,
 	.nr_max_vchans   = 34,
+	.dmac_variant    = DMAC_VARIANT_H3,
+};
 };
 
 static const struct of_device_id sun6i_dma_match[] = {
@@ -1177,11 +1203,13 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 	/*
 	 * sun8i variant requires us to toggle a dma gating register,
 	 * as seen in Allwinner's SDK. This register is not documented
-	 * in the A23 user manual.
+	 * in the A23 user manual, but appears in e.g. the H83T manual.
+	 * For the H3, H5 and A64, the register has a different location
 	 */
-	if (of_device_is_compatible(pdev->dev.of_node,
-				    "allwinner,sun8i-a23-dma"))
+	if (sdc->cfg->dmac_variant == DMAC_VARIANT_A23)
 		writel(SUN8I_DMA_GATE_ENABLE, sdc->base + SUN8I_DMA_GATE);
+	else if (sdc->cfg->dmac_variant == DMAC_VARIANT_H3)
+		writel(SUNXI_H3_DMA_GATE_ENABLE, sdc->base + SUNXI_H3_DMA_GATE);
 
 	return 0;
 
-- 
2.14.1
