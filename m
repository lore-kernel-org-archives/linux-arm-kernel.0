From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 Jun 2010 16:33:21 -0400
Subject: [PATCH 3/5] ARM: initial stack protector (-fstack-protector) support
In-Reply-To: <1276720403-27918-1-git-send-email-nico@fluxnic.net>
References: <1276720403-27918-1-git-send-email-nico@fluxnic.net>
Message-ID: <1276720403-27918-4-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the very basic stuff without the changing canary upon
task switch yet.  Just the Kconfig option and a constant canary
value initialized at boot time.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig                      |   12 ++++++++++
 arch/arm/Makefile                     |    4 +++
 arch/arm/include/asm/stackprotector.h |   38 +++++++++++++++++++++++++++++++++
 arch/arm/kernel/process.c             |    6 +++++
 4 files changed, 60 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/stackprotector.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1f254bd..f160b93 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1374,6 +1374,18 @@ config UACCESS_WITH_MEMCPY
 	  However, if the CPU data cache is using a write-allocate mode,
 	  this option is unlikely to provide any performance gain.
 
+config CC_STACKPROTECTOR
+	bool "Enable -fstack-protector buffer overflow detection (EXPERIMENTAL)"
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
 endmenu
 
 menu "Boot options"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 64ba313..ddf6da1 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -34,6 +34,10 @@ ifeq ($(CONFIG_FRAME_POINTER),y)
 KBUILD_CFLAGS	+=-fno-omit-frame-pointer -mapcs -mno-sched-prolog
 endif
 
+ifeq ($(CONFIG_CC_STACKPROTECTOR),y)
+KBUILD_CFLAGS	+=-fstack-protector
+endif
+
 ifeq ($(CONFIG_CPU_BIG_ENDIAN),y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 AS		+= -EB
diff --git a/arch/arm/include/asm/stackprotector.h b/arch/arm/include/asm/stackprotector.h
new file mode 100644
index 0000000..de00332
--- /dev/null
+++ b/arch/arm/include/asm/stackprotector.h
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
+#ifndef _ASM_STACKPROTECTOR_H
+#define _ASM_STACKPROTECTOR_H 1
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
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 1c6eb7e..090ac94 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -37,6 +37,12 @@
 #include <asm/stacktrace.h>
 #include <asm/mach/time.h>
 
+#ifdef CONFIG_CC_STACKPROTECTOR
+#include <linux/stackprotector.h>
+unsigned long __stack_chk_guard __read_mostly;
+EXPORT_SYMBOL(__stack_chk_guard);
+#endif
+
 static const char *processor_modes[] = {
   "USER_26", "FIQ_26" , "IRQ_26" , "SVC_26" , "UK4_26" , "UK5_26" , "UK6_26" , "UK7_26" ,
   "UK8_26" , "UK9_26" , "UK10_26", "UK11_26", "UK12_26", "UK13_26", "UK14_26", "UK15_26",
-- 
1.7.1.337.gbd0bc
