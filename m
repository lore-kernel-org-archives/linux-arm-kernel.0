From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  5 Jul 2016 14:45:10 +0200
Subject: [PATCH 11/11] ARM: ux500: consolidate base platform files
In-Reply-To: <1467722710-1577-1-git-send-email-linus.walleij@linaro.org>
References: <1467722710-1577-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1467722710-1577-11-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

The cpu.c and cache-l2x0.c files hold only two or three simple
functions each, and they are all called from the machine
descriptors, so we can just move them all into the same file
for simplicity and consistency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/Makefile     |  3 +-
 arch/arm/mach-ux500/cache-l2x0.c | 60 ---------------------------
 arch/arm/mach-ux500/cpu-db8500.c | 87 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-ux500/cpu.c        | 67 -------------------------------
 arch/arm/mach-ux500/setup.h      | 10 -----
 5 files changed, 88 insertions(+), 139 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/cache-l2x0.c
 delete mode 100644 arch/arm/mach-ux500/cpu.c

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 753d3eed1985..56d0eb6e254e 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -2,8 +2,7 @@
 # Makefile for the linux kernel, U8500 machine.
 #
 
-obj-y				:= cpu.o pm.o
-obj-$(CONFIG_CACHE_L2X0)	+= cache-l2x0.o
+obj-y				:= pm.o
 obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o
 obj-$(CONFIG_MACH_MOP500)	+= board-mop500-audio.o
 obj-$(CONFIG_SMP)		+= platsmp.o
diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.c
deleted file mode 100644
index adec59cc2e1d..000000000000
--- a/arch/arm/mach-ux500/cache-l2x0.c
+++ /dev/null
@@ -1,60 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2011
- *
- * License terms: GNU General Public License (GPL) version 2
- */
-
-#include <linux/io.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-
-#include <asm/outercache.h>
-#include <asm/hardware/cache-l2x0.h>
-
-#include "db8500-regs.h"
-
-static int __init ux500_l2x0_unlock(void)
-{
-	int i;
-	struct device_node *np;
-	void __iomem *l2x0_base;
-
-	np = of_find_compatible_node(NULL, NULL, "arm,pl310-cache");
-	l2x0_base = of_iomap(np, 0);
-	of_node_put(np);
-	if (!l2x0_base)
-		return -ENODEV;
-
-	/*
-	 * Unlock Data and Instruction Lock if locked. Ux500 U-Boot versions
-	 * apparently locks both caches before jumping to the kernel. The
-	 * l2x0 core will not touch the unlock registers if the l2x0 is
-	 * already enabled, so we do it right here instead. The PL310 has
-	 * 8 sets of registers, one per possible CPU.
-	 */
-	for (i = 0; i < 8; i++) {
-		writel_relaxed(0x0, l2x0_base + L2X0_LOCKDOWN_WAY_D_BASE +
-			       i * L2X0_LOCKDOWN_STRIDE);
-		writel_relaxed(0x0, l2x0_base + L2X0_LOCKDOWN_WAY_I_BASE +
-			       i * L2X0_LOCKDOWN_STRIDE);
-	}
-	iounmap(l2x0_base);
-	return 0;
-}
-
-static void ux500_l2c310_write_sec(unsigned long val, unsigned reg)
-{
-	/*
-	 * We can't write to secure registers as we are in non-secure
-	 * mode, until we have some SMI service available.
-	 */
-}
-
-void __init ux500_l2x0_init(void)
-{
-	/* Unlock before init */
-	ux500_l2x0_unlock();
-	outer_cache.write_sec = ux500_l2c310_write_sec;
-
-	return 0;
-}
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index c9c9832f79e9..46b1da1bf5d2 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -12,22 +12,109 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/amba/bus.h>
+#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/arm-gic.h>
+#include <linux/mfd/dbx500-prcmu.h>
+#include <linux/platform_data/arm-ux500-pm.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/perf/arm_pmu.h>
 #include <linux/regulator/machine.h>
 
+#include <asm/outercache.h>
+#include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/map.h>
+#include <asm/mach/arch.h>
 
 #include "setup.h"
 
 #include "board-mop500.h"
 #include "db8500-regs.h"
 
