From: Barry.Song@csr.com (Barry Song)
Date: Tue, 22 Jan 2013 20:22:09 +0800
Subject: [PATCH v3 8/9] ARM: PRIMA2: add new SiRFmarco SMP SoC infrastructures
In-Reply-To: <1358857330-10101-1-git-send-email-Barry.Song@csr.com>
References: <1358857330-10101-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1358857330-10101-4-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

this patch adds tick timer, smp entries and generic DT machine
for SiRFmarco dual-core SMP chips.

with the added marco, we change the defconfig, using the same
defconfig, we get a zImage which can work on both prima2 and
marco.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm/boot/dts/Makefile         |    1 +
 arch/arm/configs/prima2_defconfig  |    3 +
 arch/arm/mach-prima2/Kconfig       |   10 ++
 arch/arm/mach-prima2/Makefile      |    3 +
 arch/arm/mach-prima2/common.c      |   40 +++++-
 arch/arm/mach-prima2/common.h      |   11 ++
 arch/arm/mach-prima2/headsmp.S     |   79 +++++++++
 arch/arm/mach-prima2/hotplug.c     |   41 +++++
 arch/arm/mach-prima2/platsmp.c     |  163 +++++++++++++++++++
 arch/arm/mach-prima2/timer-marco.c |  316 ++++++++++++++++++++++++++++++++++++
 10 files changed, 666 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-prima2/headsmp.S
 create mode 100644 arch/arm/mach-prima2/hotplug.c
 create mode 100644 arch/arm/mach-prima2/platsmp.c
 create mode 100644 arch/arm/mach-prima2/timer-marco.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e44da40..6af9901 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -73,6 +73,7 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-dns320.dtb \
 	kirkwood-ts219-6281.dtb \
 	kirkwood-ts219-6282.dtb \
 	kirkwood-openblocks_a6.dtb
+dtb-$(CONFIG_ARCH_MARCO) += marco-evb.dtb
 dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.dtb \
 	msm8960-cdp.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
diff --git a/arch/arm/configs/prima2_defconfig b/arch/arm/configs/prima2_defconfig
index 6a936c7..002a1ce 100644
--- a/arch/arm/configs/prima2_defconfig
+++ b/arch/arm/configs/prima2_defconfig
@@ -11,6 +11,9 @@ CONFIG_PARTITION_ADVANCED=y
 CONFIG_BSD_DISKLABEL=y
 CONFIG_SOLARIS_X86_PARTITION=y
 CONFIG_ARCH_SIRF=y
+# CONFIG_SWP_EMULATE is not set
+CONFIG_SMP=y
+CONFIG_SCHED_MC=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_KEXEC=y
diff --git a/arch/arm/mach-prima2/Kconfig b/arch/arm/mach-prima2/Kconfig
index 558ccfb..4f7379f 100644
--- a/arch/arm/mach-prima2/Kconfig
+++ b/arch/arm/mach-prima2/Kconfig
@@ -11,6 +11,16 @@ config ARCH_PRIMA2
 	help
           Support for CSR SiRFSoC ARM Cortex A9 Platform
 
+config ARCH_MARCO
+	bool "CSR SiRFSoC MARCO ARM Cortex A9 Platform"
+	default y
+	select ARM_GIC
+	select CPU_V7
+	select HAVE_SMP
+	select SMP_ON_UP
+	help
+          Support for CSR SiRFSoC ARM Cortex A9 Platform
+
 endmenu
 
 config SIRF_IRQ
diff --git a/arch/arm/mach-prima2/Makefile b/arch/arm/mach-prima2/Makefile
index 0007a6e..bfe360c 100644
--- a/arch/arm/mach-prima2/Makefile
+++ b/arch/arm/mach-prima2/Makefile
@@ -5,4 +5,7 @@ obj-$(CONFIG_DEBUG_LL) += lluart.o
 obj-$(CONFIG_CACHE_L2X0) += l2x0.o
 obj-$(CONFIG_SUSPEND) += pm.o sleep.o
 obj-$(CONFIG_SIRF_IRQ) += irq.o
+obj-$(CONFIG_SMP) += platsmp.o headsmp.o
+obj-$(CONFIG_HOTPLUG_CPU)  += hotplug.o
 obj-$(CONFIG_ARCH_PRIMA2) += timer-prima2.o
