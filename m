From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon,  1 Sep 2014 16:28:40 +0100
Subject: [PATCH v8 4/8] arm64: kernel: introduce cpu_init_idle CPU operation
In-Reply-To: <1409585324-3678-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1409585324-3678-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1409585324-3678-5-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CPUidle subsystem on ARM64 machines requires the idle states
implementation back-end to initialize idle states parameter upon
boot. This patch adds a hook in the CPU operations structure that
should be initialized by the CPU operations back-end in order to
provide a function that initializes cpu idle states.

This patch also adds the infrastructure to arm64 kernel required
to export the CPU operations based initialization interface, so
that drivers (ie CPUidle) can use it when they are initialized
at probe time.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/include/asm/cpu_ops.h |  3 +++
 arch/arm64/include/asm/cpuidle.h | 13 +++++++++++++
 arch/arm64/kernel/Makefile       |  1 +
 arch/arm64/kernel/cpuidle.c      | 31 +++++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+)
 create mode 100644 arch/arm64/include/asm/cpuidle.h
 create mode 100644 arch/arm64/kernel/cpuidle.c

diff --git a/arch/arm64/include/asm/cpu_ops.h b/arch/arm64/include/asm/cpu_ops.h
index d7b4b38..47dfa31 100644
--- a/arch/arm64/include/asm/cpu_ops.h
+++ b/arch/arm64/include/asm/cpu_ops.h
@@ -28,6 +28,8 @@ struct device_node;
  *		enable-method property.
  * @cpu_init:	Reads any data necessary for a specific enable-method from the
  *		devicetree, for a given cpu node and proposed logical id.
+ * @cpu_init_idle: Reads any data necessary to initialize CPU idle states from
+ *		devicetree, for a given cpu node and proposed logical id.
  * @cpu_prepare: Early one-time preparation step for a cpu. If there is a
  *		mechanism for doing so, tests whether it is possible to boot
  *		the given CPU.
@@ -47,6 +49,7 @@ struct device_node;
 struct cpu_operations {
 	const char	*name;
 	int		(*cpu_init)(struct device_node *, unsigned int);
+	int		(*cpu_init_idle)(struct device_node *, unsigned int);
 	int		(*cpu_prepare)(unsigned int);
 	int		(*cpu_boot)(unsigned int);
 	void		(*cpu_postboot)(void);
diff --git a/arch/arm64/include/asm/cpuidle.h b/arch/arm64/include/asm/cpuidle.h
new file mode 100644
index 0000000..b52a993
--- /dev/null
+++ b/arch/arm64/include/asm/cpuidle.h
@@ -0,0 +1,13 @@
+#ifndef __ASM_CPUIDLE_H
+#define __ASM_CPUIDLE_H
+
+#ifdef CONFIG_CPU_IDLE
+extern int cpu_init_idle(unsigned int cpu);
+#else
+static inline int cpu_init_idle(unsigned int cpu)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
+#endif
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 383d81d..be78980 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -27,6 +27,7 @@ arm64-obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o
 arm64-obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
 arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 arm64-obj-$(CONFIG_ARM64_CPU_SUSPEND)	+= sleep.o suspend.o
+arm64-obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 arm64-obj-$(CONFIG_JUMP_LABEL)		+= jump_label.o
 arm64-obj-$(CONFIG_KGDB)		+= kgdb.o
 arm64-obj-$(CONFIG_EFI)			+= efi.o efi-stub.o efi-entry.o
diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
new file mode 100644
index 0000000..19d17f5
--- /dev/null
+++ b/arch/arm64/kernel/cpuidle.c
@@ -0,0 +1,31 @@
+/*
+ * ARM64 CPU idle arch support
+ *
+ * Copyright (C) 2014 ARM Ltd.
+ * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/of.h>
+#include <linux/of_device.h>
+
+#include <asm/cpuidle.h>
+#include <asm/cpu_ops.h>
+
+int cpu_init_idle(unsigned int cpu)
+{
+	int ret = -EOPNOTSUPP;
+	struct device_node *cpu_node = of_cpu_device_node_get(cpu);
+
+	if (!cpu_node)
+		return -ENODEV;
+
+	if (cpu_ops[cpu] && cpu_ops[cpu]->cpu_init_idle)
+		ret = cpu_ops[cpu]->cpu_init_idle(cpu_node, cpu);
+
+	of_node_put(cpu_node);
+	return ret;
+}
-- 
1.9.1
