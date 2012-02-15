From: rabin@rab.in (Rabin Vincent)
Date: Wed, 15 Feb 2012 22:30:44 +0530
Subject: [PATCHv3] ARM: add jump label support
In-Reply-To: <1327757725-10114-7-git-send-email-rabin@rab.in>
References: <1327757725-10114-7-git-send-email-rabin@rab.in>
Message-ID: <1329325244-16289-1-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the arch-specific code to support jump labels for ARM and Thumb-2.

This code will only be activated on compilers that are capable of
building it.  It has been tested with GCC 4.6 patched with the patch
from GCC bug 48637.

Cc: Jason Baron <jbaron@redhat.com>
Signed-off-by: Rabin Vincent <rabin@rab.in>
---
v3: add missing #ifdef HAVE_JUMP_LABEL around the code in the C file

 arch/arm/Kconfig                  |    1 +
 arch/arm/include/asm/jump_label.h |   41 +++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/Makefile          |    1 +
 arch/arm/kernel/insn.h            |   10 +++++++++
 arch/arm/kernel/jump_label.c      |   39 +++++++++++++++++++++++++++++++++++
 5 files changed, 92 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/jump_label.h
 create mode 100644 arch/arm/kernel/jump_label.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 57b6e96..aaf9a3c 100644
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
index 8c63ee8..1b7d9a3 100644
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
index 994d60f..e96065d 100644
--- a/arch/arm/kernel/insn.h
+++ b/arch/arm/kernel/insn.h
@@ -1,6 +1,16 @@
 #ifndef __ASM_ARM_INSN_H
 #define __ASM_ARM_INSN_H
 
+static inline unsigned long
+arm_gen_nop(void)
+{
+#ifdef CONFIG_THUMB2_KERNEL
+	return 0xf3af8000; /* nop.w */
+#else
+	return 0xe1a00000; /* mov r0, r0 */
+#endif
+}
+
 unsigned long
 __arm_gen_branch(unsigned long pc, unsigned long addr, bool link);
 
diff --git a/arch/arm/kernel/jump_label.c b/arch/arm/kernel/jump_label.c
new file mode 100644
index 0000000..4ce4f78
--- /dev/null
+++ b/arch/arm/kernel/jump_label.c
@@ -0,0 +1,39 @@
+#include <linux/kernel.h>
+#include <linux/jump_label.h>
+
+#include "insn.h"
+#include "patch.h"
+
+#ifdef HAVE_JUMP_LABEL
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
+
+#endif
-- 
1.7.9
