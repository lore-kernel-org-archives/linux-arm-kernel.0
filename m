From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Wed, 20 Apr 2011 23:20:51 +0900
Subject: [PATCH 2/3] arm: use asm-generic/bitops/le.h
In-Reply-To: <1303309252-9946-1-git-send-email-akinobu.mita@gmail.com>
References: <1303309252-9946-1-git-send-email-akinobu.mita@gmail.com>
Message-ID: <1303309252-9946-2-git-send-email-akinobu.mita@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The previous change enables to use asm-generic/bitops/le.h on arm.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/include/asm/bitops.h |   41 ++++-------------------------------------
 1 files changed, 4 insertions(+), 37 deletions(-)

diff --git a/arch/arm/include/asm/bitops.h b/arch/arm/include/asm/bitops.h
index ec2e0d4..4615e1b 100644
--- a/arch/arm/include/asm/bitops.h
+++ b/arch/arm/include/asm/bitops.h
@@ -203,8 +203,6 @@ extern int _find_next_bit_be(const unsigned long *p, int size, int offset);
 #define find_first_bit(p,sz)		_find_first_bit_le(p,sz)
 #define find_next_bit(p,sz,off)		_find_next_bit_le(p,sz,off)
 
-#define WORD_BITOFF_TO_LE(x)		((x))
-
 #else
 /*
  * These are the big endian, atomic definitions.
@@ -214,8 +212,6 @@ extern int _find_next_bit_be(const unsigned long *p, int size, int offset);
 #define find_first_bit(p,sz)		_find_first_bit_be(p,sz)
 #define find_next_bit(p,sz,off)		_find_next_bit_be(p,sz,off)
 
-#define WORD_BITOFF_TO_LE(x)		((x) ^ 0x18)
-
 #endif
 
 #if __LINUX_ARM_ARCH__ < 5
@@ -287,40 +283,9 @@ static inline int fls(int x)
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/lock.h>
 
-static inline void __set_bit_le(int nr, void *addr)
-{
-	__set_bit(WORD_BITOFF_TO_LE(nr), addr);
-}
-
-static inline void __clear_bit_le(int nr, void *addr)
-{
-	__clear_bit(WORD_BITOFF_TO_LE(nr), addr);
-}
-
-static inline int __test_and_set_bit_le(int nr, void *addr)
-{
-	return __test_and_set_bit(WORD_BITOFF_TO_LE(nr), addr);
-}
+#include <asm-generic/bitops/le.h>
 
-static inline int test_and_set_bit_le(int nr, void *addr)
-{
-	return test_and_set_bit(WORD_BITOFF_TO_LE(nr), addr);
-}
-
-static inline int __test_and_clear_bit_le(int nr, void *addr)
-{
-	return __test_and_clear_bit(WORD_BITOFF_TO_LE(nr), addr);
-}
-
-static inline int test_and_clear_bit_le(int nr, void *addr)
-{
-	return test_and_clear_bit(WORD_BITOFF_TO_LE(nr), addr);
-}
-
-static inline int test_bit_le(int nr, const void *addr)
-{
-	return test_bit(WORD_BITOFF_TO_LE(nr), addr);
-}
+#ifdef __ARMEB__
 
 static inline int find_first_zero_bit_le(const void *p, unsigned size)
 {
@@ -337,6 +302,8 @@ static inline int find_next_bit_le(const void *p, int size, int offset)
 	return _find_next_bit_le(p, size, offset);
 }
 
+#endif
+
 /*
  * Ext2 is defined to use little-endian byte ordering.
  */
-- 
1.7.4.4
