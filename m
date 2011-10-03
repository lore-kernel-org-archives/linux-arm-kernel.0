From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  3 Oct 2011 10:57:03 +0800
Subject: [PATCH v5 5/8] arm/imx6q: add smp and cpu hotplug support
In-Reply-To: <1317610626-24357-1-git-send-email-shawn.guo@linaro.org>
References: <1317610626-24357-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1317610626-24357-6-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds smp and cpu hotplug support for imx6q.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/Kconfig               |    1 +
 arch/arm/mach-imx/Makefile              |    5 ++
 arch/arm/mach-imx/head-v7.S             |   71 ++++++++++++++++++++++++++
 arch/arm/mach-imx/hotplug.c             |   44 ++++++++++++++++
 arch/arm/mach-imx/localtimer.c          |   35 +++++++++++++
 arch/arm/mach-imx/platsmp.c             |   85 +++++++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/common.h |    5 ++
 7 files changed, 246 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-imx/head-v7.S
 create mode 100644 arch/arm/mach-imx/hotplug.c
 create mode 100644 arch/arm/mach-imx/localtimer.c
 create mode 100644 arch/arm/mach-imx/platsmp.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 5e87372..3852f45 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -610,6 +610,7 @@ config SOC_IMX6Q
 	bool "i.MX6 Quad support"
 	select ARM_GIC
 	select CPU_V7
+	select HAVE_ARM_SCU
 	select HAVE_IMX_GPC
 	select HAVE_IMX_MMDC
 	select HAVE_IMX_SRC
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 65218d9..f109850 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -65,4 +65,9 @@ obj-$(CONFIG_DEBUG_LL) += lluart.o
 obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
 obj-$(CONFIG_HAVE_IMX_MMDC) += mmdc.o
 obj-$(CONFIG_HAVE_IMX_SRC) += src.o
+obj-$(CONFIG_CPU_V7) += head-v7.o
+AFLAGS_head-v7.o :=-Wa,-march=armv7-a
+obj-$(CONFIG_SMP) += platsmp.o
+obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
+obj-$(CONFIG_LOCAL_TIMERS) += localtimer.o
 obj-$(CONFIG_SOC_IMX6Q) += clock-imx6q.o
