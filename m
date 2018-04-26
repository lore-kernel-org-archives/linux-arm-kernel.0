From: will.deacon@arm.com (Will Deacon)
Date: Thu, 26 Apr 2018 11:34:20 +0100
Subject: [PATCH v3 06/14] locking/qspinlock: Kill cmpxchg loop when claiming
 lock from head of queue
In-Reply-To: <1524738868-31318-1-git-send-email-will.deacon@arm.com>
References: <1524738868-31318-1-git-send-email-will.deacon@arm.com>
Message-ID: <1524738868-31318-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a queued locker reaches the head of the queue, it claims the lock
by setting _Q_LOCKED_VAL in the lockword. If there isn't contention, it
must also clear the tail as part of this operation so that subsequent
lockers can avoid taking the slowpath altogether.

Currently this is expressed as a cmpxchg loop that practically only
runs up to two iterations. This is confusing to the reader and unhelpful
to the compiler. Rewrite the cmpxchg loop without the loop, so that a
failed cmpxchg implies that there is contention and we just need to
write to _Q_LOCKED_VAL without considering the rest of the lockword.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 kernel/locking/qspinlock.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index ad94b7def005..e42f50d69ed6 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -465,24 +465,21 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 * and nobody is pending, clear the tail code and grab the lock.
 	 * Otherwise, we only need to grab the lock.
 	 */
-	for (;;) {
-		/* In the PV case we might already have _Q_LOCKED_VAL set */
-		if ((val & _Q_TAIL_MASK) != tail || (val & _Q_PENDING_MASK)) {
-			set_locked(lock);
-			break;
-		}
+
+	/* In the PV case we might already have _Q_LOCKED_VAL set */
+	if ((val & _Q_TAIL_MASK) == tail) {
 		/*
 		 * The smp_cond_load_acquire() call above has provided the
-		 * necessary acquire semantics required for locking. At most
-		 * two iterations of this loop may be ran.
+		 * necessary acquire semantics required for locking.
 		 */
 		old = atomic_cmpxchg_relaxed(&lock->val, val, _Q_LOCKED_VAL);
 		if (old == val)
-			goto release;	/* No contention */
-
-		val = old;
+			goto release; /* No contention */
 	}
 
+	/* Either somebody is queued behind us or _Q_PENDING_VAL is set */
+	set_locked(lock);
+
 	/*
 	 * contended path; wait for next if not observed yet, release.
 	 */
-- 
2.1.4
