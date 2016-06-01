From: kraxel@redhat.com (Gerd Hoffmann)
Date: Wed,  1 Jun 2016 23:43:12 +0200
Subject: [PATCH 03/32] irqchip: bcm2835: Avoid arch/arm-specific handle_IRQ.
In-Reply-To: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
Message-ID: <1464817421-8519-4-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Anholt <eric@anholt.net>

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
index 72ff1d5..2787598 100644
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
1.8.3.1
