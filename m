From: mark.rutland@arm.com (Mark Rutland)
Date: Mon,  6 Jul 2015 12:23:54 +0100
Subject: [PATCHv3 2/9] arm64: perf: factor out callchain code
In-Reply-To: <1436181842-19402-1-git-send-email-mark.rutland@arm.com>
References: <1436181842-19402-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1436181842-19402-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We currently bundle the callchain handling code with the PMU code,
despite the fact the two are distinct, and the former can be useful even
in the absence of the latter.

Follow the example of arch/arm and factor the callchain handling into
its own file dependent on CONFIG_PERF_EVENTS rather than
CONFIG_HW_PERF_EVENTS.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/perf_event.h |   2 +-
 arch/arm64/kernel/Makefile          |   2 +-
 arch/arm64/kernel/perf_callchain.c  | 196 ++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/perf_event.c      | 178 --------------------------------
 4 files changed, 198 insertions(+), 180 deletions(-)
 create mode 100644 arch/arm64/kernel/perf_callchain.c

diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index 6471773..7bd3cdb 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -17,7 +17,7 @@
 #ifndef __ASM_PERF_EVENT_H
 #define __ASM_PERF_EVENT_H
 
-#ifdef CONFIG_HW_PERF_EVENTS
+#ifdef CONFIG_PERF_EVENTS
 struct pt_regs;
 extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
 extern unsigned long perf_misc_flags(struct pt_regs *regs);
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 426d076..e89063e 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -25,7 +25,7 @@ arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
 arm64-obj-$(CONFIG_SMP)			+= smp.o smp_spin_table.o topology.o
-arm64-obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o
+arm64-obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o perf_callchain.o
 arm64-obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
 arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 arm64-obj-$(CONFIG_CPU_PM)		+= sleep.o suspend.o
diff --git a/arch/arm64/kernel/perf_callchain.c b/arch/arm64/kernel/perf_callchain.c
new file mode 100644
index 0000000..3aa7483
--- /dev/null
+++ b/arch/arm64/kernel/perf_callchain.c
@@ -0,0 +1,196 @@
+/*
+ * arm64 callchain support
+ *
+ * Copyright (C) 2015 ARM Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/perf_event.h>
+#include <linux/uaccess.h>
+
+#include <asm/stacktrace.h>
+
+struct frame_tail {
+	struct frame_tail	__user *fp;
+	unsigned long		lr;
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
+	/* Also check accessibility of one struct frame_tail beyond */
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
+	if (tail >= buftail.fp)
+		return NULL;
+
+	return buftail.fp;
+}
+
+#ifdef CONFIG_COMPAT
+/*
+ * The registers we're interested in are at the end of the variable
+ * length saved register structure. The fp points at the end of this
+ * structure so the address of this struct is:
+ * (struct compat_frame_tail *)(xxx->fp)-1
+ *
+ * This code has been adapted from the ARM OProfile support.
+ */
+struct compat_frame_tail {
+	compat_uptr_t	fp; /* a (struct compat_frame_tail *) in compat mode */
+	u32		sp;
+	u32		lr;
+} __attribute__((packed));
+
+static struct compat_frame_tail __user *
+compat_user_backtrace(struct compat_frame_tail __user *tail,
+		      struct perf_callchain_entry *entry)
+{
+	struct compat_frame_tail buftail;
+	unsigned long err;
+
+	/* Also check accessibility of one struct frame_tail beyond */
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
+	if (tail + 1 >= (struct compat_frame_tail __user *)
+			compat_ptr(buftail.fp))
+		return NULL;
+
+	return (struct compat_frame_tail __user *)compat_ptr(buftail.fp) - 1;
+}
+#endif /* CONFIG_COMPAT */
+
+void perf_callchain_user(struct perf_callchain_entry *entry,
+			 struct pt_regs *regs)
+{
+	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
+		/* We don't support guest os callchain now */
+		return;
+	}
+
+	perf_callchain_store(entry, regs->pc);
+
+	if (!compat_user_mode(regs)) {
+		/* AARCH64 mode */
+		struct frame_tail __user *tail;
+
+		tail = (struct frame_tail __user *)regs->regs[29];
+
+		while (entry->nr < PERF_MAX_STACK_DEPTH &&
+		       tail && !((unsigned long)tail & 0xf))
+			tail = user_backtrace(tail, entry);
+	} else {
+#ifdef CONFIG_COMPAT
+		/* AARCH32 compat mode */
+		struct compat_frame_tail __user *tail;
+
+		tail = (struct compat_frame_tail __user *)regs->compat_fp - 1;
+
+		while ((entry->nr < PERF_MAX_STACK_DEPTH) &&
+			tail && !((unsigned long)tail & 0x3))
+			tail = compat_user_backtrace(tail, entry);
+#endif
+	}
+}
+
+/*
+ * Gets called by walk_stackframe() for every stackframe. This will be called
+ * whist unwinding the stackframe and is like a subroutine return so we use
+ * the PC.
+ */
+static int callchain_trace(struct stackframe *frame, void *data)
+{
+	struct perf_callchain_entry *entry = data;
+	perf_callchain_store(entry, frame->pc);
+	return 0;
+}
+
+void perf_callchain_kernel(struct perf_callchain_entry *entry,
+			   struct pt_regs *regs)
+{
+	struct stackframe frame;
+
+	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
+		/* We don't support guest os callchain now */
+		return;
+	}
+
+	frame.fp = regs->regs[29];
+	frame.sp = regs->sp;
+	frame.pc = regs->pc;
+
+	walk_stackframe(&frame, callchain_trace, entry);
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
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index b31e9a4..c886915 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -36,7 +36,6 @@
 #include <asm/irq.h>
 #include <asm/irq_regs.h>
 #include <asm/pmu.h>
