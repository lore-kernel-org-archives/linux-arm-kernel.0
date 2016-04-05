From: eric@anholt.net (Eric Anholt)
Date: Mon,  4 Apr 2016 20:44:15 -0700
Subject: [PATCH 1/4] irqchip: bcm2835: Avoid arch/arm-specific handle_IRQ
In-Reply-To: <1459827858-3871-1-git-send-email-eric@anholt.net>
References: <1459827858-3871-1-git-send-email-eric@anholt.net>
Message-ID: <1459827858-3871-2-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is equivalent and works for arm64 as well.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/irqchip/irq-bcm2835.c | 3 +--
 drivers/irqchip/irq-bcm2836.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
index bf9cc5f..44d7c38 100644
--- a/drivers/irqchip/irq-bcm2835.c
+++ b/drivers/irqchip/irq-bcm2835.c
@@ -52,7 +52,6 @@
 #include <linux/irqdomain.h>
 
 #include <asm/exception.h>
-#include <asm/mach/irq.h>
 
 /* Put the bank and irq (32 bits) into the hwirq */
 #define MAKE_HWIRQ(b, n)	((b << 5) | (n))
@@ -242,7 +241,7 @@ static void __exception_irq_entry bcm2835_handle_irq(
 	u32 hwirq;
 
 	while ((hwirq = get_next_armctrl_hwirq()) != ~0)
-		handle_IRQ(irq_linear_revmap(intc.domain, hwirq), regs);
+		handle_domain_irq(intc.domain, hwirq, regs);
 }
 
 static void bcm2836_chained_handle_irq(struct irq_desc *desc)
diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index b6e950d..233ccdd 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -180,7 +180,7 @@ __exception_irq_entry bcm2836_arm_irqchip_handle_irq(struct pt_regs *regs)
 	} else if (stat) {
 		u32 hwirq = ffs(stat) - 1;
 
-		handle_IRQ(irq_linear_revmap(intc.domain, hwirq), regs);
+		handle_domain_irq(intc.domain, hwirq, regs);
 	}
 }
 
-- 
2.7.0
