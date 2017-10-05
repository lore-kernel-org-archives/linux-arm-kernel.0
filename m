From: will.deacon@arm.com (Will Deacon)
Date: Thu,  5 Oct 2017 13:54:56 +0100
Subject: [PATCH 5/6] kernel/locking: Prevent slowpath writers getting held up
 by fastpath
In-Reply-To: <1507208097-825-1-git-send-email-will.deacon@arm.com>
References: <1507208097-825-1-git-send-email-will.deacon@arm.com>
Message-ID: <1507208097-825-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a prospective writer takes the qrwlock locking slowpath due to the
lock being held, it attempts to cmpxchg the wmode field from 0 to
_QW_WAITING so that concurrent lockers also take the slowpath and queue
on the spinlock accordingly, allowing the lockers to drain.

Unfortunately, this isn't fair, because a fastpath writer that comes in
after the lock is made available but before the _QW_WAITING flag is set
can effectively jump the queue. If there is a steady stream of prospective
writers, then the waiter will be held off indefinitely.

This patch restores fairness by separating _QW_WAITING and _QW_LOCKED
into two bits in the wmode byte and having the waiter set _QW_WAITING
unconditionally. This then forces the slow-path for concurrent lockers,
but requires that a writer unlock operation performs an
atomic_sub_release instead of a store_release so that the waiting status
is preserved.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/qrwlock.h |  4 ++--
 kernel/locking/qrwlock.c      | 20 +++++---------------
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
index 02c0a768e6b0..8b7edef500e5 100644
--- a/include/asm-generic/qrwlock.h
+++ b/include/asm-generic/qrwlock.h
@@ -41,7 +41,7 @@
  *       +----+----+----+----+
  */
 #define	_QW_WAITING	1		/* A writer is waiting	   */
-#define	_QW_LOCKED	0xff		/* A writer holds the lock */
+#define	_QW_LOCKED	2		/* A writer holds the lock */
 #define	_QW_WMASK	0xff		/* Writer mask		   */
 #define	_QR_SHIFT	8		/* Reader count shift	   */
 #define _QR_BIAS	(1U << _QR_SHIFT)
@@ -134,7 +134,7 @@ static inline void queued_read_unlock(struct qrwlock *lock)
  */
 static inline void queued_write_unlock(struct qrwlock *lock)
 {
-	smp_store_release(&lock->wmode, 0);
+	(void)atomic_sub_return_release(_QW_LOCKED, &lock->cnts);
 }
 
 /*
diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index b7ea4647c74d..e940f2c2b4f2 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -40,8 +40,7 @@ void queued_read_lock_slowpath(struct qrwlock *lock, u32 cnts)
 		 * so spin with ACQUIRE semantics until the lock is available
 		 * without waiting in the queue.
 		 */
-		atomic_cond_read_acquire(&lock->cnts, (VAL & _QW_WMASK)
-					 != _QW_LOCKED);
+		atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LOCKED));
 		return;
 	}
 	atomic_sub(_QR_BIAS, &lock->cnts);
@@ -57,7 +56,7 @@ void queued_read_lock_slowpath(struct qrwlock *lock, u32 cnts)
 	 * that accesses can't leak upwards out of our subsequent critical
 	 * section in the case that the lock is currently held for write.
 	 */
-	atomic_cond_read_acquire(&lock->cnts, (VAL & _QW_WMASK) != _QW_LOCKED);
+	atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LOCKED));
 
 	/*
 	 * Signal the next one in queue to become queue head
@@ -80,19 +79,10 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
 	    (atomic_cmpxchg_acquire(&lock->cnts, 0, _QW_LOCKED) == 0))
 		goto unlock;
 
-	/*
-	 * Set the waiting flag to notify readers that a writer is pending,
-	 * or wait for a previous writer to go away.
-	 */
-	for (;;) {
-		if (!READ_ONCE(lock->wmode) &&
-		   (cmpxchg_relaxed(&lock->wmode, 0, _QW_WAITING) == 0))
-			break;
-
-		cpu_relax();
-	}
+	/* Set the waiting flag to notify readers that a writer is pending */
+	atomic_add(_QW_WAITING, &lock->cnts);
 
-	/* When no more readers, set the locked flag */
+	/* When no more readers or writers, set the locked flag */
 	do {
 		atomic_cond_read_acquire(&lock->cnts, VAL == _QW_WAITING);
 	} while (atomic_cmpxchg_relaxed(&lock->cnts, _QW_WAITING,
-- 
2.1.4
