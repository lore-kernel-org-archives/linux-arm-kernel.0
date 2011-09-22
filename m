From: mhban@samsung.com (mhban)
Date: Thu, 22 Sep 2011 11:53:35 +0900
Subject: [PATCH] ARM: futex: fix clobbering oldval
Message-ID: <1316660015.6872.1.camel@puffmine-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes clobbering oldval bug. oldval should be preserved for next
compare operation.

Change-Id: I2a63bc1bdb8de330eb9e1ac02d7da1f77e6e8c3c
Signed-off-by: Minho Ban <mhban@samsung.com>
---
 arch/arm/include/asm/futex.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/futex.h b/arch/arm/include/asm/futex.h
index d2d733c..b0f2e8e 100644
--- a/arch/arm/include/asm/futex.h
+++ b/arch/arm/include/asm/futex.h
@@ -30,14 +30,14 @@
 	__asm__ __volatile__(					\
 	"1:	ldrex	%1, [%2]\n"				\
 	"	" insn "\n"					\
-	"2:	strex	%1, %0, [%2]\n"				\
-	"	teq	%1, #0\n"				\
+	"2:	strex	r5, %0, [%2]\n"				\
+	"	teq	r5, #0\n"				\
 	"	bne	1b\n"					\
 	"	mov	%0, #0\n"				\
 	__futex_atomic_ex_table("%4")				\
 	: "=&r" (ret), "=&r" (oldval)				\
 	: "r" (uaddr), "r" (oparg), "Ir" (-EFAULT)		\
-	: "cc", "memory")
+	: "r5", "cc", "memory")
 
 static inline int
 futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
-- 
1.7.0.4
