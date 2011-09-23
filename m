From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 24 Sep 2011 01:01:24 +0800
Subject: [PATCH] ARM i.MX gic: add handle_irq function
In-Reply-To: <1316522956-28530-1-git-send-email-s.hauer@pengutronix.de>
References: <1316522956-28530-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1316797284-21010-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a plain translation of assembly gic irq handler to C function
for CONFIG_MULTI_IRQ_HANDLER support on imx family.

As the speed of gic_handle_irq() is much more important than code
clean, the patch chooses to plug the ifdef in the function to compile
out the corresponding codes.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Right, ideally the arch/arm/plat-mxc/gic.c should be merged into
arch/arm/common/gic.c.  But before rmk asks me to do that, I would
let it stay in imx platform.

 arch/arm/plat-mxc/Makefile                   |    2 +-
 arch/arm/plat-mxc/gic.c                      |   47 ++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/common.h      |    2 +
 arch/arm/plat-mxc/include/mach/entry-macro.S |    6 +++
 4 files changed, 56 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/plat-mxc/gic.c

diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
index d53c35f..b9f0f5f 100644
--- a/arch/arm/plat-mxc/Makefile
+++ b/arch/arm/plat-mxc/Makefile
@@ -5,7 +5,7 @@
 # Common support
 obj-y := clock.o time.o devices.o cpu.o system.o irq-common.o
 
-# MX51 uses the TZIC interrupt controller, older platforms use AVIC
+obj-$(CONFIG_ARM_GIC) += gic.o
 obj-$(CONFIG_MXC_TZIC) += tzic.o
 obj-$(CONFIG_MXC_AVIC) += avic.o
 
diff --git a/arch/arm/plat-mxc/gic.c b/arch/arm/plat-mxc/gic.c
new file mode 100644
index 0000000..487d12c
--- /dev/null
+++ b/arch/arm/plat-mxc/gic.c
@@ -0,0 +1,47 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/io.h>
+#include <asm/localtimer.h>
+#include <asm/hardware/gic.h>
+#ifdef CONFIG_SMP
+#include <asm/smp.h>
+#endif
+
+asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
+{
+	u32 irqstat, irqnr;
+
+	do {
+		irqstat = readl_relaxed(gic_cpu_base_addr + GIC_CPU_INTACK);
+		irqnr = irqstat & 0x3ff;
+		if (irqnr == 1023)
+			break;
+
+		if (irqnr > 29 && irqnr < 1021)
+			handle_IRQ(irqnr, regs);
+#ifdef CONFIG_SMP
+		else if (irqnr < 16) {
+			writel_relaxed(irqstat, gic_cpu_base_addr +
+						GIC_CPU_EOI);
+			do_IPI(irqnr, regs);
+		}
+#endif
+#ifdef CONFIG_LOCAL_TIMERS
+		else if (irqnr == 29) {
+			writel_relaxed(irqstat, gic_cpu_base_addr +
+						GIC_CPU_EOI);
+			do_local_timer(regs);
+		}
+#endif
+	} while (1);
+}
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 2e8802b..49cad2a 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -75,6 +75,7 @@ extern int mx53_display_revision(void);
 
 void avic_handle_irq(struct pt_regs *);
 void tzic_handle_irq(struct pt_regs *);
+void gic_handle_irq(struct pt_regs *);
 
 #define mx1_handle_irq avic_handle_irq
 #define mx21_handle_irq avic_handle_irq
@@ -85,5 +86,6 @@ void tzic_handle_irq(struct pt_regs *);
 #define mx50_handle_irq tzic_handle_irq
 #define mx51_handle_irq tzic_handle_irq
 #define mx53_handle_irq tzic_handle_irq
+#define imx6q_handle_irq gic_handle_irq
 
 #endif
diff --git a/arch/arm/plat-mxc/include/mach/entry-macro.S b/arch/arm/plat-mxc/include/mach/entry-macro.S
index 842fbcb..9fe0dfc 100644
--- a/arch/arm/plat-mxc/include/mach/entry-macro.S
+++ b/arch/arm/plat-mxc/include/mach/entry-macro.S
@@ -22,3 +22,9 @@
 
 	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 	.endm
+
+	.macro test_for_ipi, irqnr, irqstat, base, tmp
+	.endm
+
+	.macro test_for_ltirq, irqnr, irqstat, base, tmp
+	.endm
-- 
1.7.4.1
