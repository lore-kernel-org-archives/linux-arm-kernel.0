From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Dec 2013 12:20:06 +0000
Subject: [PATCH 3/4] arm64: dcache: select DCACHE_WORD_ACCESS for
 little-endian CPUs
In-Reply-To: <1387282807-6024-1-git-send-email-will.deacon@arm.com>
References: <1387282807-6024-1-git-send-email-will.deacon@arm.com>
Message-ID: <1387282807-6024-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DCACHE_WORD_ACCESS uses the word-at-a-time API for optimised string
comparisons in the vfs layer.

This patch implements support for load_unaligned_zeropad in much the
same way as has been done for ARM, although big-endian systems are also
supported.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig                      |  1 +
 arch/arm64/include/asm/word-at-a-time.h | 40 +++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 295bf2de7128..435c9bc1c86c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -11,6 +11,7 @@ config ARM64
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
 	select COMMON_CLK
+	select DCACHE_WORD_ACCESS
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IOMAP
 	select GENERIC_IRQ_PROBE
diff --git a/arch/arm64/include/asm/word-at-a-time.h b/arch/arm64/include/asm/word-at-a-time.h
index 27a167d044d9..aab5bf09e9d9 100644
--- a/arch/arm64/include/asm/word-at-a-time.h
+++ b/arch/arm64/include/asm/word-at-a-time.h
@@ -47,8 +47,48 @@ static inline unsigned long find_zero(unsigned long mask)
 	return fls64(mask) >> 3;
 }
 
+#define zero_bytemask(mask) (mask)
+
 #else	/* __AARCH64EB__ */
 #include <asm-generic/word-at-a-time.h>
 #endif
 
+/*
+ * Load an unaligned word from kernel space.
+ *
+ * In the (very unlikely) case of the word being a page-crosser
+ * and the next page not being mapped, take the exception and
+ * return zeroes in the non-existing part.
+ */
+static inline unsigned long load_unaligned_zeropad(const void *addr)
+{
+	unsigned long ret, offset;
+
+	/* Load word from unaligned pointer addr */
+	asm(
+	"1:	ldr	%0, %3\n"
+	"2:\n"
+	"	.pushsection .fixup,\"ax\"\n"
+	"	.align 2\n"
+	"3:	and	%1, %2, #0x7\n"
+	"	bic	%2, %2, #0x7\n"
+	"	ldr	%0, [%2]\n"
+	"	lsl	%1, %1, #0x3\n"
+#ifndef __AARCH64EB__
+	"	lsr	%0, %0, %1\n"
+#else
+	"	lsl	%0, %0, %1\n"
+#endif
+	"	b	2b\n"
+	"	.popsection\n"
+	"	.pushsection __ex_table,\"a\"\n"
+	"	.align	3\n"
+	"	.quad	1b, 3b\n"
+	"	.popsection"
+	: "=&r" (ret), "=&r" (offset)
+	: "r" (addr), "Q" (*(unsigned long *)addr));
+
+	return ret;
+}
+
 #endif /* __ASM_WORD_AT_A_TIME_H */
-- 
1.8.2.2
