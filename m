Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F944C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:12:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F219B217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nrw2NGkG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F219B217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FrgL1HH3RtSrPLsg9PfWTEBAtu6KgKlJH/PSzGfKp9U=; b=nrw2NGkG84mMlp
	yQqdvuH7KsMz4nW0GHtQBmJ0MbLFDgC6JtsIs+spqHRqPXjZsCRy/wixqrexo5kUzNEBXG7f8AX5J
	08ng8BxQtMliSANQNsOvcqezPlWH7Rw/ujjtegRUN+x+tcipe/838S6/aLlu59Rmkex/oXwiFnmaF
	hZKQUBidsp1Lmy/E9hT3gxu1RsUQOZJpfiBX4OqGsqPzMAKfQzGEkiW9V6e6kKFHro7+sIOe0C6wo
	riO9cKzNDBHPu4Hk1GLpK3fw/iZquxYF8FA2YogKADsIih4VICh4gbyJUhENj8mLRdA6acgKxO1nA
	rMLXMKq3ygX1PVBID3YA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZNbX-0005Pw-Ck; Tue, 18 Dec 2018 22:12:43 +0000
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZNac-0004WK-IC
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 22:11:57 +0000
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
 by Galois.linutronix.de with esmtp (Exim 4.80)
 (envelope-from <bigeasy@linutronix.de>)
 id 1gZNaB-000889-Lg; Tue, 18 Dec 2018 23:11:20 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: stable@vger.kernel.org
Subject: [PATCH STABLE v4.9 03/10] locking/qspinlock: Bound spinning on
 pending->locked transition in slowpath
Date: Tue, 18 Dec 2018 23:10:42 +0100
Message-Id: <20181218221049.6816-4-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218221049.6816-1-bigeasy@linutronix.de>
References: <20181218221049.6816-1-bigeasy@linutronix.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_141147_193575_DADDBC03 
X-CRM114-Status: GOOD (  14.76  )
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

commit 6512276d97b160d90b53285bd06f7f201459a7e3 upstream.

If a locker taking the qspinlock slowpath reads a lock value indicating
that only the pending bit is set, then it will spin whilst the
concurrent pending->locked transition takes effect.

Unfortunately, there is no guarantee that such a transition will ever be
observed since concurrent lockers could continuously set pending and
hand over the lock amongst themselves, leading to starvation. Whilst
this would probably resolve in practice, it means that it is not
possible to prove liveness properties about the lock and means that lock
acquisition time is unbounded.

Rather than removing the pending->locked spinning from the slowpath
altogether (which has been shown to heavily penalise a 2-threaded
locking stress test on x86), this patch replaces the explicit spinning
with a call to atomic_cond_read_relaxed and allows the architecture to
provide a bound on the number of spins. For architectures that can
respond to changes in cacheline state in their smp_cond_load implementation,
it should be sufficient to use the default bound of 1.

Suggested-by: Waiman Long <longman@redhat.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: boqun.feng@gmail.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: paulmck@linux.vnet.ibm.com
Link: http://lkml.kernel.org/r/1524738868-31318-4-git-send-email-will.deacon@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/locking/qspinlock.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 6fce84401dba1..a8da1fc5222eb 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -75,6 +75,18 @@
 #define MAX_NODES	4
 #endif
 
+/*
+ * The pending bit spinning loop count.
+ * This heuristic is used to limit the number of lockword accesses
+ * made by atomic_cond_read_relaxed when waiting for the lock to
+ * transition out of the "== _Q_PENDING_VAL" state. We don't spin
+ * indefinitely because there's no guarantee that we'll make forward
+ * progress.
+ */
+#ifndef _Q_PENDING_LOOPS
+#define _Q_PENDING_LOOPS	1
+#endif
+
 /*
  * Per-CPU queue node structures; we can never have more than 4 nested
  * contexts: task, softirq, hardirq, nmi.
@@ -422,13 +434,15 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 		return;
 
 	/*
-	 * wait for in-progress pending->locked hand-overs
+	 * Wait for in-progress pending->locked hand-overs with a bounded
+	 * number of spins so that we guarantee forward progress.
 	 *
 	 * 0,1,0 -> 0,0,1
 	 */
 	if (val == _Q_PENDING_VAL) {
-		while ((val = atomic_read(&lock->val)) == _Q_PENDING_VAL)
-			cpu_relax();
+		int cnt = _Q_PENDING_LOOPS;
+		val = smp_cond_load_acquire(&lock->val.counter,
+					       (VAL != _Q_PENDING_VAL) || !cnt--);
 	}
 
 	/*
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
