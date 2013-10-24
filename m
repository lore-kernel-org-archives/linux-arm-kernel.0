From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 24 Oct 2013 16:08:05 +0900
Subject: [PATCH v2 3/6] arm64: ftrace: Add CALLER_ADDRx macros
In-Reply-To: <1382598488-13511-1-git-send-email-takahiro.akashi@linaro.org>
References: <1382598488-13511-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1382598488-13511-4-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These macro's unwind call stacks and return the specified caller address.
They are used for several tracers like irqsoff and preemptoff.
Strange to say, however, they are refered even without FTRACE.

Please not that this implementation assumes that we have frame pointers.
(which means kernel should be compiled with -fno-omit-frame-pointer.)

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/include/asm/ftrace.h    |   14 +++++++++
 arch/arm64/kernel/Makefile         |    3 +-
 arch/arm64/kernel/return_address.c |   55 ++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kernel/return_address.c

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 37a379d..4c6ac03 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -37,4 +37,18 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 #endif /* __ASSEMBLY__ */
 #endif /* CONFIG_FUNCTION_TRACER */
 
+#ifndef __ASSEMBLY__
+#define HAVE_ARCH_CALLER_ADDR
+
+extern void *return_address(unsigned int);
+
+#define CALLER_ADDR0 ((unsigned long)__builtin_return_address(0))
+#define CALLER_ADDR1 ((unsigned long)return_address(1))
+#define CALLER_ADDR2 ((unsigned long)return_address(2))
+#define CALLER_ADDR3 ((unsigned long)return_address(3))
+#define CALLER_ADDR4 ((unsigned long)return_address(4))
+#define CALLER_ADDR5 ((unsigned long)return_address(5))
+#define CALLER_ADDR6 ((unsigned long)return_address(6))
+#endif /* ifndef __ASSEMBLY__ */
+
 #endif /* __ASM_FTRACE_H */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 92429e4..94d1876 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -9,12 +9,13 @@ ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_ftrace.o = -pg
 CFLAGS_REMOVE_insn.o = -pg
 endif
+CFLAGS_REMOVE_return_address.o = -pg
 
 # Object file lists.
 arm64-obj-y		:= cputable.o debug-monitors.o entry.o irq.o fpsimd.o	\
 			   entry-fpsimd.o process.o ptrace.o setup.o signal.o	\
 			   sys.o stacktrace.o time.o traps.o io.o vdso.o	\
-			   hyp-stub.o psci.o insn.o
+			   hyp-stub.o psci.o insn.o return_address.o
 
 arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o
diff --git a/arch/arm64/kernel/return_address.c b/arch/arm64/kernel/return_address.c
new file mode 100644
index 0000000..89102a6
--- /dev/null
+++ b/arch/arm64/kernel/return_address.c
@@ -0,0 +1,55 @@
+/*
+ * arch/arm64/kernel/return_address.c
+ *
+ * Copyright (C) 2013 Linaro Limited
+ * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/export.h>
+#include <linux/ftrace.h>
+
+#include <asm/stacktrace.h>
+
+struct return_address_data {
+	unsigned int level;
+	void *addr;
+};
+
+static int save_return_addr(struct stackframe *frame, void *d)
+{
+	struct return_address_data *data = d;
+
+	if (!data->level) {
+		data->addr = (void *)frame->pc;
+		return 1;
+	} else {
+		--data->level;
+		return 0;
+	}
+}
+
+void *return_address(unsigned int level)
+{
+	struct return_address_data data;
+	struct stackframe frame;
+	register unsigned long current_sp asm ("sp");
+
+	data.level = level + 2;
+	data.addr = NULL;
+
+	frame.fp = (unsigned long)__builtin_frame_address(0);
+	frame.sp = current_sp;
+	frame.pc = (unsigned long)return_address; /* dummy */
+
+	walk_stackframe(&frame, save_return_addr, &data);
+
+	if (!data.level)
+		return data.addr;
+	else
+		return NULL;
+}
+EXPORT_SYMBOL_GPL(return_address);
-- 
1.7.9.5
