From: zsm@chromium.org (Zubin Mithra)
Date: Thu, 15 Mar 2018 17:08:57 +0000
Subject: [RFC 1/3] arm: factor out current_stack_pointer
In-Reply-To: <20180315170859.93893-1-zsm@chromium.org>
References: <20180315170859.93893-1-zsm@chromium.org>
Message-ID: <20180315170859.93893-2-zsm@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Multiple header files that rely on current_stack_pointer do not have the
necessary include <asm/thread_info.h>, and are thus fragile to changes
in the header soup.

Subsequent patches will affect the header soup such that including
<asm/thread_info.h> will result in a circular header include. Factor
current_thread_info into its own header and have all the users include
this header explicitely.

Signed-off-by: Zubin Mithra <zsm@chromium.org>
---
 arch/arm/include/asm/percpu.h        | 2 ++
 arch/arm/include/asm/stack_pointer.h | 9 +++++++++
 arch/arm/include/asm/thread_info.h   | 6 +-----
 arch/arm/kernel/return_address.c     | 1 +
 arch/arm/kernel/stacktrace.c         | 1 +
 arch/arm/kernel/unwind.c             | 1 +
 6 files changed, 15 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/include/asm/stack_pointer.h

diff --git a/arch/arm/include/asm/percpu.h b/arch/arm/include/asm/percpu.h
index a89b4076cde4..6a19e634d0cf 100644
--- a/arch/arm/include/asm/percpu.h
+++ b/arch/arm/include/asm/percpu.h
@@ -16,6 +16,8 @@
 #ifndef _ASM_ARM_PERCPU_H_
 #define _ASM_ARM_PERCPU_H_
 
+#include <asm/stack_pointer.h>
+
 /*
  * Same as asm-generic/percpu.h, except that we store the per cpu offset
  * in the TPIDRPRW. TPIDRPRW only exists on V6K and V7
diff --git a/arch/arm/include/asm/stack_pointer.h b/arch/arm/include/asm/stack_pointer.h
new file mode 100644
index 000000000000..5a6a8c6d9208
--- /dev/null
+++ b/arch/arm/include/asm/stack_pointer.h
@@ -0,0 +1,9 @@
+#ifndef __ASM_STACK_POINTER_H
+#define __ASM_STACK_POINTER_H
+
+/*
+ * how to get the current stack pointer in C
+ */
+register unsigned long current_stack_pointer asm ("sp");
+
+#endif
diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index e71cc35de163..56317024d221 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -25,6 +25,7 @@
 struct task_struct;
 
 #include <asm/types.h>
+#include <asm/stack_pointer.h>
 
 typedef unsigned long mm_segment_t;
 
@@ -75,11 +76,6 @@ struct thread_info {
 	.addr_limit	= KERNEL_DS,					\
 }
 
-/*
- * how to get the current stack pointer in C
- */
-register unsigned long current_stack_pointer asm ("sp");
-
 /*
  * how to get the thread information struct from C
  */
diff --git a/arch/arm/kernel/return_address.c b/arch/arm/kernel/return_address.c
index 36ed35073289..d76e64250816 100644
--- a/arch/arm/kernel/return_address.c
+++ b/arch/arm/kernel/return_address.c
@@ -14,6 +14,7 @@
 #if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND)
 #include <linux/sched.h>
 
+#include <asm/stack_pointer.h>
 #include <asm/stacktrace.h>
 
 struct return_address_data {
diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index a56e7c856ab5..d519b8e0797f 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -4,6 +4,7 @@
 #include <linux/stacktrace.h>
 
 #include <asm/sections.h>
+#include <asm/stack_pointer.h>
 #include <asm/stacktrace.h>
 #include <asm/traps.h>
 
diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index 0bee233fef9a..860f8ac187e0 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -45,6 +45,7 @@
 #include <linux/spinlock.h>
 #include <linux/list.h>
 
+#include <asm/stack_pointer.h>
 #include <asm/stacktrace.h>
 #include <asm/traps.h>
 #include <asm/unwind.h>
-- 
2.16.2.804.g6dcf76e118-goog