+obj-$(CONFIG_ARCH_MARCO) += timer-marco.o
diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
index 99f9c7e..00a6564 100644
--- a/arch/arm/mach-prima2/common.c
+++ b/arch/arm/mach-prima2/common.c
@@ -8,9 +8,11 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/of_irq.h>
 #include <asm/sizes.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include <asm/hardware/gic.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include "common.h"
@@ -30,6 +32,12 @@ void __init sirfsoc_init_late(void)
 	sirfsoc_pm_init();
 }
 
+static __init void sirfsoc_map_io(void)
+{
+	sirfsoc_map_lluart();
+	sirfsoc_map_scu();
+}
+
 #ifdef CONFIG_ARCH_PRIMA2
 static const char *prima2_dt_match[] __initdata = {
        "sirf,prima2",
@@ -38,7 +46,7 @@ static const char *prima2_dt_match[] __initdata = {
 
 DT_MACHINE_START(PRIMA2_DT, "Generic PRIMA2 (Flattened Device Tree)")
 	/* Maintainer: Barry Song <baohua.song@csr.com> */
-	.map_io         = sirfsoc_map_lluart,
+	.map_io         = sirfsoc_map_io,
 	.init_irq	= sirfsoc_of_irq_init,
 	.init_time	= sirfsoc_prima2_timer_init,
 #ifdef CONFIG_MULTI_IRQ_HANDLER
@@ -51,3 +59,33 @@ DT_MACHINE_START(PRIMA2_DT, "Generic PRIMA2 (Flattened Device Tree)")
 	.restart	= sirfsoc_restart,
 MACHINE_END
 #endif
+
+#ifdef CONFIG_ARCH_MARCO
+static const struct of_device_id marco_irq_match[] __initconst = {
+	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
+	{ /* sentinel */ }
+};
+
+static void __init marco_init_irq(void)
+{
+	of_irq_init(marco_irq_match);
+}
+
+static const char *marco_dt_match[] __initdata = {
+	"sirf,marco",
+	NULL
+};
+
+DT_MACHINE_START(MARCO_DT, "Generic MARCO (Flattened Device Tree)")
+	/* Maintainer: Barry Song <baohua.song@csr.com> */
+	.smp            = smp_ops(sirfsoc_smp_ops),
+	.map_io         = sirfsoc_map_io,
+	.init_irq	= marco_init_irq,
+	.init_time	= sirfsoc_marco_timer_init,
+	.handle_irq     = gic_handle_irq,
+	.init_machine	= sirfsoc_mach_init,
+	.init_late	= sirfsoc_init_late,
+	.dt_compat      = marco_dt_match,
+	.restart	= sirfsoc_restart,
+MACHINE_END
+#endif
diff --git a/arch/arm/mach-prima2/common.h b/arch/arm/mach-prima2/common.h
index a4f91a6..b7c26b6 100644
--- a/arch/arm/mach-prima2/common.h
+++ b/arch/arm/mach-prima2/common.h
@@ -14,6 +14,11 @@
 #include <asm/exception.h>
 
 extern void sirfsoc_prima2_timer_init(void);
+extern void sirfsoc_marco_timer_init(void);
+
+extern struct smp_operations   sirfsoc_smp_ops;
+extern void sirfsoc_secondary_startup(void);
+extern void sirfsoc_cpu_die(unsigned int cpu);
 
 extern void __init sirfsoc_of_irq_init(void);
 extern void __init sirfsoc_of_clk_init(void);
@@ -26,6 +31,12 @@ static inline void sirfsoc_map_lluart(void)  {}
 extern void __init sirfsoc_map_lluart(void);
 #endif
 
+#ifndef CONFIG_SMP
+static inline void sirfsoc_map_scu(void) {}
+#else
+extern void sirfsoc_map_scu(void);
+#endif
+
 #ifdef CONFIG_SUSPEND
 extern int sirfsoc_pm_init(void);
 #else
diff --git a/arch/arm/mach-prima2/headsmp.S b/arch/arm/mach-prima2/headsmp.S
new file mode 100644
index 0000000..6ec19d5
--- /dev/null
+++ b/arch/arm/mach-prima2/headsmp.S
@@ -0,0 +1,79 @@
+/*
+ * Entry of the second core for CSR Marco dual-core SMP SoCs
+ *
+ * Copyright (c) 2012 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/linkage.h>
+#include <linux/init.h>
+
+	__INIT
+/*
+ * Cold boot and hardware reset show different behaviour,
+ * system will be always panic if we warm-reset the board
+ * Here we invalidate L1 of CPU1 to make sure there isn't
+ * uninitialized data written into memory later
+ */
+ENTRY(v7_invalidate_l1)
+	mov	r0, #0
+	mcr	p15, 0, r0, c7, c5, 0	@ invalidate I cache
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
+/*
+ * SIRFSOC specific entry point for secondary CPUs.  This provides
+ * a "holding pen" into which all secondary cores are held until we're
+ * ready for them to initialise.
+ */
+ENTRY(sirfsoc_secondary_startup)
+	bl v7_invalidate_l1
+        mrc     p15, 0, r0, c0, c0, 5
+        and     r0, r0, #15
+        adr     r4, 1f
+        ldmia   r4, {r5, r6}
+        sub     r4, r4, r5
+        add     r6, r6, r4
+pen:    ldr     r7, [r6]
+        cmp     r7, r0
+        bne     pen
+
+        /*
+         * we've been released from the holding pen: secondary_stack
+         * should now contain the SVC stack for this core
+         */
+        b       secondary_startup
+ENDPROC(sirfsoc_secondary_startup)
+
+        .align
+1:      .long   .
+        .long   pen_release
diff --git a/arch/arm/mach-prima2/hotplug.c b/arch/arm/mach-prima2/hotplug.c
new file mode 100644
index 0000000..97c1ee5
--- /dev/null
+++ b/arch/arm/mach-prima2/hotplug.c
@@ -0,0 +1,41 @@
+/*
+ * CPU hotplug support for CSR Marco dual-core SMP SoCs
+ *
+ * Copyright (c) 2012 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/smp.h>
+
+#include <asm/cacheflush.h>
+#include <asm/smp_plat.h>
+
+static inline void platform_do_lowpower(unsigned int cpu)
+{
+	flush_cache_all();
+
+	/* we put the platform to just WFI */
+	for (;;) {
+		__asm__ __volatile__("dsb\n\t" "wfi\n\t"
+			: : : "memory");
+		if (pen_release == cpu_logical_map(cpu)) {
+			/*
+			 * OK, proper wakeup, we're done
+			 */
+			break;
+		}
+	}
+}
+
+/*
+ * platform-specific code to shutdown a CPU
+ *
+ * Called with IRQs disabled
+ */
+void sirfsoc_cpu_die(unsigned int cpu)
+{
+	platform_do_lowpower(cpu);
+}
diff --git a/arch/arm/mach-prima2/platsmp.c b/arch/arm/mach-prima2/platsmp.c
new file mode 100644
index 0000000..2395022
--- /dev/null
+++ b/arch/arm/mach-prima2/platsmp.c
@@ -0,0 +1,163 @@
+/*
+ * plat smp support for CSR Marco dual-core SMP SoCs
+ *
+ * Copyright (c) 2012 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <asm/page.h>
+#include <asm/mach/map.h>
+#include <asm/smp_plat.h>
+#include <asm/smp_scu.h>
+#include <asm/cacheflush.h>
+#include <asm/cputype.h>
+#include <asm/hardware/gic.h>
+#include <mach/map.h>
+
+#include "common.h"
+
+static void __iomem *scu_base;
+static void __iomem *rsc_base;
+
+static DEFINE_SPINLOCK(boot_lock);
+
+static struct map_desc scu_io_desc __initdata = {
+	.length		= SZ_4K,
+	.type		= MT_DEVICE,
+};
+
+void __init sirfsoc_map_scu(void)
+{
+	unsigned long base;
+
+	/* Get SCU base */
+	asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (base));
+
+	scu_io_desc.virtual = SIRFSOC_VA(base);
+	scu_io_desc.pfn = __phys_to_pfn(base);
+	iotable_init(&scu_io_desc, 1);
+
+	scu_base = (void __iomem *)SIRFSOC_VA(base);
+}
+
+static void __cpuinit sirfsoc_secondary_init(unsigned int cpu)
+{
+	/*
+	 * if any interrupts are already enabled for the primary
+	 * core (e.g. timer irq), then they will not have been enabled
+	 * for us: do so
+	 */
+	gic_secondary_init(0);
+
+	/*
+	 * let the primary processor know we're out of the
+	 * pen, then head off into the C entry point
+	 */
+	pen_release = -1;
+	smp_wmb();
+
+	/*
+	 * Synchronise with the boot thread.
+	 */
+	spin_lock(&boot_lock);
+	spin_unlock(&boot_lock);
+}
+
+static struct of_device_id rsc_ids[]  = {
+	{ .compatible = "sirf,marco-rsc" },
+	{},
+};
+
+static int __cpuinit sirfsoc_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	unsigned long timeout;
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, rsc_ids);
+	if (!np)
+		return -ENODEV;
+
+	rsc_base = of_iomap(np, 0);
+	if (!rsc_base)
+		return -ENOMEM;
+
+	/*
+	 * write the address of secondary startup into the sram register
+	 * at offset 0x2C, then write the magic number 0x3CAF5D62 to the
+	 * RSC register at offset 0x28, which is what boot rom code is
+	 * waiting for. This would wake up the secondary core from WFE
+	 */
+#define SIRFSOC_CPU1_JUMPADDR_OFFSET 0x2C
+	__raw_writel(virt_to_phys(sirfsoc_secondary_startup),
+		rsc_base + SIRFSOC_CPU1_JUMPADDR_OFFSET);
+
+#define SIRFSOC_CPU1_WAKEMAGIC_OFFSET 0x28
+	__raw_writel(0x3CAF5D62,
+		rsc_base + SIRFSOC_CPU1_WAKEMAGIC_OFFSET);
+
+	/* make sure write buffer is drained */
+	mb();
+
+	spin_lock(&boot_lock);
+
+	/*
+	 * The secondary processor is waiting to be released from
+	 * the holding pen - release it, then wait for it to flag
+	 * that it has been released by resetting pen_release.
+	 *
+	 * Note that "pen_release" is the hardware CPU ID, whereas
+	 * "cpu" is Linux's internal ID.
+	 */
+	pen_release = cpu_logical_map(cpu);
+	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
+	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
+
+	/*
+	 * Send the secondary CPU SEV, thereby causing the boot monitor to read
+	 * the JUMPADDR and WAKEMAGIC, and branch to the address found there.
+	 */
+	dsb_sev();
+
+	timeout = jiffies + (1 * HZ);
+	while (time_before(jiffies, timeout)) {
+		smp_rmb();
+		if (pen_release == -1)
+			break;
+
+		udelay(10);
+	}
+
+	/*
+	 * now the secondary core is starting up let it run its
+	 * calibrations, then wait for it to finish
+	 */
+	spin_unlock(&boot_lock);
+
+	return pen_release != -1 ? -ENOSYS : 0;
+}
+
+static void __init sirfsoc_smp_init_cpus(void)
+{
+	set_smp_cross_call(gic_raise_softirq);
+}
+
+static void __init sirfsoc_smp_prepare_cpus(unsigned int max_cpus)
+{
+	scu_enable(scu_base);
+}
+
+struct smp_operations sirfsoc_smp_ops __initdata = {
+        .smp_init_cpus          = sirfsoc_smp_init_cpus,
+        .smp_prepare_cpus       = sirfsoc_smp_prepare_cpus,
+        .smp_secondary_init     = sirfsoc_secondary_init,
+        .smp_boot_secondary     = sirfsoc_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die                = sirfsoc_cpu_die,
+#endif
+};
diff --git a/arch/arm/mach-prima2/timer-marco.c b/arch/arm/mach-prima2/timer-marco.c
new file mode 100644
index 0000000..f4eea2e
--- /dev/null
+++ b/arch/arm/mach-prima2/timer-marco.c
@@ -0,0 +1,316 @@
+/*
+ * System timer for CSR SiRFprimaII
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/bitops.h>
+#include <linux/irq.h>
+#include <linux/clk.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <asm/sched_clock.h>
+#include <asm/localtimer.h>
+#include <asm/mach/time.h>
+
+#include "common.h"
+
+#define SIRFSOC_TIMER_32COUNTER_0_CTRL			0x0000
+#define SIRFSOC_TIMER_32COUNTER_1_CTRL			0x0004
+#define SIRFSOC_TIMER_MATCH_0				0x0018
+#define SIRFSOC_TIMER_MATCH_1				0x001c
+#define SIRFSOC_TIMER_COUNTER_0				0x0048
+#define SIRFSOC_TIMER_COUNTER_1				0x004c
+#define SIRFSOC_TIMER_INTR_STATUS			0x0060
+#define SIRFSOC_TIMER_WATCHDOG_EN			0x0064
+#define SIRFSOC_TIMER_64COUNTER_CTRL			0x0068
+#define SIRFSOC_TIMER_64COUNTER_LO			0x006c
+#define SIRFSOC_TIMER_64COUNTER_HI			0x0070
+#define SIRFSOC_TIMER_64COUNTER_LOAD_LO			0x0074
+#define SIRFSOC_TIMER_64COUNTER_LOAD_HI			0x0078
+#define SIRFSOC_TIMER_64COUNTER_RLATCHED_LO		0x007c
+#define SIRFSOC_TIMER_64COUNTER_RLATCHED_HI		0x0080
+
+#define SIRFSOC_TIMER_REG_CNT 6
+
+static const u32 sirfsoc_timer_reg_list[SIRFSOC_TIMER_REG_CNT] = {
+	SIRFSOC_TIMER_WATCHDOG_EN,
+	SIRFSOC_TIMER_32COUNTER_0_CTRL,
+	SIRFSOC_TIMER_32COUNTER_1_CTRL,
+	SIRFSOC_TIMER_64COUNTER_CTRL,
+	SIRFSOC_TIMER_64COUNTER_RLATCHED_LO,
+	SIRFSOC_TIMER_64COUNTER_RLATCHED_HI,
+};
+
+static u32 sirfsoc_timer_reg_val[SIRFSOC_TIMER_REG_CNT];
+
+static void __iomem *sirfsoc_timer_base;
+static void __init sirfsoc_of_timer_map(void);
+
+/* disable count and interrupt */
+static inline void sirfsoc_timer_count_disable(int idx)
+{
+	writel_relaxed(readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_32COUNTER_0_CTRL + 4 * idx) & ~0x7,
+		sirfsoc_timer_base + SIRFSOC_TIMER_32COUNTER_0_CTRL + 4 * idx);
+}
+
+/* enable count and interrupt */
+static inline void sirfsoc_timer_count_enable(int idx)
+{
+	writel_relaxed(readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_32COUNTER_0_CTRL + 4 * idx) | 0x7,
+		sirfsoc_timer_base + SIRFSOC_TIMER_32COUNTER_0_CTRL + 4 * idx);
+}
+
+/* timer interrupt handler */
+static irqreturn_t sirfsoc_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *ce = dev_id;
+	int cpu = smp_processor_id();
+
+	/* clear timer interrupt */
+	writel_relaxed(BIT(cpu), sirfsoc_timer_base + SIRFSOC_TIMER_INTR_STATUS);
+
+	if (ce->mode == CLOCK_EVT_MODE_ONESHOT)
+		sirfsoc_timer_count_disable(cpu);
+
+	ce->event_handler(ce);
+
+	return IRQ_HANDLED;
+}
+
+/* read 64-bit timer counter */
+static cycle_t sirfsoc_timer_read(struct clocksource *cs)
+{
+	u64 cycles;
+
+	writel_relaxed((readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_CTRL) |
+			BIT(0)) & ~BIT(1), sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_CTRL);
+
+	cycles = readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_RLATCHED_HI);
+	cycles = (cycles << 32) | readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_RLATCHED_LO);
+
+	return cycles;
+}
+
+static int sirfsoc_timer_set_next_event(unsigned long delta,
+	struct clock_event_device *ce)
+{
+	int cpu = smp_processor_id();
+
+	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_0 +
+		4 * cpu);
+	writel_relaxed(delta, sirfsoc_timer_base + SIRFSOC_TIMER_MATCH_0 +
+		4 * cpu);
+
+	/* enable the tick */
+	sirfsoc_timer_count_enable(cpu);
+
+	return 0;
+}
+
+static void sirfsoc_timer_set_mode(enum clock_event_mode mode,
+	struct clock_event_device *ce)
+{
+	switch (mode) {
+	case CLOCK_EVT_MODE_ONESHOT:
+		/* enable in set_next_event */
+		break;
+	default:
+		break;
+	}
+
+	sirfsoc_timer_count_disable(smp_processor_id());
+}
+
+static void sirfsoc_clocksource_suspend(struct clocksource *cs)
+{
+	int i;
+
+	for (i = 0; i < SIRFSOC_TIMER_REG_CNT; i++)
+		sirfsoc_timer_reg_val[i] = readl_relaxed(sirfsoc_timer_base + sirfsoc_timer_reg_list[i]);
+}
+
+static void sirfsoc_clocksource_resume(struct clocksource *cs)
+{
+	int i;
+
+	for (i = 0; i < SIRFSOC_TIMER_REG_CNT - 2; i++)
+		writel_relaxed(sirfsoc_timer_reg_val[i], sirfsoc_timer_base + sirfsoc_timer_reg_list[i]);
+
+	writel_relaxed(sirfsoc_timer_reg_val[SIRFSOC_TIMER_REG_CNT - 2],
+		sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_LOAD_LO);
+	writel_relaxed(sirfsoc_timer_reg_val[SIRFSOC_TIMER_REG_CNT - 1],
+		sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_LOAD_HI);
+
+	writel_relaxed(readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_CTRL) |
+		BIT(1) | BIT(0), sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_CTRL);
+}
+
+static struct clock_event_device sirfsoc_clockevent = {
+	.name = "sirfsoc_clockevent",
+	.rating = 200,
+	.features = CLOCK_EVT_FEAT_ONESHOT,
+	.set_mode = sirfsoc_timer_set_mode,
+	.set_next_event = sirfsoc_timer_set_next_event,
+};
+
+static struct clocksource sirfsoc_clocksource = {
+	.name = "sirfsoc_clocksource",
+	.rating = 200,
+	.mask = CLOCKSOURCE_MASK(64),
+	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
+	.read = sirfsoc_timer_read,
+	.suspend = sirfsoc_clocksource_suspend,
+	.resume = sirfsoc_clocksource_resume,
+};
+
+static struct irqaction sirfsoc_timer_irq = {
+	.name = "sirfsoc_timer0",
+	.flags = IRQF_TIMER | IRQF_NOBALANCING,
+	.handler = sirfsoc_timer_interrupt,
+	.dev_id = &sirfsoc_clockevent,
+};
+
+#ifdef CONFIG_LOCAL_TIMERS
+
+static struct irqaction sirfsoc_timer1_irq = {
+	.name = "sirfsoc_timer1",
+	.flags = IRQF_TIMER | IRQF_NOBALANCING,
+	.handler = sirfsoc_timer_interrupt,
+};
+
+static int __cpuinit sirfsoc_local_timer_setup(struct clock_event_device *ce)
+{
+	/* Use existing clock_event for cpu 0 */
+	if (!smp_processor_id())
+		return 0;
+
+	ce->irq = sirfsoc_timer1_irq.irq;
+	ce->name = "local_timer";
+	ce->features = sirfsoc_clockevent.features;
+	ce->rating = sirfsoc_clockevent.rating;
+	ce->set_mode = sirfsoc_timer_set_mode;
+	ce->set_next_event = sirfsoc_timer_set_next_event;
+	ce->shift = sirfsoc_clockevent.shift;
+	ce->mult = sirfsoc_clockevent.mult;
+	ce->max_delta_ns = sirfsoc_clockevent.max_delta_ns;
+	ce->min_delta_ns = sirfsoc_clockevent.min_delta_ns;
+
+	sirfsoc_timer1_irq.dev_id = ce;
+	BUG_ON(setup_irq(ce->irq, &sirfsoc_timer1_irq));
+	irq_set_affinity(sirfsoc_timer1_irq.irq, cpumask_of(1));
+
+	clockevents_register_device(ce);
+	return 0;
+}
+
+static void sirfsoc_local_timer_stop(struct clock_event_device *ce)
+{
+	sirfsoc_timer_count_disable(1);
+
+	remove_irq(sirfsoc_timer1_irq.irq, &sirfsoc_timer1_irq);
+}
+
+static struct local_timer_ops sirfsoc_local_timer_ops __cpuinitdata = {
+	.setup	= sirfsoc_local_timer_setup,
+	.stop	= sirfsoc_local_timer_stop,
+};
+#endif /* CONFIG_LOCAL_TIMERS */
+
+static void __init sirfsoc_clockevent_init(void)
+{
+	clockevents_calc_mult_shift(&sirfsoc_clockevent, CLOCK_TICK_RATE, 60);
+
+	sirfsoc_clockevent.max_delta_ns =
+		clockevent_delta2ns(-2, &sirfsoc_clockevent);
+	sirfsoc_clockevent.min_delta_ns =
+		clockevent_delta2ns(2, &sirfsoc_clockevent);
+
+	sirfsoc_clockevent.cpumask = cpumask_of(0);
+	clockevents_register_device(&sirfsoc_clockevent);
+#ifdef CONFIG_LOCAL_TIMERS
+	local_timer_register(&sirfsoc_local_timer_ops);
+#endif
+}
+
+/* initialize the kernel jiffy timer source */
+void __init sirfsoc_marco_timer_init(void)
+{
+	unsigned long rate;
+	u32 timer_div;
+	struct clk *clk;
+
+	/* initialize clocking early, we want to set the OS timer */
+	sirfsoc_of_clk_init();
+
+	/* timer's input clock is io clock */
+	clk = clk_get_sys("io", NULL);
+
+	BUG_ON(IS_ERR(clk));
+	rate = clk_get_rate(clk);
+
+	BUG_ON(rate < CLOCK_TICK_RATE);
+	BUG_ON(rate % CLOCK_TICK_RATE);
+
+	sirfsoc_of_timer_map();
+
+	/* Initialize the timer dividers */
+	timer_div = rate / CLOCK_TICK_RATE - 1;
+	writel_relaxed(timer_div << 16, sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_CTRL);
+	writel_relaxed(timer_div << 16, sirfsoc_timer_base + SIRFSOC_TIMER_32COUNTER_0_CTRL);
+	writel_relaxed(timer_div << 16, sirfsoc_timer_base + SIRFSOC_TIMER_32COUNTER_1_CTRL);
+
+	/* Initialize timer counters to 0 */
+	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_LOAD_LO);
+	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_LOAD_HI);
+	writel_relaxed(readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_CTRL) |
+		BIT(1) | BIT(0), sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_CTRL);
+	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_0);
+	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_1);
+
+	/* Clear all interrupts */
+	writel_relaxed(0xFFFF, sirfsoc_timer_base + SIRFSOC_TIMER_INTR_STATUS);
+
+	BUG_ON(clocksource_register_hz(&sirfsoc_clocksource, CLOCK_TICK_RATE));
+
+	BUG_ON(setup_irq(sirfsoc_timer_irq.irq, &sirfsoc_timer_irq));
+
+	sirfsoc_clockevent_init();
+}
+
+static struct of_device_id timer_ids[] = {
+	{ .compatible = "sirf,marco-tick" },
+	{},
+};
+
+static void __init sirfsoc_of_timer_map(void)
+{
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, timer_ids);
+	if (!np)
+		return;
+	sirfsoc_timer_base = of_iomap(np, 0);
+	if (!sirfsoc_timer_base)
+		panic("unable to map timer cpu registers\n");
+
+	sirfsoc_timer_irq.irq = irq_of_parse_and_map(np, 0);
+	if (!sirfsoc_timer_irq.irq)
+		panic("No irq passed for timer0 via DT\n");
+
+#ifdef CONFIG_LOCAL_TIMERS
+	sirfsoc_timer1_irq.irq = irq_of_parse_and_map(np, 1);
+	if (!sirfsoc_timer1_irq.irq)
+		panic("No irq passed for timer1 via DT\n");
+#endif
+
+	of_node_put(np);
+}
-- 
1.7.5.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog@www.csr.com/blog
