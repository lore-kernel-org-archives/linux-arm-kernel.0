Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E1AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:13:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F41F021871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GTeSROh0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F41F021871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bkm7tzdIUySAKSr3HMEjG+0VIdLsBLFKlAP+Q4Ddxvs=; b=GTeSROh0Io/6Ra
	eX2aEDOgYRP/0EhFPRbtXOmFwx21Dv2Eh/DibA55MTH8Y4fX2nzKDDFCC4WIq2Z6szqzDFjwuR6/j
	1fdk4//H4gRg0NLG/hkHjD2CKeXRHJbhX1rBbx9aGpOfYUg2YfLbYmZqcJsh4whiE0HoYT6D/16w2
	qitOGokvnXvhKPKNb2i1E1R2vXgsPviMUQwOJsaUWQ78ApkiOFJKlcaRM3qm4IwWlshjh1Llv7QXF
	IspOuHqNQU3Pg4kwT902GoGYhbKP37ilW0JMUhK2X9BKzFqleU9LQVnG8U2wstXNE/g4u+PIVH6Qh
	I2eAiV0d7oOwkeBYYR8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZNcF-00065X-5C; Tue, 18 Dec 2018 22:13:27 +0000
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZNac-0004We-IE
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 22:12:05 +0000
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
 by Galois.linutronix.de with esmtp (Exim 4.80)
 (envelope-from <bigeasy@linutronix.de>)
 id 1gZNaE-000889-6M; Tue, 18 Dec 2018 23:11:22 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: stable@vger.kernel.org
Subject: [PATCH STABLE v4.9 05/10] locking/qspinlock: Remove unbounded
 cmpxchg() loop from locking slowpath
Date: Tue, 18 Dec 2018 23:10:44 +0100
Message-Id: <20181218221049.6816-6-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218221049.6816-1-bigeasy@linutronix.de>
References: <20181218221049.6816-1-bigeasy@linutronix.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_141147_222829_56DE9E44 
X-CRM114-Status: GOOD (  21.92  )
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
Cc: Peter Zijlstra <peterz@infradead.org>, bigeasy@linutronix.de,
 Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@kernel.org>,
 Daniel Wagner <daniel.wagner@siemens.com>, Waiman Long <longman@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, paulmck@linux.vnet.ibm.com,
 Linus Torvalds <torvalds@linux-foundation.org>, boqun.feng@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

commit 59fb586b4a07b4e1a0ee577140ab4842ba451acd upstream.

The qspinlock locking slowpath utilises a "pending" bit as a simple form
of an embedded test-and-set lock that can avoid the overhead of explicit
queuing in cases where the lock is held but uncontended. This bit is
managed using a cmpxchg() loop which tries to transition the uncontended
lock word from (0,0,0) -> (0,0,1) or (0,0,1) -> (0,1,1).

Unfortunately, the cmpxchg() loop is unbounded and lockers can be starved
indefinitely if the lock word is seen to oscillate between unlocked
(0,0,0) and locked (0,0,1). This could happen if concurrent lockers are
able to take the lock in the cmpxchg() loop without queuing and pass it
around amongst themselves.

This patch fixes the problem by unconditionally setting _Q_PENDING_VAL
using atomic_fetch_or, and then inspecting the old value to see whether
we need to spin on the current lock owner, or whether we now effectively
hold the lock. The tricky scenario is when concurrent lockers end up
queuing on the lock and the lock becomes available, causing us to see
a lockword of (n,0,0). With pending now set, simply queuing could lead
to deadlock as the head of the queue may not have observed the pending
flag being cleared. Conversely, if the head of the queue did observe
pending being cleared, then it could transition the lock from (n,0,0) ->
(0,0,1) meaning that any attempt to "undo" our setting of the pending
bit could race with a concurrent locker trying to set it.

We handle this race by preserving the pending bit when taking the lock
after reaching the head of the queue and leaving the tail entry intact
if we saw pending set, because we know that the tail is going to be
updated shortly.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: boqun.feng@gmail.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: paulmck@linux.vnet.ibm.com
Link: http://lkml.kernel.org/r/1524738868-31318-6-git-send-email-will.deacon@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/locking/qspinlock.c          | 102 ++++++++++++++++------------
 kernel/locking/qspinlock_paravirt.h |   5 --
 2 files changed, 58 insertions(+), 49 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index cc98050e8bec0..e7ab99a1f4387 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -126,6 +126,17 @@ static inline __pure struct mcs_spinlock *decode_tail(u32 tail)
 #define _Q_LOCKED_PENDING_MASK (_Q_LOCKED_MASK | _Q_PENDING_MASK)
 
 #if _Q_PENDING_BITS == 8
+/**
+ * clear_pending - clear the pending bit.
+ * @lock: Pointer to queued spinlock structure
+ *
+ * *,1,* -> *,0,*
+ */
+static __always_inline void clear_pending(struct qspinlock *lock)
+{
+	WRITE_ONCE(lock->pending, 0);
+}
+
 /**
  * clear_pending_set_locked - take ownership and clear the pending bit.
  * @lock: Pointer to queued spinlock structure
@@ -161,6 +172,17 @@ static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
 
 #else /* _Q_PENDING_BITS == 8 */
 
