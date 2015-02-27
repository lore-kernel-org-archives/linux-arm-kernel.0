From: bobby.prani@gmail.com (Pranith Kumar)
Date: Fri, 27 Feb 2015 00:46:55 -0500
Subject: [RFC PATCH] ARM64: cmpxchg.h: Clear the exclusive access bit on fail
Message-ID: <1425016026-19766-1-git-send-email-bobby.prani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In cmpxchg(), we do a load exclusive on an address and upon a comparison fail,
we skip the store exclusive instruction. This can result in the exclusive bit
still set. If there was a store exclusive after this to the same address, that
will see the exclusive bit set. This should not happen.

We need to clear the exclusive bit in these cases.

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 arch/arm64/include/asm/cmpxchg.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index cb95930..ed2cf90 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -94,7 +94,7 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 			"	cmp	%w1, %w3\n"
 			"	b.ne	1f\n"
 			"	stxrb	%w0, %w4, %2\n"
-			"1:\n"
+			"1:	clrex\n"
 				: "=&r" (res), "=&r" (oldval), "+Q" (*(u8 *)ptr)
 				: "Ir" (old), "r" (new)
 				: "cc");
@@ -109,7 +109,7 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 			"	cmp	%w1, %w3\n"
 			"	b.ne	1f\n"
 			"	stxrh	%w0, %w4, %2\n"
-			"1:\n"
+			"1:	clrex\n"
 				: "=&r" (res), "=&r" (oldval), "+Q" (*(u16 *)ptr)
 				: "Ir" (old), "r" (new)
 				: "cc");
@@ -124,7 +124,7 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 			"	cmp	%w1, %w3\n"
 			"	b.ne	1f\n"
 			"	stxr	%w0, %w4, %2\n"
-			"1:\n"
+			"1:	clrex\n"
 				: "=&r" (res), "=&r" (oldval), "+Q" (*(u32 *)ptr)
 				: "Ir" (old), "r" (new)
 				: "cc");
@@ -139,7 +139,7 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 			"	cmp	%1, %3\n"
 			"	b.ne	1f\n"
 			"	stxr	%w0, %4, %2\n"
-			"1:\n"
+			"1:	clrex\n"
 				: "=&r" (res), "=&r" (oldval), "+Q" (*(u64 *)ptr)
 				: "Ir" (old), "r" (new)
 				: "cc");
@@ -173,7 +173,7 @@ static inline int __cmpxchg_double(volatile void *ptr1, volatile void *ptr2,
 			"	mov	%w0, #0\n"
 			"	cbnz	%1, 1f\n"
 			"	stxp	%w0, %5, %6, %2\n"
-			"1:\n"
+			"1:	clrex\n"
 				: "=&r"(loop), "=&r"(lost), "+Q" (*(u64 *)ptr1)
 				: "r" (old1), "r"(old2), "r"(new1), "r"(new2));
 		} while (loop);
-- 
1.9.1
