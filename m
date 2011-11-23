From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 22 Nov 2011 18:21:19 -0700
Subject: [PATCH 11/17] ASoC: Tegra I2S: Add device tree binding
In-Reply-To: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
Message-ID: <1322011285-4002-12-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 .../devicetree/bindings/sound/tegra20-i2s.txt      |   16 +++++++++++
 sound/soc/tegra/tegra_i2s.c                        |   29 ++++++++++++++++---
 2 files changed, 40 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/tegra20-i2s.txt

diff --git a/Documentation/devicetree/bindings/sound/tegra20-i2s.txt b/Documentation/devicetree/bindings/sound/tegra20-i2s.txt
new file mode 100644
index 0000000..d38abdc
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tegra20-i2s.txt
@@ -0,0 +1,16 @@
+NVIDIA Tegra 20 I2S controller
+
+Required properties:
+- compatible : "nvidia,tegra20-i2s"
+- reg : Should contain I2S registers location and length
+- interrupts : Should contain I2S interrupt
+- dma-channel : The Tegra DMA controller's channel ID for this I2S controller
+
+Example:
+
+i2s at 70002800 {
+	compatible = "nvidia,tegra20-i2s";
+	reg = <0x70002800 0x200>;
+	interrupts = < 45 >;
+	dma-channel = < 2 >;
+};
diff --git a/sound/soc/tegra/tegra_i2s.c b/sound/soc/tegra/tegra_i2s.c
index 3c0cbd2..b4e19a5 100644
--- a/sound/soc/tegra/tegra_i2s.c
+++ b/sound/soc/tegra/tegra_i2s.c
@@ -36,6 +36,7 @@
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/io.h>
+#include <linux/of.h>
 #include <mach/iomap.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -332,6 +333,7 @@ static __devinit int tegra_i2s_platform_probe(struct platform_device *pdev)
 	struct tegra_i2s * i2s;
 	struct resource *mem, *memregion, *dmareq;
 	int ret;
+	u32 dma_ch;
 
 	i2s = devm_kzalloc(&pdev->dev, sizeof(struct tegra_i2s), GFP_KERNEL);
 	if (!i2s) {
@@ -360,9 +362,19 @@ static __devinit int tegra_i2s_platform_probe(struct platform_device *pdev)
 
 	dmareq = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 	if (!dmareq) {
-		dev_err(&pdev->dev, "No DMA resource\n");
-		ret = -ENODEV;
-		goto err_clk_put;
+		/*
+		 * FIXME: Perhaps there should be a standard binding for this
+		 * that ends up creating the IORESOURCE_DMA resource for us.
+		 */
+		if (of_property_read_u32(pdev->dev.of_node,
+					 "nvidia,dma-channels",
+					 &dma_ch) < 0) {
+			dev_err(&pdev->dev, "No DMA resource\n");
+			ret = -ENODEV;
+			goto err_clk_put;
+		}
+	} else {
+		dma_ch = dmareq->start;
 	}
 
 	memregion = devm_request_mem_region(&pdev->dev, mem->start,
@@ -383,12 +395,12 @@ static __devinit int tegra_i2s_platform_probe(struct platform_device *pdev)
 	i2s->capture_dma_data.addr = mem->start + TEGRA_I2S_FIFO2;
 	i2s->capture_dma_data.wrap = 4;
 	i2s->capture_dma_data.width = 32;
-	i2s->capture_dma_data.req_sel = dmareq->start;
+	i2s->capture_dma_data.req_sel = dma_ch;
 
 	i2s->playback_dma_data.addr = mem->start + TEGRA_I2S_FIFO1;
 	i2s->playback_dma_data.wrap = 4;
 	i2s->playback_dma_data.width = 32;
-	i2s->playback_dma_data.req_sel = dmareq->start;
+	i2s->playback_dma_data.req_sel = dma_ch;
 
 	i2s->reg_ctrl = TEGRA_I2S_CTRL_FIFO_FORMAT_PACKED;
 
@@ -422,10 +434,16 @@ static int __devexit tegra_i2s_platform_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id tegra_i2s_of_match[] __devinitconst = {
+	{ .compatible = "nvidia,tegra20-i2s", },
+	{},
+};
+
 static struct platform_driver tegra_i2s_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.owner = THIS_MODULE,
+		.of_match_table = tegra_i2s_of_match,
 	},
 	.probe = tegra_i2s_platform_probe,
 	.remove = __devexit_p(tegra_i2s_platform_remove),
@@ -436,3 +454,4 @@ MODULE_AUTHOR("Stephen Warren <swarren@nvidia.com>");
 MODULE_DESCRIPTION("Tegra I2S ASoC driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_DEVICE_TABLE(of, tegra_i2s_of_match);
-- 
1.7.0.4
