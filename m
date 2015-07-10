From: ganguly.s@samsung.com (Sarbojit Ganguly)
Date: Fri, 10 Jul 2015 07:50:09 +0000 (GMT)
Subject: [PATCH] arm: Adding support for atomic half word exchange
Message-ID: <710840938.569501436514608029.JavaMail.weblogic@ep2mlwas06b>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Since 16 bit half word exchange was not there and MCS based qspinlock by Waiman's xchg_tail() requires an atomic exchange on a half word,
here is a small modification to __xchg() code to support the exchange.
ARMv6 and lower does not have support for LDREXH, so we need to make sure things do not break when we're compiling on ARMv6.

Signed-off-by: Sarbojit Ganguly <ganguly.s@samsung.com>
---
 arch/arm/include/asm/cmpxchg.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
index 1692a05..547101d 100644
--- a/arch/arm/include/asm/cmpxchg.h
+++ b/arch/arm/include/asm/cmpxchg.h
@@ -50,6 +50,24 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 			: "r" (x), "r" (ptr)
 			: "memory", "cc");
 		break;
+#if !defined (CONFIG_CPU_V6)
+		/*
+		 * Halfword exclusive exchange
+		 * This is new implementation as qspinlock
+		 * wants 16 bit atomic CAS.
+		 * This is not supported on ARMv6.
+		 */
+	case 2:
+		asm volatile("@ __xchg2\n"
+		"1:     ldrexh  %0, [%3]\n"
+		"       strexh  %1, %2, [%3]\n"
+		"       teq     %1, #0\n"
+		"       bne     1b"
+		: "=&r" (ret), "=&r" (tmp)
+		: "r" (x), "r" (ptr)
+		: "memory", "cc");
+		break;
+#endif
 	case 4:
 		asm volatile("@	__xchg4\n"
 		"1:	ldrex	%0, [%3]\n"
-- 

Sarbojit
