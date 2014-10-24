From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 24 Oct 2014 13:22:20 +0100
Subject: [PATCH V2] arm64: xchg: Implement cmpxchg_double
In-Reply-To: <1413374323-2062-1-git-send-email-steve.capper@linaro.org>
References: <1413374323-2062-1-git-send-email-steve.capper@linaro.org>
Message-ID: <1414153340-19552-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm64 architecture has the ability to exclusively load and store
a pair of registers from an address (ldxp/stxp). Also the SLUB can take
advantage of a cmpxchg_double implementation to avoid taking some
locks.

This patch provides an implementation of cmpxchg_double for 64-bit
pairs, and activates the logic required for the SLUB to use these
functions (HAVE_ALIGNED_STRUCT_PAGE and HAVE_CMPXCHG_DOUBLE).

Also definitions of this_cpu_cmpxchg_8 and this_cpu_cmpxchg_double_8
are wired up to cmpxchg_local and cmpxchg_double_local (rather than the
stock implementations that perform non-atomic operations with
interrupts disabled) as they are used by the SLUB.

On a Juno platform running on only the A57s I get quite a noticeable
performance improvement with 5 runs of hackbench on v3.17:

         Baseline | With Patch
 -----------------+-----------
 Mean    119.2312 | 106.1782
 StdDev    0.4919 |   0.4494

(times taken to complete `./hackbench 100 process 1000', in seconds)

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
Changed in V2, added the this_cpu_cmpxchg* definitions, these are used
by the fast path of the SLUB (without this our hackbench mean goes up
to 111.9 seconds).
Cheers Liviu for pointing out this ommission!

The performance measurements were taken against a newer kernel running
on a board with newer firmware, thus the baseline is faster than the
one posted in V1.
---
 arch/arm64/Kconfig               |  2 ++
 arch/arm64/include/asm/cmpxchg.h | 71 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

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
index ddb9d78..89e397b 100644
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
@@ -182,6 +228,31 @@ static inline unsigned long __cmpxchg_mb(volatile void *ptr, unsigned long old,
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
+#define cmpxchg_double_local(ptr1, ptr2, o1, o2, n1, n2) \
+({\
+	int __ret;\
+	__ret = __cmpxchg_double((ptr1), (ptr2), (unsigned long)(o1), \
+			(unsigned long)(o2), (unsigned long)(n1), \
+			(unsigned long)(n2), sizeof(*(ptr1)));\
+	__ret; \
+})
+
+#define this_cpu_cmpxchg_8(ptr, o, n) \
+	cmpxchg_local(raw_cpu_ptr(&(ptr)), o, n)
+
+#define this_cpu_cmpxchg_double_8(ptr1, ptr2, o1, o2, n1, n2) \
+	cmpxchg_double_local(raw_cpu_ptr(&(ptr1)), raw_cpu_ptr(&(ptr2)), \
+				o1, o2, n1, n2)
+
 #define cmpxchg64(ptr,o,n)		cmpxchg((ptr),(o),(n))
 #define cmpxchg64_local(ptr,o,n)	cmpxchg_local((ptr),(o),(n))
 
-- 
1.9.3
