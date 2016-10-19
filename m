From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 19 Oct 2016 20:10:27 +0100
Subject: [PATCH 03/10] arm64: factor out current_stack_pointer
In-Reply-To: <1476904234-9511-1-git-send-email-mark.rutland@arm.com>
References: <1476904234-9511-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1476904234-9511-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We define current_stack_pointer in <asm/thread_info.h>, though other
files and header relying upon it do not have this necessary include, and
are thus fragile to changes in the header soup.

Subsequent patches will affect the header soup such that directly
including <asm/thread_info.h> may result in a circular header include in
some of these cases, so we can't simply include <asm/thread_info.h>.

Instead, factor current_thread_info into its own header, and have all
existing users include this explicitly.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/percpu.h        | 2 ++
 arch/arm64/include/asm/perf_event.h    | 2 ++
 arch/arm64/include/asm/stack_pointer.h | 9 +++++++++
 arch/arm64/include/asm/thread_info.h   | 6 +-----
 arch/arm64/kernel/return_address.c     | 1 +
 arch/arm64/kernel/stacktrace.c         | 1 +
 arch/arm64/kernel/traps.c              | 1 +
 7 files changed, 17 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/include/asm/stack_pointer.h

diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index 2fee2f5..2127a41 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -16,6 +16,8 @@
 #ifndef __ASM_PERCPU_H
 #define __ASM_PERCPU_H
 
+#include <asm/stack_pointer.h>
+
 static inline void set_my_cpu_offset(unsigned long off)
 {
 	asm volatile("msr tpidr_el1, %0" :: "r" (off) : "memory");
diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index 2065f46..9eee2be 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -17,6 +17,8 @@
 #ifndef __ASM_PERF_EVENT_H
 #define __ASM_PERF_EVENT_H
 
+#include <asm/stack_pointer.h>
+
 #define	ARMV8_PMU_MAX_COUNTERS	32
 #define	ARMV8_PMU_COUNTER_MASK	(ARMV8_PMU_MAX_COUNTERS - 1)
 
diff --git a/arch/arm64/include/asm/stack_pointer.h b/arch/arm64/include/asm/stack_pointer.h
new file mode 100644
index 0000000..ffcdf74
--- /dev/null
+++ b/arch/arm64/include/asm/stack_pointer.h
@@ -0,0 +1,9 @@
+#ifndef __ASM_STACK_POINTER_H
+#define __ASM_STACK_POINTER_H
+
+/*
+ * how to get the current stack pointer from C
+ */
+register unsigned long current_stack_pointer asm ("sp");
+
+#endif /* __ASM_STACK_POINTER_H */
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 76a9559..3a4f85d 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -36,6 +36,7 @@
 
 struct task_struct;
 
+#include <asm/stack_pointer.h>
 #include <asm/types.h>
 
 typedef unsigned long mm_segment_t;
@@ -62,11 +63,6 @@ struct thread_info {
 #define init_stack		(init_thread_union.stack)
 
 /*
- * how to get the current stack pointer from C
- */
-register unsigned long current_stack_pointer asm ("sp");
-
-/*
  * how to get the thread information struct from C
  */
 static inline struct thread_info *current_thread_info(void) __attribute_const__;
diff --git a/arch/arm64/kernel/return_address.c b/arch/arm64/kernel/return_address.c
index 1718706..12a87f2 100644
--- a/arch/arm64/kernel/return_address.c
+++ b/arch/arm64/kernel/return_address.c
@@ -12,6 +12,7 @@
 #include <linux/export.h>
 #include <linux/ftrace.h>
 
+#include <asm/stack_pointer.h>
 #include <asm/stacktrace.h>
 
 struct return_address_data {
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index c2efddf..5b80068 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -22,6 +22,7 @@
 #include <linux/stacktrace.h>
 
 #include <asm/irq.h>
+#include <asm/stack_pointer.h>
 #include <asm/stacktrace.h>
 
 /*
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 5ff020f..32d4bdb 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -38,6 +38,7 @@
 #include <asm/esr.h>
 #include <asm/insn.h>
 #include <asm/traps.h>
+#include <asm/stack_pointer.h>
 #include <asm/stacktrace.h>
 #include <asm/exception.h>
 #include <asm/system_misc.h>
-- 
1.9.1
