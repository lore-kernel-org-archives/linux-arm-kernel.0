Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69F4C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:26:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D88C217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FXvltSo/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEx6s6R5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D88C217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qHD1+4059y3O1tPht0ATUyrf3uHK4GaivF3cfW4wvdM=; b=FXvltSo/TvPmhK
	+3+1cLjXRkO0aql5Q6z4ihlq0aknDw0SiCEZPxBpg7jT1ChUDqfir8G08z8JTwKtysKwRiGW5xsZd
	FWvUKBFLsWOkaIscUQdSk6wGgZjCZsSR9+XFitqSBKy4pjdaD/tbPkXkyhryxl3EgDnNeoez2cifK
	22Py2ePg1UhGRzoZn8r/oYR4ZswMgJA7X2gtqJM66griTj9CocWA6JvWgOmGrp+9NhpSm2pdI0UHE
	fvWp3wpMxFnIdfvvV38B1L+WU170h+oVGBSc0M/EIHnkfyQQP2M8nbbvYItpJjiZMC+yeiTBczz6R
	Nc5I97QL0aXFb3xjp2QA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZub0-0002yC-Sv; Thu, 20 Dec 2018 09:26:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZuax-0002w7-KQ
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 09:26:21 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D6DC5217D9;
 Thu, 20 Dec 2018 09:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545297977;
 bh=g//RrL8METWwPMhlhnsTKj3bu4XG2nG50aMnPYDAwo0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hEx6s6R5UzJdcirStO7wgKEIKUuiobdEBzHKo5/W44nHTHk4r5zLp8M+zJpSbBO+S
 h5AFGZ9EBb8hOsIHrdxGbnVQailxympddQqERa5RHAkWHzjVv04kOeKNar1rT41P7a
 2pUCSdN8Mllfry6UQTJ5XkXEv9fEY9brr2eSbXhw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4.14 25/72] locking/qspinlock: Remove duplicate
 clear_pending() function from PV code
Date: Thu, 20 Dec 2018 10:18:24 +0100
Message-Id: <20181220085923.323410216@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085922.332225035@linuxfoundation.org>
References: <20181220085922.332225035@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_012619_703561_B0829ED9 
X-CRM114-Status: GOOD (  10.83  )
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
Cc: Sasha Levin <sashal@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/locking/qspinlock_paravirt.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 854443f7b60b..1e882dfc8b79 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -106,11 +106,6 @@ static __always_inline void set_pending(struct qspinlock *lock)
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
2.19.1




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
