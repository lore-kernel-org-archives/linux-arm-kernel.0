Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45156C282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:24:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D923218EA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b9KOj23W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D923218EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=hw+rbOgjBn9yK2vzPllBRFsH4So8l9nxFGosWnO7hxY=; b=b9KOj23WNrMqTD
	ohgLH5RzXpeLtoXwvFrVUGtH8pgqN73a0TxrWLqr8JbT9d4qQZ4JBS0ljD+whS/td/c4TkdKhTl1h
	iDASCsVJnokYhVt+dLLENEauEHEr6L401XNkVmPLDqQiyXpitgevpC34kHbiWdEAMhGdcyp8dNO4P
	/4JfC+5ducx+/kcx94JaHZ0feKFwGsCpOscMJRgHMY4I/1+5xSaqs2hJPOk0C7AVWYhURsPasGBt/
	ETpWc/7x48paDHvrs65iaQDDHBb+zWV4GL0gII6lRko9ZMfqWlM8Apkj/NCqHaXN8jsuGgebkzma7
	lzCvoj/9pMRP/9d89nUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpH0K-0003wz-Qx; Thu, 31 Jan 2019 18:24:00 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpH0H-0003wA-5q
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 18:23:58 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16EAEA78;
 Thu, 31 Jan 2019 10:23:55 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com
 [10.1.194.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8DA963F59C;
 Thu, 31 Jan 2019 10:23:52 -0800 (PST)
From: Valentin Schneider <valentin.schneider@arm.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] arm/arm64: entry: Remove need_resched() loop
Date: Thu, 31 Jan 2019 18:23:36 +0000
Message-Id: <20190131182339.9835-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_102357_225533_424A324D 
X-CRM114-Status: GOOD (  10.88  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Julien Thierry <julien.thierry@arm.com>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Peter Zijlstra <peterz@infradead.org>,
 Julien Grall <julien.grall@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

A while back (before [1]), i386 had this in the tail of its irq
handling code:

  need_resched:
	  movl TI_flags(%ebp), %ecx       # need_resched set ?
	  testb $_TIF_NEED_RESCHED, %cl
	  jz restore_all
	  testl $IF_MASK,EFLAGS(%esp)     # interrupts off (exception path) ?
	  jz restore_all
	  sti
	  call preempt_schedule
	  cli
	  movl $0,TI_preempt_count(%ebp)
	  jmp need_resched

preempt_schedule() already had an inner need_resched() loop introduced by

  commit 4d0b85ea4610 ("[PATCH] kernel preemption bits (2/2)")

and the outer loop was needed since, as the above commit explains, it
was possible to return from preempt_schedule(), get an interrupt and
have need_resched() true.

This was eventually changed when preempt_schedule_irq() was introduced
by [1]:

  commit b268264c6299 ("[PATCH] sched: fix preemption race (Core/i386)")

which moved the enabling & disabling of interrupts inside the then
new preempt_schedule_irq(). From then on, the arch-code loop was no
longer necessary, providing preempt_schedule_irq() was used. This was
talked over on LKML in [2].

It's worth noting that it seems most archs calling
preempt_schedule_irq() have that outer loop, and for most of them it
really looks like they could get rid of it as well.

FWIW the suspects are

$ grep -r -I "preempt_schedule_irq" arch/ | cut -d/ -f2 | sort | uniq

  arc
  arm
  arm64
  c6x
  csky
  h8300
  ia64
  m68k
  microblaze
  mips
  nds32
  nios2
  parisc
  powerpc
  s390
  sh
  sparc
  x86
  xtensa


- Patches 1-2 remove the loop for arm & arm64
- Patch 3 adds a bit of documentation to point out the loop isn't needed
  to try and spread the word.

[2]: https://lore.kernel.org/lkml/cc989920-a13b-d53b-db83-1584a7f53edc@arm.com/

Valentin Schneider (3):
  arm64: entry: Remove unneeded need_resched() loop
  ARM: entry: Remove unneeded need_resched() loop
  sched/Documentation: Point out use of preempt_schedule_irq()

 Documentation/scheduler/sched-arch.txt | 10 ++++++++++
 arch/arm/kernel/entry-armv.S           | 12 +-----------
 arch/arm64/kernel/entry.S              | 11 +----------
 3 files changed, 12 insertions(+), 21 deletions(-)

--
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
