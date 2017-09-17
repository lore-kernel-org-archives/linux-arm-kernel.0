From: stefan.bruens@rwth-aachen.de (=?UTF-8?q?Stefan=20Br=C3=BCns?=)
Date: Sun, 17 Sep 2017 05:19:54 +0200
Subject: [PATCH v2 08/10] dmaengine: sun6i: Add support for Allwinner A64 and
 compatibles
In-Reply-To: <20170917031956.28010-1-stefan.bruens@rwth-aachen.de>
References: <20170917031956.28010-1-stefan.bruens@rwth-aachen.de>
Message-ID: <20170917031956.28010-9-stefan.bruens@rwth-aachen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A64 SoC has the same dma engine as the H3 (sun8i), with a
reduced amount of physical channels. To allow future reuse of the
compatible, leave the channel count etc. in the config data blank
and retrieve it from the devicetree.

Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
---
 drivers/dma/sun6i-dma.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index b5ecc97a0d5a..118b29bb1eac 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -1127,6 +1127,28 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg = {
 			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
 };
 
+/*
+ * The A64 binding uses the number of dma channels from the
+ * device tree node.
+ */
+static struct sun6i_dma_config sun50i_a64_dma_cfg = {
+	.nr_max_channels = 0,
+	.nr_max_requests = 0,
+	.nr_max_vchans   = 0,
+	.clock_autogate_enable = sun6i_enable_clock_autogate_h3;
+	.set_burst_length = sun6i_set_burst_length_h3;
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
+};
+
 /*
  * The V3s have only 8 physical channels, a maximum DRQ port id of 23,
  * and a total of 24 usable source and destination endpoints.
@@ -1154,6 +1176,7 @@ static const struct of_device_id sun6i_dma_match[] = {
 	{ .compatible = "allwinner,sun8i-a83t-dma", .data = &sun8i_a83t_dma_cfg },
 	{ .compatible = "allwinner,sun8i-h3-dma", .data = &sun8i_h3_dma_cfg },
 	{ .compatible = "allwinner,sun8i-v3s-dma", .data = &sun8i_v3s_dma_cfg },
+	{ .compatible = "allwinner,sun50i-a64-dma", .data = &sun50i_a64_dma_cfg },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun6i_dma_match);
-- 
2.14.1
