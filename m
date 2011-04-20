From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Wed, 20 Apr 2011 23:20:50 +0900
Subject: [PATCH 1/3] bitops: add ifdef CONFIG_GENERIC_FIND_BIT_LE guard
Message-ID: <1303309252-9946-1-git-send-email-akinobu.mita@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some architectures have optimized find_*_bit_le() as static inline
functions but other little-endian bitops are identical to the generic
version.

This adds #ifdef CONFIG_GENERIC_FIND_BIT_LE guard for find_*_bit_le()
in asm-generic/bitops/le.h so that those architectures can use this
header file.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch at vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux390 at de.ibm.com
Cc: linux-s390 at vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
 include/asm-generic/bitops/le.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/asm-generic/bitops/le.h b/include/asm-generic/bitops/le.h
index 946a21b..bd2253e 100644
--- a/include/asm-generic/bitops/le.h
+++ b/include/asm-generic/bitops/le.h
@@ -30,6 +30,8 @@ static inline unsigned long find_first_zero_bit_le(const void *addr,
 
 #define BITOP_LE_SWIZZLE	((BITS_PER_LONG-1) & ~0x7)
 
+#ifdef CONFIG_GENERIC_FIND_BIT_LE
+
 extern unsigned long find_next_zero_bit_le(const void *addr,
 		unsigned long size, unsigned long offset);
 extern unsigned long find_next_bit_le(const void *addr,
@@ -38,6 +40,8 @@ extern unsigned long find_next_bit_le(const void *addr,
 #define find_first_zero_bit_le(addr, size) \
 	find_next_zero_bit_le((addr), (size), 0)
 
+#endif /* CONFIG_GENERIC_FIND_BIT_LE */
+
 #else
 #error "Please fix <asm/byteorder.h>"
 #endif
-- 
1.7.4.4
