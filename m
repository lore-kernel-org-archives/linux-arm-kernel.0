Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DF0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:26:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DB6C20656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s+e+PnBY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFUiiKjf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB6C20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u9A+UrBeXZNKvsHLN9P+SZSzIwpKY6oEcK9fHeL0Q9s=; b=s+e+PnBYaJBiXE
	ITsAiCyUg7KnDc4ZJ7OyRmZZ56WPG6Bb02Dl5DxDQ+tgD7khcXSnkVi3ngQwocxuj3V485k9XaI/x
	ezZg8A1Z3b7gNX7KUhBN9LELElmyGoOZMC6TXooV7nninsRFjYu+DY8GBVze74aRqTt1YVSRcHxyc
	qJFnAGaJ1IJQtPYCPtqXRSoBkPB2gQC4aCkcisnABaRBZivBA1tiq3ji4fMkp5CE81LXFoz8XOHHV
	T/NoQsW6tgcnJsNJKYaiyxFVFEDFnLhcXQcynrVaJxg2sHl3IbxPh8fMlQmxeEd3tQ93Yyl6Sfkti
	L7I/I4ZuqU23lTMVdVFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZubB-0003B9-WB; Thu, 20 Dec 2018 09:26:34 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZuax-0002uA-KP
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 09:26:21 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C91E521852;
 Thu, 20 Dec 2018 09:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545297969;
 bh=rn5pU5ghmL3ypDq+GsBYcQ44BoqIWc3MzRFo9MhUMDQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qFUiiKjfIBJvHdTI8xMK69tCW8UOrPrWqhLk8RMIkeqPomnOT8OkS+nWYbylnf31F
 sat6EE8584lfCork/S9S0foHbr2vvZ3xhUJlJLL/Wm29rcgk52StTQ8AJnQ0cRX+t9
 vy0e+7P5v3Qpzlyo6urJ7licPyy/pzByAjmrReSE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4.14 22/72] locking/qspinlock: Bound spinning on
 pending->locked transition in slowpath
Date: Thu, 20 Dec 2018 10:18:21 +0100
Message-Id: <20181220085923.214216778@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085922.332225035@linuxfoundation.org>
References: <20181220085922.332225035@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_012619_708423_8DE8DC5D 
X-CRM114-Status: GOOD (  17.40  )
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, boqun.feng@gmail.com,
 Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Waiman Long <longman@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 paulmck@linux.vnet.ibm.com, Linus Torvalds <torvalds@linux-foundation.org>,
 Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/locking/qspinlock.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index d880296245c5..18161264227a 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -76,6 +76,18 @@
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
@@ -306,13 +318,15 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
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
2.19.1




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
