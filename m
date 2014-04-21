From: rabin@rab.in (Rabin Vincent)
Date: Mon, 21 Apr 2014 20:10:08 +0200
Subject: [PATCH] ARM: fix string functions on !MMU
Message-ID: <1398103808-24380-1-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

8c56cc8be5b38e ("ARM: 7449/1: use generic strnlen_user and
strncpy_from_user functions") apparently broken those string operations
for !MMU.  USER_DS == KERNEL_DS on !MMU, so user_addr_max() always
restricts the addresses to TASK_SIZE.

TASK_SIZE has anyway no meaning on !MMU, so make user_addr_max() not
restrict anything.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/include/asm/uaccess.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 12c3a5d..c3a65f1 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -199,6 +199,9 @@ extern int __put_user_8(void *, unsigned long long);
 		__put_user_check(x,p);					\
 	 })
 
+#define user_addr_max() \
+	(segment_eq(get_fs(), USER_DS) ? TASK_SIZE : ~0UL)
+
 #else /* CONFIG_MMU */
 
 /*
@@ -210,6 +213,7 @@ extern int __put_user_8(void *, unsigned long long);
 #define __addr_ok(addr)		((void)(addr),1)
 #define __range_ok(addr,size)	((void)(addr),0)
 #define get_fs()		(KERNEL_DS)
+#define user_addr_max()		(~0UL)
 
 static inline void set_fs(mm_segment_t fs)
 {
@@ -222,9 +226,6 @@ static inline void set_fs(mm_segment_t fs)
 
 #define access_ok(type,addr,size)	(__range_ok(addr,size) == 0)
 
-#define user_addr_max() \
-	(segment_eq(get_fs(), USER_DS) ? TASK_SIZE : ~0UL)
-
 /*
  * The "__xxx" versions of the user access functions do not verify the
  * address space - it must have been done previously with a separate
-- 
1.9.1
