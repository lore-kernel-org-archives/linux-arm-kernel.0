Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80E1C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:11:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73A91218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QvpWBAh7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A91218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=VlQFsL2ETEc1ecePAX6OusUsT1WnB9VToy1oR0RPzXc=; b=QvpWBAh7W10evlPRcQw3qppazD
	cBM9/sUFv00OmGEin62sD8YM2nbje0VlwjrpEZo6z/WYbJnJ8kMvAg0yoI5G4QYfljC8cWFVNvRV4
	TJbnwN3V6yTmiB9/wLwbmkrVpMyL45ZmqKz5E4ycRFtDOWDGWyzTCDYsvvr92Ew6xFcAeGaoCPu+b
	ahCE6D2PmaIe+verDrHNDmUKF2A2sCqDmrQecpULNuMMImPat1p23QSB3P4nxoGc5uvtvhGQGryxL
	fEYBXWX+/YzYvIIA5jx2CdwzvlQnw2mj65ntEqgFB1WB9dEwxFMYHdxK0g5QMbNUaP/P7WDYLSC1D
	g4LaeKPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grp5N-0005RY-Am; Thu, 07 Feb 2019 19:11:45 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grp3J-0002GO-2u
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 19:11:00 +0000
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1DFDF10FA8;
 Thu,  7 Feb 2019 19:09:36 +0000 (UTC)
Received: from llong.com (dhcp-17-35.bos.redhat.com [10.18.17.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0995D62FA5;
 Thu,  7 Feb 2019 19:09:33 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH-tip 10/22] locking/rwsem: Enable lock event counting
Date: Thu,  7 Feb 2019 14:07:14 -0500
Message-Id: <1549566446-27967-11-git-send-email-longman@redhat.com>
In-Reply-To: <1549566446-27967-1-git-send-email-longman@redhat.com>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Thu, 07 Feb 2019 19:09:36 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_110938_696379_0D1C9E7D 
X-CRM114-Status: GOOD (  17.73  )
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

Add lock event counting calls so that we can track the number of lock
events happening in the rwsem code.

With CONFIG_LOCK_EVENT_COUNTS on and booting a 1-socket 22-core
44-thread x86-64 system, the non-zero rwsem counts after system bootup
were as follows:

  rwsem_opt_fail=113
  rwsem_opt_wlock=13647
  rwsem_rlock=176
  rwsem_rlock_fast=10
  rwsem_wake_reader=153
  rwsem_wake_writer=139
  rwsem_wlock=113

It can be seen that most of the lock acquisitions in the slowpath were
writer-locks in the optimistic spinning code path with no sleeping at
all. Only about 4% of locks were acquired after sleeping.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/Kconfig                      |  2 +-
 kernel/locking/lock_events_list.h | 17 +++++++++++++++++
 kernel/locking/rwsem-xadd.c       | 12 ++++++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index af147c2..7471791 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -891,7 +891,7 @@ config ARCH_USE_MEMREMAP_PROT
 config LOCK_EVENT_COUNTS
 	bool "Locking event counts collection"
 	depends on DEBUG_FS
-	depends on QUEUED_SPINLOCKS
+	depends on (QUEUED_SPINLOCKS || RWSEM_XCHGADD_ALGORITHM)
 	---help---
 	  Enable light-weight counting of various locking related events
 	  in the system with minimal performance impact. This reduces
diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index 8b4d2e1..c33c5df 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -48,3 +48,20 @@
 LOCK_EVENT(lock_use_node4)	/* # of locking ops that use 4th percpu node */
 LOCK_EVENT(lock_no_node)	/* # of locking ops w/o using percpu node    */
 #endif /* CONFIG_QUEUED_SPINLOCKS */
+
+#ifdef CONFIG_RWSEM_XCHGADD_ALGORITHM
+/*
+ * Locking events for rwsem
+ */
+LOCK_EVENT(rwsem_sleep_reader)	/* # of reader sleeps			*/
+LOCK_EVENT(rwsem_sleep_writer)	/* # of writer sleeps			*/
+LOCK_EVENT(rwsem_wake_reader)	/* # of reader wakeups			*/
+LOCK_EVENT(rwsem_wake_writer)	/* # of writer wakeups			*/
+LOCK_EVENT(rwsem_opt_wlock)	/* # of write locks opt-spin acquired	*/
+LOCK_EVENT(rwsem_opt_fail)	/* # of failed opt-spinnings		*/
+LOCK_EVENT(rwsem_rlock)		/* # of read locks acquired		*/
+LOCK_EVENT(rwsem_rlock_fast)	/* # of fast read locks acquired	*/
+LOCK_EVENT(rwsem_rlock_fail)	/* # of failed read lock acquisitions	*/
+LOCK_EVENT(rwsem_wlock)		/* # of write locks acquired		*/
+LOCK_EVENT(rwsem_wlock_fail)	/* # of failed write lock acquisitions	*/
+#endif /* CONFIG_RWSEM_XCHGADD_ALGORITHM */
diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 62422a6..fff231a 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -20,6 +20,7 @@
 #include <linux/osq_lock.h>
 
 #include "rwsem-xadd.h"
+#include "lock_events.h"
 
 /*
  * Guide to the rw_semaphore's count field for common values.
@@ -147,6 +148,7 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 			 * will notice the queued writer.
 			 */
 			wake_q_add(wake_q, waiter->task);
+			lockevent_inc(rwsem_wake_writer);
 		}
 
 		return;
