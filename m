From: tony@atomide.com (Tony Lindgren)
Date: Fri, 13 Aug 2010 11:02:10 +0300
Subject: [PATCH 5/6] omap: Use CONFIG_SMP for test_for_ipi and test_for_ltirq
In-Reply-To: <20100813080034.18750.15410.stgit@baageli.muru.com>
References: <20100813080034.18750.15410.stgit@baageli.muru.com>
Message-ID: <20100813080210.18750.68209.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise we get the following error when enabling CONFIG_SMP
for omap3_defconfig:

arch/arm/kernel/entry-armv.S: Assembler messages:
arch/arm/kernel/entry-armv.S:48: Error: bad instruction `test_for_ipi r0,r6,r5,lr'
arch/arm/kernel/entry-armv.S:48: Error: bad instruction `test_for_ltirq r0,r6,r5,lr'
arch/arm/kernel/entry-armv.S:48: Error: bad instruction `test_for_ipi r0,r6,r5,lr'
arch/arm/kernel/entry-armv.S:48: Error: bad instruction `test_for_ltirq r0,r6,r5,lr'

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/include/mach/entry-macro.S |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
index 50fd749..06e64e1 100644
--- a/arch/arm/mach-omap2/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
@@ -177,7 +177,10 @@ omap_irq_base:	.word	0
 		cmpne   \irqnr, \tmp
 		cmpcs   \irqnr, \irqnr
 		.endm
+#endif
+#endif	/* MULTI_OMAP2 */
 
+#ifdef CONFIG_SMP
 		/* We assume that irqstat (the raw value of the IRQ acknowledge
 		 * register) is preserved from the macro above.
 		 * If there is an IPI, we immediately signal end of interrupt
@@ -205,8 +208,7 @@ omap_irq_base:	.word	0
 		streq	\irqstat, [\base, #GIC_CPU_EOI]
 		cmp	\tmp, #0
 		.endm
-#endif
-#endif	/* MULTI_OMAP2 */
+#endif	/* CONFIG_SMP */
 
 		.macro	irq_prio_table
 		.endm
