From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  3 Nov 2014 09:31:02 +0100
Subject: [PATCH v2 3/5] irqchip: atmel-aic: add specific irq fixup function
 for sam9g45 and sam9rl
In-Reply-To: <1415003464-29239-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1415003464-29239-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1415003464-29239-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris BREZILLON <boris.brezillon@free-electrons.com>

The at91sam9g45 and at91sam9rl SoCs embed one RTT (Real Time Timer) and one
RTC block and thus need to call both rtt and rtc fixup functions.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 drivers/irqchip/irq-atmel-aic.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-atmel-aic.c b/drivers/irqchip/irq-atmel-aic.c
index 637d600..d7b0495 100644
--- a/drivers/irqchip/irq-atmel-aic.c
+++ b/drivers/irqchip/irq-atmel-aic.c
@@ -219,10 +219,16 @@ static void __init at91sam9260_aic_irq_fixup(struct device_node *root)
 	aic_common_rtt_irq_fixup(root);
 }
 
+static void __init at91sam9g45_aic_irq_fixup(struct device_node *root)
+{
+	aic_common_rtc_irq_fixup(root);
+	aic_common_rtt_irq_fixup(root);
+}
+
 static const struct of_device_id __initdata aic_irq_fixups[] = {
-	{ .compatible = "atmel,at91sam9g45", .data = at91sam9_aic_irq_fixup },
+	{ .compatible = "atmel,at91sam9g45", .data = at91sam9g45_aic_irq_fixup },
 	{ .compatible = "atmel,at91sam9n12", .data = at91sam9_aic_irq_fixup },
-	{ .compatible = "atmel,at91sam9rl", .data = at91sam9_aic_irq_fixup },
+	{ .compatible = "atmel,at91sam9rl", .data = at91sam9g45_aic_irq_fixup },
 	{ .compatible = "atmel,at91sam9x5", .data = at91sam9_aic_irq_fixup },
 	{ .compatible = "atmel,at91sam9260", .data = at91sam9260_aic_irq_fixup },
 	{ .compatible = "atmel,at91sam9261", .data = at91sam9260_aic_irq_fixup },
-- 
1.9.1
