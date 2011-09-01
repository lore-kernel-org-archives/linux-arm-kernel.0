From: robherring2@gmail.com (Rob Herring)
Date: Wed, 31 Aug 2011 20:44:02 -0500
Subject: [PATCH v2 3/7] ARM: add Highbank core platform support
In-Reply-To: <1314841446-11006-1-git-send-email-robherring2@gmail.com>
References: <1314841446-11006-1-git-send-email-robherring2@gmail.com>
Message-ID: <1314841446-11006-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This adds basic support for the Calxeda Highbank platform.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
Changes in v2:
 - s/a9_base_addr/scu_base_addr/
 - Move DEBUG_LL io mapping to lluart.c
 - Convert direct sysregs accesses to inline helper functions
 - drop gpio interrupt mapping for now
 - Remove IO_SPACE_LIMIT and fix warnings from inb, outb, etc. due parameter
   being unused in __io
 - sort Kconfig select entries
 - Add WARN_ON for ioremap failures
 - drop unneeded include from entry-macro.S
 - remove #ifdef around l2x0_of_init
 - Add "/* empty */" to empty headers
 
 arch/arm/Kconfig                                  |   16 +++
 arch/arm/Makefile                                 |    1 +
 arch/arm/mach-highbank/Makefile                   |    2 +
 arch/arm/mach-highbank/Makefile.boot              |    1 +
 arch/arm/mach-highbank/clock.c                    |   62 +++++++++
 arch/arm/mach-highbank/core.h                     |    9 ++
 arch/arm/mach-highbank/highbank.c                 |  150 +++++++++++++++++++++
 arch/arm/mach-highbank/include/mach/debug-macro.S |   19 +++
 arch/arm/mach-highbank/include/mach/entry-macro.S |    7 +
 arch/arm/mach-highbank/include/mach/gpio.h        |    1 +
 arch/arm/mach-highbank/include/mach/io.h          |    7 +
 arch/arm/mach-highbank/include/mach/irqs.h        |    6 +
 arch/arm/mach-highbank/include/mach/memory.h      |    1 +
 arch/arm/mach-highbank/include/mach/system.h      |   26 ++++
 arch/arm/mach-highbank/include/mach/timex.h       |    6 +
 arch/arm/mach-highbank/include/mach/uncompress.h  |    9 ++
 arch/arm/mach-highbank/include/mach/vmalloc.h     |    6 +
 arch/arm/mach-highbank/lluart.c                   |   34 +++++
 arch/arm/mach-highbank/sysregs.h                  |   52 +++++++
 arch/arm/mach-highbank/system.c                   |   33 +++++
 arch/arm/mm/Kconfig                               |    2 +-
 21 files changed, 449 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-highbank/Makefile
 create mode 100644 arch/arm/mach-highbank/Makefile.boot
 create mode 100644 arch/arm/mach-highbank/clock.c
 create mode 100644 arch/arm/mach-highbank/core.h
 create mode 100644 arch/arm/mach-highbank/highbank.c
 create mode 100644 arch/arm/mach-highbank/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-highbank/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-highbank/include/mach/gpio.h
 create mode 100644 arch/arm/mach-highbank/include/mach/io.h
 create mode 100644 arch/arm/mach-highbank/include/mach/irqs.h
 create mode 100644 arch/arm/mach-highbank/include/mach/memory.h
 create mode 100644 arch/arm/mach-highbank/include/mach/system.h
 create mode 100644 arch/arm/mach-highbank/include/mach/timex.h
 create mode 100644 arch/arm/mach-highbank/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-highbank/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-highbank/lluart.c
 create mode 100644 arch/arm/mach-highbank/sysregs.h
 create mode 100644 arch/arm/mach-highbank/system.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 63cbd86..9019a56 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -314,6 +314,22 @@ config ARCH_BCMRING
 	help
 	  Support for Broadcom's BCMRing platform.
 
