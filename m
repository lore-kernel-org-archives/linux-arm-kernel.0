From: will.deacon@arm.com (Will Deacon)
Date: Fri,  6 Oct 2017 14:34:40 +0100
Subject: [PATCH v2 3/5] kernel/locking: Use atomic_cond_read_acquire when
 spinning in qrwlock
In-Reply-To: <1507296882-18721-1-git-send-email-will.deacon@arm.com>
References: <1507296882-18721-1-git-send-email-will.deacon@arm.com>
Message-ID: <1507296882-18721-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The qrwlock slowpaths involve spinning when either a prospective reader
is waiting for a concurrent writer to drain, or a prospective writer is
waiting for concurrent readers to drain. In both of these situations,
atomic_cond_read_acquire can be used to avoid busy-waiting and make use
of any backoff functionality provided by the architecture.

This patch replaces the open-code loops and rspin_until_writer_unlock
implementation with atomic_cond_read_acquire. The write mode transition
zero to _QW_WAITING is left alone, since (a) this doesn't need acquire
semantics and (b) should be fast.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 kernel/locking/qrwlock.c | 47 +++++++++++------------------------------------
 1 file changed, 11 insertions(+), 36 deletions(-)

diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index 1af791e37348..b7ea4647c74d 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -24,23 +24,6 @@
 #include <asm/qrwlock.h>
 
 /**
- * rspin_until_writer_unlock - inc reader count & spin until writer is gone
- * @lock  : Pointer to queue rwlock structure
- * @writer: Current queue rwlock writer status byte
- *
- * In interrupt context or at the head of the queue, the reader will just
- * increment the reader count & wait until the writer releases the lock.
- */
-static __always_inline void
-rspin_until_writer_unlock(struct qrwlock *lock, u32 cnts)
-{
-	while ((cnts & _QW_WMASK) == _QW_LOCKED) {
-		cpu_relax();
-		cnts = atomic_read_acquire(&lock->cnts);
-	}
-}
-
-/**
  * queued_read_lock_slowpath - acquire read lock of a queue rwlock
  * @lock: Pointer to queue rwlock structure
  * @cnts: Current qrwlock lock value
@@ -53,13 +36,12 @@ void queued_read_lock_slowpath(struct qrwlock *lock, u32 cnts)
 	if (unlikely(in_interrupt())) {
 		/*
 		 * Readers in interrupt context will get the lock immediately
-		 * if the writer is just waiting (not holding the lock yet).
-		 * The rspin_until_writer_unlock() function returns immediately
-		 * in this case. Otherwise, they will spin (with ACQUIRE
-		 * semantics) until the lock is available without waiting in
-		 * the queue.
+		 * if the writer is just waiting (not holding the lock yet),
+		 * so spin with ACQUIRE semantics until the lock is available
+		 * without waiting in the queue.
 		 */
-		rspin_until_writer_unlock(lock, cnts);
+		atomic_cond_read_acquire(&lock->cnts, (VAL & _QW_WMASK)
+					 != _QW_LOCKED);
 		return;
 	}
 	atomic_sub(_QR_BIAS, &lock->cnts);
@@ -68,14 +50,14 @@ void queued_read_lock_slowpath(struct qrwlock *lock, u32 cnts)
 	 * Put the reader into the wait queue
 	 */
 	arch_spin_lock(&lock->wait_lock);
+	atomic_add(_QR_BIAS, &lock->cnts);
 
 	/*
 	 * The ACQUIRE semantics of the following spinning code ensure
 	 * that accesses can't leak upwards out of our subsequent critical
 	 * section in the case that the lock is currently held for write.
 	 */
-	cnts = atomic_fetch_add_acquire(_QR_BIAS, &lock->cnts);
-	rspin_until_writer_unlock(lock, cnts);
+	atomic_cond_read_acquire(&lock->cnts, (VAL & _QW_WMASK) != _QW_LOCKED);
 
 	/*
 	 * Signal the next one in queue to become queue head
@@ -90,8 +72,6 @@ EXPORT_SYMBOL(queued_read_lock_slowpath);
  */
 void queued_write_lock_slowpath(struct qrwlock *lock)
 {
-	u32 cnts;
-
 	/* Put the writer into the wait queue */
 	arch_spin_lock(&lock->wait_lock);
 
@@ -113,15 +93,10 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
 	}
 
 	/* When no more readers, set the locked flag */
-	for (;;) {
-		cnts = atomic_read(&lock->cnts);
-		if ((cnts == _QW_WAITING) &&
-		    (atomic_cmpxchg_acquire(&lock->cnts, _QW_WAITING,
-					    _QW_LOCKED) == _QW_WAITING))
-			break;
-
-		cpu_relax();
-	}
+	do {
+		atomic_cond_read_acquire(&lock->cnts, VAL == _QW_WAITING);
+	} while (atomic_cmpxchg_relaxed(&lock->cnts, _QW_WAITING,
+					_QW_LOCKED) != _QW_WAITING);
 unlock:
 	arch_spin_unlock(&lock->wait_lock);
 }
-- 
2.1.4
