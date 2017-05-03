From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  3 May 2017 16:09:35 +0100
Subject: [PATCH 3/6] arm64: uaccess: ensure extension of access_ok() addr
In-Reply-To: <1493824178-7399-1-git-send-email-mark.rutland@arm.com>
References: <1493824178-7399-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1493824178-7399-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our access_ok() simply hands its arguments over to __range_ok(), which
implicitly assummes that the addr parameter is 64 bits wide. This isn't
necessarily true for compat code, which might pass down a 32-bit address
parameter.

In these cases, we don't have a guarantee that the address has been zero
extended to 64 bits, and the upper bits of the register may contain
unknown values, potentially resulting in a suprious failure.

Avoid this by explicitly casting the addr parameter to an unsigned long
(as is done on other architectures), ensuring that the parameter is
widened appropriately.

Fixes: 0aea86a2176c2264 ("arm64: User access library functions")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/uaccess.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 5308d69..ed3ecf1 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -95,11 +95,12 @@ static inline void set_fs(mm_segment_t fs)
  */
 #define __range_ok(addr, size)						\
 ({									\
+	unsigned long __addr = (unsigned long __force)(addr);		\
 	unsigned long flag, roksum;					\
 	__chk_user_ptr(addr);						\
 	asm("adds %1, %1, %3; ccmp %1, %4, #2, cc; cset %0, ls"		\
 		: "=&r" (flag), "=&r" (roksum)				\
-		: "1" (addr), "Ir" (size),				\
+		: "1" (__addr), "Ir" (size),				\
 		  "r" (current_thread_info()->addr_limit)		\
 		: "cc");						\
 	flag;								\
-- 
1.9.1