-#include <asm/stacktrace.h>
 
 /*
  * ARMv8 supports a maximum of 32 events.
@@ -1415,180 +1414,3 @@ static int __init init_hw_perf_events(void)
 }
 early_initcall(init_hw_perf_events);
 
-/*
- * Callchain handling code.
- */
-struct frame_tail {
-	struct frame_tail	__user *fp;
-	unsigned long		lr;
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
-	/* Also check accessibility of one struct frame_tail beyond */
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
-	if (tail >= buftail.fp)
-		return NULL;
-
-	return buftail.fp;
-}
-
-#ifdef CONFIG_COMPAT
-/*
- * The registers we're interested in are at the end of the variable
- * length saved register structure. The fp points at the end of this
- * structure so the address of this struct is:
- * (struct compat_frame_tail *)(xxx->fp)-1
- *
- * This code has been adapted from the ARM OProfile support.
- */
-struct compat_frame_tail {
-	compat_uptr_t	fp; /* a (struct compat_frame_tail *) in compat mode */
-	u32		sp;
-	u32		lr;
-} __attribute__((packed));
-
-static struct compat_frame_tail __user *
-compat_user_backtrace(struct compat_frame_tail __user *tail,
-		      struct perf_callchain_entry *entry)
-{
-	struct compat_frame_tail buftail;
-	unsigned long err;
-
-	/* Also check accessibility of one struct frame_tail beyond */
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
-	if (tail + 1 >= (struct compat_frame_tail __user *)
-			compat_ptr(buftail.fp))
-		return NULL;
-
-	return (struct compat_frame_tail __user *)compat_ptr(buftail.fp) - 1;
-}
-#endif /* CONFIG_COMPAT */
-
-void perf_callchain_user(struct perf_callchain_entry *entry,
-			 struct pt_regs *regs)
-{
-	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
-		/* We don't support guest os callchain now */
-		return;
-	}
-
-	perf_callchain_store(entry, regs->pc);
-
-	if (!compat_user_mode(regs)) {
-		/* AARCH64 mode */
-		struct frame_tail __user *tail;
-
-		tail = (struct frame_tail __user *)regs->regs[29];
-
-		while (entry->nr < PERF_MAX_STACK_DEPTH &&
-		       tail && !((unsigned long)tail & 0xf))
-			tail = user_backtrace(tail, entry);
-	} else {
-#ifdef CONFIG_COMPAT
-		/* AARCH32 compat mode */
-		struct compat_frame_tail __user *tail;
-
-		tail = (struct compat_frame_tail __user *)regs->compat_fp - 1;
-
-		while ((entry->nr < PERF_MAX_STACK_DEPTH) &&
-			tail && !((unsigned long)tail & 0x3))
-			tail = compat_user_backtrace(tail, entry);
-#endif
-	}
-}
-
-/*
- * Gets called by walk_stackframe() for every stackframe. This will be called
- * whist unwinding the stackframe and is like a subroutine return so we use
- * the PC.
- */
-static int callchain_trace(struct stackframe *frame, void *data)
-{
-	struct perf_callchain_entry *entry = data;
-	perf_callchain_store(entry, frame->pc);
-	return 0;
-}
-
-void perf_callchain_kernel(struct perf_callchain_entry *entry,
-			   struct pt_regs *regs)
-{
-	struct stackframe frame;
-
-	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
-		/* We don't support guest os callchain now */
-		return;
-	}
-
-	frame.fp = regs->regs[29];
-	frame.sp = regs->sp;
-	frame.pc = regs->pc;
-
-	walk_stackframe(&frame, callchain_trace, entry);
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