diff --git a/arch/arm/mach-imx/head-v7.S b/arch/arm/mach-imx/head-v7.S
new file mode 100644
index 0000000..ede908b
--- /dev/null
+++ b/arch/arm/mach-imx/head-v7.S
@@ -0,0 +1,71 @@
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
+#include <linux/linkage.h>
+#include <linux/init.h>
+#include <asm/hardware/cache-l2x0.h>
+
+	.section ".text.head", "ax"
+	__CPUINIT
+
+/*
+ * The secondary kernel init calls v7_flush_dcache_all before it enables
+ * the L1; however, the L1 comes out of reset in an undefined state, so
+ * the clean + invalidate performed by v7_flush_dcache_all causes a bunch
+ * of cache lines with uninitialized data and uninitialized tags to get
+ * written out to memory, which does really unpleasant things to the main
+ * processor.  We fix this by performing an invalidate, rather than a
+ * clean + invalidate, before jumping into the kernel.
+ *
+ * This funciton is cloned from arch/arm/mach-tegra/headsmp.S, and needs
+ * to be called for both secondary cores startup and primary core resume
+ * procedures.  Ideally, it should be moved into arch/arm/mm/cache-v7.S.
+ */
+ENTRY(v7_invalidate_l1)
+	mov	r0, #0
+	mcr	p15, 2, r0, c0, c0, 0
+	mrc	p15, 1, r0, c0, c0, 0
+
+	ldr	r1, =0x7fff
+	and	r2, r1, r0, lsr #13
+
+	ldr	r1, =0x3ff
+
+	and	r3, r1, r0, lsr #3	@ NumWays - 1
+	add	r2, r2, #1		@ NumSets
+
+	and	r0, r0, #0x7
+	add	r0, r0, #4	@ SetShift
+
+	clz	r1, r3		@ WayShift
+	add	r4, r3, #1	@ NumWays
+1:	sub	r2, r2, #1	@ NumSets--
+	mov	r3, r4		@ Temp = NumWays
+2:	subs	r3, r3, #1	@ Temp--
+	mov	r5, r3, lsl r1
+	mov	r6, r2, lsl r0
+	orr	r5, r5, r6	@ Reg = (Temp<<WayShift)|(NumSets<<SetShift)
+	mcr	p15, 0, r5, c7, c6, 2
+	bgt	2b
+	cmp	r2, #0
+	bgt	1b
+	dsb
+	isb
+	mov	pc, lr
+ENDPROC(v7_invalidate_l1)
+
+#ifdef CONFIG_SMP
+ENTRY(v7_secondary_startup)
+	bl	v7_invalidate_l1
+	b	secondary_startup
+ENDPROC(v7_secondary_startup)
+#endif
diff --git a/arch/arm/mach-imx/hotplug.c b/arch/arm/mach-imx/hotplug.c
new file mode 100644
index 0000000..89493ab
--- /dev/null
+++ b/arch/arm/mach-imx/hotplug.c
@@ -0,0 +1,44 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later@the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/errno.h>
+#include <asm/cacheflush.h>
+#include <mach/common.h>
+
+int platform_cpu_kill(unsigned int cpu)
+{
+	return 1;
+}
+
+/*
+ * platform-specific code to shutdown a CPU
+ *
+ * Called with IRQs disabled
+ */
+void platform_cpu_die(unsigned int cpu)
+{
+	flush_cache_all();
+	imx_enable_cpu(cpu, false);
+	cpu_do_idle();
+
+	/* We should never return from idle */
+	panic("cpu %d unexpectedly exit from shutdown\n", cpu);
+}
+
+int platform_cpu_disable(unsigned int cpu)
+{
+	/*
+	 * we don't allow CPU 0 to be shutdown (it is still too special
+	 * e.g. clock tick interrupts)
+	 */
+	return cpu == 0 ? -EPERM : 0;
+}
diff --git a/arch/arm/mach-imx/localtimer.c b/arch/arm/mach-imx/localtimer.c
new file mode 100644
index 0000000..3a16351
--- /dev/null
+++ b/arch/arm/mach-imx/localtimer.c
@@ -0,0 +1,35 @@
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
+#include <linux/clockchips.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <asm/smp_twd.h>
+
+/*
+ * Setup the local clock events for a CPU.
+ */
+int __cpuinit local_timer_setup(struct clock_event_device *evt)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "arm,smp-twd");
+	if (!twd_base) {
+		twd_base = of_iomap(np, 0);
+		WARN_ON(!twd_base);
+	}
+	evt->irq = irq_of_parse_and_map(np, 0);
+	twd_timer_setup(evt);
+
+	return 0;
+}
diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
new file mode 100644
index 0000000..ab98c6f
--- /dev/null
+++ b/arch/arm/mach-imx/platsmp.c
@@ -0,0 +1,85 @@
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
+#include <linux/smp.h>
+#include <asm/page.h>
+#include <asm/smp_scu.h>
+#include <asm/hardware/gic.h>
+#include <asm/mach/map.h>
+#include <mach/common.h>
+#include <mach/hardware.h>
+
+static void __iomem *scu_base;
+
+static struct map_desc scu_io_desc __initdata = {
+	/* .virtual and .pfn are run-time assigned */
+	.length		= SZ_4K,
+	.type		= MT_DEVICE,
+};
+
+void __init imx_scu_map_io(void)
+{
+	unsigned long base;
+
+	/* Get SCU base */
+	asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (base));
+
+	scu_io_desc.virtual = IMX_IO_P2V(base);
+	scu_io_desc.pfn = __phys_to_pfn(base);
+	iotable_init(&scu_io_desc, 1);
+
+	scu_base = IMX_IO_ADDRESS(base);
+}
+
+void __cpuinit platform_secondary_init(unsigned int cpu)
+{
+	/*
+	 * if any interrupts are already enabled for the primary
+	 * core (e.g. timer irq), then they will not have been enabled
+	 * for us: do so
+	 */
+	gic_secondary_init(0);
+}
+
+int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	imx_set_cpu_jump(cpu, v7_secondary_startup);
+	imx_enable_cpu(cpu, true);
+	return 0;
+}
+
+/*
+ * Initialise the CPU possible map early - this describes the CPUs
+ * which may be present or become present in the system.
+ */
+void __init smp_init_cpus(void)
+{
+	int i, ncores;
+
+	ncores = scu_get_core_count(scu_base);
+
+	for (i = 0; i < ncores; i++)
+		set_cpu_possible(i, true);
+
+	set_smp_cross_call(gic_raise_softirq);
+}
+
+void imx_smp_prepare(void)
+{
+	scu_enable(scu_base);
+}
+
+void __init platform_smp_prepare_cpus(unsigned int max_cpus)
+{
+	imx_smp_prepare();
+}
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index c225837..6340df2 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -99,4 +99,9 @@ void gic_handle_irq(struct pt_regs *);
 #define imx53_handle_irq tzic_handle_irq
 #define imx6q_handle_irq gic_handle_irq
 
+extern void imx_enable_cpu(int cpu, bool enable);
+extern void imx_set_cpu_jump(int cpu, void *jump_addr);
+#ifdef CONFIG_SMP
+extern void v7_secondary_startup(void);
+#endif
 #endif
-- 
1.7.4.1
