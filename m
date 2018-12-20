Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429CFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:25:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DC86217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XMXfvxfc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6ac/ipk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC86217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jNjRutYQu3lB9VI4pI7t76yBxpB5pFmxV/cT+hkI8XY=; b=XMXfvxfcW72Q1Y
	JC3nAHzriUZfX/8Y1zvuGyuOOp7dNDm+yEipfeC7qlQKQTTw+GCelY0JPK8IQf4rRxFzXrGYGAT+U
	9yh1coV2yimcc4cosMufzI6z5yPqgOEe+IKwIUMtxbJWFt15rDHgEnCjOzZYdqsXqdP6nLNAglKqn
	BwNc7Z+fE2vyNoZkfsZZtMrSX2uVsm/5UOGiaJWGn8ieKes+yjDUQSEYPIHaHzdaUIiNwNHOF5CnJ
	4lxB7Mk4K2wHOgAPzmOhOXCj1I0T0BGBRuNoxzpXFBn1wI8FUFWKabH8jxiggctHNuOTe/ZOrWeLQ
	g7lGEllec53a0R6DD4gA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZuZv-00022w-Pd; Thu, 20 Dec 2018 09:25:15 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZuZr-00019v-UX
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 09:25:13 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A52AF2186A;
 Thu, 20 Dec 2018 09:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545297904;
 bh=L7iVUziSMVdeOfsu8IEWQFG3rogq34UdNf/MQwZhYyw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=l6ac/ipk3Ko8f5pAx4zXCBQ0IRXwpg/zwkzGZAVnEBbqUcfQPDTqj2emhXQBF5iCo
 zXGC3xUpoUXlRen0xmqks7FyH3VeppfgVkOiywZ2vp1KpxbbwBPozBcwa3ddq6UzIM
 PbVdNDxweCceKUdiwm9C6Jw8trdny4MeTs0Jptmc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4.9 23/61] locking/qspinlock: Merge struct __qspinlock into
 struct qspinlock
Date: Thu, 20 Dec 2018 10:18:23 +0100
Message-Id: <20181220085844.672096510@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085843.743900603@linuxfoundation.org>
References: <20181220085843.743900603@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_012512_049378_42DCACA2 
X-CRM114-Status: GOOD (  20.62  )
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
Cc: Sasha Levin <sashal@kernel.org>,
 "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Boqun Feng <boqun.feng@gmail.com>, Will Deacon <will.deacon@arm.com>,
 stable@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Waiman Long <longman@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 paulmck@linux.vnet.ibm.com, Linus Torvalds <torvalds@linux-foundation.org>,
 Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 625e88be1f41b53cec55827c984e4a89ea8ee9f9 upstream.

'struct __qspinlock' provides a handy union of fields so that
subcomponents of the lockword can be accessed by name, without having to
manage shifts and masks explicitly and take endianness into account.

This is useful in qspinlock.h and also potentially in arch headers, so
move the 'struct __qspinlock' into 'struct qspinlock' and kill the extra
definition.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Acked-by: Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: paulmck@linux.vnet.ibm.com
Link: http://lkml.kernel.org/r/1524738868-31318-3-git-send-email-will.deacon@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/qspinlock.h          |  2 +-
 arch/x86/include/asm/qspinlock_paravirt.h |  3 +-
 include/asm-generic/qspinlock_types.h     | 32 +++++++++++++++-
 kernel/locking/qspinlock.c                | 46 ++---------------------
 kernel/locking/qspinlock_paravirt.h       | 34 ++++++-----------
 5 files changed, 46 insertions(+), 71 deletions(-)

diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index eaba08076030..e07cc206919d 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -14,7 +14,7 @@
  */
 static inline void native_queued_spin_unlock(struct qspinlock *lock)
 {
-	smp_store_release((u8 *)lock, 0);
+	smp_store_release(&lock->locked, 0);
 }
 
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
index 9d55f9b6e167..fc75415ae971 100644
--- a/arch/x86/include/asm/qspinlock_paravirt.h
+++ b/arch/x86/include/asm/qspinlock_paravirt.h
@@ -21,8 +21,7 @@ PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath);
  *
  * void __pv_queued_spin_unlock(struct qspinlock *lock)
  * {
- *	struct __qspinlock *l = (void *)lock;
- *	u8 lockval = cmpxchg(&l->locked, _Q_LOCKED_VAL, 0);
+ *	u8 lockval = cmpxchg(&lock->locked, _Q_LOCKED_VAL, 0);
  *
  *	if (likely(lockval == _Q_LOCKED_VAL))
  *		return;
diff --git a/include/asm-generic/qspinlock_types.h b/include/asm-generic/qspinlock_types.h
index 034acd0c4956..0763f065b975 100644
--- a/include/asm-generic/qspinlock_types.h
+++ b/include/asm-generic/qspinlock_types.h
@@ -29,13 +29,41 @@
 #endif
 
 typedef struct qspinlock {
-	atomic_t	val;
+	union {
+		atomic_t val;
+
+		/*
+		 * By using the whole 2nd least significant byte for the
+		 * pending bit, we can allow better optimization of the lock
+		 * acquisition for the pending bit holder.
+		 */
+#ifdef __LITTLE_ENDIAN
+		struct {
+			u8	locked;
+			u8	pending;
+		};
+		struct {
+			u16	locked_pending;
+			u16	tail;
+		};
+#else
+		struct {
+			u16	tail;
+			u16	locked_pending;
+		};
+		struct {
+			u8	reserved[2];
+			u8	pending;
+			u8	locked;
+		};
+#endif
+	};
 } arch_spinlock_t;
 
 /*
  * Initializier
  */
-#define	__ARCH_SPIN_LOCK_UNLOCKED	{ ATOMIC_INIT(0) }
+#define	__ARCH_SPIN_LOCK_UNLOCKED	{ .val = ATOMIC_INIT(0) }
 
 /*
  * Bitfields in the atomic value:
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index a8da1fc5222e..cc98050e8bec 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -125,40 +125,6 @@ static inline __pure struct mcs_spinlock *decode_tail(u32 tail)
 
 #define _Q_LOCKED_PENDING_MASK (_Q_LOCKED_MASK | _Q_PENDING_MASK)
 
-/*
- * By using the whole 2nd least significant byte for the pending bit, we
- * can allow better optimization of the lock acquisition for the pending
- * bit holder.
- *
- * This internal structure is also used by the set_locked function which
- * is not restricted to _Q_PENDING_BITS == 8.
- */
-struct __qspinlock {
-	union {
-		atomic_t val;
-#ifdef __LITTLE_ENDIAN
-		struct {
-			u8	locked;
-			u8	pending;
-		};
-		struct {
-			u16	locked_pending;
-			u16	tail;
-		};
-#else
-		struct {
-			u16	tail;
-			u16	locked_pending;
-		};
-		struct {
-			u8	reserved[2];
-			u8	pending;
-			u8	locked;
-		};
-#endif
-	};
-};
-
 #if _Q_PENDING_BITS == 8
 /**
  * clear_pending_set_locked - take ownership and clear the pending bit.
@@ -170,9 +136,7 @@ struct __qspinlock {
  */
 static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
 {
-	struct __qspinlock *l = (void *)lock;
-
-	WRITE_ONCE(l->locked_pending, _Q_LOCKED_VAL);
+	WRITE_ONCE(lock->locked_pending, _Q_LOCKED_VAL);
 }
 
 /*
@@ -187,13 +151,11 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
  */
 static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
 {
-	struct __qspinlock *l = (void *)lock;
-
 	/*
 	 * Use release semantics to make sure that the MCS node is properly
 	 * initialized before changing the tail code.
 	 */
-	return (u32)xchg_release(&l->tail,
+	return (u32)xchg_release(&lock->tail,
 				 tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
 }
 
@@ -248,9 +210,7 @@ static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
  */
 static __always_inline void set_locked(struct qspinlock *lock)
 {
-	struct __qspinlock *l = (void *)lock;
-
-	WRITE_ONCE(l->locked, _Q_LOCKED_VAL);
+	WRITE_ONCE(lock->locked, _Q_LOCKED_VAL);
 }
 
 
diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index e3b5520005db..3e33336911ff 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -69,10 +69,8 @@ struct pv_node {
 #define queued_spin_trylock(l)	pv_queued_spin_steal_lock(l)
 static inline bool pv_queued_spin_steal_lock(struct qspinlock *lock)
 {
-	struct __qspinlock *l = (void *)lock;
-
 	if (!(atomic_read(&lock->val) & _Q_LOCKED_PENDING_MASK) &&
-	    (cmpxchg(&l->locked, 0, _Q_LOCKED_VAL) == 0)) {
+	    (cmpxchg(&lock->locked, 0, _Q_LOCKED_VAL) == 0)) {
 		qstat_inc(qstat_pv_lock_stealing, true);
 		return true;
 	}
@@ -87,16 +85,12 @@ static inline bool pv_queued_spin_steal_lock(struct qspinlock *lock)
 #if _Q_PENDING_BITS == 8
 static __always_inline void set_pending(struct qspinlock *lock)
 {
-	struct __qspinlock *l = (void *)lock;
-
-	WRITE_ONCE(l->pending, 1);
+	WRITE_ONCE(lock->pending, 1);
 }
 
 static __always_inline void clear_pending(struct qspinlock *lock)
 {
-	struct __qspinlock *l = (void *)lock;
-
-	WRITE_ONCE(l->pending, 0);
+	WRITE_ONCE(lock->pending, 0);
 }
 
 /*
@@ -106,10 +100,8 @@ static __always_inline void clear_pending(struct qspinlock *lock)
  */
 static __always_inline int trylock_clear_pending(struct qspinlock *lock)
 {
-	struct __qspinlock *l = (void *)lock;
-
-	return !READ_ONCE(l->locked) &&
-	       (cmpxchg(&l->locked_pending, _Q_PENDING_VAL, _Q_LOCKED_VAL)
+	return !READ_ONCE(lock->locked) &&
+	       (cmpxchg(&lock->locked_pending, _Q_PENDING_VAL, _Q_LOCKED_VAL)
 			== _Q_PENDING_VAL);
 }
 #else /* _Q_PENDING_BITS == 8 */
@@ -353,7 +345,6 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
 static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
 {
 	struct pv_node *pn = (struct pv_node *)node;
-	struct __qspinlock *l = (void *)lock;
 
 	/*
 	 * If the vCPU is indeed halted, advance its state to match that of
@@ -372,7 +363,7 @@ static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
 	 * the hash table later on at unlock time, no atomic instruction is
 	 * needed.
 	 */
-	WRITE_ONCE(l->locked, _Q_SLOW_VAL);
+	WRITE_ONCE(lock->locked, _Q_SLOW_VAL);
 	(void)pv_hash(lock, pn);
 }
 
@@ -387,7 +378,6 @@ static u32
 pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 {
 	struct pv_node *pn = (struct pv_node *)node;
-	struct __qspinlock *l = (void *)lock;
 	struct qspinlock **lp = NULL;
 	int waitcnt = 0;
 	int loop;
@@ -438,13 +428,13 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 			 *
 			 * Matches the smp_rmb() in __pv_queued_spin_unlock().
 			 */
-			if (xchg(&l->locked, _Q_SLOW_VAL) == 0) {
+			if (xchg(&lock->locked, _Q_SLOW_VAL) == 0) {
 				/*
 				 * The lock was free and now we own the lock.
 				 * Change the lock value back to _Q_LOCKED_VAL
 				 * and unhash the table.
 				 */
-				WRITE_ONCE(l->locked, _Q_LOCKED_VAL);
+				WRITE_ONCE(lock->locked, _Q_LOCKED_VAL);
 				WRITE_ONCE(*lp, NULL);
 				goto gotlock;
 			}
@@ -452,7 +442,7 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 		WRITE_ONCE(pn->state, vcpu_hashed);
 		qstat_inc(qstat_pv_wait_head, true);
 		qstat_inc(qstat_pv_wait_again, waitcnt);
-		pv_wait(&l->locked, _Q_SLOW_VAL);
+		pv_wait(&lock->locked, _Q_SLOW_VAL);
 
 		/*
 		 * Because of lock stealing, the queue head vCPU may not be
@@ -477,7 +467,6 @@ gotlock:
 __visible void
 __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
 {
-	struct __qspinlock *l = (void *)lock;
 	struct pv_node *node;
 
 	if (unlikely(locked != _Q_SLOW_VAL)) {
@@ -506,7 +495,7 @@ __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
 	 * Now that we have a reference to the (likely) blocked pv_node,
 	 * release the lock.
 	 */
-	smp_store_release(&l->locked, 0);
+	smp_store_release(&lock->locked, 0);
 
 	/*
 	 * At this point the memory pointed at by lock can be freed/reused,
@@ -532,7 +521,6 @@ __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
 #ifndef __pv_queued_spin_unlock
 __visible void __pv_queued_spin_unlock(struct qspinlock *lock)
 {
-	struct __qspinlock *l = (void *)lock;
 	u8 locked;
 
 	/*
@@ -540,7 +528,7 @@ __visible void __pv_queued_spin_unlock(struct qspinlock *lock)
 	 * unhash. Otherwise it would be possible to have multiple @lock
 	 * entries, which would be BAD.
 	 */
-	locked = cmpxchg_release(&l->locked, _Q_LOCKED_VAL, 0);
+	locked = cmpxchg_release(&lock->locked, _Q_LOCKED_VAL, 0);
 	if (likely(locked == _Q_LOCKED_VAL))
 		return;
 
-- 
2.19.1




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
