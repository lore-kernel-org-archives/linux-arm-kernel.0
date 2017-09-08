From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri,  8 Sep 2017 10:59:59 -0500
Subject: [PATCH] arm64: spinlocks: Fix write starvation with rwlock
Message-ID: <20170908155959.6940-1-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM64 rwlock is unfair in that readers can perpetually
block the writer. This is most noticeable with tests like

`stress-ng --kill $SOMENUMBERLESSTHANCPUS -t $RUNTIME -v`

which can hold the task lock with fairly small counts
(say 4 on thunderx). This can in some circumstances result
in machine deadlocks as kernel tasks get blocked and the
machine gradually falls over.

This patch changes the rwlock behavior so that the writer
unconditionally flags the lock structure (given that its
not already flagged by another writer). This blocks further
readers from acquiring the lock. Once all the readers have
drained, the writer that successfully flagged the lock can
progress.

With this change, the lock still has a fairness issue caused
by an open race for ownership following a write unlock. If
certain cores/clusters are favored to win these races it
means a small set of writers could starve other users
(including writers). This should not be a common problem
given rwlock users should be read heavy with the occasional
writer. Further, the queued rwlock should also help to
alleviate this problem.

Heavily tested on 1S thunderx, further testing on 2S
thunderx, seattle, and the v8.3 fast model (for LSE).
With the thunderx machines the stress-ng process counts
can be larger than the number of cores on the machine without
causing interactivity problems previously seen at much
lower counts.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/include/asm/spinlock.h | 46 +++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index cae331d553f8..2ddcce65ca17 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -191,7 +191,9 @@ static inline int arch_spin_is_contended(arch_spinlock_t *lock)
  * Write lock implementation.
  *
  * Write locks set bit 31. Unlocking, is done by writing 0 since the lock is
- * exclusively held.
+ * exclusively held. Setting the write bit (31) is used as a flag to drain the
+ * readers. The lock is considered taken for the writer only once all the
+ * readers have exited.
  *
  * The memory barriers are implicit with the load-acquire and store-release
  * instructions.
@@ -199,29 +201,41 @@ static inline int arch_spin_is_contended(arch_spinlock_t *lock)
 
 static inline void arch_write_lock(arch_rwlock_t *rw)
 {
-	unsigned int tmp;
+	unsigned int tmp, tmp2, status;
 
 	asm volatile(ARM64_LSE_ATOMIC_INSN(
 	/* LL/SC */
 	"	sevl\n"
 	"1:	wfe\n"
-	"2:	ldaxr	%w0, %1\n"
-	"	cbnz	%w0, 1b\n"
-	"	stxr	%w0, %w2, %1\n"
-	"	cbnz	%w0, 2b\n"
-	__nops(1),
+	"2:	ldaxr	%w0, %3\n"
+	"	tbnz	%w0, #31, 1b\n" /* must be another writer */
+	"	orr	%w1, %w0, %w4\n"
+	"	stxr	%w2, %w1, %3\n"
+	"	cbnz	%w2, 2b\n"  /* failed to store, try again */
+	"	cbz	%w0, 5f\n"  /* if there aren't any readers we're done */
+	"	sevl\n"
+	"3:	wfe\n"		    /* spin waiting for the readers to exit */
+	"4:	ldaxr	%w0, %3\n"
+	"	cmp	%w0, %w4\n"
+	"	b.ne	3b\n"
+	"5:",
 	/* LSE atomics */
-	"1:	mov	%w0, wzr\n"
-	"2:	casa	%w0, %w2, %1\n"
-	"	cbz	%w0, 3f\n"
-	"	ldxr	%w0, %1\n"
-	"	cbz	%w0, 2b\n"
+	"1:	ldseta	%w4, %w0, %3\n"
+	"	cbz	%w0, 5f\n"	/* lock was clear, we are done */
+	"	tbz	%w0, #31, 4f\n" /* we own the lock, wait for readers */
+	"2:	ldxr	%w0, %3\n"	/* spin waiting for writer to exit */
+	"	tbz	%w0, #31, 1b\n"
 	"	wfe\n"
-	"	b	1b\n"
-	"3:")
-	: "=&r" (tmp), "+Q" (rw->lock)
+	"	b	2b\n"
+	__nops(2)
+	"3:	wfe\n"		     /* spin waiting for the readers to exit*/
+	"4:	ldaxr	%w0, %3\n"
+	"	cmp	%w0, %w4\n"
+	"	b.ne	3b\n"
+	"5:")
+	: "=&r" (tmp), "=&r" (tmp2), "=&r" (status), "+Q" (rw->lock)
 	: "r" (0x80000000)
-	: "memory");
+	: "cc", "memory");
 }
 
 static inline int arch_write_trylock(arch_rwlock_t *rw)
-- 
2.13.5