+/**
+ * clear_pending - clear the pending bit.
+ * @lock: Pointer to queued spinlock structure
+ *
+ * *,1,* -> *,0,*
+ */
+static __always_inline void clear_pending(struct qspinlock *lock)
+{
+	atomic_andnot(_Q_PENDING_VAL, &lock->val);
+}
+
 /**
  * clear_pending_set_locked - take ownership and clear the pending bit.
  * @lock: Pointer to queued spinlock structure
@@ -382,7 +404,7 @@ EXPORT_SYMBOL(queued_spin_unlock_wait);
 void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 {
 	struct mcs_spinlock *prev, *next, *node;
-	u32 new, old, tail;
+	u32 old, tail;
 	int idx;
 
 	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
@@ -405,59 +427,51 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 					       (VAL != _Q_PENDING_VAL) || !cnt--);
 	}
 
+	/*
+	 * If we observe any contention; queue.
+	 */
+	if (val & ~_Q_LOCKED_MASK)
+		goto queue;
+
 	/*
 	 * trylock || pending
 	 *
 	 * 0,0,0 -> 0,0,1 ; trylock
 	 * 0,0,1 -> 0,1,1 ; pending
 	 */
-	for (;;) {
+	val = atomic_fetch_or_acquire(_Q_PENDING_VAL, &lock->val);
+	if (!(val & ~_Q_LOCKED_MASK)) {
 		/*
-		 * If we observe any contention; queue.
+		 * We're pending, wait for the owner to go away.
+		 *
+		 * *,1,1 -> *,1,0
+		 *
+		 * this wait loop must be a load-acquire such that we match the
+		 * store-release that clears the locked bit and create lock
+		 * sequentiality; this is because not all
+		 * clear_pending_set_locked() implementations imply full
+		 * barriers.
 		 */
-		if (val & ~_Q_LOCKED_MASK)
-			goto queue;
-
-		new = _Q_LOCKED_VAL;
-		if (val == new)
-			new |= _Q_PENDING_VAL;
+		if (val & _Q_LOCKED_MASK) {
+			smp_cond_load_acquire(&lock->val.counter,
+					      !(VAL & _Q_LOCKED_MASK));
+		}
 
 		/*
-		 * Acquire semantic is required here as the function may
-		 * return immediately if the lock was free.
+		 * take ownership and clear the pending bit.
+		 *
+		 * *,1,0 -> *,0,1
 		 */
-		old = atomic_cmpxchg_acquire(&lock->val, val, new);
-		if (old == val)
-			break;
-
-		val = old;
+		clear_pending_set_locked(lock);
+		return;
 	}
 
 	/*
-	 * we won the trylock
+	 * If pending was clear but there are waiters in the queue, then
+	 * we need to undo our setting of pending before we queue ourselves.
 	 */
-	if (new == _Q_LOCKED_VAL)
-		return;
-
-	/*
-	 * we're pending, wait for the owner to go away.
-	 *
-	 * *,1,1 -> *,1,0
-	 *
-	 * this wait loop must be a load-acquire such that we match the
-	 * store-release that clears the locked bit and create lock
-	 * sequentiality; this is because not all clear_pending_set_locked()
-	 * implementations imply full barriers.
-	 */
-	smp_cond_load_acquire(&lock->val.counter, !(VAL & _Q_LOCKED_MASK));
-
-	/*
-	 * take ownership and clear the pending bit.
-	 *
-	 * *,1,0 -> *,0,1
-	 */
-	clear_pending_set_locked(lock);
-	return;
+	if (!(val & _Q_PENDING_MASK))
+		clear_pending(lock);
 
 	/*
 	 * End of pending bit optimistic spinning and beginning of MCS
@@ -561,15 +575,15 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 * claim the lock:
 	 *
 	 * n,0,0 -> 0,0,1 : lock, uncontended
-	 * *,0,0 -> *,0,1 : lock, contended
+	 * *,*,0 -> *,*,1 : lock, contended
 	 *
-	 * If the queue head is the only one in the queue (lock value == tail),
-	 * clear the tail code and grab the lock. Otherwise, we only need
-	 * to grab the lock.
+	 * If the queue head is the only one in the queue (lock value == tail)
+	 * and nobody is pending, clear the tail code and grab the lock.
+	 * Otherwise, we only need to grab the lock.
 	 */
 	for (;;) {
 		/* In the PV case we might already have _Q_LOCKED_VAL set */
-		if ((val & _Q_TAIL_MASK) != tail) {
+		if ((val & _Q_TAIL_MASK) != tail || (val & _Q_PENDING_MASK)) {
 			set_locked(lock);
 			break;
 		}
diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 3e33336911ffe..9c07c72fb10e9 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -88,11 +88,6 @@ static __always_inline void set_pending(struct qspinlock *lock)
 	WRITE_ONCE(lock->pending, 1);
 }
 
-static __always_inline void clear_pending(struct qspinlock *lock)
-{
-	WRITE_ONCE(lock->pending, 0);
-}
-
 /*
  * The pending bit check in pv_queued_spin_steal_lock() isn't a memory
  * barrier. Therefore, an atomic cmpxchg() is used to acquire the lock
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