@@ -214,6 +216,7 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 	}
 
 	adjustment = woken * RWSEM_ACTIVE_READ_BIAS - adjustment;
+	lockevent_cond_inc(rwsem_wake_reader, woken);
 	if (list_empty(&sem->wait_list)) {
 		/* hit end of list above */
 		adjustment -= RWSEM_WAITING_BIAS;
@@ -269,6 +272,7 @@ static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
 				      count + RWSEM_ACTIVE_WRITE_BIAS);
 		if (old == count) {
 			rwsem_set_owner(sem);
+			lockevent_inc(rwsem_opt_wlock);
 			return true;
 		}
 
@@ -394,6 +398,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 	osq_unlock(&sem->osq);
 done:
 	preempt_enable();
+	lockevent_cond_inc(rwsem_opt_fail, !taken);
 	return taken;
 }
 
@@ -441,6 +446,7 @@ static inline bool rwsem_has_spinner(struct rw_semaphore *sem)
 		if (atomic_long_read(&sem->count) >= 0) {
 			raw_spin_unlock_irq(&sem->wait_lock);
 			rwsem_set_reader_owned(sem);
+			lockevent_inc(rwsem_rlock_fast);
 			return sem;
 		}
 		adjustment += RWSEM_WAITING_BIAS;
@@ -477,9 +483,11 @@ static inline bool rwsem_has_spinner(struct rw_semaphore *sem)
 			break;
 		}
 		schedule();
+		lockevent_inc(rwsem_sleep_reader);
 	}
 
 	__set_current_state(TASK_RUNNING);
+	lockevent_inc(rwsem_rlock);
 	return sem;
 out_nolock:
 	list_del(&waiter.list);
@@ -487,6 +495,7 @@ static inline bool rwsem_has_spinner(struct rw_semaphore *sem)
 		atomic_long_add(-RWSEM_WAITING_BIAS, &sem->count);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	__set_current_state(TASK_RUNNING);
+	lockevent_inc(rwsem_rlock_fail);
 	return ERR_PTR(-EINTR);
 }
 
@@ -580,6 +589,7 @@ static inline bool rwsem_has_spinner(struct rw_semaphore *sem)
 				goto out_nolock;
 
 			schedule();
+			lockevent_inc(rwsem_sleep_writer);
 			set_current_state(state);
 		} while ((count = atomic_long_read(&sem->count)) & RWSEM_ACTIVE_MASK);
 
@@ -588,6 +598,7 @@ static inline bool rwsem_has_spinner(struct rw_semaphore *sem)
 	__set_current_state(TASK_RUNNING);
 	list_del(&waiter.list);
 	raw_spin_unlock_irq(&sem->wait_lock);
+	lockevent_inc(rwsem_wlock);
 
 	return ret;
 
@@ -601,6 +612,7 @@ static inline bool rwsem_has_spinner(struct rw_semaphore *sem)
 		__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	wake_up_q(&wake_q);
+	lockevent_inc(rwsem_wlock_fail);
 
 	return ERR_PTR(-EINTR);
 }
-- 
1.8.3.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
