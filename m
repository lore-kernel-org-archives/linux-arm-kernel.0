Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6C1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:13:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09D44218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZXnyU/ud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D44218A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HpYQtNYpSGOcsURmrFtR98Ckp872Tq0Opn5qaVSIpEM=; b=ZXnyU/udA+x5Yl
	NekpMVCPpHF+O8q3XzOqpipnFv2ukXCmhI/s61/pZ1QLCIRUB4CzfdZSZ6KgwjmqJJNUXYgIyjE2h
	nGutbvGL7RnXAryc06JZ4zPeGIC6UDMTxRggCJ31fmWyt8llH1eRXh+ndvBrU8sXjg7/wc0C+wyKV
	7HdBRh+gPjro33xbquVCtOaBFsZ/M8irXcuihZaMX3NIds7la/eXmvW0dzFi3HiaF6G2OdE2lRU1+
	W2se279wANMLoXdo+nYFntrVL0bEeKuYWL5KvIPVl+p/Q4ns2GTfkIfiElSjEp97mg8WXsPOH8oSu
	/r6Whm5jQnEAjp0ixenQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZNcW-0006JK-7g; Tue, 18 Dec 2018 22:13:44 +0000
Received: from galois.linutronix.de ([146.0.238.70])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZNae-0004Wk-HK
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 22:12:08 +0000
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
 by Galois.linutronix.de with esmtp (Exim 4.80)
 (envelope-from <bigeasy@linutronix.de>)
 id 1gZNaG-000889-Tj; Tue, 18 Dec 2018 23:11:25 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: stable@vger.kernel.org
Subject: [PATCH STABLE v4.9 07/10] locking/qspinlock: Kill cmpxchg() loop when
 claiming lock from head of queue
Date: Tue, 18 Dec 2018 23:10:46 +0100
Message-Id: <20181218221049.6816-8-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218221049.6816-1-bigeasy@linutronix.de>
References: <20181218221049.6816-1-bigeasy@linutronix.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_141149_321624_434B3826 
X-CRM114-Status: GOOD (  13.76  )
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

commit c61da58d8a9ba9238250a548f00826eaf44af0f7 upstream.

When a queued locker reaches the head of the queue, it claims the lock
by setting _Q_LOCKED_VAL in the lockword. If there isn't contention, it
must also clear the tail as part of this operation so that subsequent
lockers can avoid taking the slowpath altogether.

Currently this is expressed as a cmpxchg() loop that practically only
runs up to two iterations. This is confusing to the reader and unhelpful
to the compiler. Rewrite the cmpxchg() loop without the loop, so that a
failed cmpxchg() implies that there is contention and we just need to
write to _Q_LOCKED_VAL without considering the rest of the lockword.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: boqun.feng@gmail.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: paulmck@linux.vnet.ibm.com
Link: http://lkml.kernel.org/r/1524738868-31318-7-git-send-email-will.deacon@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/locking/qspinlock.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index e7ab99a1f4387..ba5dc86a4d831 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -581,24 +581,21 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
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
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
