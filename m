From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 Oct 2014 13:59:19 +0200
Subject: [PATCH 06/17] gpio: mvebu: add suspend/resume support
In-Reply-To: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1414151970-6626-7-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the implementation of ->suspend() and ->resume()
platform_driver hooks in order to save and restore the state of the
GPIO configuration. In order to achieve that, additional fields are
added to the mvebu_gpio_chip structure.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: linux-gpio at vger.kernel.org
---
 drivers/gpio/gpio-mvebu.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 418e386..dd5545c 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -83,6 +83,14 @@ struct mvebu_gpio_chip {
 	int		   irqbase;
 	struct irq_domain *domain;
 	int                soc_variant;
+
+	/* Used to preserve GPIO registers accross suspend/resume */
+	u32                out_reg;
+	u32                io_conf_reg;
+	u32                blink_en_reg;
+	u32                in_pol_reg;
+	u32                edge_mask_regs[4];
+	u32                level_mask_regs[4];
 };
 
 /*
@@ -554,6 +562,93 @@ static const struct of_device_id mvebu_gpio_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mvebu_gpio_of_match);
 
+static int mvebu_gpio_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct mvebu_gpio_chip *mvchip = platform_get_drvdata(pdev);
+	int i;
+
+	mvchip->out_reg = readl(mvebu_gpioreg_out(mvchip));
+	mvchip->io_conf_reg = readl(mvebu_gpioreg_io_conf(mvchip));
+	mvchip->blink_en_reg = readl(mvebu_gpioreg_blink(mvchip));
+	mvchip->in_pol_reg = readl(mvebu_gpioreg_in_pol(mvchip));
+
+	switch (mvchip->soc_variant) {
+	case MVEBU_GPIO_SOC_VARIANT_ORION:
+		mvchip->edge_mask_regs[0] =
+			readl(mvchip->membase + GPIO_EDGE_MASK_OFF);
+		mvchip->level_mask_regs[0] =
+			readl(mvchip->membase + GPIO_LEVEL_MASK_OFF);
+		break;
+	case MVEBU_GPIO_SOC_VARIANT_MV78200:
+		for (i = 0; i < 2; i++) {
+			mvchip->edge_mask_regs[i] =
+				readl(mvchip->membase +
+				      GPIO_EDGE_MASK_MV78200_OFF(i));
+			mvchip->level_mask_regs[i] =
+				readl(mvchip->membase +
+				      GPIO_LEVEL_MASK_MV78200_OFF(i));
+		}
+		break;
+	case MVEBU_GPIO_SOC_VARIANT_ARMADAXP:
+		for (i = 0; i < 4; i++) {
+			mvchip->edge_mask_regs[i] =
+				readl(mvchip->membase +
+				      GPIO_EDGE_MASK_ARMADAXP_OFF(i));
+			mvchip->level_mask_regs[i] =
+				readl(mvchip->membase +
+				      GPIO_LEVEL_MASK_ARMADAXP_OFF(i));
+		}
+		break;
+	default:
+		BUG();
+	}
+
+	return 0;
+}
+
+static int mvebu_gpio_resume(struct platform_device *pdev)
+{
+	struct mvebu_gpio_chip *mvchip = platform_get_drvdata(pdev);
+	int i;
+
+	writel(mvchip->out_reg, mvebu_gpioreg_out(mvchip));
+	writel(mvchip->io_conf_reg, mvebu_gpioreg_io_conf(mvchip));
+	writel(mvchip->blink_en_reg, mvebu_gpioreg_blink(mvchip));
+	writel(mvchip->in_pol_reg, mvebu_gpioreg_in_pol(mvchip));
+
+	switch (mvchip->soc_variant) {
+	case MVEBU_GPIO_SOC_VARIANT_ORION:
+		writel(mvchip->edge_mask_regs[0],
+		       mvchip->membase + GPIO_EDGE_MASK_OFF);
+		writel(mvchip->level_mask_regs[0],
+		       mvchip->membase + GPIO_LEVEL_MASK_OFF);
+		break;
+	case MVEBU_GPIO_SOC_VARIANT_MV78200:
+		for (i = 0; i < 2; i++) {
+			writel(mvchip->edge_mask_regs[i],
+			       mvchip->membase + GPIO_EDGE_MASK_MV78200_OFF(i));
+			writel(mvchip->level_mask_regs[i],
+			       mvchip->membase +
+			       GPIO_LEVEL_MASK_MV78200_OFF(i));
+		}
+		break;
+	case MVEBU_GPIO_SOC_VARIANT_ARMADAXP:
+		for (i = 0; i < 4; i++) {
+			writel(mvchip->edge_mask_regs[i],
+			       mvchip->membase +
+			       GPIO_EDGE_MASK_ARMADAXP_OFF(i));
+			writel(mvchip->level_mask_regs[i],
+			       mvchip->membase +
+			       GPIO_LEVEL_MASK_ARMADAXP_OFF(i));
+		}
+		break;
+	default:
+		BUG();
+	}
+
+	return 0;
+}
+
 static int mvebu_gpio_probe(struct platform_device *pdev)
 {
 	struct mvebu_gpio_chip *mvchip;
@@ -577,6 +672,8 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	if (!mvchip)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, mvchip);
+
 	if (of_property_read_u32(pdev->dev.of_node, "ngpios", &ngpios)) {
 		dev_err(&pdev->dev, "Missing ngpios OF property\n");
 		return -ENODEV;
@@ -735,5 +832,7 @@ static struct platform_driver mvebu_gpio_driver = {
 		.of_match_table = mvebu_gpio_of_match,
 	},
 	.probe		= mvebu_gpio_probe,
+	.suspend        = mvebu_gpio_suspend,
+	.resume         = mvebu_gpio_resume,
 };
 module_platform_driver(mvebu_gpio_driver);
-- 
2.0.0
