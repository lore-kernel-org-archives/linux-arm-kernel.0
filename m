From: will.deacon@arm.com (Will Deacon)
Date: Tue, 27 Nov 2018 19:44:47 +0000
Subject: [PATCH 4/4] arm64: cmpxchg: Use "K" instead of "L" for ll/sc
 immediate constraint
In-Reply-To: <1543347887-21101-1-git-send-email-will.deacon@arm.com>
References: <1543347887-21101-1-git-send-email-will.deacon@arm.com>
Message-ID: <1543347887-21101-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "L" AArch64 machine constraint, which we use for the "old" value in
an LL/SC cmpxchg(), generates an immediate that is suitable for a 64-bit
logical instruction. However, for cmpxchg() operations on types smaller
than 64 bits, this constraint can result in an invalid instruction which
is correctly rejected by GAS, such as EOR W1, W1, #0xffffffff.

Whilst we could special-case the constraint based on the cmpxchg size,
it's far easier to change the constraint to "K" and put up with using
a register for large 64-bit immediates. For out-of-line LL/SC atomics,
this is all moot anyway.

Reported-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/atomic_ll_sc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
index b53f70dd6e10..af7b99005453 100644
--- a/arch/arm64/include/asm/atomic_ll_sc.h
+++ b/arch/arm64/include/asm/atomic_ll_sc.h
@@ -276,7 +276,7 @@ __LL_SC_PREFIX(__cmpxchg_case_##name##sz(volatile void *ptr,		\
 	"2:"								\
 	: [tmp] "=&r" (tmp), [oldval] "=&r" (oldval),			\
 	  [v] "+Q" (*(u##sz *)ptr)					\
-	: [old] "Lr" (old), [new] "r" (new)				\
+	: [old] "Kr" (old), [new] "r" (new)				\
 	: cl);								\
 									\
 	return oldval;							\
-- 
2.1.4
