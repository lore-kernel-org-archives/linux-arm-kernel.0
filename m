From: mark.rutland@arm.com (Mark Rutland)
Date: Tue,  4 Aug 2015 17:27:34 +0100
Subject: [PATCH] arm64: make ll/sc __cmpxchg_case_##name asm consistent
Message-ID: <1438705654-12583-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ll/sc __cmpxchg_case_##name assembly mostly uses symbolic names for
operands, but in a single case uses %2 to refer to what is otherwise
known as %[v]. This makes the code more painful to read than is
necessary.

Use %[v] instead.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/atomic_ll_sc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Hi Will,

I spotted this on the arm64 for-next/core branch, it applies atop of "arm64:
atomics: prefetch the destination word for write prior to stxr" from your
armv8.1/lse branch.

Mark.

diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
index 6671978..b3b5c4a 100644
--- a/arch/arm64/include/asm/atomic_ll_sc.h
+++ b/arch/arm64/include/asm/atomic_ll_sc.h
@@ -181,7 +181,7 @@ __LL_SC_PREFIX(__cmpxchg_case_##name(volatile void *ptr,		\
 	unsigned long tmp, oldval;					\
 									\
 	asm volatile(							\
-	"	prfm	pstl1strm, %2\n"				\
+	"	prfm	pstl1strm, %[v]\n"				\
 	"1:	ldxr" #sz "\t%" #w "[oldval], %[v]\n"			\
 	"	eor	%" #w "[tmp], %" #w "[oldval], %" #w "[old]\n"	\
 	"	cbnz	%" #w "[tmp], 2f\n"				\
-- 
1.9.1
