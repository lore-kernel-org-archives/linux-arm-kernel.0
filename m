From: murzin.v@gmail.com (Vladimir Murzin)
Date: Thu, 17 Apr 2014 09:38:01 +0100
Subject: [PATCH RFC] arm64: 32-bit tolerant sync bitops
Message-ID: <1397723881-31648-1-git-send-email-murzin.v@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Xen assumes that bit operations are able to operate on 32-bit size and
alignment [1]. For arm64 bitops are based on atomic exclusive load/store
instructions to guarantee that changes are made atomically. However, these
instructions require that address to be aligned to the data size. Because, by
default, bitops operates on 64-bit size it implies that address should be
aligned appropriately. All these lead to breakage of Xen assumption for bitops
properties.

With this patch 32-bit sized/aligned bitops is implemented. 

[1] http://www.gossamer-threads.com/lists/xen/devel/325613

Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
---
 Apart this patch other approaches were implemented:
 1. turn bitops to be 32-bit size/align tolerant.
    the changes are minimal, but I'm not sure how broad side effect might be
 2. separate 32-bit size/aligned operations.
    it exports new API, which might not be good

 All implementations based on arm64 version of bitops and were boot tested
 only. Hope, I didn't miss something ;) 

 arch/arm64/include/asm/sync_bitops.h | 60 ++++++++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/sync_bitops.h b/arch/arm64/include/asm/sync_bitops.h
index 8da0bf4..809926f 100644
--- a/arch/arm64/include/asm/sync_bitops.h
+++ b/arch/arm64/include/asm/sync_bitops.h
@@ -3,6 +3,7 @@
 
 #include <asm/bitops.h>
 #include <asm/cmpxchg.h>
+#include <linux/stringify.h>
 
 /* sync_bitops functions are equivalent to the SMP implementation of the
  * original functions, independently from CONFIG_SMP being defined.
@@ -12,14 +13,61 @@
  * who might be on another CPU (e.g. two uniprocessor guests communicating
  * via event channels and grant tables). So we need a variant of the bit
  * ops which are SMP safe even on a UP kernel.
+ *
+ * Xen assumes that bitops are 32-bit sized/aligned
  */
 
-#define sync_set_bit(nr, p)            set_bit(nr, p)
-#define sync_clear_bit(nr, p)          clear_bit(nr, p)
-#define sync_change_bit(nr, p)         change_bit(nr, p)
-#define sync_test_and_set_bit(nr, p)   test_and_set_bit(nr, p)
-#define sync_test_and_clear_bit(nr, p) test_and_clear_bit(nr, p)
-#define sync_test_and_change_bit(nr, p)        test_and_change_bit(nr, p)
+#define sync_bitop32(name, instr)					\
+static inline void sync_##name(int nr, volatile unsigned long *addr)	\
+{									\
+	unsigned tmp1, tmp2;						\
+	asm volatile(							\
+	"	and	%w1, %w2, #31\n"				\
+	"	eor	%w2, %w2, %w1\n"				\
+	"	mov	%w0, #1\n"					\
+	"	add	%3, %3, %2, lsr #2\n"				\
+	"	lsl	%w1, %w0, %w1\n"				\
+	"1:	ldxr	%w0, [%3]\n"					\
+	__stringify(instr)" %w0, %w0, %w1\n"				\
+	"	stxr	%w2, %w0, [%3]\n"				\
+	"	cbnz	%w2, 1b\n"					\
+	: "=&r"(tmp1), "=&r"(tmp2)		 			\
+	: "r"(nr), "r"(addr)						\
+	: "memory");							\
+}
+
+#define sync_testop32(name, instr)					\
+static inline int sync_##name(int nr, volatile unsigned long *addr)	\
+{									\
+	int oldbit;							\
+	unsigned tmp1, tmp2, tmp3;	  				\
+	asm volatile(							\
+	"	and	%w1, %w4, #31\n"				\
+	"	eor	%w4, %w4, %w1\n"				\
+	"	mov	%w0, #1\n"					\
+	"	add	%5, %5, %4, lsr #2\n"				\
+	"	lsl	%w2, %w0, %w1\n"				\
+	"1:	ldxr	%w0, [%5]\n"					\
+	"	lsr	%w3, %w0, %w1\n"				\
+	__stringify(instr)" %w0, %w0, %w2\n"				\
+	"	stlxr	%w4, %w0, [%5]\n"				\
+	"	cbnz	%w4, 1b\n"					\
+	"	dmb	ish\n"						\
+	"	and	%w3, %w3, #1\n"					\
+	: "=&r"(tmp1), "=&r"(tmp2), "=&r"(tmp3), "=&r"(oldbit)		\
+	: "r"(nr), "r"(addr)						\
+	: "memory");							\
+	return oldbit;							\
+}
+
+sync_bitop32(set_bit, orr)
+sync_bitop32(clear_bit, bic)
+sync_bitop32(change_bit, eor)
+
+sync_testop32(test_and_set_bit, orr)
+sync_testop32(test_and_clear_bit, bic)
+sync_testop32(test_and_change_bit, eor)
+
 #define sync_test_bit(nr, addr)                test_bit(nr, addr)
 #define sync_cmpxchg                   cmpxchg
 
-- 
1.8.3.2
