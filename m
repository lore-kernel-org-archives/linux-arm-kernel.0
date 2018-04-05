From: will.deacon@arm.com (Will Deacon)
Date: Thu,  5 Apr 2018 17:58:58 +0100
Subject: [PATCH 01/10] locking/qspinlock: Don't spin on pending->locked
 transition in slowpath
In-Reply-To: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
Message-ID: <1522947547-24081-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a locker taking the qspinlock slowpath reads a lock value indicating
that only the pending bit is set, then it will spin whilst the
concurrent pending->locked transition takes effect.

Unfortunately, there is no guarantee that such a transition will ever be
observed since concurrent lockers could continuously set pending and
hand over the lock amongst themselves, leading to starvation. Whilst
this would probably resolve in practice, it means that it is not
possible to prove liveness properties about the lock and means that lock
acquisition time is unbounded.

Remove the pending->locked spinning from the slowpath and instead
queue explicitly if pending is set.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 kernel/locking/qspinlock.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index d880296245c5..a192af2fe378 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -306,16 +306,6 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 		return;
 
 	/*
-	 * wait for in-progress pending->locked hand-overs
-	 *
-	 * 0,1,0 -> 0,0,1
-	 */
-	if (val == _Q_PENDING_VAL) {
-		while ((val = atomic_read(&lock->val)) == _Q_PENDING_VAL)
-			cpu_relax();
-	}
-
-	/*
 	 * trylock || pending
 	 *
 	 * 0,0,0 -> 0,0,1 ; trylock
-- 
2.1.4
