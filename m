From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  5 Dec 2011 12:15:43 +0800
Subject: [PATCH] ARM: mx5: use generic irq chip pm interface for pm functions
 on
In-Reply-To: <1323058550-13368-1-git-send-email-shawn.guo@linaro.org>
References: <1323058550-13368-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1323058550-13368-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hui Wang <jason77.wang@gmail.com>

Two problems exist in the current i.MX5 pm suspend/resume and idle
functions. The first is the current i.MX5 suspend routine will call
tzic_enable_wake(1) to set wake source, this will set all enabled
irq as wake source rather than those wake capable. The second
is i.MX5 idle will call mx5_cpu_lp_set() to prepare enter low power
mode, but it forgets to call wfi instruction to enter this mode.

To fix these two problems, using generic irq chip pm interface and
modify function imx5_idle().

[Tested by Shawn Guo on imx51 babbage board.
 Tested by Hui Wang on imx51 pdk board.]

Signed-off-by: Hui Wang <jason77.wang@gmail.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Hi Sascha,

This is a repost of patch below.

 http://comments.gmane.org/gmane.linux.ports.arm.kernel/136087

The patch looks pretty good to me, and I'm not sure why you did not
apply it (missed?).  Anyway, I repost it here after rebasing on
v3.2-rc4.

Regards,
Shawn

 arch/arm/mach-mx5/mm.c               |   19 +++++++++++++++-
 arch/arm/mach-mx5/system.c           |    3 --
 arch/arm/plat-mxc/include/mach/mxc.h |    2 +-
 arch/arm/plat-mxc/tzic.c             |   40 ++++++++++++++++++++++++---------
 4 files changed, 48 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
index df4a508f..bc17dfe 100644
--- a/arch/arm/mach-mx5/mm.c
+++ b/arch/arm/mach-mx5/mm.c
@@ -13,6 +13,7 @@
 
 #include <linux/mm.h>
 #include <linux/init.h>
+#include <linux/clk.h>
 
 #include <asm/mach/map.h>
 
@@ -21,10 +22,26 @@
 #include <mach/devices-common.h>
 #include <mach/iomux-v3.h>
 
+static struct clk *gpc_dvfs_clk;
+
 static void imx5_idle(void)
 {
-	if (!need_resched())
+	if (!need_resched()) {
+		/* gpc clock is needed for SRPG */
+		if (gpc_dvfs_clk == NULL) {
+			gpc_dvfs_clk = clk_get(NULL, "gpc_dvfs");
+			if (IS_ERR(gpc_dvfs_clk))
+				goto err0;
+		}
+		clk_enable(gpc_dvfs_clk);
 		mx5_cpu_lp_set(WAIT_UNCLOCKED_POWER_OFF);
+		if (tzic_enable_wake())
+			goto err1;
+		cpu_do_idle();
+err1:
+		clk_disable(gpc_dvfs_clk);
+	}
+err0:
 	local_irq_enable();
 }
 
diff --git a/arch/arm/mach-mx5/system.c b/arch/arm/mach-mx5/system.c
index 144ebeb..5eebfaa 100644
--- a/arch/arm/mach-mx5/system.c
+++ b/arch/arm/mach-mx5/system.c
@@ -55,9 +55,6 @@ void mx5_cpu_lp_set(enum mxc_cpu_pwr_mode mode)
 			stop_mode = 1;
 		}
 		arm_srpgcr |= MXC_SRPGCR_PCR;
-
-		if (tzic_enable_wake(1) != 0)
-			return;
 		break;
 	case STOP_POWER_ON:
 		ccm_clpcr |= 0x2 << MXC_CCM_CLPCR_LPM_OFFSET;
diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/plat-mxc/include/mach/mxc.h
index a4d36d6..d782983 100644
--- a/arch/arm/plat-mxc/include/mach/mxc.h
+++ b/arch/arm/plat-mxc/include/mach/mxc.h
@@ -168,7 +168,7 @@ struct cpu_op {
 	u32 cpu_rate;
 };
 
-int tzic_enable_wake(int is_idle);
+int tzic_enable_wake(void);
 
 extern struct cpu_op *(*get_cpu_op)(int *op);
 #endif
diff --git a/arch/arm/plat-mxc/tzic.c b/arch/arm/plat-mxc/tzic.c
index a3c164c..98308ec 100644
--- a/arch/arm/plat-mxc/tzic.c
+++ b/arch/arm/plat-mxc/tzic.c
@@ -73,7 +73,28 @@ static int tzic_set_irq_fiq(unsigned int irq, unsigned int type)
 #define tzic_set_irq_fiq NULL
 #endif
 
-static unsigned int *wakeup_intr[4];
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
 
 static struct mxc_extra_irq tzic_extra_irq = {
 #ifdef CONFIG_FIQ
@@ -91,12 +112,13 @@ static __init void tzic_init_gc(unsigned int irq_start)
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
 
@@ -167,23 +189,19 @@ void __init tzic_init_irq(void __iomem *irqbase)
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
1.7.4.1
