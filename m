Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC37C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:12:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C03D217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O0lAUKH6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C03D217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ho2H2jIguDEYNARLy0CsrF/Qsk/LbQQrpeSWEC52jzw=; b=O0lAUKH68lPjkR
	AHtsESpYQ64Ohp6sXJUyZoXuLGj6RSVm6N6MBDckG3Gp4PPHZTZf6n3v+8EkN3LvtLotwxCwI0XY7
	h++Mhe7dZiu9hHPtgIZoHOAm+aVDNITZwl00FqNOlFQJsEZ3oR9PuTWmjiRzgleVuyc54gHu6Jc9Z
	REfLlMrEnzYWAdsxFJUJqRFYGgRRwWOZVPRYLwbqnhUWwmTVbXVr4eF72n9m1iOlcdjCVDldI8eVP
	LXjUhdDrII0NRSniygcYcj/1FodzxTk2CRBOTUIdIVAsQcPn22c1p8nkSaH5ll/hEXi4IOm4rSj4x
	Klf0lDRMhHaQQm11WK4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZNbl-0005et-Qq; Tue, 18 Dec 2018 22:12:57 +0000
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZNac-0004WX-I9
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 22:11:59 +0000
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
 by Galois.linutronix.de with esmtp (Exim 4.80)
 (envelope-from <bigeasy@linutronix.de>)
 id 1gZNaF-000889-L1; Tue, 18 Dec 2018 23:11:23 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: stable@vger.kernel.org
Subject: [PATCH STABLE v4.9 06/10] locking/qspinlock: Remove duplicate
 clear_pending() function from PV code
Date: Tue, 18 Dec 2018 23:10:45 +0100
Message-Id: <20181218221049.6816-7-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218221049.6816-1-bigeasy@linutronix.de>
References: <20181218221049.6816-1-bigeasy@linutronix.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_141147_460059_11F2962C 
X-CRM114-Status: UNSURE (   8.26  )
X-CRM114-Notice: Please train this message.
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

commit 3bea9adc96842b8a7345c7fb202c16ae9c8d5b25 upstream.

The native clear_pending() function is identical to the PV version, so the
latter can simply be removed.

This fixes the build for systems with >= 16K CPUs using the PV lock implementation.

Reported-by: Waiman Long <longman@redhat.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: boqun.feng@gmail.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: paulmck@linux.vnet.ibm.com
Link: http://lkml.kernel.org/r/20180427101619.GB21705@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/locking/qspinlock_paravirt.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 9c07c72fb10e9..af2a24d484aab 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -105,11 +105,6 @@ static __always_inline void set_pending(struct qspinlock *lock)
 	atomic_or(_Q_PENDING_VAL, &lock->val);
 }
 
-static __always_inline void clear_pending(struct qspinlock *lock)
-{
-	atomic_andnot(_Q_PENDING_VAL, &lock->val);
-}
-
 static __always_inline int trylock_clear_pending(struct qspinlock *lock)
 {
 	int val = atomic_read(&lock->val);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
