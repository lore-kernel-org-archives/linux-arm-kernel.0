From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 24 Sep 2012 16:28:28 +0200
Subject: [PATCH 1/6] ARM: Add interface for registering and calling
 firmware-specific operations
In-Reply-To: <1348496913-25422-1-git-send-email-t.figa@samsung.com>
References: <1348496913-25422-1-git-send-email-t.figa@samsung.com>
Message-ID: <1348496913-25422-2-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some boards are running with secure firmware running in TrustZone secure
world, which changes the way some things have to be initialized.

This patch adds an interface for platforms to specify available firmware
operations and call them.

A wrapper macro, call_firmware_op(), checks if the operation is provided
and calls it if so, otherwise returns -ENOSYS to allow fallback to l

By default no operations are provided.

Example of use:

In code using firmware ops:

	__raw_writel(virt_to_phys(exynos4_secondary_startup),
		CPU1_BOOT_REG);

	/* Call Exynos specific smc call */
	if (call_firmware_op(cpu_boot, cpu) == -ENOSYS)
		cpu_boot_legacy(cpu); /* Try legacy way */

	gic_raise_softirq(cpumask_of(cpu), 1);

In board-/platform-specific code:

	static int platformX_do_idle(void)
	{
		/* tell platformX firmware to enter idle */
	        return 0;
	}

	static int platformX_cpu_boot(int i)
	{
		/* tell platformX firmware to boot CPU i */
		return 0;
	}

	static const struct firmware_ops platformX_firmware_ops = {
		.do_idle	= exynos_do_idle,
		.cpu_boot	= exynos_cpu_boot,
		/* cpu_boot_reg not available on platformX */
	};

	static void __init board_init_early(void)
	{
	????????register_firmware_ops(&platformX_firmware_ops);
	}

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/common/Makefile        |  2 ++
 arch/arm/common/firmware.c      | 18 ++++++++++++++++++
 arch/arm/include/asm/firmware.h | 31 +++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)
 create mode 100644 arch/arm/common/firmware.c
 create mode 100644 arch/arm/include/asm/firmware.h

diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index e8a4e58..55d4182 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -2,6 +2,8 @@
 # Makefile for the linux kernel.
 #
 
+obj-y += firmware.o
+
 obj-$(CONFIG_ARM_GIC)		+= gic.o
 obj-$(CONFIG_ARM_VIC)		+= vic.o
 obj-$(CONFIG_ICST)		+= icst.o
diff --git a/arch/arm/common/firmware.c b/arch/arm/common/firmware.c
new file mode 100644
index 0000000..27ddccb
--- /dev/null
+++ b/arch/arm/common/firmware.c
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) 2012 Samsung Electronics.
+ * Kyungmin Park <kyungmin.park@samsung.com>
+ * Tomasz Figa <t.figa@samsung.com>
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
+static const struct firmware_ops default_firmware_ops;
+
+const struct firmware_ops *firmware_ops = &default_firmware_ops;
diff --git a/arch/arm/include/asm/firmware.h b/arch/arm/include/asm/firmware.h
new file mode 100644
index 0000000..5d87d8e
--- /dev/null
+++ b/arch/arm/include/asm/firmware.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright (C) 2012 Samsung Electronics.
+ * Kyungmin Park <kyungmin.park@samsung.com>
+ * Tomasz Figa <t.figa@samsung.com>
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
+	int (*do_idle)(void);
+	int (*cpu_boot)(int cpu);
+	int (*cpu_boot_reg)(int cpu, void __iomem **ptr);
+	int (*l2x0_init)(void);
+};
+
+extern const struct firmware_ops *firmware_ops;
+
+#define call_firmware_op(op, ...)					\
+	((firmware_ops->op) ? firmware_ops->op(__VA_ARGS__) : (-ENOSYS))
+
+static inline void register_firmware_ops(const struct firmware_ops *ops)
+{
+	firmware_ops = ops;
+}
+
+#endif
-- 
1.7.12
