From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 26 Sep 2011 15:20:51 +0800
Subject: [PATCH v3 6/6] arm/imx6q: add suspend/resume support
In-Reply-To: <1317021651-17359-1-git-send-email-shawn.guo@linaro.org>
References: <1317021651-17359-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1317021651-17359-7-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds suspend/resume support for imx6q.

Signed-off-by: Anson Huang <b20788@freescale.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/Makefile              |    2 +-
 arch/arm/mach-imx/head-v7.S             |   32 +++++++++++
 arch/arm/mach-imx/pm-imx6q.c            |   90 +++++++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/common.h |    9 +++
 4 files changed, 132 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-imx/pm-imx6q.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 16737ba..c787151 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -70,4 +70,4 @@ obj-$(CONFIG_CPU_V7) += head-v7.o
 obj-$(CONFIG_SMP) += platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
 obj-$(CONFIG_LOCAL_TIMERS) += localtimer.o
-obj-$(CONFIG_SOC_IMX6Q) += clock-imx6q.o mach-imx6q.o
+obj-$(CONFIG_SOC_IMX6Q) += clock-imx6q.o mach-imx6q.o pm-imx6q.o
diff --git a/arch/arm/mach-imx/head-v7.S b/arch/arm/mach-imx/head-v7.S
index ede908b..1f6316c 100644
--- a/arch/arm/mach-imx/head-v7.S
+++ b/arch/arm/mach-imx/head-v7.S
@@ -69,3 +69,35 @@ ENTRY(v7_secondary_startup)
 	b	secondary_startup
 ENDPROC(v7_secondary_startup)
 #endif
+
+ENTRY(pl310_get_save_ptr)
+	ldr	r0, =pl310_pbase
+	mov	pc, lr
+ENDPROC(pl310_get_save_ptr)
+
+/*
+ * The following code is located into the .data section.  This is to
+ * allow pl310_pbase and pl310_aux_ctrl to be accessed with a relative
+ * load as we are running on physical address here.
+ */
+	.data
+	.align
+
+	.macro	pl310_resume
+	adr	r2, pl310_pbase
+	ldmia	r2, {r0, r1}
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
+pl310_pbase:
+	.long	0
+pl310_aux_ctrl:
+	.long	0
diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6q.c
new file mode 100644
index 0000000..db41343
--- /dev/null
+++ b/arch/arm/mach-imx/pm-imx6q.c
@@ -0,0 +1,90 @@
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
+	struct device_node *np;
+	u32 reg[2], *ptr;
+	void __iomem *base;
+
+	np = of_find_compatible_node(NULL, NULL, "arm,pl310-cache");
+	of_property_read_u32_array(np, "reg", reg, ARRAY_SIZE(reg));
+	base = ioremap(reg[0], reg[1]);
+	WARN_ON(!base);
+
+	/*
+	 * On imx6q, during system suspend, ARM core gets powered off,
+	 * but L2 cache is retained.  To avoid cleaning the entire L2,
+	 * we need to save L2 controller registers, and when system gets
+	 * woke up, restore the registers and re-enable L2 before
+	 * calling into cpu_resume().
+	 *
+	 * Most of pl310 configuration upon reset work just fine for
+	 * imx6q, and the only one register we actually need to save is
+	 * AUX_CTRL.  Also since pl310 configuration won't change in a
+	 * live system, we can save it here only once, and restore it
+	 * every time system resumes back from v7_cpu_resume().
+	 */
+	ptr = pl310_get_save_ptr();
+	/* save pl310 physical base address */
+	*ptr = reg[0];
+	/* save pl310 aux_ctrl register */
+	*(ptr + 1) = readl_relaxed(base + L2X0_AUX_CTRL);
+	/* ensure they are written into external memory */
+	__cpuc_flush_dcache_area((void *) ptr, sizeof(*ptr) * 2);
+	outer_clean_range(__pa(ptr), __pa(ptr + 2));
+
+	iounmap(base);
+
+	suspend_set_ops(&imx6q_pm_ops);
+}
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 2c2eafa..96ba321 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -13,6 +13,7 @@
 
 struct platform_device;
 struct clk;
+enum mxc_cpu_pwr_mode;
 
 extern void mx1_map_io(void);
 extern void mx21_map_io(void);
@@ -96,14 +97,22 @@ extern void imx_lluart_map_io(void);
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
