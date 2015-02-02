From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Mon, 2 Feb 2015 11:55:03 +0800
Subject: [RFC] change non-atomic bitops method
Message-ID: <35FD53F367049845BC99AC72306C23D1044A02027E0A@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch change non-atomic bitops,
add a if() condition to test it, before set/clear the bit.
so that we don't need dirty the cache line, if this bit
have been set or clear. On SMP system, dirty cache line will
need invalidate other processors cache line, this will have
some impact on SMP systems.

Signed-off-by: Yalin Wang <yalin.wang@sonymobile.com>
---
 include/asm-generic/bitops/non-atomic.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/bitops/non-atomic.h b/include/asm-generic/bitops/non-atomic.h
index 697cc2b..e4ef18a 100644
--- a/include/asm-generic/bitops/non-atomic.h
+++ b/include/asm-generic/bitops/non-atomic.h
@@ -17,7 +17,9 @@ static inline void __set_bit(int nr, volatile unsigned long *addr)
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
 
-	*p  |= mask;
+	if ((*p & mask) == 0)
+		*p  |= mask;
+
 }
 
 static inline void __clear_bit(int nr, volatile unsigned long *addr)
@@ -25,7 +27,8 @@ static inline void __clear_bit(int nr, volatile unsigned long *addr)
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
 
-	*p &= ~mask;
+	if ((*p & mask) != 0)
+		*p &= ~mask;
 }
 
 /**
@@ -60,7 +63,8 @@ static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
 	unsigned long old = *p;
 
-	*p = old | mask;
+	if ((old & mask) == 0)
+		*p = old | mask;
 	return (old & mask) != 0;
 }
 
@@ -79,7 +83,8 @@ static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
 	unsigned long old = *p;
 
-	*p = old & ~mask;
+	if ((old & mask) != 0)
+		*p = old & ~mask;
 	return (old & mask) != 0;
 }
 
-- 
2.2.2
