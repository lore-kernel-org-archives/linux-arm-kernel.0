From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 Jul 2015 10:25:18 +0100
Subject: [PATCH 17/18] arm64: atomic64_dec_if_positive: fix incorrect branch
 condition
In-Reply-To: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
References: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
Message-ID: <1436779519-2232-18-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we attempt to atomic64_dec_if_positive on INT_MIN, we will underflow
and incorrectly decide that the original parameter was positive.

This patches fixes the broken condition code so that we handle this
corner case correctly.

Reviewed-by: Steve Capper <steve.capper@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/atomic_ll_sc.h | 2 +-
 arch/arm64/include/asm/atomic_lse.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
index cbaedf9afb2f..1a9ae9197a9f 100644
--- a/arch/arm64/include/asm/atomic_ll_sc.h
+++ b/arch/arm64/include/asm/atomic_ll_sc.h
@@ -149,7 +149,7 @@ __LL_SC_PREFIX(atomic64_dec_if_positive(atomic64_t *v))
 "	prfm	pstl1strm, %2\n"
 "1:	ldxr	%0, %2\n"
 "	subs	%0, %0, #1\n"
-"	b.mi	2f\n"
+"	b.lt	2f\n"
 "	stlxr	%w1, %0, %2\n"
 "	cbnz	%w1, 1b\n"
 "	dmb	ish\n"
diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
index 6a2bbdfcf290..82926657f6af 100644
--- a/arch/arm64/include/asm/atomic_lse.h
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -176,7 +176,7 @@ static inline long atomic64_dec_if_positive(atomic64_t *v)
 	/* LSE atomics */
 	"1:	ldr	%[tmp], %[v]\n"
 	"	subs	%[ret], %[tmp], #1\n"
-	"	b.mi	2f\n"
+	"	b.lt	2f\n"
 	"	casal	%[tmp], %[ret], %[v]\n"
 	"	sub	%[tmp], %[tmp], #1\n"
 	"	sub	%[tmp], %[tmp], %[ret]\n"
-- 
2.1.4
