From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Jul 2013 16:55:37 +0100
Subject: [PATCH v2 3/6] ARM: prefetch: add support for prefetchw using pldw on
 SMP ARMv7+ CPUs
In-Reply-To: <1374767740-2068-1-git-send-email-will.deacon@arm.com>
References: <1374767740-2068-1-git-send-email-will.deacon@arm.com>
Message-ID: <1374767740-2068-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SMP ARMv7 CPUs implement the pldw instruction, which allows them to
prefetch data cachelines in an exclusive state.

This patch defines the prefetchw macro using pldw for CPUs that support
it.

Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/processor.h | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index cbdb130..dde7ecc 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -109,19 +109,26 @@ unsigned long get_wchan(struct task_struct *p);
 #if __LINUX_ARM_ARCH__ >= 5
 
 #define ARCH_HAS_PREFETCH
-static inline void prefetch(const void *ptr)
-{
-	__asm__ __volatile__(
-		"pld\t%a0"
-		:: "p" (ptr));
-}
+#define prefetch(p)							\
+({									\
+	__asm__ __volatile__(						\
+		"pld\t%a0"						\
+		:: "p" (p));						\
+})
 
+#if __LINUX_ARM_ARCH__ >= 7 && defined(CONFIG_SMP)
 #define ARCH_HAS_PREFETCHW
-#define prefetchw(ptr)	prefetch(ptr)
-
-#define ARCH_HAS_SPINLOCK_PREFETCH
-#define spin_lock_prefetch(x) do { } while (0)
-
+#define prefetchw(p)							\
+({									\
+	__asm__ __volatile__(						\
+		".arch_extension	mp\n"				\
+		__ALT_SMP_ASM(						\
+			WASM(pldw)		"\t%a0",		\
+			WASM(pld)		"\t%a0"			\
+		)							\
+		:: "p" (p));						\
+})
+#endif
 #endif
 
 #define HAVE_ARCH_PICK_MMAP_LAYOUT
-- 
1.8.2.2
