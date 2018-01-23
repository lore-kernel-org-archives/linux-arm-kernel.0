From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 23 Jan 2018 13:03:02 +0000
Subject: [RFC/RFT PATCH 2/2] arm64: kernel: use a unique stack canary value
 for each task
In-Reply-To: <20180123130302.29409-1-ard.biesheuvel@linaro.org>
References: <20180123130302.29409-1-ard.biesheuvel@linaro.org>
Message-ID: <20180123130302.29409-3-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the support plugin and expose an appropriate value for
__stack_chk_guard_tsk_offset so that function prologues and
epilogues emitted by GCC read the stack canary value straight
from the task_struct. This sidesteps any concurrency issues
resulting from the use of per-CPU variables to store the canary
value of the currently running task.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Kconfig                      | 7 +++++++
 arch/arm64/include/asm/stackprotector.h | 4 +++-
 arch/arm64/kernel/asm-offsets.c         | 3 +++
 arch/arm64/kernel/process.c             | 4 ++++
 arch/arm64/kernel/vmlinux.lds.S         | 8 ++++++++
 5 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index d1515fdf7d82..096f23ebfa02 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1083,6 +1083,13 @@ config RANDOMIZE_MODULE_REGION_FULL
 	  a limited range that contains the [_stext, _etext] interval of the
 	  core kernel, so branch relocations are always in range.
 
+config CC_STACK_PROTECTOR_PER_TASK
+	bool "Use a unique stack canary value for each task"
+	depends on GCC_PLUGINS
+	select GCC_PLUGIN_ARM64_SSP_PER_TASK
+	help
+	  Use a unique value for the stack canary value for each task.
+
 endmenu
 
 menu "Boot options"
diff --git a/arch/arm64/include/asm/stackprotector.h b/arch/arm64/include/asm/stackprotector.h
index 58d15be11c4d..fc17a66ec400 100644
--- a/arch/arm64/include/asm/stackprotector.h
+++ b/arch/arm64/include/asm/stackprotector.h
@@ -17,6 +17,7 @@
 #include <linux/version.h>
 
 extern unsigned long __stack_chk_guard;
+extern unsigned long __stack_chk_guard_tsk_offset;
 
 /*
  * Initialize the stackprotector canary value.
@@ -34,7 +35,8 @@ static __always_inline void boot_init_stack_canary(void)
 	canary &= CANARY_MASK;
 
 	current->stack_canary = canary;
-	__stack_chk_guard = current->stack_canary;
+	if (!IS_ENABLED(CONFIG_CC_STACK_PROTECTOR_PER_TASK))
+		__stack_chk_guard = current->stack_canary;
 }
 
 #endif	/* _ASM_STACKPROTECTOR_H */
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 71bf088f1e4b..ef1ff04ec064 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -43,6 +43,9 @@ int main(void)
   DEFINE(TSK_TI_TTBR0,		offsetof(struct task_struct, thread_info.ttbr0));
 #endif
   DEFINE(TSK_STACK,		offsetof(struct task_struct, stack));
+#ifdef CONFIG_CC_STACK_PROTECTOR_PER_TASK
+  DEFINE(TSK_STACK_CANARY,	offsetof(struct task_struct, stack_canary));
+#endif
   BLANK();
   DEFINE(THREAD_CPU_CONTEXT,	offsetof(struct task_struct, thread.cpu_context));
   BLANK();
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 6b7dcf4310ac..d9fd04748f95 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -62,8 +62,12 @@
 
 #ifdef CONFIG_CC_STACKPROTECTOR
 #include <linux/stackprotector.h>
+#ifndef CONFIG_CC_STACK_PROTECTOR_PER_TASK
 unsigned long __stack_chk_guard __read_mostly;
 EXPORT_SYMBOL(__stack_chk_guard);
+#else
+EXPORT_SYMBOL(__stack_chk_guard_tsk_offset);
+#endif
 #endif
 
 /*
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 7da3e5c366a0..633cfc1f940c 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -6,6 +6,7 @@
  */
 
 #include <asm-generic/vmlinux.lds.h>
+#include <asm/asm-offsets.h>
 #include <asm/cache.h>
 #include <asm/kernel-pgtable.h>
 #include <asm/thread_info.h>
@@ -239,3 +240,10 @@ ASSERT(__hibernate_exit_text_end - (__hibernate_exit_text_start & ~(SZ_4K - 1))
  * If padding is applied before .head.text, virt<->phys conversions will fail.
  */
 ASSERT(_text == (KIMAGE_VADDR + TEXT_OFFSET), "HEAD is misaligned")
+
+#ifdef CONFIG_CC_STACK_PROTECTOR_PER_TASK
+PROVIDE(__stack_chk_guard_tsk_offset = ABSOLUTE(TSK_STACK_CANARY));
+
+ASSERT(__stack_chk_guard_tsk_offset < 0x1000,
+       "__stack_chk_guard_tsk_offset out of range")
+#endif
-- 
2.11.0
