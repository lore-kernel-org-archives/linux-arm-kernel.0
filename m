From: jamie.iles@picochip.com (Jamie Iles)
Date: Fri, 11 Dec 2009 09:44:19 +0000
Subject: [PATCH 1/4] arm: provide a mechanism to reserve performance counters
In-Reply-To: <1260524662-30683-1-git-send-email-jamie.iles@picochip.com>
References: <1260524662-30683-1-git-send-email-jamie.iles@picochip.com>
Message-ID: <1260524662-30683-2-git-send-email-jamie.iles@picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To add support for perf events and to allow the hardware
counters to be shared with oprofile, we need a way to reserve
access to the pmu (performance monitor unit).

Signed-off-by: Jamie Iles <jamie.iles@picochip.com>
---
 arch/arm/include/asm/pmu.h |   54 ++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/Makefile   |    1 +
 arch/arm/kernel/pmu.c      |   32 ++++++++++++++++++++++++++
 arch/arm/mm/Kconfig        |    4 +++
 4 files changed, 91 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/pmu.h
 create mode 100644 arch/arm/kernel/pmu.c

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
new file mode 100644
index 0000000..94d6c67
--- /dev/null
+++ b/arch/arm/include/asm/pmu.h
@@ -0,0 +1,54 @@
+/*
+ *  linux/arch/arm/include/asm/pmu.h
+ *
+ *  Copyright (C) 2009 picoChip Designs Ltd, Jamie Iles
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __ARM_PMU_H__
+#define __ARM_PMU_H__
+
+#ifdef CONFIG_CPU_HAS_PMU
+
+/**
+ * reserve_pmu() - Reserve the hardware performance counters
+ *
+ * Reserve the hardware performance counters in the system for exclusive use.
+ * Note: success here does not guarantee exclusive access - callers must
+ * respect the return value.
+ *
+ * Returns zero on success, negative error on failure.
+ */
+extern int
+reserve_pmu(void);
+
+/**
+ * release_pmu() - Relinquish control of the performance counters
+ *
+ * Release the performance counters and allow someone else to use them.
+ * Callers must have disabled the counters and released IRQs before calling
+ * this.
+ */
+extern void
+release_pmu(void);
+
+#else /* CONFIG_CPU_HAS_PMU */
+
+static inline int
+reserve_pmu(void)
+{
+	return -ENODEV;
+}
+
+static inline void
+release_pmu(void)
+{
+}
+
+#endif /* CONFIG_CPU_HAS_PMU */
+
+#endif /* __ARM_PMU_H__ */
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index e7ccf7e..286a276 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_CPU_XSCALE)	+= xscale-cp0.o
 obj-$(CONFIG_CPU_XSC3)		+= xscale-cp0.o
 obj-$(CONFIG_CPU_MOHAWK)	+= xscale-cp0.o
 obj-$(CONFIG_IWMMXT)		+= iwmmxt.o
+obj-$(CONFIG_CPU_HAS_PMU)	+= pmu.o
 AFLAGS_iwmmxt.o			:= -Wa,-mcpu=iwmmxt
 
 ifneq ($(CONFIG_ARCH_EBSA110),y)
diff --git a/arch/arm/kernel/pmu.c b/arch/arm/kernel/pmu.c
new file mode 100644
index 0000000..a2b1a26
--- /dev/null
+++ b/arch/arm/kernel/pmu.c
@@ -0,0 +1,32 @@
+/*
+ *  linux/arch/arm/kernel/pmu.c
+ *
+ *  Copyright (C) 2009 picoChip Designs Ltd, Jamie Iles
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/semaphore.h>
+
+#include <asm/pmu.h>
+
+static DECLARE_MUTEX(pmu_mutex);
+
+int
+reserve_pmu(void)
+{
+	return down_trylock(&pmu_mutex) ? -EBUSY : 0;
+}
+EXPORT_SYMBOL_GPL(reserve_pmu);
+
+void
+release_pmu(void)
+{
+	up(&pmu_mutex);
+}
+EXPORT_SYMBOL_GPL(release_pmu);
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index dd4698c..60edbfe 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -398,6 +398,7 @@ config CPU_V6
 	select CPU_HAS_ASID if MMU
 	select CPU_COPY_V6 if MMU
 	select CPU_TLB_V6 if MMU
+	select CPU_HAS_PMU
 
 # ARMv6k
 config CPU_32v6K
@@ -536,6 +537,9 @@ config CPU_COPY_FA
 config CPU_COPY_V6
 	bool
 
+config CPU_HAS_PMU
+	bool
+
 # This selects the TLB model
 config CPU_TLB_V3
 	bool
-- 
1.6.5.4
