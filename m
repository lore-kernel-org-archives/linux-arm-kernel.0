From: robherring2@gmail.com (Rob Herring)
Date: Mon, 12 May 2014 19:29:52 -0500
Subject: [PATCH 6/7] irqchip: mxs: fix function type for IRQCHIP_OF_DECLARE
In-Reply-To: <1399940993-1773-1-git-send-email-robherring2@gmail.com>
References: <1399940993-1773-1-git-send-email-robherring2@gmail.com>
Message-ID: <1399940993-1773-7-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Adding function type checking to IRQCHIP_OF_DECLARE found a type mismatch
with icoll_of_init. The function should return an error code or 0 on
success.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-mxs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-mxs.c b/drivers/irqchip/irq-mxs.c
index 63b3d4e..4044ff2 100644
--- a/drivers/irqchip/irq-mxs.c
+++ b/drivers/irqchip/irq-mxs.c
@@ -96,7 +96,7 @@ static struct irq_domain_ops icoll_irq_domain_ops = {
 	.xlate = irq_domain_xlate_onecell,
 };
 
-static void __init icoll_of_init(struct device_node *np,
+static int __init icoll_of_init(struct device_node *np,
 			  struct device_node *interrupt_parent)
 {
 	icoll_base = of_iomap(np, 0);
@@ -110,6 +110,6 @@ static void __init icoll_of_init(struct device_node *np,
 
 	icoll_domain = irq_domain_add_linear(np, ICOLL_NUM_IRQS,
 					     &icoll_irq_domain_ops, NULL);
-	WARN_ON(!icoll_domain);
+	return icoll_domain ? 0 : -ENODEV;
 }
 IRQCHIP_DECLARE(mxs, "fsl,icoll", icoll_of_init);
-- 
1.9.1
