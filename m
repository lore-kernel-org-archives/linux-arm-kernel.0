From: rabin@rab.in (Rabin Vincent)
Date: Mon, 21 Nov 2011 20:43:49 +0530
Subject: [PATCH 4/4] ARM: add jump label support
In-Reply-To: <1321888429-3519-1-git-send-email-rabin@rab.in>
References: <1321888429-3519-1-git-send-email-rabin@rab.in>
Message-ID: <1321888429-3519-4-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the arch-specific code to support jump labels for ARM and Thumb-2.

Note that to build succesfully it requires (what will be) GCC 4.7.0
because of incomplete support for the '%c' specifier in earlier
versions:

	http://gcc.gnu.org/bugzilla/show_bug.cgi?id=48637

Cc: Jason Baron <jbaron@redhat.com>
Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/Kconfig                  |    1 +
 arch/arm/include/asm/jump_label.h |   41 +++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/Makefile          |    1 +
 arch/arm/kernel/insn.h            |   12 ++++++++++
 arch/arm/kernel/jump_label.c      |   35 +++++++++++++++++++++++++++++++
 5 files changed, 90 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/jump_label.h
 create mode 100644 arch/arm/kernel/jump_label.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 44789ef..ae6d31c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -9,6 +9,7 @@ config ARM
 	select SYS_SUPPORTS_APM_EMULATION
 	select GENERIC_ATOMIC64 if (CPU_V6 || !CPU_32v6K || !AEABI)
 	select HAVE_OPROFILE if (HAVE_PERF_EVENTS)
+	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
 	select HAVE_ARCH_KGDB
 	select HAVE_KPROBES if !XIP_KERNEL
 	select HAVE_KRETPROBES if (HAVE_KPROBES)
diff --git a/arch/arm/include/asm/jump_label.h b/arch/arm/include/asm/jump_label.h
new file mode 100644
index 0000000..5c5ca2e
--- /dev/null
+++ b/arch/arm/include/asm/jump_label.h
@@ -0,0 +1,41 @@
+#ifndef _ASM_ARM_JUMP_LABEL_H
+#define _ASM_ARM_JUMP_LABEL_H
+
+#ifdef __KERNEL__
+
+#include <linux/types.h>
+#include <asm/system.h>
+
+#define JUMP_LABEL_NOP_SIZE 4
+
+#ifdef CONFIG_THUMB2_KERNEL
+#define JUMP_LABEL_NOP	"nop.w"
+#else
+#define JUMP_LABEL_NOP	"nop"
+#endif
+
+static __always_inline bool arch_static_branch(struct jump_label_key *key)
+{
+	asm goto("1:\n\t"
+		 JUMP_LABEL_NOP "\n\t"
+		 ".pushsection __jump_table,  \"aw\"\n\t"
+		 ".word 1b, %l[l_yes], %c0\n\t"
+		 ".popsection\n\t"
+		 : :  "i" (key) :  : l_yes);
+
+	return false;
+l_yes:
+	return true;
+}
+
+#endif /* __KERNEL__ */
+
+typedef u32 jump_label_t;
+
+struct jump_entry {
+	jump_label_t code;
+	jump_label_t target;
+	jump_label_t key;
+};
+
+#endif
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index adf02ed..be200ad 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_HAVE_ARM_SCU)	+= smp_scu.o
 obj-$(CONFIG_HAVE_ARM_TWD)	+= smp_twd.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o insn.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o insn.o
+obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o insn.o patch.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o kprobes-common.o patch.o
 ifdef CONFIG_THUMB2_KERNEL
diff --git a/arch/arm/kernel/insn.h b/arch/arm/kernel/insn.h
index 994d60f..c32d271 100644
--- a/arch/arm/kernel/insn.h
+++ b/arch/arm/kernel/insn.h
@@ -1,6 +1,18 @@
 #ifndef __ASM_ARM_INSN_H
 #define __ASM_ARM_INSN_H
 
+static inline unsigned long
+arm_gen_nop(void)
+{
+#ifdef CONFIG_THUMB2_KERNEL
+	return 0xf3af8000; /* nop.w */
+#elif defined(CONFIG_CPU_32v6K)
+	return 0xe320f000; /* nop */
+#else
+	return 0xe1a00000; /* mov r0, r0 */
+#endif
+}
+
 unsigned long
 __arm_gen_branch(unsigned long pc, unsigned long addr, bool link);
 
diff --git a/arch/arm/kernel/jump_label.c b/arch/arm/kernel/jump_label.c
new file mode 100644
index 0000000..7900914
--- /dev/null
+++ b/arch/arm/kernel/jump_label.c
@@ -0,0 +1,35 @@
+#include <linux/kernel.h>
+#include <linux/jump_label.h>
+
+#include "insn.h"
+#include "patch.h"
+
+static void __arch_jump_label_transform(struct jump_entry *entry,
+					enum jump_label_type type,
+					bool is_static)
+{
+	void *addr = (void *)entry->code;
+	unsigned int insn;
+
+	if (type == JUMP_LABEL_ENABLE)
+		insn = arm_gen_branch(entry->code, entry->target);
+	else
+		insn = arm_gen_nop();
+
+	if (is_static)
+		__patch_text(addr, insn);
+	else
+		patch_text(addr, insn);
+}
+
+void arch_jump_label_transform(struct jump_entry *entry,
+			       enum jump_label_type type)
+{
+	__arch_jump_label_transform(entry, type, false);
+}
+
+void arch_jump_label_transform_static(struct jump_entry *entry,
+				      enum jump_label_type type)
+{
+	__arch_jump_label_transform(entry, type, true);
+}
-- 
1.7.7.3
