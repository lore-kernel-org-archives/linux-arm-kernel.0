From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:39:27 +0900
Subject: [GIT PULL 1/9] ARM: shmobile: Introduce shared SCU SMP boot code
In-Reply-To: <cover.1375841380.git.horms+renesas@verge.net.au>
References: <cover.1375841380.git.horms+renesas@verge.net.au>
Message-ID: <c970d4ef3ac6d56f5fd02902ad2ad80377c0bca1.1375841380.git.horms+renesas@verge.net.au>
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
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/common.h |  3 +++
 arch/arm/mach-shmobile/platsmp-scu.c         | 31 ++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 arch/arm/mach-shmobile/platsmp-scu.c

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index e818f02..42761f4 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
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
diff --git a/arch/arm/mach-shmobile/platsmp-scu.c b/arch/arm/mach-shmobile/platsmp-scu.c
new file mode 100644
index 0000000..8f478e4
--- /dev/null
+++ b/arch/arm/mach-shmobile/platsmp-scu.c
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
-- 
1.8.3.2
