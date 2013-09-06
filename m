From: behanw@converseincode.com (behanw at converseincode.com)
Date: Fri,  6 Sep 2013 17:28:07 -0400
Subject: [PATCH 1/5] arm: LLVMLinux: Add current_stack_pointer macro for ARM
In-Reply-To: <1378502899-1241-1-git-send-email-behanw@converseincode.com>
References: <1378502899-1241-1-git-send-email-behanw@converseincode.com>
Message-ID: <1378502899-1241-2-git-send-email-behanw@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Behan Webster <behanw@converseincode.com>

A macro to get the current stack pointer which allows for a single place in
which to do so with ASM. Before this named registers (a gcc extension) was used
to get the stack pointer. Using ASM is a more portable way of getting the stack
pointer which works with both gcc and clang.  This macro is of the same name
used in the X86 arch.

Author: Behan Webster <behanw@converseincode.com>
Signed-off-by: Behan Webster <behanw@converseincode.com>
Reviewed-by: Jan-Simon M?ller <dl9pf@gmx.de>
---
 arch/arm/include/asm/thread_info.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index df5e13d..94283f8 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -100,6 +100,15 @@ struct thread_info {
 #define init_stack		(init_thread_union.stack)
 
 /*
+ * how to get the current stack pointer from C
+ */
+#define current_stack_pointer ({ \
+	unsigned long current_sp; \
+	asm ("mov %0, r13" : "=r" (current_sp)); \
+	current_sp; \
+})
+
+/*
  * how to get the thread information struct from C
  */
 static inline struct thread_info *current_thread_info(void) __attribute_const__;
-- 
1.8.1.2
