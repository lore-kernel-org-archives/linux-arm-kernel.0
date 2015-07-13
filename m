From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 Jul 2015 10:25:10 +0100
Subject: [PATCH 09/18] arm64: xchg: patch in lse instructions when supported
 by the CPU
In-Reply-To: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
References: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
Message-ID: <1436779519-2232-10-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On CPUs which support the LSE atomic instructions introduced in ARMv8.1,
it makes sense to use them in preference to ll/sc sequences.

This patch introduces runtime patching of our xchg primitives so that
the LSE swp instruction (yes, you read right!) is used instead.

Reviewed-by: Steve Capper <steve.capper@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cmpxchg.h | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index d8c25b7b18fb..d0cce8068902 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -22,6 +22,7 @@
 #include <linux/mmdebug.h>
 
 #include <asm/barrier.h>
+#include <asm/lse.h>
 
 static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size)
 {
@@ -29,37 +30,65 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 
 	switch (size) {
 	case 1:
-		asm volatile("//	__xchg1\n"
+		asm volatile(ARM64_LSE_ATOMIC_INSN(
+		/* LL/SC */
 		"1:	ldxrb	%w0, %2\n"
 		"	stlxrb	%w1, %w3, %2\n"
 		"	cbnz	%w1, 1b\n"
+		"	dmb	ish",
+		/* LSE atomics */
+		"	nop\n"
+		"	swpalb	%w3, %w0, %2\n"
+		"	nop\n"
+		"	nop")
 			: "=&r" (ret), "=&r" (tmp), "+Q" (*(u8 *)ptr)
 			: "r" (x)
 			: "memory");
 		break;
 	case 2:
-		asm volatile("//	__xchg2\n"
+		asm volatile(ARM64_LSE_ATOMIC_INSN(
+		/* LL/SC */
 		"1:	ldxrh	%w0, %2\n"
 		"	stlxrh	%w1, %w3, %2\n"
 		"	cbnz	%w1, 1b\n"
+		"	dmb	ish",
+		/* LSE atomics */
+		"	nop\n"
+		"	swpalh	%w3, %w0, %2\n"
+		"	nop\n"
+		"	nop")
 			: "=&r" (ret), "=&r" (tmp), "+Q" (*(u16 *)ptr)
 			: "r" (x)
 			: "memory");
 		break;
 	case 4:
-		asm volatile("//	__xchg4\n"
+		asm volatile(ARM64_LSE_ATOMIC_INSN(
+		/* LL/SC */
 		"1:	ldxr	%w0, %2\n"
 		"	stlxr	%w1, %w3, %2\n"
 		"	cbnz	%w1, 1b\n"
+		"	dmb	ish",
+		/* LSE atomics */
+		"	nop\n"
+		"	swpal	%w3, %w0, %2\n"
+		"	nop\n"
+		"	nop")
 			: "=&r" (ret), "=&r" (tmp), "+Q" (*(u32 *)ptr)
 			: "r" (x)
 			: "memory");
 		break;
 	case 8:
-		asm volatile("//	__xchg8\n"
+		asm volatile(ARM64_LSE_ATOMIC_INSN(
+		/* LL/SC */
 		"1:	ldxr	%0, %2\n"
 		"	stlxr	%w1, %3, %2\n"
 		"	cbnz	%w1, 1b\n"
+		"	dmb	ish",
+		/* LSE atomics */
+		"	nop\n"
+		"	swpal	%3, %0, %2\n"
+		"	nop\n"
+		"	nop")
 			: "=&r" (ret), "=&r" (tmp), "+Q" (*(u64 *)ptr)
 			: "r" (x)
 			: "memory");
@@ -68,7 +97,6 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 		BUILD_BUG();
 	}
 
-	smp_mb();
 	return ret;
 }
 
-- 
2.1.4
