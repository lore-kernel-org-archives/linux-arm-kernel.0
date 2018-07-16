From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 16 Jul 2018 12:30:10 +0100
Subject: [PATCHv4 05/12] atomics: instrument cmpxchg_double*()
In-Reply-To: <20180716113017.3909-1-mark.rutland@arm.com>
References: <20180716113017.3909-1-mark.rutland@arm.com>
Message-ID: <20180716113017.3909-6-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We currently don't instrument cmpxchg_double() and
cmpxchg_double_local() due to compilation issues reported in the past,
which are supposedly related to GCC bug 72873 [1], reported when GCC 7
was not yet released. This bug only applies to x86-64, and does not
apply to other architectures.

While the test case for GCC bug 72873 triggers issues with released
versions of GCC, the instrumented kernel code compiles fine for all
configurations I have tried, and it is unclear how the two cases
are/were related.

As we can't reproduce the kernel build failures, let's instrument
cmpxchg_double*() again. We can revisit the issue if build failures
reappear.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/asm-generic/atomic-instrumented.h | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
index 53481b6eacdf..0d4b1d3dbc1e 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -450,23 +450,18 @@ static __always_inline bool atomic64_add_negative(s64 i, atomic64_t *v)
 	arch_cmpxchg64_local(__ai_ptr, (old), (new));			\
 })
 
-/*
- * Originally we had the following code here:
- *     __typeof__(p1) ____p1 = (p1);
- *     kasan_check_write(____p1, 2 * sizeof(*____p1));
- *     arch_cmpxchg_double(____p1, (p2), (o1), (o2), (n1), (n2));
- * But it leads to compilation failures (see gcc issue 72873).
- * So for now it's left non-instrumented.
- * There are few callers of cmpxchg_double(), so it's not critical.
- */
 #define cmpxchg_double(p1, p2, o1, o2, n1, n2)				\
 ({									\
-	arch_cmpxchg_double((p1), (p2), (o1), (o2), (n1), (n2));	\
+	typeof(p1) __ai_p1 = (p1);					\
+	kasan_check_write(__ai_p1, 2 * sizeof(*__ai_p1));		\
+	arch_cmpxchg_double(__ai_p1, (p2), (o1), (o2), (n1), (n2));	\
 })
 
-#define cmpxchg_double_local(p1, p2, o1, o2, n1, n2)			\
-({									\
-	arch_cmpxchg_double_local((p1), (p2), (o1), (o2), (n1), (n2));	\
+#define cmpxchg_double_local(p1, p2, o1, o2, n1, n2)				\
+({										\
+	typeof(p1) __ai_p1 = (p1);						\
+	kasan_check_write(__ai_p1, 2 * sizeof(*__ai_p1));			\
+	arch_cmpxchg_double_local(__ai_p1, (p2), (o1), (o2), (n1), (n2));	\
 })
 
 #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
-- 
2.11.0
