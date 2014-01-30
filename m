From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 30 Jan 2014 13:05:44 -0800
Subject: [PATCHv3] arm64: Add CONFIG_CC_STACKPROTECTOR
Message-ID: <1391115944-10183-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm64 currently lacks support for -fstack-protector. Add
similar functionality to arm to detect stack corruption.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
I realized today that the patch I gave before was not going to work for recent
trees because of changes to CC_STACKPROTECTOR that were not in my working tree
before. This should be the patch to actually work against recent kernels.
---
 arch/arm64/Kconfig                      |    1 +
 arch/arm64/include/asm/stackprotector.h |   38 +++++++++++++++++++++++++++++++
 arch/arm64/kernel/process.c             |    6 +++++
 3 files changed, 45 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/include/asm/stackprotector.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index dd4327f..2ebf522 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -27,6 +27,7 @@ config ARM64
 	select HARDIRQS_SW_RESEND
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_TRACEHOOK
+	select HAVE_CC_STACKPROTECTOR
 	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_API_DEBUG
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
index 1e5a178..89c301d 100644
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
