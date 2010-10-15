From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Fri, 15 Oct 2010 18:46:03 +0900
Subject: [PATCH 04/22] arm: introduce little endian bitops
In-Reply-To: <1287135981-17604-1-git-send-email-akinobu.mita@gmail.com>
References: <1287135981-17604-1-git-send-email-akinobu.mita@gmail.com>
Message-ID: <1287135981-17604-5-git-send-email-akinobu.mita@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce little endian bit operations by renaming native ext2 bit
operations. The ext2 bit operations are kept by using little endian
bit operations until the conversions are finished.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/include/asm/bitops.h |   46 +++++++++++++++++++++++++++++-----------
 1 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/bitops.h b/arch/arm/include/asm/bitops.h
index 338ff19..d8af4af 100644
--- a/arch/arm/include/asm/bitops.h
+++ b/arch/arm/include/asm/bitops.h
@@ -303,41 +303,61 @@ static inline int fls(int x)
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/lock.h>
 
+#define __set_le_bit(nr, p)			\
+	__set_bit(WORD_BITOFF_TO_LE(nr), (p))
+#define __clear_le_bit(nr, p)			\
+	__clear_bit(WORD_BITOFF_TO_LE(nr), (p))
+#define __test_and_set_le_bit(nr, p)			\
+		__test_and_set_bit(WORD_BITOFF_TO_LE(nr), (p))
+#define test_and_set_le_bit(lock, nr, p)          \
+		test_and_set_bit(WORD_BITOFF_TO_LE(nr), (p))
+#define __test_and_clear_le_bit(nr, p)			\
+		__test_and_clear_bit(WORD_BITOFF_TO_LE(nr), (p))
+#define test_and_clear_le_bit(lock, nr, p)	\
+		test_and_clear_bit(WORD_BITOFF_TO_LE(nr), (p))
+#define test_le_bit(nr, p)			\
+		test_bit(WORD_BITOFF_TO_LE(nr), (p))
+#define find_first_zero_le_bit(p, sz)		\
+		_find_first_zero_bit_le(p, sz)
+#define find_next_zero_le_bit(p, sz, off)	\
+		_find_next_zero_bit_le(p, sz, off)
+#define find_next_le_bit(p, sz, off) \
+		_find_next_bit_le(p, sz, off)
 /*
  * Ext2 is defined to use little-endian byte ordering.
  * These do not need to be atomic.
  */
 #define ext2_set_bit(nr,p)			\
-		__test_and_set_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+		__test_and_set_le_bit(nr, (unsigned long *)(p))
 #define ext2_set_bit_atomic(lock,nr,p)          \
-                test_and_set_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+		test_and_set_le_bit(nr, (unsigned long *)(p))
 #define ext2_clear_bit(nr,p)			\
-		__test_and_clear_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+		__test_and_clear_le_bit(nr, (unsigned long *)(p))
 #define ext2_clear_bit_atomic(lock,nr,p)        \
-                test_and_clear_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+		test_and_clear_le_bit(nr, (unsigned long *)(p))
 #define ext2_test_bit(nr,p)			\
-		test_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+		test_le_bit(nr, (unsigned long *)(p))
 #define ext2_find_first_zero_bit(p,sz)		\
-		_find_first_zero_bit_le(p,sz)
+		find_first_zero_le_bit((unsigned long *)(p), sz)
 #define ext2_find_next_zero_bit(p,sz,off)	\
-		_find_next_zero_bit_le(p,sz,off)
+		find_next_zero_le_bit((unsigned long *)(p), sz, off)
 #define ext2_find_next_bit(p, sz, off) \
-		_find_next_bit_le(p, sz, off)
+		find_next_le_bit((unsigned long *)(p), sz, off)
 
 /*
  * Minix is defined to use little-endian byte ordering.
  * These do not need to be atomic.
  */
 #define minix_set_bit(nr,p)			\
-		__set_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+		__set_le_bit(nr, (unsigned long *)(p))
 #define minix_test_bit(nr,p)			\
-		test_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+		test_le_bit(nr, (unsigned long *)(p))
 #define minix_test_and_set_bit(nr,p)		\
-		__test_and_set_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+		__test_and_set_le_bit(nr, (unsigned long *)(p))
 #define minix_test_and_clear_bit(nr,p)		\
-		__test_and_clear_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+		__test_and_clear_le_bit(nr, (unsigned long *)(p))
 #define minix_find_first_zero_bit(p,sz)		\
-		_find_first_zero_bit_le(p,sz)
+		find_first_zero_le_bit((unsigned long *)(p), sz)
 
 #endif /* __KERNEL__ */
 
-- 
1.7.1.231.gd0b16
