From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 Jul 2015 11:42:05 +0100
Subject: [PATCH v2 14/20] arm64: cmpxchg: avoid "cc" clobber in ll/sc routines
In-Reply-To: <1437734531-10698-1-git-send-email-will.deacon@arm.com>
References: <1437734531-10698-1-git-send-email-will.deacon@arm.com>
Message-ID: <1437734531-10698-15-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can perform the cmpxchg comparison using eor and cbnz which avoids
the "cc" clobber for the ll/sc case and consequently for the LSE case
where we may have to fall-back on the ll/sc code at runtime.

Reviewed-by: Steve Capper <steve.capper@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/atomic_ll_sc.h | 14 ++++++--------
 arch/arm64/include/asm/atomic_lse.h   |  4 ++--
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
index 77d3aabf52ad..d21091bae901 100644
--- a/arch/arm64/include/asm/atomic_ll_sc.h
+++ b/arch/arm64/include/asm/atomic_ll_sc.h
@@ -96,14 +96,13 @@ __LL_SC_PREFIX(atomic_cmpxchg(atomic_t *ptr, int old, int new))
 
 	asm volatile("// atomic_cmpxchg\n"
 "1:	ldxr	%w1, %2\n"
-"	cmp	%w1, %w3\n"
-"	b.ne	2f\n"
+"	eor	%w0, %w1, %w3\n"
+"	cbnz	%w0, 2f\n"
 "	stxr	%w0, %w4, %2\n"
 "	cbnz	%w0, 1b\n"
 "2:"
 	: "=&r" (tmp), "=&r" (oldval), "+Q" (ptr->counter)
-	: "Ir" (old), "r" (new)
-	: "cc");
+	: "Lr" (old), "r" (new));
 
 	smp_mb();
 	return oldval;
@@ -169,14 +168,13 @@ __LL_SC_PREFIX(atomic64_cmpxchg(atomic64_t *ptr, long old, long new))
 
 	asm volatile("// atomic64_cmpxchg\n"
 "1:	ldxr	%1, %2\n"
-"	cmp	%1, %3\n"
-"	b.ne	2f\n"
+"	eor	%0, %1, %3\n"
+"	cbnz	%w0, 2f\n"
 "	stxr	%w0, %4, %2\n"
 "	cbnz	%w0, 1b\n"
 "2:"
 	: "=&r" (res), "=&r" (oldval), "+Q" (ptr->counter)
-	: "Ir" (old), "r" (new)
-	: "cc");
+	: "Lr" (old), "r" (new));
 
 	smp_mb();
 	return oldval;
diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
index db41a63691cd..a03242e143e5 100644
--- a/arch/arm64/include/asm/atomic_lse.h
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -113,7 +113,7 @@ static inline int atomic_cmpxchg(atomic_t *ptr, int old, int new)
 	"	mov	%w[ret], w30")
 	: [ret] "+r" (x0), [v] "+Q" (ptr->counter)
 	: [old] "r" (w1), [new] "r" (w2)
-	: "x30", "cc", "memory");
+	: "x30", "memory");
 
 	return x0;
 }
@@ -207,7 +207,7 @@ static inline long atomic64_cmpxchg(atomic64_t *ptr, long old, long new)
 	"	mov	%[ret], x30")
 	: [ret] "+r" (x0), [v] "+Q" (ptr->counter)
 	: [old] "r" (x1), [new] "r" (x2)
-	: "x30", "cc", "memory");
+	: "x30", "memory");
 
 	return x0;
 }
-- 
2.1.4
