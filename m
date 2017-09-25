From: stefan.bruens@rwth-aachen.de (=?UTF-8?q?Stefan=20Br=C3=BCns?=)
Date: Mon, 25 Sep 2017 02:02:38 +0200
Subject: [PATCH v3 04/10] dmaengine: sun6i: Enable additional burst
 lengths/widths on H3
In-Reply-To: <20170925000244.11679-1-stefan.bruens@rwth-aachen.de>
References: <20170925000244.11679-1-stefan.bruens@rwth-aachen.de>
Message-ID: <ec539919-e0c2-4765-96ed-3aeb71af6e73@rwthex-w2-a.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The H3 supports bursts lengths of 1, 4, 8 and 16 transfers, each with
a width of 1, 2, 4 or 8 bytes.

The register value for the the width is log2-encoded, change the
conversion function to provide the correct value for width == 8.

Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

---

Changes in v3: None
Changes in v2:
- Store burst widths in config

 drivers/dma/sun6i-dma.c | 54 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 5d0c009bad02..c7ad3b4e836c 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -120,6 +120,8 @@ struct sun6i_dma_config {
 	void (*set_burst_length)(u32 *p_cfg, s8 src_burst, s8 dst_burst);
 	u32 src_burst_lengths;
 	u32 dst_burst_lengths;
+	u32 src_addr_widths;
+	u32 dst_addr_widths;
 };
 
 /*
@@ -259,8 +261,12 @@ static inline s8 convert_burst(u32 maxburst)
 	switch (maxburst) {
 	case 1:
 		return 0;
+	case 4:
+		return 1;
 	case 8:
 		return 2;
+	case 16:
+		return 3;
 	default:
 		return -EINVAL;
 	}
@@ -268,7 +274,7 @@ static inline s8 convert_burst(u32 maxburst)
 
 static inline s8 convert_buswidth(enum dma_slave_buswidth addr_width)
 {
-	return addr_width >> 1;
+	return ilog2(addr_width);
 }
 
 static void sun6i_enable_clock_autogate_a23(struct sun6i_dma_dev *sdev)
@@ -1040,6 +1046,12 @@ static struct sun6i_dma_config sun6i_a31_dma_cfg = {
 	.set_burst_length = sun6i_set_burst_length_a31;
 	.src_burst_lengths = BIT(1) | BIT(8);
 	.dst_burst_lengths = BIT(1) | BIT(8);
+	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
+			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
+			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 };
 
 /*
@@ -1055,6 +1067,12 @@ static struct sun6i_dma_config sun8i_a23_dma_cfg = {
 	.set_burst_length = sun6i_set_burst_length_a31;
 	.src_burst_lengths = BIT(1) | BIT(8);
 	.dst_burst_lengths = BIT(1) | BIT(8);
+	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
+			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
+			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 };
 
 static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
@@ -1065,11 +1083,19 @@ static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
 	.set_burst_length = sun6i_set_burst_length_a31;
 	.src_burst_lengths = BIT(1) | BIT(8);
 	.dst_burst_lengths = BIT(1) | BIT(8);
+	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
+			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
+			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 };
 
 /*
  * The H3 has 12 physical channels, a maximum DRQ port id of 27,
  * and a total of 34 usable source and destination endpoints.
+ * It also supports additional burst lengths and bus widths,
+ * and the burst length fields have different offsets.
  */
 
 static struct sun6i_dma_config sun8i_h3_dma_cfg = {
@@ -1078,8 +1104,16 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg = {
 	.nr_max_vchans   = 34,
 	.clock_autogate_enable = sun6i_enable_clock_autogate_h3;
 	.set_burst_length = sun6i_set_burst_length_h3;
-	.src_burst_lengths = BIT(1) | BIT(8);
-	.dst_burst_lengths = BIT(1) | BIT(8);
+	.src_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16);
+	.dst_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16);
+	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
+			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
+			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
+	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
+			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
+			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
 };
 
 /*
@@ -1095,6 +1129,12 @@ static struct sun6i_dma_config sun8i_v3s_dma_cfg = {
 	.set_burst_length = sun6i_set_burst_length_a31;
 	.src_burst_lengths = BIT(1) | BIT(8);
 	.dst_burst_lengths = BIT(1) | BIT(8);
+	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
+			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
+			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 };
 
 static const struct of_device_id sun6i_dma_match[] = {
@@ -1174,12 +1214,8 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 	sdc->slave.device_pause			= sun6i_dma_pause;
 	sdc->slave.device_resume		= sun6i_dma_resume;
 	sdc->slave.device_terminate_all		= sun6i_dma_terminate_all;
-	sdc->slave.src_addr_widths		= BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
-						  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
-						  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
-	sdc->slave.dst_addr_widths		= BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
-						  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
-						  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	sdc->slave.src_addr_widths		= sdc->cfg->src_addr_widths;
+	sdc->slave.dst_addr_widths		= sdc->cfg->dst_addr_widths;
 	sdc->slave.directions			= BIT(DMA_DEV_TO_MEM) |
 						  BIT(DMA_MEM_TO_DEV);
 	sdc->slave.residue_granularity		= DMA_RESIDUE_GRANULARITY_BURST;
-- 
2.14.1