+static int __init ux500_l2x0_unlock(void)
+{
+	int i;
+	struct device_node *np;
+	void __iomem *l2x0_base;
+
+	np = of_find_compatible_node(NULL, NULL, "arm,pl310-cache");
+	l2x0_base = of_iomap(np, 0);
+	of_node_put(np);
+	if (!l2x0_base)
+		return -ENODEV;
+
+	/*
+	 * Unlock Data and Instruction Lock if locked. Ux500 U-Boot versions
+	 * apparently locks both caches before jumping to the kernel. The
+	 * l2x0 core will not touch the unlock registers if the l2x0 is
+	 * already enabled, so we do it right here instead. The PL310 has
+	 * 8 sets of registers, one per possible CPU.
+	 */
+	for (i = 0; i < 8; i++) {
+		writel_relaxed(0x0, l2x0_base + L2X0_LOCKDOWN_WAY_D_BASE +
+			       i * L2X0_LOCKDOWN_STRIDE);
+		writel_relaxed(0x0, l2x0_base + L2X0_LOCKDOWN_WAY_I_BASE +
+			       i * L2X0_LOCKDOWN_STRIDE);
+	}
+	iounmap(l2x0_base);
+	return 0;
+}
+
+static void ux500_l2c310_write_sec(unsigned long val, unsigned reg)
+{
+	/*
+	 * We can't write to secure registers as we are in non-secure
+	 * mode, until we have some SMI service available.
+	 */
+}
+
+/*
+ * FIXME: Should we set up the GPIO domain here?
+ *
+ * The problem is that we cannot put the interrupt resources into the platform
+ * device until the irqdomain has been added. Right now, we set the GIC interrupt
+ * domain from init_irq(), then load the gpio driver from
+ * core_initcall(nmk_gpio_init) and add the platform devices from
+ * arch_initcall(customize_machine).
+ *
+ * This feels fragile because it depends on the gpio device getting probed
+ * _before_ any device uses the gpio interrupts.
+*/
+static void __init ux500_init_irq(void)
+{
+	struct device_node *np;
+	struct resource r;
+
+	irqchip_init();
+	np = of_find_compatible_node(NULL, NULL, "stericsson,db8500-prcmu");
+	of_address_to_resource(np, 0, &r);
+	of_node_put(np);
+	if (!r.start) {
+		pr_err("could not find PRCMU base resource\n");
+		return;
+	}
+	prcmu_early_init(r.start, r.end-r.start);
+	ux500_pm_init(r.start, r.end-r.start);
+
+	/* Unlock before init */
+	ux500_l2x0_unlock();
+	outer_cache.write_sec = ux500_l2c310_write_sec;
+}
+
+static void ux500_restart(enum reboot_mode mode, const char *cmd)
+{
+	local_irq_disable();
+	local_fiq_disable();
+
+	prcmu_system_reset(0);
+}
+
 /*
  * The PMU IRQ lines of two cores are wired together into a single interrupt.
  * Bounce the interrupt to the other core if it's not ours.
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
deleted file mode 100644
index a34af283ee23..000000000000
--- a/arch/arm/mach-ux500/cpu.c
+++ /dev/null
@@ -1,67 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
- * Author: Lee Jones <lee.jones@linaro.org> for ST-Ericsson
- * License terms: GNU General Public License (GPL) version 2
- */
-
-#include <linux/platform_device.h>
-#include <linux/io.h>
-#include <linux/mfd/dbx500-prcmu.h>
-#include <linux/sys_soc.h>
-#include <linux/err.h>
-#include <linux/slab.h>
-#include <linux/stat.h>
-#include <linux/of.h>
-#include <linux/of_irq.h>
-#include <linux/of_address.h>
-#include <linux/irq.h>
-#include <linux/irqchip.h>
-#include <linux/irqchip/arm-gic.h>
-#include <linux/platform_data/arm-ux500-pm.h>
-
-#include <asm/mach/map.h>
-
-#include "setup.h"
-
-#include "board-mop500.h"
-#include "db8500-regs.h"
-
-void ux500_restart(enum reboot_mode mode, const char *cmd)
-{
-	local_irq_disable();
-	local_fiq_disable();
-
-	prcmu_system_reset(0);
-}
-
-/*
- * FIXME: Should we set up the GPIO domain here?
- *
- * The problem is that we cannot put the interrupt resources into the platform
- * device until the irqdomain has been added. Right now, we set the GIC interrupt
- * domain from init_irq(), then load the gpio driver from
- * core_initcall(nmk_gpio_init) and add the platform devices from
- * arch_initcall(customize_machine).
- *
- * This feels fragile because it depends on the gpio device getting probed
- * _before_ any device uses the gpio interrupts.
-*/
-void __init ux500_init_irq(void)
-{
-	struct device_node *np;
-	struct resource r;
-
-	irqchip_init();
-	np = of_find_compatible_node(NULL, NULL, "stericsson,db8500-prcmu");
-	of_address_to_resource(np, 0, &r);
-	of_node_put(np);
-	if (!r.start) {
-		pr_err("could not find PRCMU base resource\n");
-		return;
-	}
-	prcmu_early_init(r.start, r.end-r.start);
-	ux500_pm_init(r.start, r.end-r.start);
-	ux500_l2x0_init();
-}
diff --git a/arch/arm/mach-ux500/setup.h b/arch/arm/mach-ux500/setup.h
index 85b7819a40ab..988e7c77068d 100644
--- a/arch/arm/mach-ux500/setup.h
+++ b/arch/arm/mach-ux500/setup.h
@@ -11,16 +11,6 @@
 #ifndef __ASM_ARCH_SETUP_H
 #define __ASM_ARCH_SETUP_H
 
-#include <asm/mach/arch.h>
-#include <linux/init.h>
-
-
-void ux500_l2x0_init(void);
-
-void ux500_restart(enum reboot_mode mode, const char *cmd);
-
-extern void __init ux500_init_irq(void);
-
 extern void ux500_cpu_die(unsigned int cpu);
 
 #endif /*  __ASM_ARCH_SETUP_H */
-- 
2.4.11