+config ARCH_HIGHBANK
+	bool "Calxeda Highbank-based"
+	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select ARM_AMBA
+	select ARM_GIC
+	select ARM_PATCH_PHYS_VIRT
+	select ARM_TIMER_SP804
+	select AUTO_ZRELADDR
+	select CLKDEV_LOOKUP
+	select CPU_V7
+	select GENERIC_CLOCKEVENTS
+	select HAVE_ARM_SCU
+	select USE_OF
+	help
+	  Support for the Calxeda Highbank SoC based boards.
+
 config ARCH_CLPS711X
 	bool "Cirrus Logic CLPS711x/EP721x-based"
 	select CPU_ARM720T
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 5665c2a..98c3c22 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -144,6 +144,7 @@ machine-$(CONFIG_ARCH_EBSA110)		:= ebsa110
 machine-$(CONFIG_ARCH_EP93XX)		:= ep93xx
 machine-$(CONFIG_ARCH_GEMINI)		:= gemini
 machine-$(CONFIG_ARCH_H720X)		:= h720x
+machine-$(CONFIG_ARCH_HIGHBANK)		:= highbank
 machine-$(CONFIG_ARCH_INTEGRATOR)	:= integrator
 machine-$(CONFIG_ARCH_IOP13XX)		:= iop13xx
 machine-$(CONFIG_ARCH_IOP32X)		:= iop32x
