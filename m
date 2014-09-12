From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 12 Sep 2014 17:43:00 +0200
Subject: [PATCHv2 1/8] irqchip: atmel-aic5: Add sama5d4 support
In-Reply-To: <1410536587-24607-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1410536587-24607-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1410536587-24607-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add sama5d4 support to irq-atmel-aic5.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: Jason Cooper <jason@lakedaemon.net>
 .../devicetree/bindings/interrupt-controller/atmel,aic.txt     |  2 +-
 drivers/irqchip/irq-atmel-aic5.c                               | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
index 2742e9cfd6b1..f292917fa00d 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
@@ -2,7 +2,7 @@
 
 Required properties:
 - compatible: Should be "atmel,<chip>-aic"
-  <chip> can be "at91rm9200" or "sama5d3"
+  <chip> can be "at91rm9200", "sama5d3" or "sama5d4"
 - interrupt-controller: Identifies the node as an interrupt controller.
 - interrupt-parent: For single AIC system, it is an empty property.
 - #interrupt-cells: The number of cells to define the interrupts. It should be 3.
diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
index dc7d98607a89..a11aae8fb006 100644
--- a/drivers/irqchip/irq-atmel-aic5.c
+++ b/drivers/irqchip/irq-atmel-aic5.c
@@ -295,6 +295,7 @@ static void __init sama5d3_aic_irq_fixup(struct device_node *root)
 
 static const struct of_device_id __initdata aic5_irq_fixups[] = {
 	{ .compatible = "atmel,sama5d3", .data = sama5d3_aic_irq_fixup },
+	{ .compatible = "atmel,sama5d4", .data = sama5d3_aic_irq_fixup },
 	{ /* sentinel */ },
 };
 
@@ -349,3 +350,12 @@ static int __init sama5d3_aic5_of_init(struct device_node *node,
 	return aic5_of_init(node, parent, NR_SAMA5D3_IRQS);
 }
 IRQCHIP_DECLARE(sama5d3_aic5, "atmel,sama5d3-aic", sama5d3_aic5_of_init);
+
+#define NR_SAMA5D4_IRQS		68
+
+static int __init sama5d4_aic5_of_init(struct device_node *node,
+				       struct device_node *parent)
+{
+	return aic5_of_init(node, parent, NR_SAMA5D4_IRQS);
+}
+IRQCHIP_DECLARE(sama5d4_aic5, "atmel,sama5d4-aic", sama5d4_aic5_of_init);
-- 
1.9.1
