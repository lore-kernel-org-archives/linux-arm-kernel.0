Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B19C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:35:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C22A3222DD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kUPNDB6R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22A3222DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4etRvHvktEtKnffCEeWaim0oRrYaK+kR4WG/dgfWcB4=; b=kUPNDB6R6j8Kvh
	x+VltuPVqdzgFtHgr0oq7/SCH+D92K+Hk6nd3iqilIHShRv+1mbJFtyK27pYMSthkx+3P4hyBvKPJ
	QH+T2iuhs6hb8iTqBJKDabPrI6z5f3il7qscCj1nzvRBSE6mc+fW95yAe9/d1ErJaIRThKmD4djV1
	nrsG3pAnZvEisAsJIvIUt3Jg1Y0xv4/BzHexl2PZGipRsj69IgIsci8L7nIpXB+B16+aqC1SmkF8Q
	6Fsa3wi5nsq9dKNTpeR6b/537n89iZSUbSXA/irFhOTsbu736WriWzaeCDnlmEx5sr3R/FzDkR0q9
	quuD56SLsL0WK0/fpi7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guJzD-0005Lo-Un; Thu, 14 Feb 2019 16:35:43 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guJzA-0005LR-Hk
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 16:35:41 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8E4515AB;
 Thu, 14 Feb 2019 08:35:39 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B46343F575;
 Thu, 14 Feb 2019 08:35:38 -0800 (PST)
Date: Thu, 14 Feb 2019 16:35:36 +0000
From: Will Deacon <will.deacon@arm.com>
To: Qian Cai <cai@lca.pw>
Subject: Re: livelock with KASAN_SW_TAGS
Message-ID: <20190214163536.GB1825@fuggles.cambridge.arm.com>
References: <7ec14ad5-8d64-b842-a819-9d57cc8495e2@lca.pw>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7ec14ad5-8d64-b842-a819-9d57cc8495e2@lca.pw>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_083540_592691_DF8B4001 
X-CRM114-Status: GOOD (  12.35  )
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
Cc: Andrey Konovalov <andreyknvl@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 kasan-dev <kasan-dev@googlegroups.com>, aryabinin@virtuozzo.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Qian Cai,

On Wed, Feb 13, 2019 at 10:32:11PM -0500, Qian Cai wrote:
> Running LTP msgstress03 [1] triggers endless soft lockups below after a few
> minutes on a ThunderX2 server. It works fine with KASAN_GENERIC and finish the
> test in roughly 11 minutes.

I've not been able to reproduce this failure under KVM, however the test
only takes around 18s to complete on the host and the guest, so it feels
like something is amiss here. Please could you share more information about
how you're triggering this problem? For example:

  - Kernel version and .config
  - Clang version
  - LTP version and command-line
  - Machine configuration (CPUs, memory, etc)

> # ./scripts/faddr2line vmlinux _raw_spin_unlock_irqrestore+0x44/0xac
> _raw_spin_unlock_irqrestore+0x44/0xac:
> arch_local_irq_restore at arch/arm64/include/asm/irqflags.h:88
> (inlined by) __raw_spin_unlock_irqrestore at include/linux/spinlock_api_smp.h:160
> (inlined by) _raw_spin_unlock_irqrestore at kernel/locking/spinlock.c:184
> 
> This code:
> 
> 	asm volatile(
> 		"msr	daif, %0
> 	:
> 	: "r" (flags)
> 	: "memory");

This is just the instruction when we unmask interrupts, so that's when the
soft watchdog fires. I suspect the real issue is that we're spending lots
of time in:

> [  545.772027]  free_debug_processing+0x308/0x410

with irqs disabled. Does the machine eventually come back to life?

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
