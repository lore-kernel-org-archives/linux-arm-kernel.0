From: tony@atomide.com (Tony Lindgren)
Date: Tue, 4 Sep 2012 17:03:09 -0700
Subject: [PATCH] ARM: OMAP4: Fix array size for irq_target_cpu
Message-ID: <20120905000309.GW1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If NR_IRQS is less than MAX_IRQS, we end up writing past the
irq_target_cpu array in omap_wakeupgen_init():

/* Associate all the IRQs to boot CPU like GIC init does. */
for (i = 0; i < max_irqs; i++)
	irq_target_cpu[i] = boot_cpu;

This can happen if SPARSE_IRQ is enabled as by default NR_IRQS is
set to 16. Without this patch we're overwriting other data during
the boot.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -47,7 +47,7 @@
 static void __iomem *wakeupgen_base;
 static void __iomem *sar_base;
 static DEFINE_SPINLOCK(wakeupgen_lock);
-static unsigned int irq_target_cpu[NR_IRQS];
+static unsigned int irq_target_cpu[MAX_IRQS];
 static unsigned int irq_banks = MAX_NR_REG_BANKS;
 static unsigned int max_irqs = MAX_IRQS;
 static unsigned int omap_secure_apis;
