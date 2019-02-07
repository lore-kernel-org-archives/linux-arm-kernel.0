Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D72C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:11:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A02E6218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="APqwY+bU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02E6218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Tr8jwpNwuxfS5God2iaBDq1qf42xUKY7znKyu8JsWMM=; b=APqwY+bU2JbTb1YtYXE1FGCPul
	/sK1SRYPllPR7MvBbhRHzvpv5z274gOT5F2WEvEHvqdidgeFBopkw5nqDdmSu47n2P093dKJkkCag
	rOgadYYBfJVYGTE5Y6O0AcdzHKb1kYRsLFmUAIBcXe4bBJqcl4lzYYSS4hGorWkM1B/BNKR/Q3xDO
	tKQAhtEJCFnvnPGlKdVXrGGCjQ/qwfZM7nEB03O0OnDnc5IelRkkapR41VvzzrvznpvQU34QLBaaZ
	xnqLyVnUHm8f49VMqRh7xDedgomzsh52dacaA7VmkYZXwYymDcJ6GhSx/MRrqHsfbQD3YvZ4UJN1y
	dvidpI5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grp54-00057G-9R; Thu, 07 Feb 2019 19:11:26 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grp34-00021e-3b
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 19:09:54 +0000
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E5B3180E7B;
 Thu,  7 Feb 2019 19:09:20 +0000 (UTC)
Received: from llong.com (dhcp-17-35.bos.redhat.com [10.18.17.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4E8617BAC;
 Thu,  7 Feb 2019 19:09:09 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH-tip 07/22] locking/rwsem: Move rwsem internal function
 declarations to rwsem-xadd.h
Date: Thu,  7 Feb 2019 14:07:11 -0500
Message-Id: <1549566446-27967-8-git-send-email-longman@redhat.com>
In-Reply-To: <1549566446-27967-1-git-send-email-longman@redhat.com>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 07 Feb 2019 19:09:21 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_110922_406176_C33BDF68 
X-CRM114-Status: GOOD (  13.24  )
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

We don't need to expose rwsem internal functions which are not supposed
to be called directly from other kernel code.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/rwsem.h       | 7 -------
 kernel/locking/rwsem-xadd.h | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 6e56006..1e0457b 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -50,13 +50,6 @@ struct rw_semaphore {
  */
 #define RWSEM_OWNER_UNKNOWN	((struct task_struct *)-2L)
 
-extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_down_read_failed_killable(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_down_write_failed_killable(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *);
-extern struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem);
-
 /* In all implementations count != 0 means locked */
 static inline int rwsem_is_locked(struct rw_semaphore *sem)
 {
diff --git a/kernel/locking/rwsem-xadd.h b/kernel/locking/rwsem-xadd.h
index 2eaa762..64e7d62 100644
--- a/kernel/locking/rwsem-xadd.h
+++ b/kernel/locking/rwsem-xadd.h
@@ -153,6 +153,13 @@ static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
 }
 #endif
 
+extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem);
+extern struct rw_semaphore *rwsem_down_read_failed_killable(struct rw_semaphore *sem);
+extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem);
+extern struct rw_semaphore *rwsem_down_write_failed_killable(struct rw_semaphore *sem);
+extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem);
+extern struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem);
+
 /*
  * lock for reading
  */
-- 
1.8.3.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
