From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Dec 2013 12:16:16 +0000
Subject: [PATCH 1/2] ARM: dcache: select DCACHE_WORD_ACCESS for big-endian CPUs
Message-ID: <1387282577-2753-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With commit 11ec50caedb5 ("word-at-a-time: provide generic big-endian
zero_bytemask implementation"), the asm-generic word-at-a-time code now
provides a zero_bytemask implementation, allowing us to make use of
DCACHE_WORD_ACCESS on big-endian CPUs, providing our
load_unaligned_zeropad function is endianness-clean.

This patch reworks the load_unaligned_zeropad fixup code to work for
both big- and little-endian CPUs, then removes the !CPU_BIG_ENDIAN check
when selecting DCACHE_WORD_ACCESS.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig                      |  2 +-
 arch/arm/include/asm/word-at-a-time.h | 18 ++++++++++--------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 88f726d36a40..38ccfd0adbf9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -11,7 +11,7 @@ config ARM
 	select BUILDTIME_EXTABLE_SORT if MMU
 	select CLONE_BACKWARDS
 	select CPU_PM if (SUSPEND || CPU_IDLE)
-	select DCACHE_WORD_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && !CPU_BIG_ENDIAN && MMU
+	select DCACHE_WORD_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
 	select GENERIC_ATOMIC64 if (CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI)
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select GENERIC_IDLE_POLL_SETUP
diff --git a/arch/arm/include/asm/word-at-a-time.h b/arch/arm/include/asm/word-at-a-time.h
index 4d52f92967a6..a6d0a29861e7 100644
--- a/arch/arm/include/asm/word-at-a-time.h
+++ b/arch/arm/include/asm/word-at-a-time.h
@@ -48,10 +48,14 @@ static inline unsigned long find_zero(unsigned long mask)
 	return ret;
 }
 
-#ifdef CONFIG_DCACHE_WORD_ACCESS
-
 #define zero_bytemask(mask) (mask)
 
+#else	/* __ARMEB__ */
+#include <asm-generic/word-at-a-time.h>
+#endif
+
+#ifdef CONFIG_DCACHE_WORD_ACCESS
+
 /*
  * Load an unaligned word from kernel space.
  *
@@ -73,7 +77,11 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 	"	bic	%2, %2, #0x3\n"
 	"	ldr	%0, [%2]\n"
 	"	lsl	%1, %1, #0x3\n"
+#ifndef __ARMEB__
 	"	lsr	%0, %0, %1\n"
+#else
+	"	lsl	%0, %0, %1\n"
+#endif
 	"	b	2b\n"
 	"	.popsection\n"
 	"	.pushsection __ex_table,\"a\"\n"
@@ -86,11 +94,5 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 	return ret;
 }
 
-
 #endif	/* DCACHE_WORD_ACCESS */
-
-#else	/* __ARMEB__ */
-#include <asm-generic/word-at-a-time.h>
-#endif
-
 #endif /* __ASM_ARM_WORD_AT_A_TIME_H */
-- 
1.8.2.2
