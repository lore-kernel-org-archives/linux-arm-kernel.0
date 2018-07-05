From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  5 Jul 2018 17:40:47 +0100
Subject: [PATCHv3 06/12] atomics/treewide: rework ordering barriers
In-Reply-To: <20180705164053.10073-1-mark.rutland@arm.com>
References: <20180705164053.10073-1-mark.rutland@arm.com>
Message-ID: <20180705164053.10073-7-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently architectures can override __atomic_op_*() to define the barriers
used before/after a relaxed atomic when used to build acquire/release/fence
variants.

This has the unfortunate property of requiring the architecture to define the
full wrapper for the atomics, rather than just the barriers they care about,
and gets in the way of generating atomics which can be easily read.

Instead, this patch has architectures define an optional set of barriers:

* __atomic_acquire_fence()
* __atomic_release_fence()
* __atomic_pre_full_fence()
* __atomic_post_full_fence()

... which <linux/atomic.h> uses to build the wrappers.

It would be nice if we could undef these, along with the __atomic_op_*()
wrappers, but that would break the cmpxchg() wrappers, which are written
in preprocessor. Undefs would have been nice, but alas.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/alpha/include/asm/atomic.h   |  8 ++++----
 arch/powerpc/include/asm/atomic.h | 17 +++++------------
 arch/riscv/include/asm/atomic.h   | 17 +++++------------
 include/linux/atomic.h            | 38 ++++++++++++++++++++++----------------
 4 files changed, 36 insertions(+), 44 deletions(-)

diff --git a/arch/alpha/include/asm/atomic.h b/arch/alpha/include/asm/atomic.h
index 4a6a8f58c9c9..150a1c5d6a2c 100644
--- a/arch/alpha/include/asm/atomic.h
+++ b/arch/alpha/include/asm/atomic.h
@@ -18,11 +18,11 @@
  * To ensure dependency ordering is preserved for the _relaxed and
  * _release atomics, an smp_read_barrier_depends() is unconditionally
  * inserted into the _relaxed variants, which are used to build the
- * barriered versions. To avoid redundant back-to-back fences, we can
- * define the _acquire and _fence versions explicitly.
+ * barriered versions. Avoid redundant back-to-back fences in the
+ * _acquire and _fence versions.
  */
-#define __atomic_op_acquire(op, args...)	op##_relaxed(args)
-#define __atomic_op_fence			__atomic_op_release
+#define __atomic_acquire_fence()
+#define __atomic_post_full_fence()
 
 #define ATOMIC_INIT(i)		{ (i) }
 #define ATOMIC64_INIT(i)	{ (i) }
diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index a0156cb43d1f..963abf8bf1c0 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -18,18 +18,11 @@
  * a "bne-" instruction at the end, so an isync is enough as a acquire barrier
  * on the platform without lwsync.
  */
-#define __atomic_op_acquire(op, args...)				\
-({									\
-	typeof(op##_relaxed(args)) __ret  = op##_relaxed(args);		\
-	__asm__ __volatile__(PPC_ACQUIRE_BARRIER "" : : : "memory");	\
-	__ret;								\
-})
-
-#define __atomic_op_release(op, args...)				\
-({									\
-	__asm__ __volatile__(PPC_RELEASE_BARRIER "" : : : "memory");	\
-	op##_relaxed(args);						\
-})
+#define __atomic_acquire_fence()					\
+	__asm__ __volatile__(PPC_ACQUIRE_BARRIER "" : : : "memory")
+
+#define __atomic_release_fence()					\
+	__asm__ __volatile__(PPC_RELEASE_BARRIER "" : : : "memory")
 
 static __inline__ int atomic_read(const atomic_t *v)
 {
diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 512b89485790..c452359c9cb8 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -25,18 +25,11 @@
 
 #define ATOMIC_INIT(i)	{ (i) }
 
-#define __atomic_op_acquire(op, args...)				\
-({									\
-	typeof(op##_relaxed(args)) __ret  = op##_relaxed(args);		\
-	__asm__ __volatile__(RISCV_ACQUIRE_BARRIER "" ::: "memory");	\
-	__ret;								\
-})
-
-#define __atomic_op_release(op, args...)				\
-({									\
-	__asm__ __volatile__(RISCV_RELEASE_BARRIER "" ::: "memory");	\
-	op##_relaxed(args);						\
-})
+#define __atomic_acquire_fence()					\
+	__asm__ __volatile__(RISCV_ACQUIRE_BARRIER "" ::: "memory")
+
+#define __atomic_release_fence()					\
+	__asm__ __volatile__(RISCV_RELEASE_BARRIER "" ::: "memory");
 
 static __always_inline int atomic_read(const atomic_t *v)
 {
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 8e04f1f69bd9..1e8e88bdaf09 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -38,40 +38,46 @@
  * barriers on top of the relaxed variant. In the case where the relaxed
  * variant is already fully ordered, no additional barriers are needed.
  *
- * Besides, if an arch has a special barrier for acquire/release, it could
- * implement its own __atomic_op_* and use the same framework for building
- * variants
- *
- * If an architecture overrides __atomic_op_acquire() it will probably want
- * to define smp_mb__after_spinlock().
+ * If an architecture overrides __atomic_acquire_fence() it will probably
+ * want to define smp_mb__after_spinlock().
  */
-#ifndef __atomic_op_acquire
+#ifndef __atomic_acquire_fence
+#define __atomic_acquire_fence		smp_mb__after_atomic
+#endif
+
+#ifndef __atomic_release_fence
+#define __atomic_release_fence		smp_mb__before_atomic
+#endif
+
+#ifndef __atomic_pre_full_fence
+#define __atomic_pre_full_fence		smp_mb__before_atomic
+#endif
+
+#ifndef __atomic_post_full_fence
+#define __atomic_post_full_fence	smp_mb__after_atomic
+#endif
+
 #define __atomic_op_acquire(op, args...)				\
 ({									\
 	typeof(op##_relaxed(args)) __ret  = op##_relaxed(args);		\
-	smp_mb__after_atomic();						\
+	__atomic_acquire_fence();					\
 	__ret;								\
 })
-#endif
 
-#ifndef __atomic_op_release
 #define __atomic_op_release(op, args...)				\
 ({									\
-	smp_mb__before_atomic();					\
+	__atomic_release_fence();					\
 	op##_relaxed(args);						\
 })
-#endif
 
-#ifndef __atomic_op_fence
 #define __atomic_op_fence(op, args...)					\
 ({									\
 	typeof(op##_relaxed(args)) __ret;				\
-	smp_mb__before_atomic();					\
+	__atomic_pre_full_fence();					\
 	__ret = op##_relaxed(args);					\
-	smp_mb__after_atomic();						\
+	__atomic_post_full_fence();					\
 	__ret;								\
 })
-#endif
 
 /* atomic_add_return_relaxed */
 #ifndef atomic_add_return_relaxed
-- 
2.11.0
