Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96181C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:12:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65489218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ftj+X43y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65489218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=p9O7WzruZe1zG/a1L0S+DjWRS+a75zYJoxce+vosQXU=; b=ftj+X43yRByF9SuV5C+Q4mfb2/
	JMNW0p/TsryLirDs4UZYkfnHwBKv2XFAfUYFbLMYWvEvND/HpfzufL5LKdugala2vZf0ozT2WONp+
	D6p/5UnAF+sDpjIG+s8tr1m50AotQUrPJeBK7TpHH63t6F+aT+sqVFljBKY/CPVABW32U4zI3ONuy
	+DEooqpeFYbzrX4qHcv3QiU1yvj+JITl8+bgSEl/9Xp0XvD40JWEeBJp8oSCgnazYMFrCsCzcRrpx
	6V7gs97wOTxNjNw/38gAcy4gcUUa6bel6zssi4Z4SEiL8DZOd7TrW57IVlBZjP5Dm1GESmbWDsyCv
	QV/ydu4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grp5a-0005dD-8K; Thu, 07 Feb 2019 19:11:58 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grp3T-0002Qj-P5
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 19:11:04 +0000
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E1A64C06A7F9;
 Thu,  7 Feb 2019 19:09:46 +0000 (UTC)
Received: from llong.com (dhcp-17-35.bos.redhat.com [10.18.17.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3FAF461146;
 Thu,  7 Feb 2019 19:09:42 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH-tip 12/22] locking/rwsem: Implement lock handoff to prevent
 lock starvation
Date: Thu,  7 Feb 2019 14:07:16 -0500
Message-Id: <1549566446-27967-13-git-send-email-longman@redhat.com>
In-Reply-To: <1549566446-27967-1-git-send-email-longman@redhat.com>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 07 Feb 2019 19:09:47 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_110948_707040_8A1BEAB6 
X-CRM114-Status: GOOD (  28.60  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 Davidlohr Bueso <dave@stgolabs.net>, linux-ia64@vger.kernel.org,
 Tim Chen <tim.c.chen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Borislav Petkov <bp@alien8.de>,
 linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
 Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Because of writer lock stealing, it is possible that a constant
stream of incoming writers will cause a waiting writer or reader to
wait indefinitely leading to lock starvation.

The mutex code has a lock handoff mechanism to prevent lock starvation.
This patch implements a similar lock handoff mechanism to disable
lock stealing and force lock handoff to the first waiter in the queue
after at least a 5ms waiting period. The waiting period is used to
avoid discouraging lock stealing too much to affect performance.

A rwsem microbenchmark was run for 8 seconds on a 4-socket 56-core
128-thread x86-64 system with a v5.0 based kernel and 112 write_lock
threads with 5us sleep critical section.

Before the patch, the min/mean/max numbers of locking operations for
the locking threads were 1/7,708/542,988. After the patch, the figures
became 6,031/7,267/9,476. It can be seen that the rwsem became much more
fair, though there was a slight drop of about 6% in the mean locking
operations done which was a tradeoff of having better fairness.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lock_events_list.h |   2 +
 kernel/locking/rwsem-xadd.c       | 110 +++++++++++++++++++++++++++++++-------
 kernel/locking/rwsem-xadd.h       |  23 +++++---
 3 files changed, 109 insertions(+), 26 deletions(-)

diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index c33c5df..4cde507 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -62,6 +62,8 @@
 LOCK_EVENT(rwsem_rlock)		/* # of read locks acquired		*/
 LOCK_EVENT(rwsem_rlock_fast)	/* # of fast read locks acquired	*/
 LOCK_EVENT(rwsem_rlock_fail)	/* # of failed read lock acquisitions	*/
+LOCK_EVENT(rwsem_rlock_handoff)	/* # of read lock handoffs		*/
 LOCK_EVENT(rwsem_wlock)		/* # of write locks acquired		*/
 LOCK_EVENT(rwsem_wlock_fail)	/* # of failed write lock acquisitions	*/
+LOCK_EVENT(rwsem_wlock_handoff)	/* # of write lock handoffs		*/
 #endif /* CONFIG_RWSEM_XCHGADD_ALGORITHM */
diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 18a414e..12b1d61 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -74,6 +74,7 @@ struct rwsem_waiter {
 	struct list_head list;
 	struct task_struct *task;
 	enum rwsem_waiter_type type;
+	unsigned long timeout;
 };
 
 enum rwsem_wake_type {
@@ -83,6 +84,12 @@ enum rwsem_wake_type {
 };
 
 /*
+ * The minimum waiting time (5ms) in the wait queue before initiating the
+ * handoff protocol.
+ */
+#define RWSEM_WAIT_TIMEOUT	((HZ - 1)/200 + 1)
+
+/*
  * handle the lock release when processes blocked on it that can now run
  * - if we come here from up_xxxx(), then the RWSEM_FLAG_WAITERS bit must
  *   have been set.
@@ -132,6 +139,15 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 		adjustment = RWSEM_READER_BIAS;
 		oldcount = atomic_long_fetch_add(adjustment, &sem->count);
 		if (unlikely(oldcount & RWSEM_WRITER_MASK)) {
+			/*
+			 * Initiate handoff to reader, if applicable.
+			 */
+			if (!(oldcount & RWSEM_FLAG_HANDOFF) &&
+			    time_after(jiffies, waiter->timeout)) {
+				adjustment -= RWSEM_FLAG_HANDOFF;
+				lockevent_inc(rwsem_rlock_handoff);
+			}
+
 			atomic_long_sub(adjustment, &sem->count);
 			return;
 		}
@@ -180,6 +196,12 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 		adjustment -= RWSEM_FLAG_WAITERS;
 	}
 
+	/*
+	 * Clear the handoff flag
+	 */
+	if (woken && RWSEM_COUNT_HANDOFF(atomic_long_read(&sem->count)))
+		adjustment -= RWSEM_FLAG_HANDOFF;
+
 	if (adjustment)
 		atomic_long_add(adjustment, &sem->count);
 }
