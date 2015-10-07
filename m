From: will.deacon@arm.com (Will Deacon)
Date: Wed,  7 Oct 2015 15:10:38 +0100
Subject: [PATCH -tip] ARM: atomics: implement _relaxed variants of
 atomic[64]_{inc, dec}
Message-ID: <1444227038-12533-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the core code supports acquire/release/relaxed versions of
the atomic_inc family, implement only the _relaxed flavours in the ARM
backend so that we get all of the others for free.

Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

This sits on top of tip/locking/core and it would be great to have it
queued there.

 arch/arm/include/asm/atomic.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index 2bf80afb7841..9e10c4567eb4 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -210,8 +210,8 @@ ATOMIC_OP(xor, ^=, eor)
 
 #define atomic_inc_and_test(v)	(atomic_add_return(1, v) == 0)
 #define atomic_dec_and_test(v)	(atomic_sub_return(1, v) == 0)
-#define atomic_inc_return(v)    (atomic_add_return(1, v))
-#define atomic_dec_return(v)    (atomic_sub_return(1, v))
+#define atomic_inc_return_relaxed(v)    (atomic_add_return_relaxed(1, v))
+#define atomic_dec_return_relaxed(v)    (atomic_sub_return_relaxed(1, v))
 #define atomic_sub_and_test(i, v) (atomic_sub_return(i, v) == 0)
 
 #define atomic_add_negative(i,v) (atomic_add_return(i, v) < 0)
@@ -442,11 +442,11 @@ static inline int atomic64_add_unless(atomic64_t *v, long long a, long long u)
 
 #define atomic64_add_negative(a, v)	(atomic64_add_return((a), (v)) < 0)
 #define atomic64_inc(v)			atomic64_add(1LL, (v))
-#define atomic64_inc_return(v)		atomic64_add_return(1LL, (v))
+#define atomic64_inc_return_relaxed(v)	atomic64_add_return_relaxed(1LL, (v))
 #define atomic64_inc_and_test(v)	(atomic64_inc_return(v) == 0)
 #define atomic64_sub_and_test(a, v)	(atomic64_sub_return((a), (v)) == 0)
 #define atomic64_dec(v)			atomic64_sub(1LL, (v))
-#define atomic64_dec_return(v)		atomic64_sub_return(1LL, (v))
+#define atomic64_dec_return_relaxed(v)	atomic64_sub_return_relaxed(1LL, (v))
 #define atomic64_dec_and_test(v)	(atomic64_dec_return((v)) == 0)
 #define atomic64_inc_not_zero(v)	atomic64_add_unless((v), 1LL, 0LL)
 
-- 
2.1.4
