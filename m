From: mark.rutland@arm.com (Mark Rutland)
Date: Tue,  3 Oct 2017 18:25:46 +0100
Subject: [PATCH] arm64: Use larger stacks when KASAN is selected
Message-ID: <1507051546-11677-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AddressSanitizer instrumentation can significantly bloat the stack, and
with GCC 7 this can result in stack overflows at boot time in some
configurations.

We can avoid this by doubling our stack size when KASAN is in use, as is
already done on x86 (and has been since KASAN was introduced).
Regardless of other patches to decrease KASAN's stack utilization,
kernels built with KASAN will always require more stack space than those
built without, and we should take this into account.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/memory.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

In local testing (with KASAN and other options enabled), I've seen a stack
depth of 23928 bytes while booting to a prompt with an Ubuntu 14.04 filesystem
mounted over NFS. Without KASAN (but with other debug options enabled), this
was 7992 bytes.

I wonder if we want to go for 4x rather than 2x...

Thanks,
Mark.

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 3585a5e..f7c4d21 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -95,16 +95,19 @@
 #define KERNEL_END        _end
 
 /*
- * The size of the KASAN shadow region. This should be 1/8th of the
- * size of the entire kernel virtual address space.
+ * KASAN requires 1/8th of the kernel virtual address space for the shadow
+ * region. KASAN can bloat the stack significantly, so double the (minimum)
+ * stack size when KASAN is in use.
  */
 #ifdef CONFIG_KASAN
 #define KASAN_SHADOW_SIZE	(UL(1) << (VA_BITS - 3))
+#define KASAN_THREAD_SHIFT	1
 #else
 #define KASAN_SHADOW_SIZE	(0)
+#define KASAN_THREAD_SHIFT	0
 #endif
 
-#define MIN_THREAD_SHIFT	14
+#define MIN_THREAD_SHIFT	(14 + KASAN_THREAD_SHIFT)
 
 /*
  * VMAP'd stacks are allocated@page granularity, so we must ensure that such
-- 
1.9.1
