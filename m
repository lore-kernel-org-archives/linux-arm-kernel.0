From: yvo@apm.com (Y Vo)
Date: Fri, 11 Sep 2015 16:22:11 +0700
Subject: [PATCH 1/2] gpio: xgene: add support to configure GPIO line as input,
 output or external IRQ pin
In-Reply-To: <1441963332-13329-1-git-send-email-yvo@apm.com>
References: <1441963332-13329-1-git-send-email-yvo@apm.com>
Message-ID: <1441963332-13329-2-git-send-email-yvo@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support to configure GPIO line as input, output or external IRQ pin.

Signed-off-by: Y Vo <yvo@apm.com>
---
 drivers/gpio/gpio-xgene-sb.c |   33 ++++++++++++++++++++++++++-------
 1 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-xgene-sb.c b/drivers/gpio/gpio-xgene-sb.c
index d57068b..76b15e0 100644
--- a/drivers/gpio/gpio-xgene-sb.c
+++ b/drivers/gpio/gpio-xgene-sb.c
@@ -32,6 +32,8 @@
 
 #define XGENE_MAX_GPIO_DS		22
 #define XGENE_MAX_GPIO_DS_IRQ		6
+#define XGENE_GPIO8_HWIRQ		0x48
+#define XGENE_GPIO8_IDX			8
 
 #define GPIO_MASK(x)			(1U << ((x) % 32))
 
@@ -82,11 +84,19 @@ static int apm_gpio_sb_to_irq(struct gpio_chip *gc, u32 gpio)
 	return -ENXIO;
 }
 
+static int xgene_irq_to_line(u32 irq)
+{
+	u32 offset = irq_get_irq_data(irq)->hwirq - XGENE_GPIO8_HWIRQ;
+
+	return (offset < XGENE_MAX_GPIO_DS_IRQ) ?
+			(offset + XGENE_GPIO8_IDX) : -EINVAL;
+}
+
 static int xgene_gpio_sb_probe(struct platform_device *pdev)
 {
 	struct xgene_gpio_sb *priv;
 	u32 ret, i;
-	u32 default_lines[] = {0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D};
+	int virq, line;
 	struct resource *res;
 	void __iomem *regs;
 
@@ -109,20 +119,29 @@ static int xgene_gpio_sb_probe(struct platform_device *pdev)
 	priv->bgc.gc.to_irq = apm_gpio_sb_to_irq;
 	priv->bgc.gc.ngpio = XGENE_MAX_GPIO_DS;
 
-	priv->nirq = XGENE_MAX_GPIO_DS_IRQ;
-
 	priv->irq = devm_kzalloc(&pdev->dev, sizeof(u32) * XGENE_MAX_GPIO_DS,
 				   GFP_KERNEL);
 	if (!priv->irq)
 		return -ENOMEM;
 
-	for (i = 0; i < priv->nirq; i++) {
-		priv->irq[default_lines[i]] = platform_get_irq(pdev, i);
+	for (i = 0; i < XGENE_MAX_GPIO_DS_IRQ; i++) {
+		virq = platform_get_irq(pdev, i);
+		if (virq < 0)
+			break;
+		line = xgene_irq_to_line(virq);
+		if (line < XGENE_GPIO8_IDX)
+			break;
+		priv->irq[line] = virq;
 		xgene_gpio_set_bit(&priv->bgc, regs + MPA_GPIO_SEL_LO,
-                                   default_lines[i] * 2, 1);
-		xgene_gpio_set_bit(&priv->bgc, regs + MPA_GPIO_INT_LVL, i, 1);
+						line * 2, 1);
+		xgene_gpio_set_bit(&priv->bgc, regs + MPA_GPIO_INT_LVL,
+						(line - XGENE_GPIO8_IDX), 1);
+		dev_dbg(&pdev->dev,
+			"gpio line %d mapped as external irq pin\n", line);
 	}
 
+	priv->nirq = i;
+
 	platform_set_drvdata(pdev, priv);
 
 	ret = gpiochip_add(&priv->bgc.gc);
-- 
1.7.1
