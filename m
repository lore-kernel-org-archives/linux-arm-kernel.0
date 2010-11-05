From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  5 Nov 2010 10:46:08 +0100
Subject: [PATCH 4/7] ARM i.MX irq: Allow runtime decision between AVIC and TZIC
In-Reply-To: <1288950371-1552-1-git-send-email-s.hauer@pengutronix.de>
References: <1288950371-1552-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1288950371-1552-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we are on a path to support more different i.MX SoCs in a single
binary we have to able to support both AVIC and TZIC in a single
binary. This patch only introduces overhead when both controllers
are needed.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/avic.c                     |    2 +
 arch/arm/plat-mxc/cpu.c                      |    3 +
 arch/arm/plat-mxc/include/mach/entry-macro.S |   66 ++++++++++++++++----------
 arch/arm/plat-mxc/include/mach/mxc.h         |    8 +++
 arch/arm/plat-mxc/tzic.c                     |    3 +
 5 files changed, 57 insertions(+), 25 deletions(-)

diff --git a/arch/arm/plat-mxc/avic.c b/arch/arm/plat-mxc/avic.c
index 7331f2a..1cb464a 100644
--- a/arch/arm/plat-mxc/avic.c
+++ b/arch/arm/plat-mxc/avic.c
@@ -118,6 +118,8 @@ void __init mxc_init_irq(void __iomem *irqbase)
 	int i;
 
 	avic_base = irqbase;
+	mxc_irq_base = irqbase;
+	mxc_irq_controller_type = MXC_IRQ_TYPE_AVIC;
 
 	/* put the AVIC into the reset value with
 	 * all interrupts disabled
diff --git a/arch/arm/plat-mxc/cpu.c b/arch/arm/plat-mxc/cpu.c
index 386e0d5..dc14a1c 100644
--- a/arch/arm/plat-mxc/cpu.c
+++ b/arch/arm/plat-mxc/cpu.c
@@ -9,3 +9,6 @@ void mxc_set_cpu_type(unsigned int type)
 	__mxc_cpu_type = type;
 }
 
+void __iomem *mxc_irq_base;
+int mxc_irq_controller_type;
+
diff --git a/arch/arm/plat-mxc/include/mach/entry-macro.S b/arch/arm/plat-mxc/include/mach/entry-macro.S
index aeb0869..a7dd008 100644
--- a/arch/arm/plat-mxc/include/mach/entry-macro.S
+++ b/arch/arm/plat-mxc/include/mach/entry-macro.S
@@ -18,40 +18,18 @@
 	.endm
 
 	.macro  get_irqnr_preamble, base, tmp
-#ifndef CONFIG_MXC_TZIC
-	ldr	\base, =avic_base
+	ldr	\base, =mxc_irq_base
 	ldr	\base, [\base]
 #ifdef CONFIG_MXC_IRQ_PRIOR
 	ldr	r4, [\base, #AVIC_NIMASK]
 #endif
-#elif defined CONFIG_MXC_TZIC
-	ldr	\base, =tzic_base
-	ldr	\base, [\base]
-#endif /* CONFIG_MXC_TZIC */
 	.endm
 
 	.macro  arch_ret_to_user, tmp1, tmp2
 	.endm
 
