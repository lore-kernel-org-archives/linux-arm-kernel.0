From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 25 Nov 2014 22:09:50 +0300
Subject: [PATCH v2 6/8] ARM: sa1100: merge GPIO multiplexer IRQ to "normal"
 irq domain
In-Reply-To: <1416942592-23059-1-git-send-email-dbaryshkov@gmail.com>
References: <1416942592-23059-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1416942592-23059-7-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IRQ_GPIO11_27 is a shared IRQ receiving IRQs from "high" GPIOs. It is
still handled by sa1100_normal_chip, so there is no point to exclude it
from "normal" irq domain. The IRQF_VALID flag set by domain map function
will be cleared by irq_set_chained_handler() internally.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/irq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index 2d8be03..14a7633e 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/arch/arm/mach-sa1100/irq.c
@@ -387,7 +387,7 @@ void __init sa1100_init_irq(void)
 			&sa1100_low_gpio_irqdomain_ops, NULL);
 
 	sa1100_normal_irqdomain = irq_domain_add_legacy(NULL,
-			20, IRQ_LCD, 12,
+			21, IRQ_GPIO11_27, 11,
 			&sa1100_normal_irqdomain_ops, NULL);
 
 	sa1100_high_gpio_irqdomain = irq_domain_add_legacy(NULL,
@@ -397,7 +397,6 @@ void __init sa1100_init_irq(void)
 	/*
 	 * Install handler for GPIO 11-27 edge detect interrupts
 	 */
-	irq_set_chip(IRQ_GPIO11_27, &sa1100_normal_chip);
 	irq_set_chained_handler(IRQ_GPIO11_27, sa1100_high_gpio_handler);
 
 	set_handle_irq(sa1100_handle_irq);
-- 
2.1.3
