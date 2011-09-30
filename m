From: jason77.wang@gmail.com (Hui Wang)
Date: Fri, 30 Sep 2011 14:37:22 +0800
Subject: [PATCH] mx5: modify pm and idle
Message-ID: <1317364642-22956-1-git-send-email-jason77.wang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two problems exist in the current i.MX5 pm suspend/resume and idle
functions. The first is the current i.MX5 suspend routine will call
tzic_enable_wake(1) to set wake source, this will set all enabled
irq as wake source rather than those wake capable. The second
is i.MX5 idle will call mx5_cpu_lp_set() to prepare enter low power
mode, but it forgets to call wfi instruction to enter this mode.

To fix these two problems, using generic irq chip pm interface and
adding a new function mx5_arch_idle().

Signed-off-by: Hui Wang <jason77.wang@gmail.com>
---

This patch is basing on the latest imx-features branch.

This patch is validated on the i.MX51 PDK board (CPU revision 2.0).

Since both pm suspend/resume and idle has close relation with
mx5_cpu_lp_set() and tzic_enable_wake(), i choose to use one patch
instead of independent two to address existing problems.

 arch/arm/mach-mx5/system.c              |   24 +++++++++++++++--
 arch/arm/plat-mxc/include/mach/mxc.h    |    2 +-
 arch/arm/plat-mxc/include/mach/system.h |    3 +-
 arch/arm/plat-mxc/tzic.c                |   42 ++++++++++++++++++++++---------
 4 files changed, 54 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-mx5/system.c b/arch/arm/mach-mx5/system.c
index 76ae8dc..92bf341 100644
--- a/arch/arm/mach-mx5/system.c
+++ b/arch/arm/mach-mx5/system.c
@@ -10,11 +10,17 @@
  * http://www.opensource.org/licenses/gpl-license.html
  * http://www.gnu.org/copyleft/gpl.html
  */
+#include <linux/suspend.h>
+#include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <mach/hardware.h>
+#include <mach/common.h>
+
 #include "crm_regs.h"
 
+static struct clk *gpc_dvfs_clk;
+
 /* set cpu low power mode before WFI instruction. This function is called
   * mx5 because it can be used for mx50, mx51, and mx53.*/
 void mx5_cpu_lp_set(enum mxc_cpu_pwr_mode mode)
@@ -54,9 +60,6 @@ void mx5_cpu_lp_set(enum mxc_cpu_pwr_mode mode)
 			stop_mode = 1;
 		}
 		arm_srpgcr |= MXC_SRPGCR_PCR;
-
-		if (tzic_enable_wake(1) != 0)
-			return;
 		break;
 	case STOP_POWER_ON:
 		ccm_clpcr |= 0x2 << MXC_CCM_CLPCR_LPM_OFFSET;
@@ -82,3 +85,18 @@ void mx5_cpu_lp_set(enum mxc_cpu_pwr_mode mode)
 		__raw_writel(empgc1, MXC_SRPG_EMPGC1_SRPGCR);
 	}
 }
+
+void mx5_arch_idle(void)
+{
+		if (gpc_dvfs_clk == NULL)
+			gpc_dvfs_clk = clk_get(NULL, "gpc_dvfs");
+
+		/* gpc clock is needed for SRPG */
+		clk_enable(gpc_dvfs_clk);
+		mx5_cpu_lp_set(WAIT_UNCLOCKED_POWER_OFF);
+		if (tzic_enable_wake() != 0)
+			goto exit;
+		cpu_do_idle();
+exit:
+		clk_disable(gpc_dvfs_clk);
+}
diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/plat-mxc/include/mach/mxc.h
index 0987923..c4d324a 100644
--- a/arch/arm/plat-mxc/include/mach/mxc.h
+++ b/arch/arm/plat-mxc/include/mach/mxc.h
@@ -182,7 +182,7 @@ struct cpu_op {
 	u32 cpu_rate;
 };
 
