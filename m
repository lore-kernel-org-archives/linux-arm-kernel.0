From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 21:05:57 +0900
Subject: [PATCH 13/14] irqchip: intc-irqpin: Initial DT support
In-Reply-To: <1363608358-24215-1-git-send-email-horms+renesas@verge.net.au>
References: <1363608358-24215-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363608358-24215-14-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add initial DT support to the INTC External IRQ Pin
driver. At this point only hardware with 4-bit wide
sense registers is supported via DT.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/irqchip/irq-renesas-intc-irqpin.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index 21f4602..fd5dabc 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -278,6 +278,7 @@ static int intc_irqpin_irq_domain_map(struct irq_domain *h, unsigned int virq,
 
 static struct irq_domain_ops intc_irqpin_irq_domain_ops = {
 	.map	= intc_irqpin_irq_domain_map,
+	.xlate  = irq_domain_xlate_twocell,
 };
 
 static int intc_irqpin_probe(struct platform_device *pdev)
@@ -437,11 +438,19 @@ static int intc_irqpin_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id intc_irqpin_dt_ids[] = {
+	{ .compatible = "renesas,intc-irqpin", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, intc_irqpin_dt_ids);
+
 static struct platform_driver intc_irqpin_device_driver = {
 	.probe		= intc_irqpin_probe,
 	.remove		= intc_irqpin_remove,
 	.driver		= {
 		.name	= "renesas_intc_irqpin",
+		.of_match_table = intc_irqpin_dt_ids,
+		.owner  = THIS_MODULE,
 	}
 };
 
-- 
1.7.10.4
