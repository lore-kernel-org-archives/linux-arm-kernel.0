From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 31 Jul 2013 16:07:12 +0900
Subject: [PATCH 01/07] ARM: shmobile: Introduce shared SCU SMP boot code
In-Reply-To: <20130731070702.14444.64961.sendpatchset@w520>
References: <20130731070702.14444.64961.sendpatchset@w520>
Message-ID: <20130731070712.14444.49956.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add SMP boot functions for SCU equipped mach-shmobile SoCs.

At this point shmobile_smp_scu_prepare_cpus() controls the SCU and
installs boot fn and arg, while shmobile_smp_scu_boot_secondary()
currently does nothing. In the future the boot function and arg
install code will be reworked, so the empty function is ground
work for that.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/common.h |    3 ++
 arch/arm/mach-shmobile/platsmp-scu.c         |   31 ++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

--- 0001/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2013-07-29 16:50:17.000000000 +0900
@@ -11,6 +11,9 @@ extern void shmobile_boot_vector(void);
 extern unsigned long shmobile_boot_fn;
 extern unsigned long shmobile_boot_arg;
 extern void shmobile_boot_scu(void);
+extern void shmobile_smp_scu_prepare_cpus(unsigned int max_cpus);
+extern int shmobile_smp_scu_boot_secondary(unsigned int cpu,
+					   struct task_struct *idle);
 struct clk;
 extern int shmobile_clk_init(void);
 extern void shmobile_handle_irq_intc(struct pt_regs *);
--- /dev/null
+++ work/arch/arm/mach-shmobile/platsmp-scu.c	2013-07-29 21:39:30.000000000 +0900
@@ -0,0 +1,31 @@
+/*
+ * SMP support for SoCs with SCU covered by mach-shmobile
+ *
+ * Copyright (C) 2013  Magnus Damm
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/smp.h>
+#include <asm/smp_plat.h>
+#include <asm/smp_scu.h>
+#include <mach/common.h>
+
+void __init shmobile_smp_scu_prepare_cpus(unsigned int max_cpus)
+{
+	shmobile_boot_fn = virt_to_phys(shmobile_boot_scu);
+	shmobile_boot_arg = (unsigned long)shmobile_scu_base;
+
+	/* enable SCU and cache coherency on booting CPU */
+	scu_enable(shmobile_scu_base);
+	scu_power_mode(shmobile_scu_base, SCU_PM_NORMAL);
+}
+
+int shmobile_smp_scu_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	/* do nothing for now */
+	return 0;
+}
