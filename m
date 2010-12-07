From: filippo.arcidiacono@st.com (Filippo ARCIDIACONO)
Date: Tue, 7 Dec 2010 11:20:53 +0100
Subject: [PATCH (sh-2.6) 1/2] sh: add stack smashing protection support
Message-ID: <1291717254-17455-1-git-send-email-filippo.arcidiacono@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add stack smashing suppurt for SH architecture. This is based on work
from Nicolas Pitre for ARM (c743f38013aeff58ef6252601e397b5ba281c633).
Use the ARM boot_init_stack_canary function to initialize the guard
canary. It has been placed under asm-generic to allow archtectures
based on __stack_chk_guard to use a common implementation.
Update the __stack_chk_guard global variable with the value stored in
the task struct whenever a task switch occurs to allow for different
canary values per task. This cannot work on SMP where the initial
canary value is always used.

Signed-off-by: Filippo Arcidiacono <filippo.arcidiacono@st.com>
Reviewed-by: Carmelo Amoroso <carmelo.amoroso@st.com>
---
 arch/sh/Kconfig                      |   13 +++++++++++
 arch/sh/Makefile                     |    4 +++
 arch/sh/include/asm/stackprotector.h |   10 ++++++++
 arch/sh/kernel/process_32.c          |    9 +++++++
 include/asm-generic/stackprotector.h |   39 ++++++++++++++++++++++++++++++++++
 5 files changed, 75 insertions(+), 0 deletions(-)
 create mode 100644 arch/sh/include/asm/stackprotector.h
 create mode 100644 include/asm-generic/stackprotector.h

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 1e905a6..2c82c98 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -742,6 +742,19 @@ config HW_PERF_EVENTS
 	  Enable hardware performance counter support for perf events. If
 	  disabled, perf events will use software events only.
 
+config CC_STACKPROTECTOR
+	bool "Enable -fstack-protector buffer overflow detection (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  This option turns on the -fstack-protector GCC feature. This
+	  feature puts, at the beginning of functions, a canary value on
+	  the stack just before the return address, and validates
+	  the value just before actually returning.  Stack based buffer
+	  overflows (that need to overwrite this return address) now also
+	  overwrite the canary, which gets detected and the attack is then
+	  neutralized via a kernel panic.
+	  This feature requires gcc version 4.2 or above.
+
 source "drivers/sh/Kconfig"
 
 endmenu
diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index 9c8c6e1..3cef435 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -197,6 +197,10 @@ ifeq ($(CONFIG_DWARF_UNWINDER),y)
   KBUILD_CFLAGS += -fasynchronous-unwind-tables
 endif
 
+ifeq ($(CONFIG_CC_STACKPROTECTOR),y)
+  KBUILD_CFLAGS += -fstack-protector
+endif
+
 libs-$(CONFIG_SUPERH32)		:= arch/sh/lib/	$(libs-y)
 libs-$(CONFIG_SUPERH64)		:= arch/sh/lib64/ $(libs-y)
 
diff --git a/arch/sh/include/asm/stackprotector.h b/arch/sh/include/asm/stackprotector.h
new file mode 100644
index 0000000..f777dbd
--- /dev/null
+++ b/arch/sh/include/asm/stackprotector.h
@@ -0,0 +1,10 @@
+/*
+ * SH specific GCC stack protector support.
+ */
+
+#ifndef _ASM_STACKPROTECTOR_H
+#define _ASM_STACKPROTECTOR_H 1
+
+#include <asm-generic/stackprotector.h>
+
+#endif	/* _ASM_STACKPROTECTOR_H */
diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
index 762a139..97535d8 100644
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -27,6 +27,11 @@
 #include <asm/fpu.h>
 #include <asm/syscalls.h>
 
+#ifdef CONFIG_CC_STACKPROTECTOR
+unsigned long __stack_chk_guard __read_mostly;
+EXPORT_SYMBOL(__stack_chk_guard);
+#endif
+
 void show_regs(struct pt_regs * regs)
 {
 	printk("\n");
@@ -221,6 +226,10 @@ __switch_to(struct task_struct *prev, struct task_struct *next)
 {
 	struct thread_struct *next_t = &next->thread;
 
+#if defined CONFIG_CC_STACKPROTECTOR && !defined CONFIG_SMP
+	__stack_chk_guard = next->stack_canary;
+#endif
+
 	unlazy_fpu(prev, task_pt_regs(prev));
 
 	/* we're going to use this soon, after a few expensive things */
diff --git a/include/asm-generic/stackprotector.h b/include/asm-generic/stackprotector.h
new file mode 100644
index 0000000..2d33c83
--- /dev/null
+++ b/include/asm-generic/stackprotector.h
@@ -0,0 +1,39 @@
+/*
+ * GCC stack protector support.
+ * (Generic implementation based on __stack_chk_guard)
+ *
+ * Stack protector works by putting predefined pattern at the start of
+ * the stack frame and verifying that it hasn't been overwritten when
+ * returning from the function.  The pattern is called stack canary
+ * and gcc expects it to be defined by a global variable called
+ * "__stack_chk_guard". This unfortunately means that on SMP
+ * we cannot have a different canary value per task.
+ */
+
+#ifndef _ASM_STACKPROTECTOR_H
+#error "Never use <asm-generic/stackprotector.h> directly; \
+include <asm/stackprotector.h> instead."
+#endif
+
+#include <linux/random.h>
+#include <linux/version.h>
+
+extern unsigned long __stack_chk_guard;
+
+/*
+ * Initialize the stackprotector canary value.
+ *
+ * NOTE: this must only be called from functions that never return,
+ * and it must always be inlined.
+ */
+static __always_inline void boot_init_stack_canary(void)
+{
+	unsigned long canary;
+
+	/* Try to get a semi random initial value. */
+	get_random_bytes(&canary, sizeof(canary));
+	canary ^= LINUX_VERSION_CODE;
+
+	current->stack_canary = canary;
+	__stack_chk_guard = current->stack_canary;
+}
-- 
1.5.5.6
