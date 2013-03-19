From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 19 Mar 2013 17:38:22 +0000
Subject: [PATCH v3 3/4] irqchip: gic: Call handle_bad_irq() directly
In-Reply-To: <1363714703-9629-1-git-send-email-catalin.marinas@arm.com>
References: <1363714703-9629-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1363714703-9629-4-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously, the gic_handle_cascade_irq() function was calling the
ARM-specific do_bad_IRQ() function which calls handle_bad_irq() after
acquiring the desk->lock. Locking the cascaded IRQ desc is not needed
for error reporting, so just call handle_bad_irq() directly.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 drivers/irqchip/irq-gic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 0b1c0af..974f77c 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -44,7 +44,6 @@
 #include <asm/irq.h>
 #include <asm/exception.h>
 #include <asm/smp_plat.h>
-#include <asm/mach/irq.h>
 
 #include "irqchip.h"
 
@@ -324,7 +323,7 @@ static void gic_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
 
 	cascade_irq = irq_find_mapping(chip_data->domain, gic_irq);
 	if (unlikely(gic_irq < 32 || gic_irq > 1020))
-		do_bad_IRQ(cascade_irq, desc);
+		handle_bad_irq(cascade_irq, desc);
 	else
 		generic_handle_irq(cascade_irq);
 
