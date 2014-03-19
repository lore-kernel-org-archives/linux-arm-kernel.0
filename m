From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 19 Mar 2014 12:29:37 -0400
Subject: [PATCH v2] arm64: Fix __range_ok macro
In-Reply-To: <1394059289-3972-1-git-send-email-cov@codeaurora.org>
References: <1394059289-3972-1-git-send-email-cov@codeaurora.org>
Message-ID: <1395246577-22120-1-git-send-email-cov@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this, the following scenario is incorrectly determined
to be invalid.

addr 0x7f_ffffe000 size 8192 addr_limit 0x80_00000000

This behavior was observed while trying to vmsplice the stack
as part of a CRIU dump of a process on a system started with the
norandmaps kernel parameter.

Signed-off-by: Christopher Covington <cov@codeaurora.org>
---
 arch/arm64/include/asm/uaccess.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 7ecc2b2..5974459 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
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
+	asm("adds %1, %1, %3; ccmp %1, %4, #2, cc; cset %0, ls"		\
 		: "=&r" (flag), "=&r" (roksum)				\
 		: "1" (addr), "Ir" (size),				\
 		  "r" (current_thread_info()->addr_limit)		\
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by the Linux Foundation.
