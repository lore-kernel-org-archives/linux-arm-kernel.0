From: cov@codeaurora.org (Christopher Covington)
Date: Wed,  5 Mar 2014 17:41:28 -0500
Subject: [RFC PATCH] arm64: Fix __addr_ok and __range_ok macros
Message-ID: <1394059289-3972-1-git-send-email-cov@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this, the following scenario is incorrectly determined
to be invalid.

addr 0x7f_ffffe000 size 8192 addr_limit 0x80_00000000

This behavior was observed while trying to vmsplice the stack
as part of a CRIU dump of a process.

Signed-off-by: Christopher Covington <cov@codeaurora.org>
---
 arch/arm64/include/asm/uaccess.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index edb3d5c..9309024 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -66,12 +66,12 @@ static inline void set_fs(mm_segment_t fs)
 #define segment_eq(a,b)	((a) == (b))
 
 /*
- * Return 1 if addr < current->addr_limit, 0 otherwise.
+ * Return 1 if addr <= current->addr_limit, 0 otherwise.
  */
 #define __addr_ok(addr)							\
 ({									\
 	unsigned long flag;						\
-	asm("cmp %1, %0; cset %0, lo"					\
+	asm("cmp %1, %0; cset %0, ls"					\
 		: "=&r" (flag)						\
 		: "r" (addr), "0" (current_thread_info()->addr_limit)	\
 		: "cc");						\
@@ -83,7 +83,7 @@ static inline void set_fs(mm_segment_t fs)
  * Returns 1 if the range is valid, 0 otherwise.
  *
  * This is equivalent to the following test:
- * (u65)addr + (u65)size < (u65)current->addr_limit
+ * (u65)addr + (u65)size <= current->addr_limit
  *
  * This needs 65-bit arithmetic.
  */
@@ -91,7 +91,7 @@ static inline void set_fs(mm_segment_t fs)
 ({									\
 	unsigned long flag, roksum;					\
 	__chk_user_ptr(addr);						\
-	asm("adds %1, %1, %3; ccmp %1, %4, #2, cc; cset %0, cc"		\
+	asm("adds %1, %1, %3; ccmp %1, %4, #3, cc; cset %0, ls"		\
 		: "=&r" (flag), "=&r" (roksum)				\
 		: "1" (addr), "Ir" (size),				\
 		  "r" (current_thread_info()->addr_limit)		\
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by the Linux Foundation.
