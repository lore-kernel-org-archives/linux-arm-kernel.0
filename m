From: stefan.bruens@rwth-aachen.de (=?UTF-8?q?Stefan=20Br=C3=BCns?=)
Date: Sun, 17 Sep 2017 05:19:47 +0200
Subject: [PATCH v2 01/10] dmaengine: sun6i: Correct setting of clock
 autogating register for A83T/H3
In-Reply-To: <20170917031956.28010-1-stefan.bruens@rwth-aachen.de>
References: <20170917031956.28010-1-stefan.bruens@rwth-aachen.de>
Message-ID: <20170917031956.28010-2-stefan.bruens@rwth-aachen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The H83T uses a compatible string different from the A23, but requires
the same clock autogating register setting.

The H3 also requires setting the clock autogating register, but has
the register at a different offset.

Add three suitable callbacks for the existing controller generations
and set it in the controller config structure.

Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
---
 drivers/dma/sun6i-dma.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index bcd496edc70f..45bcd5271d94 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -48,6 +48,9 @@
 #define SUN8I_DMA_GATE		0x20
 #define SUN8I_DMA_GATE_ENABLE	0x4
 
+#define SUNXI_H3_SECURE_REG		0x20
+#define SUNXI_H3_DMA_GATE		0x28
+#define SUNXI_H3_DMA_GATE_ENABLE	0x4
 /*
  * Channels specific registers
  */
@@ -111,7 +114,7 @@ struct sun6i_dma_config {
 	 * however these SoCs really have and need this bit, as seen in the
 	 * BSP kernel source code.
 	 */
-	bool gate_needed;
+	void (*clock_autogate_enable)();
 };
 
 /*
@@ -267,6 +270,20 @@ static inline s8 convert_buswidth(enum dma_slave_buswidth addr_width)
 	return addr_width >> 1;
 }
 
+static void sun6i_enable_clock_autogate_noop(struct sun6i_dma_dev *sdev)
+{
+}
+
+static void sun6i_enable_clock_autogate_a23(struct sun6i_dma_dev *sdev)
+{
+	writel(SUN8I_DMA_GATE_ENABLE, sdev->base + SUN8I_DMA_GATE);
+}
+
+static void sun6i_enable_clock_autogate_h3(struct sun6i_dma_dev *sdev)
+{
+	writel(SUNXI_H3_DMA_GATE_ENABLE, sdev->base + SUNXI_H3_DMA_GATE);
+}
+
 static size_t sun6i_get_chan_size(struct sun6i_pchan *pchan)
 {
 	struct sun6i_desc *txd = pchan->desc;
@@ -1009,6 +1026,7 @@ static struct sun6i_dma_config sun6i_a31_dma_cfg = {
 	.nr_max_channels = 16,
 	.nr_max_requests = 30,
 	.nr_max_vchans   = 53,
+	.clock_autogate_enable = sun6i_enable_clock_autogate_noop;
 };
 
 /*
@@ -1020,24 +1038,28 @@ static struct sun6i_dma_config sun8i_a23_dma_cfg = {
 	.nr_max_channels = 8,
 	.nr_max_requests = 24,
 	.nr_max_vchans   = 37,
-	.gate_needed	 = true,
+	.clock_autogate_enable = sun6i_enable_clock_autogate_a23;
 };
 
 static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
 	.nr_max_channels = 8,
 	.nr_max_requests = 28,
 	.nr_max_vchans   = 39,
+	.clock_autogate_enable = sun6i_enable_clock_autogate_a23;
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
+	.clock_autogate_enable = sun6i_enable_clock_autogate_h3;
 };
 
 /*
@@ -1049,7 +1071,7 @@ static struct sun6i_dma_config sun8i_v3s_dma_cfg = {
 	.nr_max_channels = 8,
 	.nr_max_requests = 23,
 	.nr_max_vchans   = 24,
-	.gate_needed	 = true,
+	.clock_autogate_enable = sun6i_enable_clock_autogate_a23;
 };
 
 static const struct of_device_id sun6i_dma_match[] = {
@@ -1199,8 +1221,7 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 		goto err_dma_unregister;
 	}
 
-	if (sdc->cfg->gate_needed)
-		writel(SUN8I_DMA_GATE_ENABLE, sdc->base + SUN8I_DMA_GATE);
+	sdc->cfg->clock_autogate_enable();
 
 	return 0;
 
-- 
2.14.1
