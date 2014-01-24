From: lauraa@codeaurora.org (Laura Abbott)
Date: Fri, 24 Jan 2014 15:09:15 -0800
Subject: [PATCHv2] arm64: Add CONFIG_CC_STACKPROTECTOR
Message-ID: <1390604955-6309-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm64 currently lacks support for -fstack-protector. Add
similar functionality to arm to detect stack corruption.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm64/Kconfig                      |   11 +++++++++
 arch/arm64/Makefile                     |    4 +++
 arch/arm64/include/asm/stackprotector.h |   38 +++++++++++++++++++++++++++++++
 arch/arm64/kernel/process.c             |    6 +++++
 4 files changed, 59 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/include/asm/stackprotector.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6d4dd22..47280cf 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -168,6 +168,17 @@ config HOTPLUG_CPU
 	  Say Y here to experiment with turning CPUs off and on.  CPUs
 	  can be controlled through /sys/devices/system/cpu.
 
+config CC_STACKPROTECTOR
+	bool "Enable -fstack-protector buffer overflow detection"
+	help
+	  This option turns on the -fstack-protector GCC feature. This
+	  feature puts, at the beginning of functions, a canary value on
+	  the stack just before the return address, and validates
+	  the value just before actually returning.  Stack based buffer
+	  overflows (that need to overwrite this return address) now also
+	  overwrite the canary, which gets detected and the attack is then
+	  neutralized via a kernel panic.
+
 source kernel/Kconfig.preempt
 
 config HZ
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 2fceb71..1ce221e 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -48,6 +48,10 @@ core-$(CONFIG_XEN) += arch/arm64/xen/
 libs-y		:= arch/arm64/lib/ $(libs-y)
 libs-y		+= $(LIBGCC)
 
+ifeq ($(CONFIG_CC_STACKPROTECTOR),y)
+KBUILD_CFLAGS	+=-fstack-protector
+endif
+
 # Default target when executing plain make
 KBUILD_IMAGE	:= Image.gz
 KBUILD_DTBS	:= dtbs
diff --git a/arch/arm64/include/asm/stackprotector.h b/arch/arm64/include/asm/stackprotector.h
new file mode 100644
index 0000000..fe5e287
--- /dev/null
+++ b/arch/arm64/include/asm/stackprotector.h
@@ -0,0 +1,38 @@
+/*
+ * GCC stack protector support.
+ *
+ * Stack protector works by putting predefined pattern at the start of
+ * the stack frame and verifying that it hasn't been overwritten when
+ * returning from the function.  The pattern is called stack canary
+ * and gcc expects it to be defined by a global variable called
+ * "__stack_chk_guard" on ARM.  This unfortunately means that on SMP
+ * we cannot have a different canary value per task.
+ */
+
+#ifndef __ASM_STACKPROTECTOR_H
+#define __ASM_STACKPROTECTOR_H
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
+
+#endif	/* _ASM_STACKPROTECTOR_H */
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index de17c89..72c5188 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -50,6 +50,12 @@
 #include <asm/processor.h>
 #include <asm/stacktrace.h>
 
+#ifdef CONFIG_CC_STACKPROTECTOR
+#include <linux/stackprotector.h>
+unsigned long __stack_chk_guard __read_mostly;
+EXPORT_SYMBOL(__stack_chk_guard);
+#endif
+
 static void setup_restart(void)
 {
 	/*
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
