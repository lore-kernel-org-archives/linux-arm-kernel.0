From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 18 Oct 2012 19:19:15 +0200
Subject: [PATCH 6/8] mfd/ab8500-core: use irq_domain_add_simple()
Message-ID: <1350580755-8516-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

To be able to use SPARSE_IRQ while yet not using device tree,
we need to use irq_domain_add_simple() that will allocate
descriptors for the IRQs in the non-DT case, and fall back
to using the linear irqdomain in the DT case.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Sam, requesting you ACK on this patch so we can merge them
all together.
Lee, requesting your testing with Device Tree to see that this
actually can fly as I wanted it.
---
 drivers/mfd/ab8500-core.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 1667c77..547fff4 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -565,15 +565,10 @@ static int ab8500_irq_init(struct ab8500 *ab8500, struct device_node *np)
 	else
 		num_irqs = AB8500_NR_IRQS;
 
-	if (ab8500->irq_base) {
-		ab8500->domain = irq_domain_add_legacy(
-			NULL, num_irqs, ab8500->irq_base,
-			0, &ab8500_irq_ops, ab8500);
-	}
-	else {
-		ab8500->domain = irq_domain_add_linear(
-			np, num_irqs, &ab8500_irq_ops, ab8500);
-	}
+	/* If ->irq_base is zero this will give a linear mapping */
+	ab8500->domain = irq_domain_add_simple(NULL,
+			num_irqs, ab8500->irq_base,
+			&ab8500_irq_ops, ab8500);
 
 	if (!ab8500->domain) {
 		dev_err(ab8500->dev, "Failed to create irqdomain\n");
-- 
1.7.11.3
