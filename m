From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  7 Jun 2017 16:35:13 +0100
Subject: [PATCH 2/2] arm64: use larger stacks for KASAN
In-Reply-To: <1496849713-17078-1-git-send-email-mark.rutland@arm.com>
References: <1496849713-17078-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1496849713-17078-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With recent toolchains (e.g. GCC 7.1.0), KASAN will instrument stack
accesses, significantly increasing stack pressure. This has been
observed to result in a boot-time stack overflow on Juno R1, and various
failures under Syzkaller-directed Qemu VMs.

On x86, this was addressed in commit:

  c420f167db8c799d ("kasan: enable stack instrumentation")

... by doubling the stack size to 32K when the kernel is compiled with
KASAN.

This patch does the same for arm64, enabling us to make use of KASAN's
stack instrumentation. Kernels without KASAN are not affected and will
retain the current 16K stack size.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/thread_info.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 4f42275..1dec96e8 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -25,7 +25,17 @@
 
 #include <asm/page.h>
 
-#define THREAD_SHIFT		14
+/*
+ * AddressSanitizer's stack instrumentation significantly increases stack
+ * usage. We double the stack size when KASAN is selected to avoid overflows.
+ */
+#ifdef CONFIG_KASAN
+#define KASAN_THREAD_SHIFT	1
+#else
+#define KASAN_THREAD_SHIFT	0
+#endif
+
+#define THREAD_SHIFT		(14 + KASAN_THREAD_SHIFT)
 
 #if THREAD_SHIFT >= PAGE_SHIFT
 #define THREAD_SIZE_ORDER	(THREAD_SHIFT - PAGE_SHIFT)
-- 
1.9.1
