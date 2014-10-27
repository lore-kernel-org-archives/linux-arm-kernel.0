From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 27 Oct 2014 12:06:31 +0000
Subject: [PATCHv2 1/9] arm: perf: factor out callchain code
In-Reply-To: <1414411599-1938-1-git-send-email-mark.rutland@arm.com>
References: <1414411599-1938-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1414411599-1938-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM callchain handling code is currently bundled with the ARM PMU
management code, despite the two having no dependency on each other.
This bundling has the unfortunate property of making callchain handling
depend on CONFIG_HW_PERF_EVENTS, even though the callchain handling
could be applied to software events in the absence of PMU hardware
support.

This patch separates the two, placing the callchain handling in
perf_callchain.c and making it depend on CONFIG_PERF_EVENTS rather than
CONFIG_HW_PERF_EVENTS, enabling callchain recording on kernels built
without hardware perf event support.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/perf_event.h |   2 +-
 arch/arm/kernel/Makefile          |   2 +-
 arch/arm/kernel/perf_callchain.c  | 137 ++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/perf_event.c      | 132 +-----------------------------------
 4 files changed, 140 insertions(+), 133 deletions(-)
 create mode 100644 arch/arm/kernel/perf_callchain.c

diff --git a/arch/arm/include/asm/perf_event.h b/arch/arm/include/asm/perf_event.h
index c3a8369..d9cf138 100644
--- a/arch/arm/include/asm/perf_event.h
+++ b/arch/arm/include/asm/perf_event.h
@@ -12,7 +12,7 @@
 #ifndef __ARM_PERF_EVENT_H__
 #define __ARM_PERF_EVENT_H__
 
-#ifdef CONFIG_HW_PERF_EVENTS
+#ifdef CONFIG_PERF_EVENTS
 struct pt_regs;
 extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
 extern unsigned long perf_misc_flags(struct pt_regs *regs);
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 38ddd9f..8dcbed5 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -82,7 +82,7 @@ obj-$(CONFIG_CPU_MOHAWK)	+= xscale-cp0.o
 obj-$(CONFIG_CPU_PJ4)		+= pj4-cp0.o
 obj-$(CONFIG_CPU_PJ4B)		+= pj4-cp0.o
 obj-$(CONFIG_IWMMXT)		+= iwmmxt.o
-obj-$(CONFIG_PERF_EVENTS)	+= perf_regs.o
+obj-$(CONFIG_PERF_EVENTS)	+= perf_regs.o perf_callchain.o
 obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o perf_event_cpu.o
 AFLAGS_iwmmxt.o			:= -Wa,-mcpu=iwmmxt
 obj-$(CONFIG_ARM_CPU_TOPOLOGY)  += topology.o
diff --git a/arch/arm/kernel/perf_callchain.c b/arch/arm/kernel/perf_callchain.c
new file mode 100644
index 0000000..ccadfc3
--- /dev/null
+++ b/arch/arm/kernel/perf_callchain.c
@@ -0,0 +1,137 @@
+/*
+ * ARM callchain support
+ *
+ * Copyright (C) 2009 picoChip Designs, Ltd., Jamie Iles
+ * Copyright (C) 2010 ARM Ltd., Will Deacon <will.deacon@arm.com>
+ *
+ * This code is based on the ARM OProfile backtrace code.
+ */
+#include <linux/perf_event.h>
+#include <linux/uaccess.h>
+
+#include <asm/stacktrace.h>
+
+/*
+ * The registers we're interested in are at the end of the variable
+ * length saved register structure. The fp points at the end of this
+ * structure so the address of this struct is:
+ * (struct frame_tail *)(xxx->fp)-1
+ *
+ * This code has been adapted from the ARM OProfile support.
+ */
+struct frame_tail {
+	struct frame_tail __user *fp;
+	unsigned long sp;
+	unsigned long lr;
+} __attribute__((packed));
+
+/*
+ * Get the return address for a single stackframe and return a pointer to the
+ * next frame tail.
+ */
+static struct frame_tail __user *
+user_backtrace(struct frame_tail __user *tail,
+	       struct perf_callchain_entry *entry)
+{
+	struct frame_tail buftail;
+	unsigned long err;
+
+	if (!access_ok(VERIFY_READ, tail, sizeof(buftail)))
+		return NULL;
+
+	pagefault_disable();
+	err = __copy_from_user_inatomic(&buftail, tail, sizeof(buftail));
+	pagefault_enable();
+
+	if (err)
+		return NULL;
+
+	perf_callchain_store(entry, buftail.lr);
+
+	/*
+	 * Frame pointers should strictly progress back up the stack
+	 * (towards higher addresses).
+	 */
+	if (tail + 1 >= buftail.fp)
+		return NULL;
+
+	return buftail.fp - 1;
+}
+
+void
+perf_callchain_user(struct perf_callchain_entry *entry, struct pt_regs *regs)
+{
+	struct frame_tail __user *tail;
+
+	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
+		/* We don't support guest os callchain now */
+		return;
+	}
+
+	perf_callchain_store(entry, regs->ARM_pc);
+
+	if (!current->mm)
+		return;
+
+	tail = (struct frame_tail __user *)regs->ARM_fp - 1;
+
+	while ((entry->nr < PERF_MAX_STACK_DEPTH) &&
+	       tail && !((unsigned long)tail & 0x3))
+		tail = user_backtrace(tail, entry);
+}
+
+/*
+ * Gets called by walk_stackframe() for every stackframe. This will be called
+ * whist unwinding the stackframe and is like a subroutine return so we use
+ * the PC.
+ */
+static int
+callchain_trace(struct stackframe *fr,
+		void *data)
+{
+	struct perf_callchain_entry *entry = data;
+	perf_callchain_store(entry, fr->pc);
+	return 0;
+}
+
+void
+perf_callchain_kernel(struct perf_callchain_entry *entry, struct pt_regs *regs)
+{
+	struct stackframe fr;
+
+	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
+		/* We don't support guest os callchain now */
+		return;
+	}
+
+	arm_get_current_stackframe(regs, &fr);
+	walk_stackframe(&fr, callchain_trace, entry);
+}
+
+unsigned long perf_instruction_pointer(struct pt_regs *regs)
+{
+	if (perf_guest_cbs && perf_guest_cbs->is_in_guest())
+		return perf_guest_cbs->get_guest_ip();
+
+	return instruction_pointer(regs);
+}
+
+unsigned long perf_misc_flags(struct pt_regs *regs)
+{
+	int misc = 0;
+
+	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
+		if (perf_guest_cbs->is_user_mode())
+			misc |= PERF_RECORD_MISC_GUEST_USER;
+		else
+			misc |= PERF_RECORD_MISC_GUEST_KERNEL;
+	} else {
+		if (user_mode(regs))
+			misc |= PERF_RECORD_MISC_USER;
+		else
+			misc |= PERF_RECORD_MISC_KERNEL;
+	}
+
+	return misc;
+}
+
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 266cba4..ae96b98 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -7,21 +7,18 @@
  * Copyright (C) 2010 ARM Ltd., Will Deacon <will.deacon@arm.com>
  *
  * This code is based on the sparc64 perf event code, which is in turn based
