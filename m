From: stefan.bruens@rwth-aachen.de (=?UTF-8?q?Stefan=20Br=C3=BCns?=)
Date: Mon, 25 Sep 2017 02:02:35 +0200
Subject: [PATCH v3 01/10] dmaengine: sun6i: Correct setting of clock
 autogating register for A83T/H3
In-Reply-To: <20170925000244.11679-1-stefan.bruens@rwth-aachen.de>
References: <20170925000244.11679-1-stefan.bruens@rwth-aachen.de>
Message-ID: <8b0e3c36-850c-4211-b647-b03143be67f7@rwthex-w2-a.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The H83T uses a compatible string different from the A23, but requires
the same clock autogating register setting.

The H3 also requires setting the clock autogating register, but has
the register at a different offset.

Add three suitable callbacks for the existing controller generations
and set it in the controller config structure.

Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

---

Changes in v3:
- Check for callback instead of using a no-op callback

Changes in v2:
- Use callback for autogating instead of variable for different SoC generations

 drivers/dma/sun6i-dma.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index bcd496edc70f..b4a29d1a100d 100644
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
@@ -267,6 +270,16 @@ static inline s8 convert_buswidth(enum dma_slave_buswidth addr_width)
 	return addr_width >> 1;
 }
 
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
@@ -1020,24 +1033,28 @@ static struct sun6i_dma_config sun8i_a23_dma_cfg = {
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
@@ -1049,7 +1066,7 @@ static struct sun6i_dma_config sun8i_v3s_dma_cfg = {
 	.nr_max_channels = 8,
 	.nr_max_requests = 23,
 	.nr_max_vchans   = 24,
-	.gate_needed	 = true,
+	.clock_autogate_enable = sun6i_enable_clock_autogate_a23;
 };
 
 static const struct of_device_id sun6i_dma_match[] = {
@@ -1199,8 +1216,8 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 		goto err_dma_unregister;
 	}
 
-	if (sdc->cfg->gate_needed)
-		writel(SUN8I_DMA_GATE_ENABLE, sdc->base + SUN8I_DMA_GATE);
+	if (sdc->cfg->clock_autogate_enable)
+		sdc->cfg->clock_autogate_enable();
 
 	return 0;
 
-- 
2.14.1
