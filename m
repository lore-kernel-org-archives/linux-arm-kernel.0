Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B124CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:28:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C1F420989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mFSEocgL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zqI0uXoM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1F420989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GsZoNWGTnRjP323kSdLMZyw6+PTMJzv6cNHj66IrCOQ=; b=mFSEocgLCUmZKG
	vKbSJOB4k6m9VdUfwDGsxp6q+svCHpuL+ipoDDe4xWvtNJcsIqeGUCqGCjElcziWRXaACek7iaSBr
	Bo65LB8PAJXg6PFj/wpr6PT4rTY7W2Afda540GMVZiF2oET2w9BzOrjc6P9qEwbWUGTrXjr4TUpxY
	nPxCkolUX8Ajg05g5AONTJK74UGodEtpwQcaQUu5ziOoCQZR8Pg84uXBVb9aglP3YgUK73TiGpfsz
	MYNzUj32bo+FRZktxWDXXc3rpmnkPq0KysApqtUeKBpnX8s2xnw2mzK3udGbwnQkpgOdZPp/fTJoF
	M34C0/sydfeqoUIlvNKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZucY-0004WA-Sd; Thu, 20 Dec 2018 09:27:58 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZubw-0003sv-Vi
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 09:27:25 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2D15B21741;
 Thu, 20 Dec 2018 09:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545298030;
 bh=BeS2+wPT5J7OU323vln46527eYsRVsS3gmsvUTEH/u4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=zqI0uXoMVsEMVfI7gfGIV+gTr0Kjuthv53UqdaC8dwZDXRqsxzfkMRoRGqxeEX65b
 u9ycwBIKOVXqsf8MSlCHQZyvbeX/14CW71M/lrC8Y6U3wawn4vMY6VcUlwcuPGo2Sx
 STPPp1gSYRcYAzoiCQIObyGRoZBX3Fl+oUTFf/5k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4.14 28/72] locking/qspinlock/x86: Increase _Q_PENDING_LOOPS
 upper bound
Date: Thu, 20 Dec 2018 10:18:27 +0100
Message-Id: <20181220085923.447185200@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085922.332225035@linuxfoundation.org>
References: <20181220085922.332225035@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_012721_705827_3B5E670B 
X-CRM114-Status: GOOD (  12.18  )
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

commit b247be3fe89b6aba928bf80f4453d1c4ba8d2063 upstream.

On x86, atomic_cond_read_relaxed will busy-wait with a cpu_relax() loop,
so it is desirable to increase the number of times we spin on the qspinlock
lockword when it is found to be transitioning from pending to locked.

According to Waiman Long:

 | Ideally, the spinning times should be at least a few times the typical
 | cacheline load time from memory which I think can be down to 100ns or
 | so for each cacheline load with the newest systems or up to several
 | hundreds ns for older systems.

which in his benchmarking corresponded to 512 iterations.

Suggested-by: Waiman Long <longman@redhat.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: boqun.feng@gmail.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: paulmck@linux.vnet.ibm.com
Link: http://lkml.kernel.org/r/1524738868-31318-5-git-send-email-will.deacon@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/qspinlock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index cf4cdf508ef4..2cb6624acaec 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -6,6 +6,8 @@
 #include <asm-generic/qspinlock_types.h>
 #include <asm/paravirt.h>
 
+#define _Q_PENDING_LOOPS	(1 << 9)
+
 #define	queued_spin_unlock queued_spin_unlock
 /**
  * queued_spin_unlock - release a queued spinlock
-- 
2.19.1




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