diff --git a/arch/arm/mach-highbank/Makefile b/arch/arm/mach-highbank/Makefile
new file mode 100644
index 0000000..11d4010
--- /dev/null
+++ b/arch/arm/mach-highbank/Makefile
@@ -0,0 +1,2 @@
+obj-y					:= clock.o highbank.o system.o
+obj-$(CONFIG_DEBUG_LL)			+= lluart.o
diff --git a/arch/arm/mach-highbank/Makefile.boot b/arch/arm/mach-highbank/Makefile.boot
new file mode 100644
index 0000000..dae9661
--- /dev/null
+++ b/arch/arm/mach-highbank/Makefile.boot
@@ -0,0 +1 @@
+zreladdr-y	:= 0x00008000
diff --git a/arch/arm/mach-highbank/clock.c b/arch/arm/mach-highbank/clock.c
new file mode 100644
index 0000000..c25a2ae
--- /dev/null
+++ b/arch/arm/mach-highbank/clock.c
@@ -0,0 +1,62 @@
+/*
+ * Copyright 2011 Calxeda, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+
+struct clk {
+	unsigned long rate;
+};
+
+int clk_enable(struct clk *clk)
+{
+	return 0;
+}
+
+void clk_disable(struct clk *clk)
+{}
+
+unsigned long clk_get_rate(struct clk *clk)
+{
+	return clk->rate;
+}
+
+long clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	return clk->rate;
+}
+
+int clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	return 0;
+}
+
+static struct clk eclk = { .rate = 200000000 };
+static struct clk pclk = { .rate = 150000000 };
+
+static struct clk_lookup lookups[] = {
+	{ .clk = &pclk, .con_id = "apb_pclk", },
+	{ .clk = &pclk, .dev_id = "sp804", },
+	{ .clk = &eclk, .dev_id = "ffe0e000.sdhci", },
+	{ .clk = &pclk, .dev_id = "fff36000.serial", },
+};
+
+void __init highbank_clocks_init(void)
+{
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+}
diff --git a/arch/arm/mach-highbank/core.h b/arch/arm/mach-highbank/core.h
new file mode 100644
index 0000000..9df3fc7
--- /dev/null
+++ b/arch/arm/mach-highbank/core.h
@@ -0,0 +1,9 @@
+extern void highbank_set_cpu_jump(int cpu, void *jump_addr);
+extern void highbank_clocks_init(void);
+extern void __iomem *scu_base_addr;
+#ifdef CONFIG_DEBUG_LL
+extern void highbank_lluart_map_io(void);
+#else
+static inline void highbank_lluart_map_io(void) {}
+#endif
+
diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
new file mode 100644
index 0000000..fb257e0
--- /dev/null
+++ b/arch/arm/mach-highbank/highbank.c
@@ -0,0 +1,150 @@
+/*
+ * Copyright 2010-2011 Calxeda, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+
+#include <asm/cacheflush.h>
+#include <asm/unified.h>
+#include <asm/smp_scu.h>
+#include <asm/hardware/arm_timer.h>
+#include <asm/hardware/timer-sp.h>
+#include <asm/hardware/gic.h>
+#include <asm/hardware/cache-l2x0.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/time.h>
+#include <mach/irqs.h>
+
+#include "core.h"
+#include "sysregs.h"
+
+void __iomem *sregs_base;
+
+#define HB_SCU_VIRT_BASE	0xfee00000
+void __iomem *scu_base_addr = ((void __iomem *)(HB_SCU_VIRT_BASE));
+
+static struct map_desc scu_io_desc __initdata = {
+	.virtual	= HB_SCU_VIRT_BASE,
+	.pfn		= 0, /* run-time */
+	.length		= SZ_4K,
+	.type		= MT_DEVICE,
+};
+
+static void __init highbank_scu_map_io(void)
+{
+	unsigned long base;
+
+	/* Get SCU base */
+	asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (base));
+
+	scu_io_desc.pfn = __phys_to_pfn(base);
+	iotable_init(&scu_io_desc, 1);
+}
+
+static void __init highbank_map_io(void)
+{
+	highbank_scu_map_io();
+	highbank_lluart_map_io();
+}
+
+#define HB_JUMP_TABLE_PHYS(cpu)		(0x40 + (0x10 * (cpu)))
+#define HB_JUMP_TABLE_VIRT(cpu)		phys_to_virt(HB_JUMP_TABLE_PHYS(cpu))
+
+void highbank_set_cpu_jump(int cpu, void *jump_addr)
+{
+	writel(BSYM(virt_to_phys(jump_addr)), HB_JUMP_TABLE_VIRT(cpu));
+	__cpuc_flush_dcache_area(HB_JUMP_TABLE_VIRT(cpu), 16);
+	outer_clean_range(HB_JUMP_TABLE_PHYS(cpu),
+			  HB_JUMP_TABLE_PHYS(cpu) + 15);
+}
+
+void highbank_init_irq(void)
+{
+	struct device_node *node;
+	struct of_intc_desc desc;
+
+	memset(&desc, 0, sizeof(desc));
+	desc.controller = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-gic");
+	gic_of_init(&desc);
+	node = desc.controller;
+	for_each_child_of_node(node, desc.controller)
+		gic_of_ppi_init(&desc);
+
+	l2x0_of_init(0, ~0UL);
+}
+
+static void __init highbank_timer_init(void)
+{
+	int irq;
+	struct device_node *np;
+	void __iomem *timer_base;
+
+	/* Map system registers */
+	np = of_find_compatible_node(NULL, NULL, "calxeda,hb-sregs");
+	sregs_base = of_iomap(np, 0);
+	WARN_ON(!sregs_base);
+
+	np = of_find_compatible_node(NULL, NULL, "arm,sp804");
+	timer_base = of_iomap(np, 0);
+	WARN_ON(!timer_base);
+	irq = irq_of_parse_and_map(np, 0);
+
+	highbank_clocks_init();
+
+	sp804_clocksource_init(timer_base + 0x20, "timer1");
+	sp804_clockevents_init(timer_base, irq, "timer0");
+}
+
+static struct sys_timer highbank_timer = {
+	.init = highbank_timer_init,
+};
+
+static void highbank_power_off(void)
+{
+	hignbank_set_pwr_shutdown();
+	scu_power_mode(scu_base_addr, SCU_PM_POWEROFF);
+
+	while (1)
+		cpu_do_idle();
+}
+
+static void __init highbank_init(void)
+{
+	pm_power_off = highbank_power_off;
+
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static const char *highbank_match[] __initconst = {
+	"calxeda,highbank",
+	NULL,
+};
+
+DT_MACHINE_START(HIGHBANK, "Highbank")
+	.map_io		= highbank_map_io,
+	.init_irq	= highbank_init_irq,
+	.nr_irqs	= NR_IRQS,
+	.timer		= &highbank_timer,
+	.init_machine	= highbank_init,
+	.dt_compat	= highbank_match,
+MACHINE_END
diff --git a/arch/arm/mach-highbank/include/mach/debug-macro.S b/arch/arm/mach-highbank/include/mach/debug-macro.S
new file mode 100644
index 0000000..2f3e344
--- /dev/null
+++ b/arch/arm/mach-highbank/include/mach/debug-macro.S
@@ -0,0 +1,19 @@
+/*
+ * Debugging macro include header
+ *
+ *  Copyright (C) 1994-1999 Russell King
+ *  Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+		.macro	addruart,rp,rv
+		movw	\rv, #0x6000
+		movt	\rv, #0xfee3
+		movw	\rp, #0x6000
+		movt	\rp, #0xfff3
+		.endm
+
+#include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/mach-highbank/include/mach/entry-macro.S b/arch/arm/mach-highbank/include/mach/entry-macro.S
new file mode 100644
index 0000000..73c1129
--- /dev/null
+++ b/arch/arm/mach-highbank/include/mach/entry-macro.S
@@ -0,0 +1,7 @@
+#include <asm/hardware/entry-macro-gic.S>
+
+	.macro	disable_fiq
+	.endm
+
+	.macro	arch_ret_to_user, tmp1, tmp2
+	.endm
diff --git a/arch/arm/mach-highbank/include/mach/gpio.h b/arch/arm/mach-highbank/include/mach/gpio.h
new file mode 100644
index 0000000..40a8c17
--- /dev/null
+++ b/arch/arm/mach-highbank/include/mach/gpio.h
@@ -0,0 +1 @@
+/* empty */
diff --git a/arch/arm/mach-highbank/include/mach/io.h b/arch/arm/mach-highbank/include/mach/io.h
new file mode 100644
index 0000000..70cfa3b
--- /dev/null
+++ b/arch/arm/mach-highbank/include/mach/io.h
@@ -0,0 +1,7 @@
+#ifndef __MACH_IO_H
+#define __MACH_IO_H
+
+#define __io(a)		({ (void)(a); __typesafe_io(0); })
+#define __mem_pci(a)	(a)
+
+#endif
diff --git a/arch/arm/mach-highbank/include/mach/irqs.h b/arch/arm/mach-highbank/include/mach/irqs.h
new file mode 100644
index 0000000..9746aab
--- /dev/null
+++ b/arch/arm/mach-highbank/include/mach/irqs.h
@@ -0,0 +1,6 @@
+#ifndef __MACH_IRQS_H
+#define __MACH_IRQS_H
+
+#define NR_IRQS			192
+
+#endif
diff --git a/arch/arm/mach-highbank/include/mach/memory.h b/arch/arm/mach-highbank/include/mach/memory.h
new file mode 100644
index 0000000..40a8c17
--- /dev/null
+++ b/arch/arm/mach-highbank/include/mach/memory.h
@@ -0,0 +1 @@
+/* empty */
diff --git a/arch/arm/mach-highbank/include/mach/system.h b/arch/arm/mach-highbank/include/mach/system.h
new file mode 100644
index 0000000..7e81922
--- /dev/null
+++ b/arch/arm/mach-highbank/include/mach/system.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright 2010-2011 Calxeda, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __MACH_SYSTEM_H
+#define __MACH_SYSTEM_H
+
+static inline void arch_idle(void)
+{
+	cpu_do_idle();
+}
+
+extern void arch_reset(char mode, const char *cmd);
+
+#endif
diff --git a/arch/arm/mach-highbank/include/mach/timex.h b/arch/arm/mach-highbank/include/mach/timex.h
new file mode 100644
index 0000000..88dac7a
--- /dev/null
+++ b/arch/arm/mach-highbank/include/mach/timex.h
@@ -0,0 +1,6 @@
+#ifndef __MACH_TIMEX_H
+#define __MACH_TIMEX_H
+
+#define CLOCK_TICK_RATE		1000000
+
+#endif
diff --git a/arch/arm/mach-highbank/include/mach/uncompress.h b/arch/arm/mach-highbank/include/mach/uncompress.h
new file mode 100644
index 0000000..bbe20e6
--- /dev/null
+++ b/arch/arm/mach-highbank/include/mach/uncompress.h
@@ -0,0 +1,9 @@
+#ifndef __MACH_UNCOMPRESS_H
+#define __MACH_UNCOMPRESS_H
+
+#define putc(c)
+#define flush()
+#define arch_decomp_setup()
+#define arch_decomp_wdog()
+
+#endif
diff --git a/arch/arm/mach-highbank/include/mach/vmalloc.h b/arch/arm/mach-highbank/include/mach/vmalloc.h
new file mode 100644
index 0000000..1a3e398
--- /dev/null
+++ b/arch/arm/mach-highbank/include/mach/vmalloc.h
@@ -0,0 +1,6 @@
+#ifndef __MACH_VMALLOC_H
+#define __MACH_VMALLOC_H
+
+#define VMALLOC_END		0xFEE00000UL
+
+#endif
diff --git a/arch/arm/mach-highbank/lluart.c b/arch/arm/mach-highbank/lluart.c
new file mode 100644
index 0000000..3715750
--- /dev/null
+++ b/arch/arm/mach-highbank/lluart.c
@@ -0,0 +1,34 @@
+/*
+ * Copyright 2011 Calxeda, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/init.h>
+#include <asm/page.h>
+#include <asm/sizes.h>
+#include <asm/mach/map.h>
+
+#define HB_DEBUG_LL_PHYS_BASE	0xfff36000
+#define HB_DEBUG_LL_VIRT_BASE	0xfee36000
+
+static struct map_desc lluart_io_desc __initdata = {
+	.virtual	= HB_DEBUG_LL_VIRT_BASE,
+	.pfn		= __phys_to_pfn(HB_DEBUG_LL_PHYS_BASE),
+	.length		= SZ_4K,
+	.type		= MT_DEVICE,
+};
+
+void __init highbank_lluart_map_io(void)
+{
+	iotable_init(&lluart_io_desc, 1);
+}
diff --git a/arch/arm/mach-highbank/sysregs.h b/arch/arm/mach-highbank/sysregs.h
new file mode 100644
index 0000000..0e91338
--- /dev/null
+++ b/arch/arm/mach-highbank/sysregs.h
@@ -0,0 +1,52 @@
+/*
+ * Copyright 2011 Calxeda, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef _MACH_HIGHBANK__SYSREGS_H_
+#define _MACH_HIGHBANK__SYSREGS_H_
+
+#include <linux/io.h>
+
+extern void __iomem *sregs_base;
+
+#define HB_SREG_A9_PWR_REQ		0xf00
+#define HB_SREG_A9_BOOT_STAT		0xf04
+#define HB_SREG_A9_BOOT_DATA		0xf08
+
+#define HB_PWR_SUSPEND			0
+#define HB_PWR_SOFT_RESET		1
+#define HB_PWR_HARD_RESET		2
+#define HB_PWR_SHUTDOWN			3
+
+static inline void hignbank_set_pwr_suspend(void)
+{
+	writel(HB_PWR_SUSPEND, sregs_base + HB_SREG_A9_PWR_REQ);
+}
+
+static inline void hignbank_set_pwr_shutdown(void)
+{
+	writel(HB_PWR_SHUTDOWN, sregs_base + HB_SREG_A9_PWR_REQ);
+}
+
+static inline void hignbank_set_pwr_soft_reset(void)
+{
+	writel(HB_PWR_SOFT_RESET, sregs_base + HB_SREG_A9_PWR_REQ);
+}
+
+static inline void hignbank_set_pwr_hard_reset(void)
+{
+	writel(HB_PWR_HARD_RESET, sregs_base + HB_SREG_A9_PWR_REQ);
+}
+
+#endif
diff --git a/arch/arm/mach-highbank/system.c b/arch/arm/mach-highbank/system.c
new file mode 100644
index 0000000..53f0c4c
--- /dev/null
+++ b/arch/arm/mach-highbank/system.c
@@ -0,0 +1,33 @@
+/*
+ * Copyright 2011 Calxeda, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/io.h>
+#include <asm/smp_scu.h>
+#include <asm/proc-fns.h>
+
+#include "core.h"
+#include "sysregs.h"
+
+void arch_reset(char mode, const char *cmd)
+{
+	if (mode == 'h')
+		hignbank_set_pwr_hard_reset();
+	else
+		hignbank_set_pwr_soft_reset();
+
+	scu_power_mode(scu_base_addr, SCU_PM_POWEROFF);
+	cpu_do_idle();
+}
+
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 88633fe..7d5fff7 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -822,7 +822,7 @@ config CACHE_L2X0
 		   REALVIEW_EB_A9MP || SOC_IMX35 || SOC_IMX31 || MACH_REALVIEW_PBX || \
 		   ARCH_NOMADIK || ARCH_OMAP4 || ARCH_EXYNOS4 || ARCH_TEGRA || \
 		   ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_SHMOBILE || \
-		   ARCH_PRIMA2 || ARCH_ZYNQ || ARCH_CNS3XXX
+		   ARCH_PRIMA2 || ARCH_ZYNQ || ARCH_CNS3XXX || ARCH_HIGHBANK
 	default y
 	select OUTER_CACHE
 	select OUTER_CACHE_SYNC
-- 
1.7.4.1
