From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue,  6 Jun 2017 02:54:18 +0200
Subject: [PATCH v4 20/28] ARM: owl: Implement CPU enable-method for S500
In-Reply-To: <20170606005426.26446-1-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
Message-ID: <20170606005426.26446-21-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow to bring up CPU1.

Based on LeMaker linux-actions tree.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v3 -> v4: Unchanged
 
 v3: new
 
 arch/arm/mach-actions/Makefile  |   3 +
 arch/arm/mach-actions/headsmp.S |  68 ++++++++++++++++
 arch/arm/mach-actions/platsmp.c | 166 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 237 insertions(+)
 create mode 100644 arch/arm/mach-actions/headsmp.S
 create mode 100644 arch/arm/mach-actions/platsmp.c

diff --git a/arch/arm/mach-actions/Makefile b/arch/arm/mach-actions/Makefile
index 524c3817bcb3..217e95d04b43 100644
--- a/arch/arm/mach-actions/Makefile
+++ b/arch/arm/mach-actions/Makefile
@@ -1 +1,4 @@
 obj-$(CONFIG_ARCH_ACTIONS) += owl.o
+obj-${CONFIG_ARCH_ACTIONS} += platsmp.o headsmp.o
+
+AFLAGS_headsmp.o := -Wa,-march=armv7-a
diff --git a/arch/arm/mach-actions/headsmp.S b/arch/arm/mach-actions/headsmp.S
new file mode 100644
index 000000000000..dc4832fc101a
--- /dev/null
+++ b/arch/arm/mach-actions/headsmp.S
@@ -0,0 +1,68 @@
+/*
+ * Copyright 2012 Actions Semi Inc.
+ * Author: Actions Semi, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/linkage.h>
+#include <linux/init.h>
+
+ENTRY(owl_v7_invalidate_l1)
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
+ENDPROC(owl_v7_invalidate_l1)
+
+ENTRY(owl_secondary_startup)
+	mrc	p15, 0, r0, c0, c0, 5
+	and	r0, r0, #0xf
+	adr	r4, 1f
+	ldmia	r4, {r5, r6}
+	sub	r4, r4, r5
+	add	r6, r6, r4
+pen:
+	ldr	r7, [r6]
+	cmp	r7, r0
+	bne	pen
+
+	/*
+	 * we've been released from the holding pen: secondary_stack
+	 * should now contain the SVC stack for this core
+	 */
+	bl	owl_v7_invalidate_l1
+	b	secondary_startup
+
+1:	.long	.
+	.long	pen_release
diff --git a/arch/arm/mach-actions/platsmp.c b/arch/arm/mach-actions/platsmp.c
new file mode 100644
index 000000000000..9d3601ebe535
--- /dev/null
+++ b/arch/arm/mach-actions/platsmp.c
@@ -0,0 +1,166 @@
+/*
+ * Actions Semi Leopard
+ *
+ * This file is based on arm realview smp platform.
+ *
+ * Copyright 2012 Actions Semi Inc.
+ * Author: Actions Semi, Inc.
+ *
+ * Copyright (c) 2017 Andreas F?rber
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/smp.h>
+#include <asm/cacheflush.h>
+#include <asm/smp_plat.h>
+#include <asm/smp_scu.h>
+
+#define OWL_CPU1_ADDR	0x50
+#define OWL_CPU1_FLAG	0x5c
+
+#define OWL_CPUx_FLAG_BOOT	0x55aa
+
+static void __iomem *scu_base_addr;
+static void __iomem *timer_base_addr;
+static int ncores;
+
+static DEFINE_SPINLOCK(boot_lock);
+
+static void write_pen_release(int val)
+{
+	pen_release = val;
+	smp_wmb();
+	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
+	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
+}
+
+static void s500_smp_secondary_init(unsigned int cpu)
+{
+	/*
+	 * let the primary processor know we're out of the
+	 * pen, then head off into the C entry point
+	 */
+	write_pen_release(-1);
+
+	spin_lock(&boot_lock);
+	spin_unlock(&boot_lock);
+}
+
+void owl_secondary_startup(void);
+
+static int s500_wakeup_secondary(unsigned int cpu)
+{
+	if (cpu > 3)
+		return -EINVAL;
+
+	switch (cpu) {
+	case 2:
+	case 3:
+		/* CPU2/3 are power-gated */
+		return -EINVAL;
+	}
+
+	/* wait for CPUx to run to WFE instruction */
+	udelay(200);
+
+	writel(virt_to_phys(owl_secondary_startup),
+	       timer_base_addr + OWL_CPU1_ADDR + (cpu - 1) * 4);
+	writel(OWL_CPUx_FLAG_BOOT,
+	       timer_base_addr + OWL_CPU1_FLAG + (cpu - 1) * 4);
+
+	dsb_sev();
+	mb();
+
+	return 0;
+}
+
+static int s500_smp_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	unsigned long timeout;
+	int ret;
+
+	ret = s500_wakeup_secondary(cpu);
+	if (ret)
+		return ret;
+
+	udelay(10);
+
+	spin_lock(&boot_lock);
+
+	/*
+	 * The secondary processor is waiting to be released from
+	 * the holding pen - release it, then wait for it to flag
+	 * that it has been released by resetting pen_release.
+	 */
+	write_pen_release(cpu_logical_map(cpu));
+	smp_send_reschedule(cpu);
+
+	timeout = jiffies + (1 * HZ);
+	while (time_before(jiffies, timeout)) {
+		if (pen_release == -1)
+			break;
+	}
+
+	writel(0, timer_base_addr + OWL_CPU1_ADDR + (cpu - 1) * 4);
+	writel(0, timer_base_addr + OWL_CPU1_FLAG + (cpu - 1) * 4);
+
+	spin_unlock(&boot_lock);
+
+	return pen_release != -1 ? -ENOSYS : 0;
+}
+
+static void __init s500_smp_prepare_cpus(unsigned int max_cpus)
+{
+	struct device_node *node;
+
+	node = of_find_compatible_node(NULL, NULL, "actions,s500-timer");
+	if (!node) {
+		pr_err("%s: missing timer\n", __func__);
+		return;
+	}
+
+	timer_base_addr = of_iomap(node, 0);
+	if (!timer_base_addr) {
+		pr_err("%s: could not map timer registers\n", __func__);
+		return;
+	}
+
+	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9) {
+		node = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
+		if (!node) {
+			pr_err("%s: missing scu\n", __func__);
+			return;
+		}
+
+		scu_base_addr = of_iomap(node, 0);
+		if (!scu_base_addr) {
+			pr_err("%s: could not map scu registers\n", __func__);
+			return;
+		}
+
+		/*
+		 * While the number of cpus is gathered from dt, also get the
+		 * number of cores from the scu to verify this value when
+		 * booting the cores.
+		 */
+		ncores = scu_get_core_count(scu_base_addr);
+		pr_debug("%s: ncores %d\n", __func__, ncores);
+
+		scu_enable(scu_base_addr);
+	}
+}
+
+static const struct smp_operations s500_smp_ops __initconst = {
+	.smp_prepare_cpus = s500_smp_prepare_cpus,
+	.smp_secondary_init = s500_smp_secondary_init,
+	.smp_boot_secondary = s500_smp_boot_secondary,
+};
+CPU_METHOD_OF_DECLARE(s500_smp, "actions,s500-smp", &s500_smp_ops);
-- 
2.12.3
