From: jamie.iles@picochip.com (Jamie Iles)
Date: Mon, 14 Dec 2009 14:04:40 +0000
Subject: [PATCH 4/5] arm: enable support for software perf events
In-Reply-To: <1260799481-29951-4-git-send-email-jamie.iles@picochip.com>
References: <1260799481-29951-1-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-2-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-3-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-4-git-send-email-jamie.iles@picochip.com>
Message-ID: <1260799481-29951-5-git-send-email-jamie.iles@picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The perf events subsystem allows counting of both hardware and
software events. This patch implements the bare minimum for software
performance events.

Signed-off-by: Jamie Iles <jamie.iles@picochip.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>
---
 arch/arm/Kconfig                  |    2 +
 arch/arm/include/asm/perf_event.h |   38 +++++++++++++++++++++++++++++++++++++
 arch/arm/mm/fault.c               |    7 ++++++
 3 files changed, 47 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/perf_event.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b13cb85..dc4eb0f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -19,6 +19,8 @@ config ARM
 	select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
 	select HAVE_GENERIC_DMA_COHERENT
 	select GENERIC_ATOMIC64
+	select HAVE_PERF_EVENTS
+	select PERF_USE_VMALLOC
 	help
 	  The ARM series is a line of low-power-consumption RISC chip designs
 	  licensed by ARM Ltd and targeted at embedded applications and
diff --git a/arch/arm/include/asm/perf_event.h b/arch/arm/include/asm/perf_event.h
new file mode 100644
index 0000000..32a66ac
--- /dev/null
+++ b/arch/arm/include/asm/perf_event.h
@@ -0,0 +1,38 @@
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
+/* Get the PC. Make sure that we have a 64bit value with the upper 32 cleared.
+ */
+#define perf_instruction_pointer(_regs) \
+	((u64)instruction_pointer(regs) & 0xFFFFFFFFLU)
+#define perf_misc_flags(regs)   (user_mode(regs) ? PERF_RECORD_MISC_USER : \
+                                 PERF_RECORD_MISC_KERNEL)
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
