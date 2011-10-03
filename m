From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  3 Oct 2011 10:57:05 +0800
Subject: [PATCH v5 7/8] arm/imx6q: add suspend/resume support
In-Reply-To: <1317610626-24357-1-git-send-email-shawn.guo@linaro.org>
References: <1317610626-24357-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1317610626-24357-8-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds suspend/resume support for imx6q.

Signed-off-by: Anson Huang <b20788@freescale.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/Makefile              |    2 +-
 arch/arm/mach-imx/head-v7.S             |   28 ++++++++++++
 arch/arm/mach-imx/pm-imx6q.c            |   70 +++++++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/common.h |    9 ++++
 4 files changed, 108 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-imx/pm-imx6q.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 994ae82..aba7321 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -70,4 +70,4 @@ AFLAGS_head-v7.o :=-Wa,-march=armv7-a
 obj-$(CONFIG_SMP) += platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
 obj-$(CONFIG_LOCAL_TIMERS) += localtimer.o
-obj-$(CONFIG_SOC_IMX6Q) += clock-imx6q.o mach-imx6q.o
+obj-$(CONFIG_SOC_IMX6Q) += clock-imx6q.o mach-imx6q.o pm-imx6q.o
diff --git a/arch/arm/mach-imx/head-v7.S b/arch/arm/mach-imx/head-v7.S
index ede908b..6229efb 100644
--- a/arch/arm/mach-imx/head-v7.S
+++ b/arch/arm/mach-imx/head-v7.S
@@ -12,6 +12,7 @@
 
 #include <linux/linkage.h>
 #include <linux/init.h>
+#include <asm/asm-offsets.h>
 #include <asm/hardware/cache-l2x0.h>
 
 	.section ".text.head", "ax"
@@ -69,3 +70,30 @@ ENTRY(v7_secondary_startup)
 	b	secondary_startup
 ENDPROC(v7_secondary_startup)
 #endif
+
+/*
+ * The following code is located into the .data section.  This is to
+ * allow phys_l2x0_saved_regs to be accessed with a relative load
+ * as we are running on physical address here.
+ */
+	.data
+	.align
+
+	.macro	pl310_resume
+	ldr	r2, phys_l2x0_saved_regs
+	ldr	r0, [r2, #L2X0_R_PHY_BASE]	@ get physical base of l2x0
+	ldr	r1, [r2, #L2X0_R_AUX_CTRL]	@ get aux_ctrl value
+	str	r1, [r0, #L2X0_AUX_CTRL]	@ restore aux_ctrl
+	mov	r1, #0x1
+	str	r1, [r0, #L2X0_CTRL]		@ re-enable L2
+	.endm
+
+ENTRY(v7_cpu_resume)
+	bl	v7_invalidate_l1
+	pl310_resume
+	b	cpu_resume
+ENDPROC(v7_cpu_resume)
+
+	.globl	phys_l2x0_saved_regs
+phys_l2x0_saved_regs:
+        .long   0
diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6q.c
new file mode 100644
index 0000000..f20f191
--- /dev/null
+++ b/arch/arm/mach-imx/pm-imx6q.c
@@ -0,0 +1,70 @@
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
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/suspend.h>
+#include <asm/cacheflush.h>
+#include <asm/proc-fns.h>
+#include <asm/suspend.h>
+#include <asm/hardware/cache-l2x0.h>
+#include <mach/common.h>
+#include <mach/hardware.h>
+
+extern unsigned long phys_l2x0_saved_regs;
+
+static int imx6q_suspend_finish(unsigned long val)
+{
+	cpu_do_idle();
+	return 0;
+}
+
+static int imx6q_pm_enter(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_MEM:
+		imx6q_set_lpm(STOP_POWER_OFF);
+		imx_gpc_pre_suspend();
+		imx_set_cpu_jump(0, v7_cpu_resume);
+		/* Zzz ... */
+		cpu_suspend(0, imx6q_suspend_finish);
+		imx_smp_prepare();
+		imx_gpc_post_resume();
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct platform_suspend_ops imx6q_pm_ops = {
+	.enter = imx6q_pm_enter,
+	.valid = suspend_valid_only_mem,
+};
+
+void __init imx6q_pm_init(void)
+{
+	/*
+	 * The l2x0 core code provides an infrastucture to save and restore
+	 * l2x0 registers across suspend/resume cycle.  But because imx6q
+	 * retains L2 content during suspend and needs to resume L2 before
+	 * MMU is enabled, it can only utilize register saving support and
+	 * have to take care of restoring on its own.  So we save physical
+	 * address of the data structure used by l2x0 core to save registers,
+	 * and later restore the necessary ones in imx6q resume entry.
+	 */
+	phys_l2x0_saved_regs = __pa(&l2x0_saved_regs);
+
+	suspend_set_ops(&imx6q_pm_ops);
+}
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 607b462..6a7d993 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -13,6 +13,7 @@
 
 struct platform_device;
 struct clk;
+enum mxc_cpu_pwr_mode;
 
 extern void mx1_map_io(void);
 extern void mx21_map_io(void);
@@ -107,14 +108,22 @@ extern void imx_lluart_map_io(void);
 #else
 static inline void imx_lluart_map_io(void) {}
 #endif
+extern void v7_cpu_resume(void);
+extern u32 *pl310_get_save_ptr(void);
 #ifdef CONFIG_SMP
 extern void v7_secondary_startup(void);
 extern void imx_scu_map_io(void);
+extern void imx_smp_prepare(void);
 #else
 static inline void imx_scu_map_io(void) {}
+static inline void imx_smp_prepare(void) {}
 #endif
 extern void imx_enable_cpu(int cpu, bool enable);
 extern void imx_set_cpu_jump(int cpu, void *jump_addr);
 extern void imx_src_init(void);
 extern void imx_gpc_init(void);
+extern void imx_gpc_pre_suspend(void);
+extern void imx_gpc_post_resume(void);
+extern int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode);
+extern void imx6q_pm_init(void);
 #endif
-- 
1.7.4.1
