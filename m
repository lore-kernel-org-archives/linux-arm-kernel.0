From: will.deacon@arm.com (Will Deacon)
Date: Fri,  6 Oct 2017 14:34:39 +0100
Subject: [PATCH v2 2/5] locking/atomic: Add atomic_cond_read_acquire
In-Reply-To: <1507296882-18721-1-git-send-email-will.deacon@arm.com>
References: <1507296882-18721-1-git-send-email-will.deacon@arm.com>
Message-ID: <1507296882-18721-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

smp_cond_load_acquire provides a way to spin on a variable with acquire
semantics until some conditional expression involing the variable is
satisfied. Architectures such as arm64 can potentially enter a low-power
state, waking up only when the value of the variable changes, which
reduces the system impact of tight polling loops.

This patch makes the same interface available to users of atomic_t,
atomic64_t and atomic_long_t, rather than require messy accesses to the
structure internals.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/atomic-long.h | 3 +++
 include/linux/atomic.h            | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/include/asm-generic/atomic-long.h b/include/asm-generic/atomic-long.h
index 288cc9e96395..f2d97b782031 100644
--- a/include/asm-generic/atomic-long.h
+++ b/include/asm-generic/atomic-long.h
@@ -243,4 +243,7 @@ static inline long atomic_long_add_unless(atomic_long_t *l, long a, long u)
 #define atomic_long_inc_not_zero(l) \
 	ATOMIC_LONG_PFX(_inc_not_zero)((ATOMIC_LONG_PFX(_t) *)(l))
 
+#define atomic_long_cond_read_acquire(v, c) \
+	ATOMIC_LONG_PFX(_cond_read_acquire)((ATOMIC_LONG_PFX(_t) *)(v), (c))
+
 #endif  /*  _ASM_GENERIC_ATOMIC_LONG_H  */
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 40d6bfec0e0d..0aeb2b3f4578 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -653,6 +653,8 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 }
 #endif
 
+#define atomic_cond_read_acquire(v, c)	smp_cond_load_acquire(&(v)->counter, (c))
+
 #ifdef CONFIG_GENERIC_ATOMIC64
 #include <asm-generic/atomic64.h>
 #endif
@@ -1072,6 +1074,8 @@ static inline long long atomic64_fetch_andnot_release(long long i, atomic64_t *v
 }
 #endif
 
+#define atomic64_cond_read_acquire(v, c)	smp_cond_load_acquire(&(v)->counter, (c))
+
 #include <asm-generic/atomic-long.h>
 
 #endif /* _LINUX_ATOMIC_H */
-- 
2.1.4
