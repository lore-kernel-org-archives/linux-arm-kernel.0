From: will.deacon@arm.com (Will Deacon)
Date: Wed, 11 Apr 2018 19:01:13 +0100
Subject: [PATCH v2 06/13] locking/qspinlock: Use atomic_cond_read_acquire
In-Reply-To: <1523469680-17699-1-git-send-email-will.deacon@arm.com>
References: <1523469680-17699-1-git-send-email-will.deacon@arm.com>
Message-ID: <1523469680-17699-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than dig into the counter field of the atomic_t inside the
qspinlock structure so that we can call smp_cond_load_acquire, use
atomic_cond_read_acquire instead, which operates on the atomic_t
directly.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 kernel/locking/qspinlock.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 01b660442d87..648a16a2cd23 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -377,8 +377,8 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 		 * barriers.
 		 */
 		if (val & _Q_LOCKED_MASK) {
-			smp_cond_load_acquire(&lock->val.counter,
-					      !(VAL & _Q_LOCKED_MASK));
+			atomic_cond_read_acquire(&lock->val,
+						 !(VAL & _Q_LOCKED_MASK));
 		}
 
 		/*
@@ -481,8 +481,8 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 *
 	 * The PV pv_wait_head_or_lock function, if active, will acquire
 	 * the lock and return a non-zero value. So we have to skip the
-	 * smp_cond_load_acquire() call. As the next PV queue head hasn't been
-	 * designated yet, there is no way for the locked value to become
+	 * atomic_cond_read_acquire() call. As the next PV queue head hasn't
+	 * been designated yet, there is no way for the locked value to become
 	 * _Q_SLOW_VAL. So both the set_locked() and the
 	 * atomic_cmpxchg_relaxed() calls will be safe.
 	 *
@@ -492,7 +492,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	if ((val = pv_wait_head_or_lock(lock, node)))
 		goto locked;
 
-	val = smp_cond_load_acquire(&lock->val.counter, !(VAL & _Q_LOCKED_PENDING_MASK));
+	val = atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK));
 
 locked:
 	/*
@@ -509,7 +509,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	/* In the PV case we might already have _Q_LOCKED_VAL set */
 	if ((val & _Q_TAIL_MASK) == tail) {
 		/*
-		 * The smp_cond_load_acquire() call above has provided the
+		 * The atomic_cond_read_acquire() call above has provided the
 		 * necessary acquire semantics required for locking.
 		 */
 		old = atomic_cmpxchg_relaxed(&lock->val, val, _Q_LOCKED_VAL);
-- 
2.1.4
