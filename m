From: bobby.prani@gmail.com (Pranith Kumar)
Date: Wed, 25 Feb 2015 10:36:20 -0500
Subject: [RFC PATCH] arm: asm/cmpxchg.h: Add support half-word xchg()
Message-ID: <1424878581-11701-1-git-send-email-bobby.prani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for a half-word xchg() for ARM using ldrexh/strexh
instructions. It also fixes an asm comment  for __cmpxchg2.

Currently using a half-word xchg() results in the following splat on an ARMv7
machine.

[   45.833303] xchg: bad data size: pc 0xbe806020, ptr 0xeb18deee, size 2
[   45.833324] ------------[ cut here ]------------
[   45.837939] kernel BUG at /dvs/git/dirty/git-master_linux/kernel/arch/arm/kernel/traps.c:727!

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 arch/arm/include/asm/cmpxchg.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
index abb2c37..9505cca 100644
--- a/arch/arm/include/asm/cmpxchg.h
+++ b/arch/arm/include/asm/cmpxchg.h
@@ -50,6 +50,16 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 			: "r" (x), "r" (ptr)
 			: "memory", "cc");
 		break;
+	case 2:
+		asm volatile("@	__xchg2\n"
+		"1:	ldrexh	%0, [%3]\n"
+		"	strexh	%1, %2, [%3]\n"
+		"	teq	%1, #0\n"
+		"	bne	1b"
+			: "=&r" (ret), "=&r" (tmp)
+			: "r" (x), "r" (ptr)
+			: "memory", "cc");
+		break;
 	case 4:
 		asm volatile("@	__xchg4\n"
 		"1:	ldrex	%0, [%3]\n"
@@ -93,6 +103,12 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 			: "memory", "cc");
 		break;
 #endif
+	case 2:
+		raw_local_irq_save(flags);
+		ret = *(volatile uint16_t *)ptr;
+		*(volatile uint16_t *)ptr = x;
+		raw_local_irq_restore(flags);
+		break;
 	default:
 		__bad_xchg(ptr, size), ret = 0;
 		break;
@@ -158,7 +174,7 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 		break;
 	case 2:
 		do {
-			asm volatile("@ __cmpxchg1\n"
+			asm volatile("@ __cmpxchg2\n"
 			"	ldrexh	%1, [%2]\n"
 			"	mov	%0, #0\n"
 			"	teq	%1, %3\n"
-- 
1.9.1
