From: tim.bird@am.sony.com (Tim Bird)
Date: Tue, 18 Oct 2011 16:29:10 -0700
Subject: [PATCH 1/3] ARM 4Kstacks: Add support for 4K kernel stacks to ARM
In-Reply-To: <4E9E0B71.9020708@am.sony.com>
References: <4E9E0B71.9020708@am.sony.com>
Message-ID: <4E9E0BC6.1030505@am.sony.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This saves 4K per kernel thread and user-space process.
For systems with lots of threads, this can save
100s of K of memory.

Signed-off-by: Tim Bird <tim.bird@am.sony.com>
---
 arch/arm/Kconfig                   |   13 +++++++++++++
 arch/arm/include/asm/thread_info.h |    7 ++++++-
 arch/arm/kernel/entry-header.S     |    4 ++--
 arch/arm/mm/proc-macros.S          |    4 ++--
 4 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3146ed3..321ee11 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1555,6 +1555,19 @@ config OABI_COMPAT
 	  UNPREDICTABLE (in fact it can be predicted that it won't work
 	  at all). If in doubt say Y.

+config 4KSTACKS
+	bool "Use 4K kernel stacks instead of 8K"
+	default n
+	help
+	  This option will use less memory for each kernel stack in the
+	  system, which can save potentially hundreds of kilobytes of memory.
+	  It also helps reduce fragmentation in kernel memory.  However,
+	  it can be dangerous since not all kernel code paths are thrifty
+	  in their use of the stack.  Unless you have carefully monitored your
+	  kernel stack usage and verified that your programs and kernel
+	  usage patterns will not overflow 4K, you should leave this set
+	  to N.
+
 config ARCH_HAS_HOLES_MEMORYMODEL
 	bool

diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 7b5cc8d..3021d06 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -15,8 +15,13 @@
 #include <linux/compiler.h>
 #include <asm/fpstate.h>

+#ifndef CONFIG_4KSTACKS
 #define THREAD_SIZE_ORDER	1
-#define THREAD_SIZE		8192
+#else
+#define THREAD_SIZE_ORDER	0
+#endif
+
+#define THREAD_SIZE		(4096 << THREAD_SIZE_ORDER)
 #define THREAD_START_SP		(THREAD_SIZE - 8)

 #ifndef __ASSEMBLY__
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 9a8531e..c818505 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -109,8 +109,8 @@
 	.endm

 	.macro	get_thread_info, rd
-	mov	\rd, sp, lsr #13
-	mov	\rd, \rd, lsl #13
+	mov	\rd, sp, lsr #12 + THREAD_SIZE_ORDER
+	mov	\rd, \rd, lsl #12 + THREAD_SIZE_ORDER
 	.endm

 	@
diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index 307a4de..27c0907 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -30,8 +30,8 @@
  * act_mm - get current->active_mm
  */
 	.macro	act_mm, rd
-	bic	\rd, sp, #8128
-	bic	\rd, \rd, #63
+	mov	\rd, sp, lsr #12 + THREAD_SIZE_ORDER
+	mov	\rd, \rd, lsl #12 + THREAD_SIZE_ORDER
 	ldr	\rd, [\rd, #TI_TASK]
 	ldr	\rd, [\rd, #TSK_ACTIVE_MM]
 	.endm
-- 
1.6.6
