From: b-cousson@ti.com (Benoit Cousson)
Date: Tue, 20 Dec 2011 14:39:55 +0100
Subject: [PATCH v2 2/5] ARM: OMAP2/3: intc: Add irqdomain support
In-Reply-To: <1324388398-2683-1-git-send-email-b-cousson@ti.com>
References: <1324388398-2683-1-git-send-email-b-cousson@ti.com>
Message-ID: <1324388398-2683-3-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce the usage of the irqdomain to prepare the DT support.
The irq_base is still hard coded to 0 to allow non-DT drivers
to work with the previous assumption that was hwirq = irq.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-omap2/irq.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 42b1d65..2f65dfd 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -17,6 +17,7 @@
 #include <mach/hardware.h>
 #include <asm/exception.h>
 #include <asm/mach/irq.h>
+#include <linux/irqdomain.h>
 
 
 /* selected INTC register offsets */
@@ -57,6 +58,8 @@ static struct omap_irq_bank {
 	},
 };
 
+static struct irq_domain domain;
+
 /* Structure to save interrupt controller context */
 struct omap3_intc_regs {
 	u32 sysconfig;
@@ -158,6 +161,17 @@ static void __init omap_init_irq(u32 base, int nr_irqs)
 	if (WARN_ON(!omap_irq_base))
 		return;
 
+	/*
+	 * XXX: Use a 0 irq_base for the moment since the legacy devices
+	 * created statically are expected a hwirq = irq mapping.
+	 * A proper offset will be added later, when IRQ resource creation
+	 * will be handled by DT.
+	 */
+	domain.irq_base = 0;
+	domain.nr_irq = nr_irqs;
+	domain.ops = &irq_domain_simple_ops;
+	irq_domain_add(&domain);
+
 	for (i = 0; i < ARRAY_SIZE(irq_banks); i++) {
 		struct omap_irq_bank *bank = irq_banks + i;
 
@@ -225,8 +239,10 @@ out:
 		irqnr = readl_relaxed(base_addr + INTCPS_SIR_IRQ_OFFSET);
 		irqnr &= ACTIVEIRQ_MASK;
 
-		if (irqnr)
+		if (irqnr) {
+			irqnr = irq_domain_to_irq(&domain, irqnr);
 			handle_IRQ(irqnr, regs);
+		}
 	} while (irqnr);
 }
 
-- 
1.7.0.4
