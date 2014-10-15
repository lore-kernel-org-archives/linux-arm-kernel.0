From: steve.capper@linaro.org (Steve Capper)
Date: Wed, 15 Oct 2014 12:58:43 +0100
Subject: [PATCH] arm64: xchg: Implement cmpxchg_double
Message-ID: <1413374323-2062-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm64 architecture has the ability to exclusively load and store
a pair of registers from an address (ldxp/stxp). Also the SLUB can take
advantage of a cmpxchg_double implementation to avoid taking some
locks.

This patch provides an implementation of cmpxchg_double for 64-bit
pairs, and activates the logic required for the SLUB to use these
functions (HAVE_ALIGNED_STRUCT_PAGE and HAVE_CMPXCHG_DOUBLE).

On a Juno platform running on only the A57s I get quite a noticeable
performance improvement with hackbench.

Before patch applied:
$ ./hackbench 100 process 1000
Running with 100*40 (== 4000) tasks.
Time: 206.331

After patch applied:
$ ./hackbench 100 process 1000
Running with 100*40 (== 4000) tasks.
Time: 182.396

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm64/Kconfig               |  2 ++
 arch/arm64/include/asm/cmpxchg.h | 55 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fd4e81a..4a0f9a1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -31,12 +31,14 @@ config ARM64
 	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
 	select HARDIRQS_SW_RESEND
+	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_CC_STACKPROTECTOR
+	select HAVE_CMPXCHG_DOUBLE
 	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_API_DEBUG
diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index ddb9d78..47d2929 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -19,6 +19,7 @@
 #define __ASM_CMPXCHG_H
 
 #include <linux/bug.h>
+#include <linux/mmdebug.h>
 
 #include <asm/barrier.h>
 
@@ -152,6 +153,51 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 	return oldval;
 }
 
+#define system_has_cmpxchg_double()     1
+
+static inline int __cmpxchg_double(volatile void *ptr1, volatile void *ptr2,
+		unsigned long old1, unsigned long old2,
+		unsigned long new1, unsigned long new2, int size)
+{
+	unsigned long loop, lost;
+
+	switch (size) {
+	case 8:
+		VM_BUG_ON((unsigned long *)ptr2 - (unsigned long *)ptr1 != 1);
+		do {
+			asm volatile("// __cmpxchg_double8\n"
+			"	ldxp	%0, %1, %2\n"
+			"	eor	%0, %0, %3\n"
+			"	eor	%1, %1, %4\n"
+			"	orr	%1, %0, %1\n"
+			"	mov	%w0, #0\n"
+			"	cbnz	%1, 1f\n"
+			"	stxp	%w0, %5, %6, %2\n"
+			"1:\n"
+				: "=&r"(loop), "=&r"(lost), "+Q" (*(u64 *)ptr1)
+				: "r" (old1), "r"(old2), "r"(new1), "r"(new2));
+		} while (loop);
+		break;
+	default:
+		BUILD_BUG();
+	}
+
+	return !lost;
+}
+
+static inline int __cmpxchg_double_mb(volatile void *ptr1, volatile void *ptr2,
+			unsigned long old1, unsigned long old2,
+			unsigned long new1, unsigned long new2, int size)
+{
+	int ret;
+
+	smp_mb();
+	ret = __cmpxchg_double(ptr1, ptr2, old1, old2, new1, new2, size);
+	smp_mb();
+
+	return ret;
+}
+
 static inline unsigned long __cmpxchg_mb(volatile void *ptr, unsigned long old,
 					 unsigned long new, int size)
 {
@@ -173,6 +219,15 @@ static inline unsigned long __cmpxchg_mb(volatile void *ptr, unsigned long old,
 	__ret; \
 })
 
+#define cmpxchg_double(ptr1, ptr2, o1, o2, n1, n2) \
+({\
+	int __ret;\
+	__ret = __cmpxchg_double_mb((ptr1), (ptr2), (unsigned long)(o1), \
+			(unsigned long)(o2), (unsigned long)(n1), \
+			(unsigned long)(n2), sizeof(*(ptr1)));\
+	__ret; \
+})
+
 #define cmpxchg_local(ptr, o, n) \
 ({ \
 	__typeof__(*(ptr)) __ret; \
-- 
1.9.3
