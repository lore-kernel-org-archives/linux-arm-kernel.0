From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 14 Feb 2018 17:27:33 +0100
Subject: [PATCH] dmaengine: mv_xor_v2: Fix clock resource by adding a register
 clock
Message-ID: <20180214162733.4591-1-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the CP110 components whic are present on the Armada 7K/8K SoC we need
to explicitly enable the registers clock. However it is not needed for
the AP8xx componenet, that's why this clock is optional.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 .../devicetree/bindings/dma/mv-xor-v2.txt          |  6 +++++-
 drivers/dma/mv_xor_v2.c                            | 23 +++++++++++++++++-----
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/mv-xor-v2.txt b/Documentation/devicetree/bindings/dma/mv-xor-v2.txt
index 217a90eaabe7..9c38bbe7e6d7 100644
--- a/Documentation/devicetree/bindings/dma/mv-xor-v2.txt
+++ b/Documentation/devicetree/bindings/dma/mv-xor-v2.txt
@@ -11,7 +11,11 @@ Required properties:
   interrupts.
 
 Optional properties:
-- clocks: Optional reference to the clock used by the XOR engine.
+- clocks: Optional reference to the clocks used by the XOR engine.
+- clock-names: mandatory if there is a second clock, in this case the
+   name must be "core" for the first clock and "reg" for the second
+   one
+
 
 Example:
 
diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index f652a0e0f5a2..93b3d80ce701 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -163,6 +163,7 @@ struct mv_xor_v2_device {
 	void __iomem *dma_base;
 	void __iomem *glob_base;
 	struct clk *clk;
+	struct clk *reg_clk;
 	struct tasklet_struct irq_tasklet;
 	struct list_head free_sw_desc;
 	struct dma_device dmadev;
@@ -749,13 +750,24 @@ static int mv_xor_v2_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	xor_dev->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(xor_dev->clk) && PTR_ERR(xor_dev->clk) == -EPROBE_DEFER)
+	xor_dev->reg_clk = devm_clk_get(&pdev->dev, "reg");
+	if (!IS_ERR(xor_dev->reg_clk)) {
+		ret = clk_prepare_enable(xor_dev->reg_clk);
+		if (ret)
+			return ret;
+	} else if (PTR_ERR(xor_dev->reg_clk) == -EPROBE_DEFER) {
 		return -EPROBE_DEFER;
+	}
+
+	xor_dev->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(xor_dev->clk) && PTR_ERR(xor_dev->clk) == -EPROBE_DEFER) {
+		ret = EPROBE_DEFER;
+		goto disable_reg_clk;
+	}
 	if (!IS_ERR(xor_dev->clk)) {
 		ret = clk_prepare_enable(xor_dev->clk);
 		if (ret)
-			return ret;
+			goto disable_reg_clk;
 	}
 
 	ret = platform_msi_domain_alloc_irqs(&pdev->dev, 1,
@@ -866,8 +878,9 @@ static int mv_xor_v2_probe(struct platform_device *pdev)
 free_msi_irqs:
 	platform_msi_domain_free_irqs(&pdev->dev);
 disable_clk:
-	if (!IS_ERR(xor_dev->clk))
-		clk_disable_unprepare(xor_dev->clk);
+	clk_disable_unprepare(xor_dev->clk);
+disable_reg_clk:
+	clk_disable_unprepare(xor_dev->reg_clk);
 	return ret;
 }
 
-- 
2.15.1
