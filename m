From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Sep 2013 14:29:35 +0100
Subject: [PATCH v3 3/6] ARM: prefetch: add support for prefetchw using pldw on
 SMP ARMv7+ CPUs
In-Reply-To: <1379424578-7477-1-git-send-email-will.deacon@arm.com>
References: <1379424578-7477-1-git-send-email-will.deacon@arm.com>
Message-ID: <1379424578-7477-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SMP ARMv7 CPUs implement the pldw instruction, which allows them to
prefetch data cachelines in an exclusive state.

This patch defines the prefetchw macro using pldw for CPUs that support
it.

Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/processor.h | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index 26164c9..c3d5fc1 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -112,12 +112,19 @@ static inline void prefetch(const void *ptr)
 		:: "p" (ptr));
 }
 
+#if __LINUX_ARM_ARCH__ >= 7 && defined(CONFIG_SMP)
 #define ARCH_HAS_PREFETCHW
-#define prefetchw(ptr)	prefetch(ptr)
-
-#define ARCH_HAS_SPINLOCK_PREFETCH
-#define spin_lock_prefetch(x) do { } while (0)
-
+static inline void prefetchw(const void *ptr)
+{
+	__asm__ __volatile__(
+		".arch_extension	mp\n"
+		__ALT_SMP_ASM(
+			WASM(pldw)		"\t%a0",
+			WASM(pld)		"\t%a0"
+		)
+		:: "p" (ptr));
+}
+#endif
 #endif
 
 #define HAVE_ARCH_PICK_MMAP_LAYOUT
-- 
1.8.2.2
