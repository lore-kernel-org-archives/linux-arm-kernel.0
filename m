From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  5 Jul 2018 17:40:45 +0100
Subject: [PATCHv3 04/12] atomics/treewide: instrument xchg()
In-Reply-To: <20180705164053.10073-1-mark.rutland@arm.com>
References: <20180705164053.10073-1-mark.rutland@arm.com>
Message-ID: <20180705164053.10073-5-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While we instrument all of the (non-relaxed) atomic_*() functions and
cmpxchg(), we missed xchg().

Let's add instrumentation for xchg(), fixing up x86 to implement
arch_xchg().

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/x86/include/asm/atomic.h             | 2 +-
 arch/x86/include/asm/atomic64_64.h        | 2 +-
 arch/x86/include/asm/cmpxchg.h            | 2 +-
 include/asm-generic/atomic-instrumented.h | 7 +++++++
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index 823fd2f320cf..b143717b92b3 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -202,7 +202,7 @@ static __always_inline bool arch_atomic_try_cmpxchg(atomic_t *v, int *old, int n
 
 static inline int arch_atomic_xchg(atomic_t *v, int new)
 {
-	return xchg(&v->counter, new);
+	return arch_xchg(&v->counter, new);
 }
 
 static inline void arch_atomic_and(int i, atomic_t *v)
diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
index 849f1c566a11..4343d9b4f30e 100644
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -188,7 +188,7 @@ static __always_inline bool arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, l
 
 static inline long arch_atomic64_xchg(atomic64_t *v, long new)
 {
-	return xchg(&v->counter, new);
+	return arch_xchg(&v->counter, new);
 }
 
 static inline void arch_atomic64_and(long i, atomic64_t *v)
diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
index e3efd8a06066..a55d79b233d3 100644
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -75,7 +75,7 @@ extern void __add_wrong_size(void)
  * use "asm volatile" and "memory" clobbers to prevent gcc from moving
  * information around.
  */
-#define xchg(ptr, v)	__xchg_op((ptr), (v), xchg, "")
+#define arch_xchg(ptr, v)	__xchg_op((ptr), (v), xchg, "")
 
 /*
  * Atomic compare and exchange.  Compare OLD with MEM, if identical,
diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
index c7c3e4cdd942..53481b6eacdf 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -408,6 +408,13 @@ static __always_inline bool atomic64_add_negative(s64 i, atomic64_t *v)
 }
 #endif
 
+#define xchg(ptr, new)							\
+({									\
+	typeof(ptr) __ai_ptr = (ptr);					\
+	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));			\
+	arch_xchg(__ai_ptr, (new));					\
+})
+
 #define cmpxchg(ptr, old, new)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-- 
2.11.0
