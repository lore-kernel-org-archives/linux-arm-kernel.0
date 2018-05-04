From: mark.rutland@arm.com (Mark Rutland)
Date: Fri,  4 May 2018 18:39:33 +0100
Subject: [PATCH 2/6] locking/atomic, asm-generic: instrument atomic*andnot*()
In-Reply-To: <20180504173937.25300-1-mark.rutland@arm.com>
References: <20180504173937.25300-1-mark.rutland@arm.com>
Message-ID: <20180504173937.25300-3-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't currently define instrumentation wrappers for the various forms
of atomic*andnot*(), as these aren't implemented directly by x86.

So that we can instrument architectures which provide these, let's
define wrappers for all the variants of these atomics.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/atomic-instrumented.h | 112 ++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
index 26f0e3098442..b1920f0f64ab 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -498,6 +498,62 @@ INSTR_ATOMIC64_AND(_release)
 #define atomic64_and_release atomic64_and_release
 #endif
 
+#define INSTR_ATOMIC_ANDNOT(order)					\
+static __always_inline void						\
+atomic_andnot##order(int i, atomic_t *v)				\
+{									\
+	kasan_check_write(v, sizeof(*v));				\
+	arch_atomic_andnot##order(i, v);				\
+}
+
+#ifdef arch_atomic_andnot
+INSTR_ATOMIC_ANDNOT()
+#define atomic_andnot atomic_andnot
+#endif
+
+#ifdef arch_atomic_andnot_relaxed
+INSTR_ATOMIC_ANDNOT(_relaxed)
+#define atomic_andnot_relaxed atomic_andnot_relaxed
+#endif
+
+#ifdef arch_atomic_andnot_acquire
+INSTR_ATOMIC_ANDNOT(_acquire)
+#define atomic_andnot_acquire atomic_andnot_acquire
+#endif
+
+#ifdef arch_atomic_andnot_release
+INSTR_ATOMIC_ANDNOT(_release)
+#define atomic_andnot_release atomic_andnot_release
+#endif
+
+#define INSTR_ATOMIC64_ANDNOT(order)					\
+static __always_inline void						\
+atomic64_andnot##order(s64 i, atomic64_t *v)				\
+{									\
+	kasan_check_write(v, sizeof(*v));				\
+	arch_atomic64_andnot##order(i, v);				\
+}
+
+#ifdef arch_atomic64_andnot
+INSTR_ATOMIC64_ANDNOT()
+#define atomic64_andnot atomic64_andnot
+#endif
+
+#ifdef arch_atomic64_andnot_relaxed
+INSTR_ATOMIC64_ANDNOT(_relaxed)
+#define atomic64_andnot_relaxed atomic64_andnot_relaxed
+#endif
+
+#ifdef arch_atomic64_andnot_acquire
+INSTR_ATOMIC64_ANDNOT(_acquire)
+#define atomic64_andnot_acquire atomic64_andnot_acquire
+#endif
+
+#ifdef arch_atomic64_andnot_release
+INSTR_ATOMIC64_ANDNOT(_release)
+#define atomic64_andnot_release atomic64_andnot_release
+#endif
+
 #define INSTR_ATOMIC_OR(order)						\
 static __always_inline void						\
 atomic_or##order(int i, atomic_t *v)					\
@@ -984,6 +1040,62 @@ INSTR_ATOMIC64_FETCH_AND(_release)
 #define atomic64_fetch_and_release atomic64_fetch_and_release
 #endif
 
+#define INSTR_ATOMIC_FETCH_ANDNOT(order)				\
+static __always_inline int						\
+atomic_fetch_andnot##order(int i, atomic_t *v)				\
+{									\
+	kasan_check_write(v, sizeof(*v));				\
+	return arch_atomic_fetch_andnot##order(i, v);			\
+}
+
+#ifdef arch_atomic_fetch_andnot
+INSTR_ATOMIC_FETCH_ANDNOT()
+#define atomic_fetch_andnot atomic_fetch_andnot
+#endif
+
+#ifdef arch_atomic_fetch_andnot_relaxed
+INSTR_ATOMIC_FETCH_ANDNOT(_relaxed)
+#define atomic_fetch_andnot_relaxed atomic_fetch_andnot_relaxed
+#endif
+
+#ifdef arch_atomic_fetch_andnot_acquire
+INSTR_ATOMIC_FETCH_ANDNOT(_acquire)
+#define atomic_fetch_andnot_acquire atomic_fetch_andnot_acquire
+#endif
+
+#ifdef arch_atomic_fetch_andnot_release
+INSTR_ATOMIC_FETCH_ANDNOT(_release)
+#define atomic_fetch_andnot_release atomic_fetch_andnot_release
+#endif
+
+#define INSTR_ATOMIC64_FETCH_ANDNOT(order)				\
+static __always_inline s64						\
+atomic64_fetch_andnot##order(s64 i, atomic64_t *v)			\
+{									\
+	kasan_check_write(v, sizeof(*v));				\
+	return arch_atomic64_fetch_andnot##order(i, v);			\
+}
+
+#ifdef arch_atomic64_fetch_andnot
+INSTR_ATOMIC64_FETCH_ANDNOT()
+#define atomic64_fetch_andnot atomic64_fetch_andnot
+#endif
+
+#ifdef arch_atomic64_fetch_andnot_relaxed
+INSTR_ATOMIC64_FETCH_ANDNOT(_relaxed)
+#define atomic64_fetch_andnot_relaxed atomic64_fetch_andnot_relaxed
+#endif
+
+#ifdef arch_atomic64_fetch_andnot_acquire
+INSTR_ATOMIC64_FETCH_ANDNOT(_acquire)
+#define atomic64_fetch_andnot_acquire atomic64_fetch_andnot_acquire
+#endif
+
+#ifdef arch_atomic64_fetch_andnot_release
+INSTR_ATOMIC64_FETCH_ANDNOT(_release)
+#define atomic64_fetch_andnot_release atomic64_fetch_andnot_release
+#endif
+
 #define INSTR_ATOMIC_FETCH_OR(order)					\
 static __always_inline int						\
 atomic_fetch_or##order(int i, atomic_t *v)				\
-- 
2.11.0
