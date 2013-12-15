From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sun, 15 Dec 2013 08:28:15 +0400
Subject: [PATCH v3 08/10] arm: sa1100: merge IRQ 11 to "normal" irq domain
In-Reply-To: <1387081697-21841-1-git-send-email-dbaryshkov@gmail.com>
References: <1387081697-21841-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1387081697-21841-9-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IRQ 11 is a shared IRQ receiving IRQs from "high" GPIOs. It is still
handled by sa1100_normal_chip, so there is no point to exclude it from
"normal" irq domain. The IRQF_VALID flag set by domain map function will
be cleared by irq_set_chained_handler() internally.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/irq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index bb3bdad..5c72062 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/arch/arm/mach-sa1100/irq.c
@@ -434,7 +434,7 @@ void __init sa1100_init_irq(void)
 			&sa1100_low_gpio_irqdomain_ops, NULL);
 
 	sa1100_normal_irqdomain = irq_domain_add_legacy(NULL,
-			20, 12, 12,
+			21, 11, 11,
 			&sa1100_normal_irqdomain_ops, NULL);
 
 	sa1100_high_gpio_irqdomain = irq_domain_add_legacy(NULL,
@@ -444,7 +444,6 @@ void __init sa1100_init_irq(void)
 	/*
 	 * Install handler for GPIO 11-27 edge detect interrupts
 	 */
-	irq_set_chip(IRQ_GPIO11_27, &sa1100_normal_chip);
 	irq_set_chained_handler(IRQ_GPIO11_27, sa1100_high_gpio_handler);
 
 	set_handle_irq(sa1100_handle_irq);
-- 
1.8.5.1
