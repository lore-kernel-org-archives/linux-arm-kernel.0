From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  5 Jun 2018 13:43:34 +0200
Subject: [PATCH] irqchip/stm32: fix non-SMP build warning
Message-ID: <20180605114347.1347128-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without CONFIG_SMP, we get a harmless compile-time warning:

drivers/irqchip/irq-stm32-exti.c:495:12: error: 'stm32_exti_h_set_affinity' defined but not used [-Werror=unused-function]

The #ifdef is inconsistent here, and it's better to use an IS_ENABLED() check
that lets the compiler silently drop that function.

Fixes: 927abfc4461e ("irqchip/stm32: Add stm32mp1 support with hierarchy domain")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/irqchip/irq-stm32-exti.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 5089c1e2838d..3a7e8905a97e 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -552,9 +552,7 @@ static struct irq_chip stm32_exti_h_chip = {
 	.irq_set_type		= stm32_exti_h_set_type,
 	.irq_set_wake		= stm32_exti_h_set_wake,
 	.flags			= IRQCHIP_MASK_ON_SUSPEND,
-#ifdef CONFIG_SMP
-	.irq_set_affinity	= stm32_exti_h_set_affinity,
-#endif
+	.irq_set_affinity	= IS_ENABLED(CONFIG_SMP) ? stm32_exti_h_set_affinity : NULL,
 };
 
 static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
-- 
2.9.0
