From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sun, 11 Dec 2011 12:21:38 +0530
Subject: [PATCH v2 1/4] ARM: Exynos4: Simplify EINT number to linux irq number
 translation
In-Reply-To: <1323586301-24537-1-git-send-email-thomas.abraham@linaro.org>
References: <1323586301-24537-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1323586301-24537-2-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The exynos4_get_irq_nr function that converts a given wakeup interrupt
source number to a linux irq number is simplified and replaced with
the new macro exynos4_irq_eint_to_gic_irq.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/irq-eint.c |   25 +++----------------------
 1 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-exynos/irq-eint.c b/arch/arm/mach-exynos/irq-eint.c
index badb8c6..5e89412 100644
--- a/arch/arm/mach-exynos/irq-eint.c
+++ b/arch/arm/mach-exynos/irq-eint.c
@@ -29,26 +29,7 @@ static DEFINE_SPINLOCK(eint_lock);
 
 static unsigned int eint0_15_data[16];
 
-static unsigned int exynos4_get_irq_nr(unsigned int number)
-{
-	u32 ret = 0;
-
-	switch (number) {
-	case 0 ... 3:
-		ret = (number + IRQ_EINT0);
-		break;
-	case 4 ... 7:
-		ret = (number + (IRQ_EINT4 - 4));
-		break;
-	case 8 ... 15:
-		ret = (number + (IRQ_EINT8 - 8));
-		break;
-	default:
-		printk(KERN_ERR "number available : %d\n", number);
-	}
-
-	return ret;
-}
+#define exynos4_irq_eint_to_gic_irq(number) (IRQ_EINT0 + number)
 
 static inline void exynos4_irq_eint_mask(struct irq_data *data)
 {
@@ -225,9 +206,9 @@ int __init exynos4_init_irq_eint(void)
 	for (irq = 0 ; irq <= 15 ; irq++) {
 		eint0_15_data[irq] = IRQ_EINT(irq);
 
-		irq_set_handler_data(exynos4_get_irq_nr(irq),
+		irq_set_handler_data(exynos4_irq_eint_to_gic_irq(irq),
 				     &eint0_15_data[irq]);
-		irq_set_chained_handler(exynos4_get_irq_nr(irq),
+		irq_set_chained_handler(exynos4_irq_eint_to_gic_irq(irq),
 					exynos4_irq_eint0_15);
 	}
 
-- 
1.6.6.rc2
