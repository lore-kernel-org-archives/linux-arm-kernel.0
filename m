From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 5 Oct 2017 15:56:18 +0200
Subject: [PATCH 5/6] kernel/locking: Prevent slowpath writers getting
 held up by fastpath
In-Reply-To: <1507208097-825-6-git-send-email-will.deacon@arm.com>
References: <1507208097-825-1-git-send-email-will.deacon@arm.com>
 <1507208097-825-6-git-send-email-will.deacon@arm.com>
Message-ID: <20171005135618.yufhaklq5cefaiyn@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 05, 2017 at 01:54:56PM +0100, Will Deacon wrote:
> When a prospective writer takes the qrwlock locking slowpath due to the
> lock being held, it attempts to cmpxchg the wmode field from 0 to
> _QW_WAITING so that concurrent lockers also take the slowpath and queue
> on the spinlock accordingly, allowing the lockers to drain.
> 
> Unfortunately, this isn't fair, because a fastpath writer that comes in
> after the lock is made available but before the _QW_WAITING flag is set
> can effectively jump the queue. If there is a steady stream of prospective
> writers, then the waiter will be held off indefinitely.
> 
> This patch restores fairness by separating _QW_WAITING and _QW_LOCKED
> into two bits in the wmode byte and having the waiter set _QW_WAITING
> unconditionally. This then forces the slow-path for concurrent lockers,
> but requires that a writer unlock operation performs an
> atomic_sub_release instead of a store_release so that the waiting status
> is preserved.

> diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
> index 02c0a768e6b0..8b7edef500e5 100644
> --- a/include/asm-generic/qrwlock.h
> +++ b/include/asm-generic/qrwlock.h
> @@ -41,7 +41,7 @@
>   *       +----+----+----+----+
>   */
>  #define	_QW_WAITING	1		/* A writer is waiting	   */
> -#define	_QW_LOCKED	0xff		/* A writer holds the lock */
> +#define	_QW_LOCKED	2		/* A writer holds the lock */
>  #define	_QW_WMASK	0xff		/* Writer mask		   */
>  #define	_QR_SHIFT	8		/* Reader count shift	   */
>  #define _QR_BIAS	(1U << _QR_SHIFT)
> @@ -134,7 +134,7 @@ static inline void queued_read_unlock(struct qrwlock *lock)
>   */
>  static inline void queued_write_unlock(struct qrwlock *lock)
>  {
> -	smp_store_release(&lock->wmode, 0);
> +	(void)atomic_sub_return_release(_QW_LOCKED, &lock->cnts);
>  }

That is a fairly painful hit on x86. Changes a regular store into an
"LOCK XADD" +20 cycles right there.

Can't we steal one of the reader bits for waiting?

diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
index 7d026bf27713..5524801a02a5 100644
--- a/include/asm-generic/qrwlock.h
+++ b/include/asm-generic/qrwlock.h
@@ -40,10 +40,10 @@
  *       |      rd      | wr |
  *       +----+----+----+----+
  */
-#define	_QW_WAITING	1		/* A writer is waiting	   */
-#define	_QW_LOCKED	0xff		/* A writer holds the lock */
-#define	_QW_WMASK	0xff		/* Writer mask		   */
-#define	_QR_SHIFT	8		/* Reader count shift	   */
+#define	_QW_WAITING	0x100		/* A writer is waiting	   */
+#define	_QW_LOCKED	0x0ff		/* A writer holds the lock */
+#define	_QW_WMASK	0x1ff		/* Writer mask		   */
+#define	_QR_SHIFT	9		/* Reader count shift	   */
 #define _QR_BIAS	(1U << _QR_SHIFT)
 
 /*
diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index 2655f26ec882..5f75caea97e0 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -54,7 +54,7 @@ struct __qrwlock {
 static __always_inline void
 rspin_until_writer_unlock(struct qrwlock *lock, u32 cnts)
 {
-	while ((cnts & _QW_WMASK) == _QW_LOCKED) {
+	while ((cnts & _QW_LOCKED)) {
 		cpu_relax();
 		cnts = atomic_read_acquire(&lock->cnts);
 	}
@@ -120,21 +120,10 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
 	    (atomic_cmpxchg_acquire(&lock->cnts, 0, _QW_LOCKED) == 0))
 		goto unlock;
 
-	/*
-	 * Set the waiting flag to notify readers that a writer is pending,
-	 * or wait for a previous writer to go away.
-	 */
-	for (;;) {
-		struct __qrwlock *l = (struct __qrwlock *)lock;
-
-		if (!READ_ONCE(l->wmode) &&
-		   (cmpxchg_relaxed(&l->wmode, 0, _QW_WAITING) == 0))
-			break;
-
-		cpu_relax();
-	}
+	/* Set the waiting flag to notify readers that a writer is pending */
+	atomic_add(_QW_WAITING, &lock->cnts);
 
-	/* When no more readers, set the locked flag */
+	/* When no more readers or writers, set the locked flag */
 	for (;;) {
 		cnts = atomic_read(&lock->cnts);
 		if ((cnts == _QW_WAITING) &&
