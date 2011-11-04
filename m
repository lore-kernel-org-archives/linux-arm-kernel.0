From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  4 Nov 2011 16:57:38 +0000
Subject: [PATCH v3 04/17] ARM: mxc: convert smp platforms to global
	gic_handle_irq()
In-Reply-To: <1320425871-30564-1-git-send-email-marc.zyngier@arm.com>
References: <1320425871-30564-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1320425871-30564-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the SMP shmobile platforms to use the global gic_handle_irq()
function instead a private function.

Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/plat-mxc/Makefile                   |    1 -
 arch/arm/plat-mxc/gic.c                      |   41 --------------------------
 arch/arm/plat-mxc/include/mach/common.h      |    3 +-
 arch/arm/plat-mxc/include/mach/entry-macro.S |   14 ---------
 4 files changed, 1 insertions(+), 58 deletions(-)
 delete mode 100644 arch/arm/plat-mxc/gic.c

diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
index b9f0f5f..076db84 100644
--- a/arch/arm/plat-mxc/Makefile
+++ b/arch/arm/plat-mxc/Makefile
@@ -5,7 +5,6 @@
 # Common support
 obj-y := clock.o time.o devices.o cpu.o system.o irq-common.o
 
-obj-$(CONFIG_ARM_GIC) += gic.o
 obj-$(CONFIG_MXC_TZIC) += tzic.o
 obj-$(CONFIG_MXC_AVIC) += avic.o
 
diff --git a/arch/arm/plat-mxc/gic.c b/arch/arm/plat-mxc/gic.c
deleted file mode 100644
index ea51ea4..0000000
--- a/arch/arm/plat-mxc/gic.c
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * Copyright 2011 Freescale Semiconductor, Inc.
- * Copyright 2011 Linaro Ltd.
- *
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
-
-#include <linux/io.h>
-#include <asm/exception.h>
-#include <asm/localtimer.h>
-#include <asm/hardware/gic.h>
-#ifdef CONFIG_SMP
-#include <asm/smp.h>
-#endif
-
-asmlinkage void __exception_irq_entry mxc_gic_handle_irq(struct pt_regs *regs)
-{
-	u32 irqstat, irqnr;
-
-	do {
-		irqstat = readl_relaxed(gic_cpu_base_addr + GIC_CPU_INTACK);
-		irqnr = irqstat & 0x3ff;
-		if (irqnr == 1023)
-			break;
-
-		if (irqnr > 15 && irqnr < 1021)
-			handle_IRQ(irqnr, regs);
-#ifdef CONFIG_SMP
-		else {
-			writel_relaxed(irqstat, gic_cpu_base_addr +
-						GIC_CPU_EOI);
-			handle_IPI(irqnr, regs);
-		}
-#endif
-	} while (1);
-}
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index f6c13ab..14b4703 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -90,7 +90,6 @@ extern void imx_print_silicon_rev(const char *cpu, int srev);
 
 void avic_handle_irq(struct pt_regs *);
 void tzic_handle_irq(struct pt_regs *);
-void mxc_gic_handle_irq(struct pt_regs *);
 
 #define imx1_handle_irq avic_handle_irq
 #define imx21_handle_irq avic_handle_irq
@@ -101,7 +100,7 @@ void mxc_gic_handle_irq(struct pt_regs *);
 #define imx50_handle_irq tzic_handle_irq
 #define imx51_handle_irq tzic_handle_irq
 #define imx53_handle_irq tzic_handle_irq
-#define imx6q_handle_irq mcx_gic_handle_irq
+#define imx6q_handle_irq gic_handle_irq
 
 extern void imx_enable_cpu(int cpu, bool enable);
 extern void imx_set_cpu_jump(int cpu, void *jump_addr);
diff --git a/arch/arm/plat-mxc/include/mach/entry-macro.S b/arch/arm/plat-mxc/include/mach/entry-macro.S
index 9fe0dfc..def5d30 100644
--- a/arch/arm/plat-mxc/include/mach/entry-macro.S
+++ b/arch/arm/plat-mxc/include/mach/entry-macro.S
@@ -9,22 +9,8 @@
  * published by the Free Software Foundation.
  */
 
-/* Unused, we use CONFIG_MULTI_IRQ_HANDLER */
-
 	.macro	disable_fiq
 	.endm
 
-	.macro  get_irqnr_preamble, base, tmp
-	.endm
-
 	.macro  arch_ret_to_user, tmp1, tmp2
 	.endm
-
-	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-	.endm
-
-	.macro test_for_ipi, irqnr, irqstat, base, tmp
-	.endm
-
-	.macro test_for_ltirq, irqnr, irqstat, base, tmp
-	.endm
-- 
1.7.0.4
