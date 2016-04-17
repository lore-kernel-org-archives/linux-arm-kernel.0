From: sasha.levin@oracle.com (Sasha Levin)
Date: Sun, 17 Apr 2016 05:59:51 -0400
Subject: [added to the 3.18 stable tree] irqchip: omap-intc: Improve IRQ
 handler
In-Reply-To: <1460887352-20128-1-git-send-email-sasha.levin@oracle.com>
References: <1460887352-20128-1-git-send-email-sasha.levin@oracle.com>
Message-ID: <1460887352-20128-6-git-send-email-sasha.levin@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Balbi <balbi@ti.com>

This patch has been added to the 3.18 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit 6ed3464897cc825a75218653c710d673282dfcf8 ]

As it turns out the current IRQ number will *always* be available from
SIR register which renders the reads of PENDING registers as plain
unnecessary overhead.

In order to catch any situation where SIR reads as zero, we're adding
a WARN() to turn it into a very verbose error and users actually
report it.

With this patch average running time of omap_intc_handle_irq() reduced
from about 28.5us to 19.8us as measured by the kernel function
profiler.

Tested with BeagleBoneBlack Rev A5C.

Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
Cc: Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
Link: http://lkml.kernel.org/r/20150720204910.GH5394 at saruman.tx.rr.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 drivers/irqchip/irq-omap-intc.c | 35 +++++------------------------------
 1 file changed, 5 insertions(+), 30 deletions(-)

diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-intc.c
index c03f140..e37490d 100644
--- a/drivers/irqchip/irq-omap-intc.c
+++ b/drivers/irqchip/irq-omap-intc.c
@@ -331,37 +331,12 @@ static int __init omap_init_irq(u32 base, struct device_node *node)
 static asmlinkage void __exception_irq_entry
 omap_intc_handle_irq(struct pt_regs *regs)
 {
-	u32 irqnr = 0;
-	int handled_irq = 0;
-	int i;
-
-	do {
-		for (i = 0; i < omap_nr_pending; i++) {
-			irqnr = intc_readl(INTC_PENDING_IRQ0 + (0x20 * i));
-			if (irqnr)
-				goto out;
-		}
-
-out:
-		if (!irqnr)
-			break;
-
-		irqnr = intc_readl(INTC_SIR);
-		irqnr &= ACTIVEIRQ_MASK;
+	u32 irqnr;
 
-		if (irqnr) {
-			handle_domain_irq(domain, irqnr, regs);
-			handled_irq = 1;
-		}
-	} while (irqnr);
-
-	/*
-	 * If an irq is masked or deasserted while active, we will
-	 * keep ending up here with no irq handled. So remove it from
-	 * the INTC with an ack.
-	 */
-	if (!handled_irq)
-		omap_ack_irq(NULL);
+	irqnr = intc_readl(INTC_SIR);
+	irqnr &= ACTIVEIRQ_MASK;
+	WARN_ONCE(!irqnr, "Spurious IRQ ?\n");
+	handle_domain_irq(domain, irqnr, regs);
 }
 
 void __init omap2_init_irq(void)
-- 
2.5.0