-	@ this macro checks which interrupt occured
-	@ and returns its number in irqnr
-	@ and returns if an interrupt occured in irqstat
-	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-#ifndef CONFIG_MXC_TZIC
-	@ Load offset & priority of the highest priority
-	@ interrupt pending from AVIC_NIVECSR
-	ldr	\irqstat, [\base, #0x40]
-	@ Shift to get the decoded IRQ number, using ASR so
-	@ 'no interrupt pending' becomes 0xffffffff
-	mov	\irqnr, \irqstat, asr #16
-	@ set zero flag if IRQ + 1 == 0
-	adds	\tmp, \irqnr, #1
-#ifdef CONFIG_MXC_IRQ_PRIOR
-	bicne	\tmp, \irqstat, #0xFFFFFFE0
-	strne	\tmp, [\base, #AVIC_NIMASK]
-	streq	r4, [\base, #AVIC_NIMASK]
-#endif
-#elif defined CONFIG_MXC_TZIC
+	.macro	tzic_get_irqnr_and_base, irqnr, irqstat, base, tmp
+
 	@ Load offset & priority of the highest priority
 	@ interrupt pending.
 	@ 0xD80 is HIPND0 register
@@ -76,6 +54,44 @@
 	mov  \irqnr, #0
 2002:
 	movs \irqnr, \irqnr
+	.endm
+
+	.macro	avic_get_irqnr_and_base, irqnr, irqstat, base, tmp
+
+	@ Load offset & priority of the highest priority
+	@ interrupt pending from AVIC_NIVECSR
+	ldr	\irqstat, [\base, #0x40]
+	@ Shift to get the decoded IRQ number, using ASR so
+	@ 'no interrupt pending' becomes 0xffffffff
+	mov	\irqnr, \irqstat, asr #16
+	@ set zero flag if IRQ + 1 == 0
+	adds	\tmp, \irqnr, #1
+#ifdef CONFIG_MXC_IRQ_PRIOR
+	bicne	\tmp, \irqstat, #0xFFFFFFE0
+	strne	\tmp, [\base, #AVIC_NIMASK]
+	streq	r4, [\base, #AVIC_NIMASK]
+#endif
+	.endm
+
+	.macro get_irqnr_and_base, irqnr, irqstat, base, tmp
+#if defined CONFIG_MXC_TZIC && defined CONFIG_MXC_AVIC
+	ldr	\tmp, =mxc_irq_controller_type
+	ldr	\tmp, [\tmp]
+	cmp	\tmp, #MXC_IRQ_TYPE_AVIC
+	beq	3001f
+
+	tzic_get_irqnr_and_base \irqnr, \irqstat, \base, \tmp
+	b	3002f
+3001:
+	avic_get_irqnr_and_base \irqnr, \irqstat, \base, \tmp
+3002:
+
+#elif defined CONFIG_MXC_TZIC
+	tzic_get_irqnr_and_base \irqnr, \irqstat, \base, \tmp
+#elif defined CONFIG_MXC_AVIC
+	avic_get_irqnr_and_base \irqnr, \irqstat, \base, \tmp
+#else
+#error no tzic and no avic?
 #endif
 	.endm
 
diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/plat-mxc/include/mach/mxc.h
index a42c720..3432b78 100644
--- a/arch/arm/plat-mxc/include/mach/mxc.h
+++ b/arch/arm/plat-mxc/include/mach/mxc.h
@@ -154,4 +154,12 @@ extern struct cpu_op *(*get_cpu_op)(int *op);
 #define cpu_is_mx3()	(cpu_is_mx31() || cpu_is_mx35() || cpu_is_mxc91231())
 #define cpu_is_mx2()	(cpu_is_mx21() || cpu_is_mx27())
 
+#ifndef __ASSEMBLY__
+extern int mxc_irq_controller_type;
+extern void __iomem *mxc_irq_base;
+#endif
+
+#define MXC_IRQ_TYPE_AVIC	1
+#define MXC_IRQ_TYPE_TZIC	2
+
 #endif /*  __ASM_ARCH_MXC_H__ */
diff --git a/arch/arm/plat-mxc/tzic.c b/arch/arm/plat-mxc/tzic.c
index 3703ab2..f2179b1 100644
--- a/arch/arm/plat-mxc/tzic.c
+++ b/arch/arm/plat-mxc/tzic.c
@@ -122,6 +122,9 @@ void __init tzic_init_irq(void __iomem *irqbase)
 	int i;
 
 	tzic_base = irqbase;
+	mxc_irq_base = irqbase;
+	mxc_irq_controller_type = MXC_IRQ_TYPE_TZIC;
+
 	/* put the TZIC into the reset value with
 	 * all interrupts disabled
 	 */
-- 
1.7.2.3
