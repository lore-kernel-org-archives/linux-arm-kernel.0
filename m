From: kmpark@infradead.org (Kyungmin Park)
Date: Fri, 24 Aug 2012 09:24:37 +0900
Subject: [PATCH v4 1/2] ARM: Make a compile firmware conditionally
Message-ID: <20120824002437.GA17038@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Some boards can use the firmware at trustzone but others can't use this.
However we need to build it simultaneously. To address this issue,
introduce arm firmware support and use it at each board files.

e.g., In boot_secondary at mach-exynos/platsmp.c

        __raw_writel(virt_to_phys(exynos4_secondary_startup),
                CPU1_BOOT_REG);

        if (IS_ENABLED(CONFIG_ARM_FIRMWARE)) {
                /* Call Exynos specific smc call */
                firmware_ops->cpu_boot(cpu);
        }

        gic_raise_softirq(cpumask_of(cpu), 1);

        if (pen_release == -1)

Now smp_ops is not yet merged, now just call the firmware_init at init_early
 at board file

e.g., exynos4412 based board

static void __init board_init_early(void)
{
        exynos_firmware_init();
}

TODO
        1. DT support.
        2. call firmware init by smp_ops.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
index 283fa1d..5b097ca 100644
--- a/arch/arm/common/Kconfig
+++ b/arch/arm/common/Kconfig
@@ -21,6 +21,9 @@ config ARM_VIC_NR
 	  The maximum number of VICs available in the system, for
 	  power management.
 
+config ARM_FIRMWARE
+	bool
+
 config ICST
 	bool
 
diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index e8a4e58..4af6568 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -4,6 +4,7 @@
 
 obj-$(CONFIG_ARM_GIC)		+= gic.o
 obj-$(CONFIG_ARM_VIC)		+= vic.o
+obj-$(CONFIG_ARM_FIRMWARE)	+= firmware.o
 obj-$(CONFIG_ICST)		+= icst.o
 obj-$(CONFIG_SA1111)		+= sa1111.o
 obj-$(CONFIG_PCI_HOST_VIA82C505) += via82c505.o
diff --git a/arch/arm/common/firmware.c b/arch/arm/common/firmware.c
new file mode 100644
index 0000000..d2c5d37
--- /dev/null
+++ b/arch/arm/common/firmware.c
@@ -0,0 +1,33 @@
+/*
+ *  Copyright (C) 2012 Samsung Electronics.
+ *  Kyungmin Park <kyungmin.park@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/suspend.h>
+
+#include <asm/firmware.h>
+
+struct firmware_ops *firmware_ops;
+
+static void cpu_boot(int cpu)
+{
+	/* Do nothing */
+}
+
+static struct firmware_ops __firmware_ops = {
+	.do_idle		= cpu_do_idle,
+	.cpu_boot		= cpu_boot,
+};
+
+static int __init firmware_init(void)
+{
+	firmware_ops = __firmware_ops;
+	return 0;
+}
+
+core_initcall(firmware_init);
diff --git a/arch/arm/include/asm/firmware.h b/arch/arm/include/asm/firmware.h
new file mode 100644
index 0000000..8f47cf7
--- /dev/null
+++ b/arch/arm/include/asm/firmware.h
@@ -0,0 +1,20 @@
+/*
+ *  Copyright (C) 2012 Samsung Electronics.
+ *  Kyungmin Park <kyungmin.park@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_ARM_FIRMWARE_H
+#define __ASM_ARM_FIRMWARE_H
+
+struct firmware_ops {
+	int	(*do_idle)(void);
+	void	(*cpu_boot)(int cpu);
+};
+
+extern struct firmware_ops *firmware_ops;
+
+#endif
