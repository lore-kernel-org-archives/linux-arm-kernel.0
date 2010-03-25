From: virtuoso@slind.org (Alexander Shishkin)
Date: Thu, 25 Mar 2010 17:52:40 +0200
Subject: [PATCH 1/1] [RFCv2] arm: add half-word __xchg
In-Reply-To: <20100318135008.GA11800@Krystal>
References: <20100318135008.GA11800@Krystal>
Message-ID: <1269532360-18504-1-git-send-email-virtuoso@slind.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On systems where ldrexh/strexh are not available,
  * for pre-v6 systems, use a generic local version,
  * for v6 without v6K, emulate xchg2 using 32-bit cmpxchg()
    (it is not yet clear if xchg1 has to be emulated on such
    systems as well, thus the "size" parameter).

The __xchg_generic() function is based on the code that Jamie
posted earlier.

Signed-off-by: Alexander Shishkin <virtuoso@slind.org>
CC: linux-arm-kernel-bounces at lists.infradead.org
CC: Imre Deak <imre.deak@nokia.com>
CC: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
CC: Jamie Lokier <jamie@shareable.org>
---
 arch/arm/include/asm/system.h |   53 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index d65b2f5..e7a17ab 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -218,6 +218,36 @@ do {									\
 	last = __switch_to(prev,task_thread_info(prev), task_thread_info(next));	\
 } while (0)
 
+#ifdef __LINUX_ARM_ARCH__ >= 6
+static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
+				      unsigned long new, int size);
+
+/*
+ * emulate __xchg() using 32-bit __cmpxchg()
+ */
+static inline unsigned long __xchg_generic(unsigned long x,
+						 volatile void *ptr, int size)
+{
+	unsigned long *ptrbig = (unsigned long *)((unsigned long)ptr & ~3UL);
+	int shift = ((unsigned)ptr - (unsigned)ptrbig) * 8;
+	unsigned long mask, add, ret;
+
+	mask = ~(((1 << (size * 8)) - 1) << shift);
+	add = x << shift;
+
+	ret = *ptrbig;
+	while (1) {
+		unsigned long tmp = __cmpxchg(ptrbig, ret, (ret & mask) | add,
+					      4);
+		if (tmp == ret)
+			break;
+		ret = tmp;
+	}
+
+	return ret;
+}
+#endif
+
 #if defined(CONFIG_CPU_SA1100) || defined(CONFIG_CPU_SA110)
 /*
  * On the StrongARM, "swp" is terminally broken since it bypasses the
@@ -262,6 +292,22 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 			: "r" (x), "r" (ptr)
 			: "memory", "cc");
 		break;
+#ifdef CONFIG_CPU_32v6K
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
+#else
+	case 2:
+		ret = __xchg_generic(x, ptr, 2);
+		break;
+#endif
 	case 4:
 		asm volatile("@	__xchg4\n"
 		"1:	ldrex	%0, [%3]\n"
@@ -283,6 +329,13 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 		raw_local_irq_restore(flags);
 		break;
 
+	case 2:
+		raw_local_irq_save(flags);
+		ret = *(volatile unsigned short *)ptr;
+		*(volatile unsigned short *)ptr = x;
+		raw_local_irq_restore(flags);
+		break;
+
 	case 4:
 		raw_local_irq_save(flags);
 		ret = *(volatile unsigned long *)ptr;
-- 
1.6.3.3
