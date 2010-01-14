From: jamie.iles@picochip.com (Jamie Iles)
Date: Thu, 14 Jan 2010 12:14:15 +0000
Subject: [PATCH 4/5] arm: enable support for software perf events
In-Reply-To: <1263471256-3739-4-git-send-email-jamie.iles@picochip.com>
References: <1263471256-3739-1-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-2-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-3-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-4-git-send-email-jamie.iles@picochip.com>
Message-ID: <1263471256-3739-5-git-send-email-jamie.iles@picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The perf events subsystem allows counting of both hardware and
software events. This patch implements the bare minimum for software
performance events.

Signed-off-by: Jamie Iles <jamie.iles@picochip.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>
---
 arch/arm/Kconfig                  |    2 ++
 arch/arm/include/asm/perf_event.h |   31 +++++++++++++++++++++++++++++++
 arch/arm/mm/fault.c               |    7 +++++++
 3 files changed, 40 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/perf_event.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 293a879..72646b2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -21,6 +21,8 @@ config ARM
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZO
 	select GENERIC_ATOMIC64
+	select HAVE_PERF_EVENTS
+	select PERF_USE_VMALLOC
 	help
 	  The ARM series is a line of low-power-consumption RISC chip designs
 	  licensed by ARM Ltd and targeted at embedded applications and
diff --git a/arch/arm/include/asm/perf_event.h b/arch/arm/include/asm/perf_event.h
new file mode 100644
index 0000000..49e3049
--- /dev/null
+++ b/arch/arm/include/asm/perf_event.h
@@ -0,0 +1,31 @@
+/*
+ *  linux/arch/arm/include/asm/perf_event.h
+ *
+ *  Copyright (C) 2009 picoChip Designs Ltd, Jamie Iles
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __ARM_PERF_EVENT_H__
+#define __ARM_PERF_EVENT_H__
+
+/*
+ * NOP: on *most* (read: all supported) ARM platforms, the performance
+ * counter interrupts are regular interrupts and not an NMI. This
+ * means that when we receive the interrupt we can call
+ * perf_event_do_pending() that handles all of the work with
+ * interrupts enabled.
+ */
+static inline void
+set_perf_event_pending(void)
+{
+}
+
+/* ARM performance counters start from 1 (in the cp15 accesses) so use the
+ * same indexes here for consistency. */
+#define PERF_EVENT_INDEX_OFFSET 1
+
+#endif /* __ARM_PERF_EVENT_H__ */
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 10e0680..9d40c34 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -18,6 +18,7 @@
 #include <linux/page-flags.h>
 #include <linux/sched.h>
 #include <linux/highmem.h>
+#include <linux/perf_event.h>
 
 #include <asm/system.h>
 #include <asm/pgtable.h>
@@ -302,6 +303,12 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	fault = __do_page_fault(mm, addr, fsr, tsk);
 	up_read(&mm->mmap_sem);
 
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, 0, regs, addr);
+	if (fault & VM_FAULT_MAJOR)
+		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, 0, regs, addr);
+	else if (fault & VM_FAULT_MINOR)
+		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, 0, regs, addr);
+
 	/*
 	 * Handle the "normal" case first - VM_FAULT_MAJOR / VM_FAULT_MINOR
 	 */
-- 
1.6.5.4
