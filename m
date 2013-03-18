From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 21:05:58 +0900
Subject: [PATCH 14/14] irqchip: irqc: Add DT support
In-Reply-To: <1363608358-24215-1-git-send-email-horms+renesas@verge.net.au>
References: <1363608358-24215-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363608358-24215-15-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add DT support to the IRQC External IRQ Pin driver.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/irqchip/irq-renesas-irqc.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index 95d69bf..927bff3 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -145,6 +145,7 @@ static int irqc_irq_domain_map(struct irq_domain *h, unsigned int virq,
 
 static struct irq_domain_ops irqc_irq_domain_ops = {
 	.map	= irqc_irq_domain_map,
+	.xlate  = irq_domain_xlate_twocell,
 };
 
 static int irqc_probe(struct platform_device *pdev)
@@ -273,11 +274,19 @@ static int irqc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id irqc_dt_ids[] = {
+	{ .compatible = "renesas,irqc", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, irqc_dt_ids);
+
 static struct platform_driver irqc_device_driver = {
 	.probe		= irqc_probe,
 	.remove		= irqc_remove,
 	.driver		= {
 		.name	= "renesas_irqc",
+		.of_match_table	= irqc_dt_ids,
+		.owner	= THIS_MODULE,
 	}
 };
 
-- 
1.7.10.4
