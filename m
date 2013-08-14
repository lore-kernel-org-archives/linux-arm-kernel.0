From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Wed, 14 Aug 2013 00:08:54 -0700
Subject: [PATCH v2 1/1] ARM: signal: sigreturn_codes should be endian neutral
 to work in BE8
In-Reply-To: <1376464134-23029-1-git-send-email-victor.kamensky@linaro.org>
References: <1376464134-23029-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <1376464134-23029-2-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case of BE8 kernel data is in BE order whereas code stays in LE
order. Move sigreturn_codes to separate .S file and use proper
assembler mnemonics for these code snippets. In this case compiler
will take care of proper instructions byteswaps for BE8 case.
Change assumes that sufficiently Thumb-capable tools are used to
build kernel.

Problem was discovered during ltp testing of BE system: all rt_sig*
tests failed. Tested against the same tests in both BE and LE modes.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
---
 arch/arm/kernel/Makefile          |  3 +-
 arch/arm/kernel/signal.c          | 29 +++---------------
 arch/arm/kernel/sigreturn_codes.S | 64 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm/kernel/sigreturn_codes.S

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 86d10dd..0722155 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -17,7 +17,8 @@ CFLAGS_REMOVE_return_address.o = -pg
 
 obj-y		:= elf.o entry-common.o irq.o opcodes.o \
 		   process.o ptrace.o return_address.o \
-		   setup.o signal.o stacktrace.o sys_arm.o time.o traps.o
+		   setup.o signal.o sigreturn_codes.o \
+		   stacktrace.o sys_arm.o time.o traps.o
 
 obj-$(CONFIG_ATAGS)		+= atags_parse.o
 obj-$(CONFIG_ATAGS_PROC)	+= atags_proc.o
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index ab33042..cdcbf04 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -21,29 +21,8 @@
 #include <asm/unistd.h>
 #include <asm/vfp.h>
 
-/*
- * For ARM syscalls, we encode the syscall number into the instruction.
- */
-#define SWI_SYS_SIGRETURN	(0xef000000|(__NR_sigreturn)|(__NR_OABI_SYSCALL_BASE))
-#define SWI_SYS_RT_SIGRETURN	(0xef000000|(__NR_rt_sigreturn)|(__NR_OABI_SYSCALL_BASE))
-
-/*
- * With EABI, the syscall number has to be loaded into r7.
- */
-#define MOV_R7_NR_SIGRETURN	(0xe3a07000 | (__NR_sigreturn - __NR_SYSCALL_BASE))
-#define MOV_R7_NR_RT_SIGRETURN	(0xe3a07000 | (__NR_rt_sigreturn - __NR_SYSCALL_BASE))
-
-/*
- * For Thumb syscalls, we pass the syscall number via r7.  We therefore
- * need two 16-bit instructions.
- */
-#define SWI_THUMB_SIGRETURN	(0xdf00 << 16 | 0x2700 | (__NR_sigreturn - __NR_SYSCALL_BASE))
-#define SWI_THUMB_RT_SIGRETURN	(0xdf00 << 16 | 0x2700 | (__NR_rt_sigreturn - __NR_SYSCALL_BASE))
-
-static const unsigned long sigreturn_codes[7] = {
-	MOV_R7_NR_SIGRETURN,    SWI_SYS_SIGRETURN,    SWI_THUMB_SIGRETURN,
-	MOV_R7_NR_RT_SIGRETURN, SWI_SYS_RT_SIGRETURN, SWI_THUMB_RT_SIGRETURN,
-};
+extern const unsigned long sigreturn_codes[];
+extern const int sigreturn_codes_size;
 
 static unsigned long signal_return_offset;
 
@@ -639,10 +618,10 @@ struct page *get_signal_page(void)
 	 * Copy signal return handlers into the vector page, and
 	 * set sigreturn to be a pointer to these.
 	 */
-	memcpy(addr + offset, sigreturn_codes, sizeof(sigreturn_codes));
+	memcpy(addr + offset, sigreturn_codes, sigreturn_codes_size);
 
 	ptr = (unsigned long)addr + offset;
-	flush_icache_range(ptr, ptr + sizeof(sigreturn_codes));
+	flush_icache_range(ptr, ptr + sigreturn_codes_size);
 
 	return page;
 }
diff --git a/arch/arm/kernel/sigreturn_codes.S b/arch/arm/kernel/sigreturn_codes.S
new file mode 100644
index 0000000..3ac1540
--- /dev/null
+++ b/arch/arm/kernel/sigreturn_codes.S
@@ -0,0 +1,64 @@
+/*
+ * sigreturn_codes.S - code sinpets for sigreturn syscalls
+ *
+ * Created by:	Victor Kamensky, 2013-08-13
+ * Copyright:	(C) 2013  Linaro Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <asm/unistd.h>
+
+/*
+ * For ARM syscalls, we encode the syscall number into the instruction.
+ * With EABI, the syscall number has to be loaded into r7. As result
+ * ARM syscall sequence snippet will have move and svc in .arm encoding
+ *
+ * For Thumb syscalls, we pass the syscall number via r7.  We therefore
+ * need two 16-bit instructions in .thumb encoding
+ */
+
+	.text
+	.global sigreturn_codes
+	.type	sigreturn_codes, #object
+
+sigreturn_codes:
+	/* ARM sigreturn syscall code snippet */
+	.arm
+	mov	r7, #(__NR_sigreturn - __NR_SYSCALL_BASE)
+	svc	#(__NR_sigreturn)|(__NR_OABI_SYSCALL_BASE)
+
+	/* Thumb sigreturn syscall code snippet */
+	.thumb
+	movs	r7, #(__NR_sigreturn - __NR_SYSCALL_BASE)
+	svc	#0
+
+	/* ARM sigreturn_rt syscall code snippet */
+	.arm
+	mov	r7, #(__NR_rt_sigreturn - __NR_SYSCALL_BASE)
+	svc	#(__NR_rt_sigreturn)|(__NR_OABI_SYSCALL_BASE)
+
+	/* Thumb sigreturn_rt syscall code snippet */
+	.thumb
+	movs	r7, #(__NR_rt_sigreturn - __NR_SYSCALL_BASE)
+	svc	#0
+
+	.arm
+	.space	4
+__sigreturn_codes_end:
+	.size	sigreturn_codes, . - sigreturn_codes
+
+	.section .rodata
+	.global	sigreturn_codes_size
+	.type	sigreturn_codes_size, #object
+	.size	sigreturn_codes_size, 4
+
+sigreturn_codes_size:
+	.long __sigreturn_codes_end - sigreturn_codes
-- 
1.8.1.4
