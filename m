From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Tue, 17 Jan 2017 15:02:24 +0100
Subject: [PATCH v2 04/10] ASoC: sun4i-i2s: Add quirks to handle new compatible
 for reset
In-Reply-To: <20170117140230.23142-1-mylene.josserand@free-electrons.com>
References: <20170117140230.23142-1-mylene.josserand@free-electrons.com>
Message-ID: <20170117140230.23142-5-mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some SoCs have a reset line that must be asserted/deasserted.
This patch adds a quirk to handle the new compatible
"allwinner,sun6i-a31-i2s" which will deassert the reset
line on probe function and assert it on remove's one.

This new compatible is useful in case of A33 codec driver, for example.

Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 57 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 4237323ef594..3635bbc72cbc 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -14,9 +14,11 @@
 #include <linux/clk.h>
 #include <linux/dmaengine.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 
 #include <sound/dmaengine_pcm.h>
 #include <sound/pcm_params.h>
@@ -92,6 +94,7 @@ struct sun4i_i2s {
 	struct clk	*bus_clk;
 	struct clk	*mod_clk;
 	struct regmap	*regmap;
+	struct reset_control *rst;
 
 	unsigned int	mclk_freq;
 
@@ -651,9 +654,22 @@ static int sun4i_i2s_runtime_suspend(struct device *dev)
 	return 0;
 }
 
+struct sun4i_i2s_quirks {
+	bool has_reset;
+};
+
+static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
+	.has_reset	= false,
+};
+
+static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
+	.has_reset	= true,
+};
+
 static int sun4i_i2s_probe(struct platform_device *pdev)
 {
 	struct sun4i_i2s *i2s;
+	const struct sun4i_i2s_quirks *quirks;
 	struct resource *res;
 	void __iomem *regs;
 	int irq, ret;
@@ -674,6 +690,12 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 		return irq;
 	}
 
+	quirks = of_device_get_match_data(&pdev->dev);
+	if (!quirks) {
+		dev_err(&pdev->dev, "Failed to determine the quirks to use\n");
+		return -ENODEV;
+	}
+
 	i2s->bus_clk = devm_clk_get(&pdev->dev, "apb");
 	if (IS_ERR(i2s->bus_clk)) {
 		dev_err(&pdev->dev, "Can't get our bus clock\n");
@@ -692,7 +714,24 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Can't get our mod clock\n");
 		return PTR_ERR(i2s->mod_clk);
 	}
-	
+
+	if (quirks->has_reset) {
+		i2s->rst = devm_reset_control_get(&pdev->dev, NULL);
+		if (IS_ERR(i2s->rst)) {
+			dev_err(&pdev->dev, "Failed to get reset control\n");
+			return PTR_ERR(i2s->rst);
+		}
+	}
+
+	if (!IS_ERR(i2s->rst)) {
+		ret = reset_control_deassert(i2s->rst);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to deassert the reset control\n");
+			return -EINVAL;
+		}
+	}
+
 	i2s->playback_dma_data.addr = res->start + SUN4I_I2S_FIFO_TX_REG;
 	i2s->playback_dma_data.maxburst = 8;
 
@@ -727,23 +766,37 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 		sun4i_i2s_runtime_suspend(&pdev->dev);
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
+	if (!IS_ERR(i2s->rst))
+		reset_control_assert(i2s->rst);
 
 	return ret;
 }
 
 static int sun4i_i2s_remove(struct platform_device *pdev)
 {
+	struct sun4i_i2s *i2s = dev_get_drvdata(&pdev->dev);
+
 	snd_dmaengine_pcm_unregister(&pdev->dev);
 
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		sun4i_i2s_runtime_suspend(&pdev->dev);
 
+	if (!IS_ERR(i2s->rst))
+		reset_control_assert(i2s->rst);
+
 	return 0;
 }
 
 static const struct of_device_id sun4i_i2s_match[] = {
-	{ .compatible = "allwinner,sun4i-a10-i2s", },
+	{
+		.compatible = "allwinner,sun4i-a10-i2s",
+		.data = &sun4i_a10_i2s_quirks,
+	},
+	{
+		.compatible = "allwinner,sun6i-a31-i2s",
+		.data = &sun6i_a31_i2s_quirks,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sun4i_i2s_match);
-- 
2.11.0
