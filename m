From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 1 Jul 2013 16:16:10 +0800
Subject: [PATCH 3/4] ASoC: mxs: register saif mclk to clock framework
In-Reply-To: <1372666571-17276-1-git-send-email-shawn.guo@linaro.org>
References: <1372666571-17276-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1372666571-17276-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mostly the mxs system design uses saif0 mclk output as the clock source
of codec.  Since the mclk is implemented as a general divider with the
saif clk as the parent clock, let's register the mclk as a basic
clk-divider to common clock framework.  Then with it being a clock
provdier, clk_get() call in codec driver probe function will just work.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/mxs/mxs-saif.c |   35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 49d8700..54511c5 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/time.h>
 #include <sound/core.h>
@@ -658,6 +659,33 @@ static irqreturn_t mxs_saif_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int mxs_saif_mclk_init(struct platform_device *pdev)
+{
+	struct mxs_saif *saif = platform_get_drvdata(pdev);
+	struct device_node *np = pdev->dev.of_node;
+	struct clk *clk;
+	int ret;
+
+	clk = clk_register_divider(&pdev->dev, "mxs_saif_mclk",
+				   __clk_get_name(saif->clk), 0,
+				   saif->base + SAIF_CTRL,
+				   BP_SAIF_CTRL_BITCLK_MULT_RATE, 3,
+				   0, NULL);
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		if (ret == -EEXIST)
+			return 0;
+		dev_err(&pdev->dev, "failed to register mclk: %d\n", ret);
+		return PTR_ERR(clk);
+	}
+
+	ret = of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int mxs_saif_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -734,6 +762,13 @@ static int mxs_saif_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, saif);
 
+	/* We only support saif0 being tx and clock master */
+	if (saif->id == 0) {
+		ret = mxs_saif_mclk_init(pdev);
+		if (ret)
+			dev_warn(&pdev->dev, "failed to init clocks\n");
+	}
+
 	ret = snd_soc_register_component(&pdev->dev, &mxs_saif_component,
 					 &mxs_saif_dai, 1);
 	if (ret) {
-- 
1.7.9.5