-int tzic_enable_wake(int is_idle);
+int tzic_enable_wake(void);
 enum mxc_cpu_pwr_mode {
 	WAIT_CLOCKED,		/* wfi only */
 	WAIT_UNCLOCKED,		/* WAIT */
diff --git a/arch/arm/plat-mxc/include/mach/system.h b/arch/arm/plat-mxc/include/mach/system.h
index 51f02a9..5b6f991 100644
--- a/arch/arm/plat-mxc/include/mach/system.h
+++ b/arch/arm/plat-mxc/include/mach/system.h
@@ -21,6 +21,7 @@
 #include <mach/common.h>
 
 extern void mx5_cpu_lp_set(enum mxc_cpu_pwr_mode mode);
+extern void mx5_arch_idle(void);
 
 static inline void arch_idle(void)
 {
@@ -51,7 +52,7 @@ static inline void arch_idle(void)
 			"mcr p15, 0, %0, c1, c0, 0\n"
 			: "=r" (reg));
 	} else if (cpu_is_mx51())
-		mx5_cpu_lp_set(WAIT_UNCLOCKED_POWER_OFF);
+		mx5_arch_idle();
 	else
 		cpu_do_idle();
 }
diff --git a/arch/arm/plat-mxc/tzic.c b/arch/arm/plat-mxc/tzic.c
index e993a18..bd73910 100644
--- a/arch/arm/plat-mxc/tzic.c
+++ b/arch/arm/plat-mxc/tzic.c
@@ -72,14 +72,35 @@ static int tzic_set_irq_fiq(unsigned int irq, unsigned int type)
 #define tzic_set_irq_fiq NULL
 #endif
 
-static unsigned int *wakeup_intr[4];
-
 static struct mxc_extra_irq tzic_extra_irq = {
 #ifdef CONFIG_FIQ
 	.set_irq_fiq = tzic_set_irq_fiq,
 #endif
 };
 
+#ifdef CONFIG_PM
+static void tzic_irq_suspend(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	int idx = gc->irq_base >> 5;
+
+	__raw_writel(gc->wake_active, tzic_base + TZIC_WAKEUP0(idx));
+}
+
+static void tzic_irq_resume(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	int idx = gc->irq_base >> 5;
+
+	__raw_writel(__raw_readl(tzic_base + TZIC_ENSET0(idx)),
+		     tzic_base + TZIC_WAKEUP0(idx));
+}
+
+#else
+#define tzic_irq_suspend NULL
+#define tzic_irq_resume NULL
+#endif
+
 static __init void tzic_init_gc(unsigned int irq_start)
 {
 	struct irq_chip_generic *gc;
@@ -90,12 +111,13 @@ static __init void tzic_init_gc(unsigned int irq_start)
 				    handle_level_irq);
 	gc->private = &tzic_extra_irq;
 	gc->wake_enabled = IRQ_MSK(32);
-	wakeup_intr[idx] = &gc->wake_active;
 
 	ct = gc->chip_types;
 	ct->chip.irq_mask = irq_gc_mask_disable_reg;
 	ct->chip.irq_unmask = irq_gc_unmask_enable_reg;
 	ct->chip.irq_set_wake = irq_gc_set_wake;
+	ct->chip.irq_suspend = tzic_irq_suspend;
+	ct->chip.irq_resume = tzic_irq_resume;
 	ct->regs.disable = TZIC_ENCLEAR0(idx);
 	ct->regs.enable = TZIC_ENSET0(idx);
 
@@ -166,23 +188,19 @@ void __init tzic_init_irq(void __iomem *irqbase)
 /**
  * tzic_enable_wake() - enable wakeup interrupt
  *
- * @param is_idle		1 if called in idle loop (ENSET0 register);
- *				0 to be used when called from low power entry
  * @return			0 if successful; non-zero otherwise
  */
-int tzic_enable_wake(int is_idle)
+int tzic_enable_wake(void)
 {
-	unsigned int i, v;
+	unsigned int i;
 
 	__raw_writel(1, tzic_base + TZIC_DSMINT);
 	if (unlikely(__raw_readl(tzic_base + TZIC_DSMINT) == 0))
 		return -EAGAIN;
 
-	for (i = 0; i < 4; i++) {
-		v = is_idle ? __raw_readl(tzic_base + TZIC_ENSET0(i)) :
-			*wakeup_intr[i];
-		__raw_writel(v, tzic_base + TZIC_WAKEUP0(i));
-	}
+	for (i = 0; i < 4; i++)
+		__raw_writel(__raw_readl(tzic_base + TZIC_ENSET0(i)),
+			     tzic_base + TZIC_WAKEUP0(i));
 
 	return 0;
 }
-- 
1.7.6