@@ -189,15 +211,19 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
  * race conditions between checking the rwsem wait list and setting the
  * sem->count accordingly.
  */
-static inline bool rwsem_try_write_lock(long count, struct rw_semaphore *sem)
+static inline bool
+rwsem_try_write_lock(long count, struct rw_semaphore *sem, bool first)
 {
 	long new;
 
 	if (RWSEM_COUNT_LOCKED(count))
 		return false;
 
-	new = count + RWSEM_WRITER_LOCKED -
-	     (list_is_singular(&sem->wait_list) ? RWSEM_FLAG_WAITERS : 0);
+	if (!first && RWSEM_COUNT_HANDOFF(count))
+		return false;
+
+	new = (count & ~RWSEM_FLAG_HANDOFF) + RWSEM_WRITER_LOCKED -
+	      (list_is_singular(&sem->wait_list) ? RWSEM_FLAG_WAITERS : 0);
 
 	if (atomic_long_cmpxchg_acquire(&sem->count, count, new) == count) {
 		rwsem_set_owner(sem);
@@ -216,7 +242,7 @@ static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
 	long old, count = atomic_long_read(&sem->count);
 
 	while (true) {
-		if (RWSEM_COUNT_LOCKED(count))
+		if (RWSEM_COUNT_LOCKED_OR_HANDOFF(count))
 			return false;
 
 		old = atomic_long_cmpxchg_acquire(&sem->count, count,
@@ -374,6 +400,16 @@ static inline bool rwsem_has_spinner(struct rw_semaphore *sem)
 #endif
 
 /*
+ * This is safe to be called without holding the wait_lock.
+ */
+static inline bool
+rwsem_waiter_is_first(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
+{
+	return list_first_entry(&sem->wait_list, struct rwsem_waiter, list)
+			== waiter;
+}
+
+/*
  * Wait for the read lock to be granted
  */
 static inline struct rw_semaphore __sched *
@@ -385,6 +421,7 @@ static inline bool rwsem_has_spinner(struct rw_semaphore *sem)
 
 	waiter.task = current;
 	waiter.type = RWSEM_WAITING_FOR_READ;
+	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
 
 	raw_spin_lock_irq(&sem->wait_lock);
 	if (list_empty(&sem->wait_list)) {
@@ -441,8 +478,12 @@ static inline bool rwsem_has_spinner(struct rw_semaphore *sem)
 	return sem;
 out_nolock:
 	list_del(&waiter.list);
-	if (list_empty(&sem->wait_list))
-		atomic_long_add(-RWSEM_FLAG_WAITERS, &sem->count);
+	if (list_empty(&sem->wait_list)) {
+		int adjustment = -RWSEM_FLAG_WAITERS -
+			(atomic_long_read(&sem->count) & RWSEM_FLAG_HANDOFF);
+
+		atomic_long_add(adjustment, &sem->count);
+	}
 	raw_spin_unlock_irq(&sem->wait_lock);
 	__set_current_state(TASK_RUNNING);
 	lockevent_inc(rwsem_rlock_fail);
@@ -469,8 +510,8 @@ static inline bool rwsem_has_spinner(struct rw_semaphore *sem)
 static inline struct rw_semaphore *
 __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 {
-	long count;
-	bool waiting = true; /* any queued threads before us */
+	long count, adjustment;
+	bool first;	/* First one in queue */
 	struct rwsem_waiter waiter;
 	struct rw_semaphore *ret = sem;
 	DEFINE_WAKE_Q(wake_q);
@@ -485,17 +526,17 @@ static inline bool rwsem_has_spinner(struct rw_semaphore *sem)
 	 */
 	waiter.task = current;
 	waiter.type = RWSEM_WAITING_FOR_WRITE;
+	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
 
 	raw_spin_lock_irq(&sem->wait_lock);
 
 	/* account for this before adding a new element to the list */
-	if (list_empty(&sem->wait_list))
-		waiting = false;
+	first = list_empty(&sem->wait_list);
 
 	list_add_tail(&waiter.list, &sem->wait_list);
 
 	/* we're now waiting on the lock, but no longer actively locking */
-	if (waiting) {
+	if (!first) {
 		count = atomic_long_read(&sem->count);
 
 		/*
@@ -529,12 +570,13 @@ static inline bool rwsem_has_spinner(struct rw_semaphore *sem)
 	/* wait until we successfully acquire the lock */
 	set_current_state(state);
 	while (true) {
-		if (rwsem_try_write_lock(count, sem))
+		if (rwsem_try_write_lock(count, sem, first))
 			break;
+
 		raw_spin_unlock_irq(&sem->wait_lock);
 
 		/* Block until there are no active lockers. */
-		do {
+		for (;;) {
 			if (signal_pending_state(state, current))
 				goto out_nolock;
 
@@ -542,7 +584,29 @@ static inline bool rwsem_has_spinner(struct rw_semaphore *sem)
 			lockevent_inc(rwsem_sleep_writer);
 			set_current_state(state);
 			count = atomic_long_read(&sem->count);
-		} while (RWSEM_COUNT_LOCKED(count));
+
+			if (!first)
+				first = rwsem_waiter_is_first(sem, &waiter);
+
+			if (!RWSEM_COUNT_LOCKED(count))
+				break;
+
+			if (first && !RWSEM_COUNT_HANDOFF(count) &&
+			    time_after(jiffies, waiter.timeout)) {
+				atomic_long_or(RWSEM_FLAG_HANDOFF, &sem->count);
+				/*
+				 * Make sure the handoff bit is seen by
+				 * others before proceeding.
+				 */
+				smp_mb__after_atomic();
+				lockevent_inc(rwsem_wlock_handoff);
+				/*
+				 * Do a trylock after setting the handoff
+				 * flag to avoid missed wakeup.
+				 */
+				break;
+			}
+		}
 
 		raw_spin_lock_irq(&sem->wait_lock);
 	}
@@ -557,9 +621,15 @@ static inline bool rwsem_has_spinner(struct rw_semaphore *sem)
 	__set_current_state(TASK_RUNNING);
 	raw_spin_lock_irq(&sem->wait_lock);
 	list_del(&waiter.list);
+	adjustment = 0;
 	if (list_empty(&sem->wait_list))
-		atomic_long_add(-RWSEM_FLAG_WAITERS, &sem->count);
-	else
+		adjustment -= RWSEM_FLAG_WAITERS;
+	if (first)
+		adjustment -= (atomic_long_read(&sem->count) &
+			       RWSEM_FLAG_HANDOFF);
+	if (adjustment)
+		atomic_long_add(adjustment, &sem->count);
+	if (!list_empty(&sem->wait_list))
 		__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	wake_up_q(&wake_q);
@@ -587,7 +657,7 @@ static inline bool rwsem_has_spinner(struct rw_semaphore *sem)
  * - up_read/up_write has decremented the active part of count if we come here
  */
 __visible
-struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
+struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem, long count)
 {
 	unsigned long flags;
 	DEFINE_WAKE_Q(wake_q);
@@ -620,7 +690,9 @@ struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
 	smp_rmb();
 
 	/*
-	 * If a spinner is present, it is not necessary to do the wakeup.
+	 * If a spinner is present and the handoff flag isn't set, it is
+	 * not necessary to do the wakeup.
+	 *
 	 * Try to do wakeup only if the trylock succeeds to minimize
 	 * spinlock contention which may introduce too much delay in the
 	 * unlock operation.
@@ -639,7 +711,7 @@ struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
 	 * rwsem_has_spinner() is true, it will guarantee at least one
 	 * trylock attempt on the rwsem later on.
 	 */
-	if (rwsem_has_spinner(sem)) {
+	if (rwsem_has_spinner(sem) && !RWSEM_COUNT_HANDOFF(count)) {
 		/*
 		 * The smp_rmb() here is to make sure that the spinner
 		 * state is consulted before reading the wait_lock.
diff --git a/kernel/locking/rwsem-xadd.h b/kernel/locking/rwsem-xadd.h
index 1febd17..6d4890d 100644
--- a/kernel/locking/rwsem-xadd.h
+++ b/kernel/locking/rwsem-xadd.h
@@ -41,7 +41,8 @@
  *
  * Bit  0   - writer locked bit
  * Bit  1   - waiters present bit
- * Bits 2-7 - reserved
+ * Bit  2   - lock handoff bit
+ * Bits 3-7 - reserved
  * Bits 8-X - 24-bit (32-bit) or 56-bit reader count
  *
  * atomic_long_fetch_add() is used to obtain reader lock, whereas
@@ -49,14 +50,20 @@
  */
 #define RWSEM_WRITER_LOCKED	(1UL << 0)
 #define RWSEM_FLAG_WAITERS	(1UL << 1)
+#define RWSEM_FLAG_HANDOFF	(1UL << 2)
+
 #define RWSEM_READER_SHIFT	8
 #define RWSEM_READER_BIAS	(1UL << RWSEM_READER_SHIFT)
 #define RWSEM_READER_MASK	(~(RWSEM_READER_BIAS - 1))
 #define RWSEM_WRITER_MASK	RWSEM_WRITER_LOCKED
 #define RWSEM_LOCK_MASK		(RWSEM_WRITER_MASK|RWSEM_READER_MASK)
-#define RWSEM_READ_FAILED_MASK	(RWSEM_WRITER_MASK|RWSEM_FLAG_WAITERS)
+#define RWSEM_READ_FAILED_MASK	(RWSEM_WRITER_MASK|RWSEM_FLAG_WAITERS|\
+				 RWSEM_FLAG_HANDOFF)
 
 #define RWSEM_COUNT_LOCKED(c)	((c) & RWSEM_LOCK_MASK)
+#define RWSEM_COUNT_HANDOFF(c)	((c) & RWSEM_FLAG_HANDOFF)
+#define RWSEM_COUNT_LOCKED_OR_HANDOFF(c)	\
+	((c) & (RWSEM_LOCK_MASK|RWSEM_FLAG_HANDOFF))
 
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 /*
@@ -163,7 +170,7 @@ static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
 extern struct rw_semaphore *rwsem_down_read_failed_killable(struct rw_semaphore *sem);
 extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem);
 extern struct rw_semaphore *rwsem_down_write_failed_killable(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem);
+extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem, long count);
 extern struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem);
 
 /*
@@ -253,7 +260,7 @@ static inline void __up_read(struct rw_semaphore *sem)
 	tmp = atomic_long_add_return_release(-RWSEM_READER_BIAS, &sem->count);
 	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS))
 			== RWSEM_FLAG_WAITERS))
-		rwsem_wake(sem);
+		rwsem_wake(sem, tmp);
 }
 
 /*
@@ -261,11 +268,13 @@ static inline void __up_read(struct rw_semaphore *sem)
  */
 static inline void __up_write(struct rw_semaphore *sem)
 {
+	long tmp;
+
 	DEBUG_RWSEMS_WARN_ON(sem->owner != current, sem);
 	rwsem_clear_owner(sem);
-	if (unlikely(atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED,
-			&sem->count) & RWSEM_FLAG_WAITERS))
-		rwsem_wake(sem);
+	tmp = atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED, &sem->count);
+	if (unlikely(tmp & RWSEM_FLAG_WAITERS))
+		rwsem_wake(sem, tmp);
 }
 
 /*
-- 
1.8.3.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