- * on the x86 code. Callchain code is based on the ARM OProfile backtrace
- * code.
+ * on the x86 code.
  */
 #define pr_fmt(fmt) "hw perfevents: " fmt
 
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-#include <linux/uaccess.h>
 #include <linux/irq.h>
 #include <linux/irqdesc.h>
 
 #include <asm/irq_regs.h>
 #include <asm/pmu.h>
-#include <asm/stacktrace.h>
 
 static int
 armpmu_map_cache_event(const unsigned (*cache_map)
@@ -533,130 +530,3 @@ int armpmu_register(struct arm_pmu *armpmu, int type)
 	return perf_pmu_register(&armpmu->pmu, armpmu->name, type);
 }
 
-/*
- * Callchain handling code.
- */
-
-/*
- * The registers we're interested in are at the end of the variable
- * length saved register structure. The fp points at the end of this
- * structure so the address of this struct is:
- * (struct frame_tail *)(xxx->fp)-1
- *
- * This code has been adapted from the ARM OProfile support.
- */
-struct frame_tail {
-	struct frame_tail __user *fp;
-	unsigned long sp;
-	unsigned long lr;
-} __attribute__((packed));
-
-/*
- * Get the return address for a single stackframe and return a pointer to the
- * next frame tail.
- */
-static struct frame_tail __user *
-user_backtrace(struct frame_tail __user *tail,
-	       struct perf_callchain_entry *entry)
-{
-	struct frame_tail buftail;
-	unsigned long err;
-
-	if (!access_ok(VERIFY_READ, tail, sizeof(buftail)))
-		return NULL;
-
-	pagefault_disable();
-	err = __copy_from_user_inatomic(&buftail, tail, sizeof(buftail));
-	pagefault_enable();
-
-	if (err)
-		return NULL;
-
-	perf_callchain_store(entry, buftail.lr);
-
-	/*
-	 * Frame pointers should strictly progress back up the stack
-	 * (towards higher addresses).
-	 */
-	if (tail + 1 >= buftail.fp)
-		return NULL;
-
-	return buftail.fp - 1;
-}
-
-void
-perf_callchain_user(struct perf_callchain_entry *entry, struct pt_regs *regs)
-{
-	struct frame_tail __user *tail;
-
-	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
-		/* We don't support guest os callchain now */
-		return;
-	}
-
-	perf_callchain_store(entry, regs->ARM_pc);
-
-	if (!current->mm)
-		return;
-
-	tail = (struct frame_tail __user *)regs->ARM_fp - 1;
-
-	while ((entry->nr < PERF_MAX_STACK_DEPTH) &&
-	       tail && !((unsigned long)tail & 0x3))
-		tail = user_backtrace(tail, entry);
-}
-
-/*
- * Gets called by walk_stackframe() for every stackframe. This will be called
- * whist unwinding the stackframe and is like a subroutine return so we use
- * the PC.
- */
-static int
-callchain_trace(struct stackframe *fr,
-		void *data)
-{
-	struct perf_callchain_entry *entry = data;
-	perf_callchain_store(entry, fr->pc);
-	return 0;
-}
-
-void
-perf_callchain_kernel(struct perf_callchain_entry *entry, struct pt_regs *regs)
-{
-	struct stackframe fr;
-
-	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
-		/* We don't support guest os callchain now */
-		return;
-	}
-
-	arm_get_current_stackframe(regs, &fr);
-	walk_stackframe(&fr, callchain_trace, entry);
-}
-
-unsigned long perf_instruction_pointer(struct pt_regs *regs)
-{
-	if (perf_guest_cbs && perf_guest_cbs->is_in_guest())
-		return perf_guest_cbs->get_guest_ip();
-
-	return instruction_pointer(regs);
-}
-
-unsigned long perf_misc_flags(struct pt_regs *regs)
-{
-	int misc = 0;
-
-	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
-		if (perf_guest_cbs->is_user_mode())
-			misc |= PERF_RECORD_MISC_GUEST_USER;
-		else
-			misc |= PERF_RECORD_MISC_GUEST_KERNEL;
-	} else {
-		if (user_mode(regs))
-			misc |= PERF_RECORD_MISC_USER;
-		else
-			misc |= PERF_RECORD_MISC_KERNEL;
-	}
-
-	return misc;
-}
-- 
1.9.1
