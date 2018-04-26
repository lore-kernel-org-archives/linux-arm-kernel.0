From: will.deacon@arm.com (Will Deacon)
Date: Thu, 26 Apr 2018 11:34:26 +0100
Subject: [PATCH v3 12/14] locking/qspinlock: Use try_cmpxchg instead of
 cmpxchg when locking
In-Reply-To: <1524738868-31318-1-git-send-email-will.deacon@arm.com>
References: <1524738868-31318-1-git-send-email-will.deacon@arm.com>
Message-ID: <1524738868-31318-13-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When reaching the head of an uncontended queue on the qspinlock slow-path,
using a try_cmpxchg instead of a cmpxchg operation to transition the
lock work to _Q_LOCKED_VAL generates slightly better code for x86 and
pretty much identical code for arm64.

Cc: Ingo Molnar <mingo@kernel.org>
Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 kernel/locking/qspinlock.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index fa5d2ab369f9..1e3ddc42135e 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -467,16 +467,15 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 * Otherwise, we only need to grab the lock.
 	 */
 
-	/* In the PV case we might already have _Q_LOCKED_VAL set */
-	if ((val & _Q_TAIL_MASK) == tail) {
-		/*
-		 * The atomic_cond_read_acquire() call above has provided the
-		 * necessary acquire semantics required for locking.
-		 */
-		old = atomic_cmpxchg_relaxed(&lock->val, val, _Q_LOCKED_VAL);
-		if (old == val)
-			goto release; /* No contention */
-	}
+	/*
+	 * In the PV case we might already have _Q_LOCKED_VAL set.
+	 *
+	 * The atomic_cond_read_acquire() call above has provided the
+	 * necessary acquire semantics required for locking.
+	 */
+	if (((val & _Q_TAIL_MASK) == tail) &&
+	    atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKED_VAL))
+		goto release; /* No contention */
 
 	/* Either somebody is queued behind us or _Q_PENDING_VAL is set */
 	set_locked(lock);
-- 
2.1.4
