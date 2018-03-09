From: alex.shi@linaro.org (Alex Shi)
Date: Fri,  9 Mar 2018 17:06:47 +0800
Subject: [PATCH 04/39] arm64: move TASK_* definitions to <asm/processor.h>
In-Reply-To: <20180309090722.26279-1-alex.shi@linaro.org>
References: <20180309090722.26279-1-alex.shi@linaro.org>
Message-ID: <20180309090722.26279-5-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yury Norov <ynorov@caviumnetworks.com>

commit eef94a3d09aab upstream.

ILP32 series [1] introduces the dependency on <asm/is_compat.h> for
TASK_SIZE macro. Which in turn requires <asm/thread_info.h>, and
<asm/thread_info.h> include <asm/memory.h>, giving a circular dependency,
because TASK_SIZE is currently located in <asm/memory.h>.

In other architectures, TASK_SIZE is defined in <asm/processor.h>, and
moving TASK_SIZE there fixes the problem.

Discussion: https://patchwork.kernel.org/patch/9929107/

[1] https://github.com/norov/linux/tree/ilp32-next

CC: Will Deacon <will.deacon@arm.com>
CC: Laura Abbott <labbott@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/include/asm/memory.h    | 17 -----------------
 arch/arm64/include/asm/processor.h | 23 +++++++++++++++++++++--
 arch/arm64/kernel/entry.S          |  2 +-
 3 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 853953cd1f08..1af98f8660a4 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -43,10 +43,6 @@
  *		 (VA_BITS - 1))
  * VA_BITS - the maximum number of bits for virtual addresses.
  * VA_START - the first kernel virtual address.
- * TASK_SIZE - the maximum size of a user space task.
- * TASK_UNMAPPED_BASE - the lower boundary of the mmap VM area.
- * The module space lives between the addresses given by TASK_SIZE
- * and PAGE_OFFSET - it must be within 128MB of the kernel text.
  */
 #define VA_BITS			(CONFIG_ARM64_VA_BITS)
 #define VA_START		(UL(0xffffffffffffffff) << VA_BITS)
@@ -56,19 +52,6 @@
 #define PCI_IO_END		(MODULES_VADDR - SZ_2M)
 #define PCI_IO_START		(PCI_IO_END - PCI_IO_SIZE)
 #define FIXADDR_TOP		(PCI_IO_START - SZ_2M)
-#define TASK_SIZE_64		(UL(1) << VA_BITS)
-
-#ifdef CONFIG_COMPAT
-#define TASK_SIZE_32		UL(0x100000000)
-#define TASK_SIZE		(test_thread_flag(TIF_32BIT) ? \
-				TASK_SIZE_32 : TASK_SIZE_64)
-#define TASK_SIZE_OF(tsk)	(test_tsk_thread_flag(tsk, TIF_32BIT) ? \
-				TASK_SIZE_32 : TASK_SIZE_64)
-#else
-#define TASK_SIZE		TASK_SIZE_64
-#endif /* CONFIG_COMPAT */
-
-#define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 4))
 
 /*
  * Physical vs virtual RAM address space conversion.  These are
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index d08559528927..12d5b2b97f04 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -19,6 +19,10 @@
 #ifndef __ASM_PROCESSOR_H
 #define __ASM_PROCESSOR_H
 
+#define TASK_SIZE_64		(UL(1) << VA_BITS)
+
+#ifndef __ASSEMBLY__
+
 /*
  * Default implementation of macro that returns current
  * instruction pointer ("program counter").
@@ -35,7 +39,22 @@
 #include <asm/ptrace.h>
 #include <asm/types.h>
 
-#ifdef __KERNEL__
+/*
+ * TASK_SIZE - the maximum size of a user space task.
+ * TASK_UNMAPPED_BASE - the lower boundary of the mmap VM area.
+ */
+#ifdef CONFIG_COMPAT
+#define TASK_SIZE_32		UL(0x100000000)
+#define TASK_SIZE		(test_thread_flag(TIF_32BIT) ? \
+				TASK_SIZE_32 : TASK_SIZE_64)
+#define TASK_SIZE_OF(tsk)	(test_tsk_thread_flag(tsk, TIF_32BIT) ? \
+				TASK_SIZE_32 : TASK_SIZE_64)
+#else
+#define TASK_SIZE		TASK_SIZE_64
+#endif /* CONFIG_COMPAT */
+
+#define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 4))
+
 #define STACK_TOP_MAX		TASK_SIZE_64
 #ifdef CONFIG_COMPAT
 #define AARCH32_VECTORS_BASE	0xffff0000
@@ -47,7 +66,6 @@
 
 extern phys_addr_t arm64_dma_phys_limit;
 #define ARCH_LOW_ADDRESS_LIMIT	(arm64_dma_phys_limit - 1)
-#endif /* __KERNEL__ */
 
 struct debug_info {
 	/* Have we suspended stepping by a debugger? */
@@ -188,4 +206,5 @@ static inline void spin_lock_prefetch(const void *x)
 
 int cpu_enable_pan(void *__unused);
 
+#endif /* __ASSEMBLY__ */
 #endif /* __ASM_PROCESSOR_H */
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index dccd0c2e9023..fbb4fdd370b9 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -27,7 +27,7 @@
 #include <asm/cpufeature.h>
 #include <asm/errno.h>
 #include <asm/esr.h>
-#include <asm/memory.h>
+#include <asm/processor.h>
 #include <asm/thread_info.h>
 #include <asm/asm-uaccess.h>
 #include <asm/unistd.h>
-- 
2.16.2.440.gc6284da
