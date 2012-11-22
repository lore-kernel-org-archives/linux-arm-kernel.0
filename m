From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 22 Nov 2012 16:51:14 +0100
Subject: [PATCH v4 1/5] ARM: Add interface for registering and calling
 firmware-specific operations
In-Reply-To: <1353599478-24617-1-git-send-email-t.figa@samsung.com>
References: <1353599478-24617-1-git-send-email-t.figa@samsung.com>
Message-ID: <1353599478-24617-2-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some boards are running with secure firmware running in TrustZone secure
world, which changes the way some things have to be initialized.

This patch adds an interface for platforms to specify available firmware
operations and call them.

A wrapper macro, call_firmware_op(), checks if the operation is provided
and calls it if so, otherwise returns -ENOSYS to allow fallback to
legacy operation..

By default no operations are provided.

Example of use:

In code using firmware ops:

	__raw_writel(virt_to_phys(exynos4_secondary_startup),
		CPU1_BOOT_REG);

	/* Call Exynos specific smc call */
	if (call_firmware_op(cpu_boot, cpu) == -ENOSYS)
		cpu_boot_legacy(...); /* Try legacy way */

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
		/* other operations not available on platformX */
	};

	static void __init board_init_early(void)
	{
	????????register_firmware_ops(&platformX_firmware_ops);
	}

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 Documentation/arm/firmware.txt  | 88 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/common/Makefile        |  2 +
 arch/arm/common/firmware.c      | 18 +++++++++
 arch/arm/include/asm/firmware.h | 66 +++++++++++++++++++++++++++++++
 4 files changed, 174 insertions(+)
 create mode 100644 Documentation/arm/firmware.txt
 create mode 100644 arch/arm/common/firmware.c
 create mode 100644 arch/arm/include/asm/firmware.h

diff --git a/Documentation/arm/firmware.txt b/Documentation/arm/firmware.txt
new file mode 100644
index 0000000..c2e468f
--- /dev/null
+++ b/Documentation/arm/firmware.txt
@@ -0,0 +1,88 @@
+Interface for registering and calling firmware-specific operations for ARM.
+----
+Written by Tomasz Figa <t.figa@samsung.com>
+
+Some boards are running with secure firmware running in TrustZone secure
+world, which changes the way some things have to be initialized. This makes
+a need to provide an interface for such platforms to specify available firmware
+operations and call them when needed.
+
+Firmware operations can be specified using struct firmware_ops
+
+	struct firmware_ops {
+		/*
+		* Enters CPU idle mode
+		*/
+		int (*do_idle)(void);
+		/*
+		* Sets boot address of specified physical CPU
+		*/
+		int (*set_cpu_boot_addr)(int cpu, unsigned long boot_addr);
+		/*
+		* Boots specified physical CPU
+		*/
+		int (*cpu_boot)(int cpu);
+		/*
+		* Initializes L2 cache
+		*/
+		int (*l2x0_init)(void);
+	};
+
+and then registered with register_firmware_ops function
+
+	void register_firmware_ops(const struct firmware_ops *ops)
+
+the ops pointer must be non-NULL.
+
+There is a default, empty set of operations provided, so there is no need to
+set anything if platform does not require firmware operations.
+
+To call a firmware operation, a helper macro is provided
+
+	#define call_firmware_op(op, ...)				\
+		((firmware_ops->op) ? firmware_ops->op(__VA_ARGS__) : (-ENOSYS))
+
+the macro checks if the operation is provided and calls it or otherwise returns
+-ENOSYS to signal that given operation is not available (for example, to allow
+fallback to legacy operation).
+
+Example of registering firmware operations:
+
+	/* board file */
+
+	static int platformX_do_idle(void)
+	{
+		/* tell platformX firmware to enter idle */
+		return 0;
+	}
+
+	static int platformX_cpu_boot(int i)
+	{
+		/* tell platformX firmware to boot CPU i */
+		return 0;
+	}
+
+	static const struct firmware_ops platformX_firmware_ops = {
+		.do_idle        = exynos_do_idle,
+		.cpu_boot       = exynos_cpu_boot,
+		/* other operations not available on platformX */
+	};
+
+	/* init_early callback of machine descriptor */
+	static void __init board_init_early(void)
+	{
+		register_firmware_ops(&platformX_firmware_ops);
+	}
+
+Example of using a firmware operation:
+
+	/* some platform code, e.g. SMP initialization */
+
+	__raw_writel(virt_to_phys(exynos4_secondary_startup),
+		CPU1_BOOT_REG);
+
+	/* Call Exynos specific smc call */
+	if (call_firmware_op(cpu_boot, cpu) == -ENOSYS)
+		cpu_boot_legacy(...); /* Try legacy way */
+
+	gic_raise_softirq(cpumask_of(cpu), 1);
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
index 0000000..1563130
--- /dev/null
+++ b/arch/arm/include/asm/firmware.h
@@ -0,0 +1,66 @@
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
+#include <linux/bug.h>
+
+/*
+ * struct firmware_ops
+ *
+ * A structure to specify available firmware operations.
+ *
+ * A filled up structure can be registered with register_firmware_ops().
+ */
+struct firmware_ops {
+	/*
+	 * Enters CPU idle mode
+	 */
+	int (*do_idle)(void);
+	/*
+	 * Sets boot address of specified physical CPU
+	 */
+	int (*set_cpu_boot_addr)(int cpu, unsigned long boot_addr);
+	/*
+	 * Boots specified physical CPU
+	 */
+	int (*cpu_boot)(int cpu);
+	/*
+	 * Initializes L2 cache
+	 */
+	int (*l2x0_init)(void);
+};
+
+/* Global pointer for current firmware_ops structure, can't be NULL. */
+extern const struct firmware_ops *firmware_ops;
+
+/*
+ * call_firmware_op(op, ...)
+ *
+ * Checks if firmware operation is present and calls it,
+ * otherwise returns -ENOSYS
+ */
+#define call_firmware_op(op, ...)					\
+	((firmware_ops->op) ? firmware_ops->op(__VA_ARGS__) : (-ENOSYS))
+
+/*
+ * register_firmware_ops(ops)
+ *
+ * A function to register platform firmware_ops struct.
+ */
+static inline void register_firmware_ops(const struct firmware_ops *ops)
+{
+	BUG_ON(!ops);
+
+	firmware_ops = ops;
+}
+
+#endif
-- 
1.8.0
