Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06196C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:46:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C986120855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L84H9BgH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C986120855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OsdJwGKyIxAkOquzH4B6ruqPEbVk2FXBZQr+2DHYjMo=; b=L84H9BgHGnQgPV
	l0AlqSvBkWVtxTgaxdqs30K3Il/a0mLVGmhQNvRpvd55VDAfwoYIELfgabGT+Uut4/1PeSEj5M+VO
	D+I5Jk6ASKnhwZ04IrVRy/Gh/lzpvYmZsfdZU1/7O4u/NvnXN0E3kXQpZy16gmXzXGtQFSerGDc/t
	lggwbytxY79TwtnWYoLMCKIRyzgLS3ZTM4okOcU2UKiSG4vAGjXqPIFvXbDmG3q4quRs7n3K5NDCK
	61PM65OSuY+oMPFRk6amhONzIxhQtGYYsQEWqHtAPny2QKv/b1muijCCLnzkurnS3tfYzuR0paNsk
	j3wVpEu/FG65dbH1V3SA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwnkQ-0006ma-Ie; Thu, 21 Feb 2019 12:46:42 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwnkM-0006m9-Ms
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 12:46:39 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF44680D;
 Thu, 21 Feb 2019 04:46:37 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A3E83F575;
 Thu, 21 Feb 2019 04:46:34 -0800 (PST)
Date: Thu, 21 Feb 2019 12:46:29 +0000
From: Will Deacon <will.deacon@arm.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
Message-ID: <20190221124629.GA12696@fuggles.cambridge.arm.com>
References: <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
 <20190216103044.GR32494@hirez.programming.kicks-ass.net>
 <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <20190219090409.GW32494@hirez.programming.kicks-ass.net>
 <20190219124808.GG8501@fuggles.cambridge.arm.com>
 <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_044638_751379_752FAA72 
X-CRM114-Status: GOOD (  15.94  )
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
Cc: dvlasenk@redhat.com, jpoimboe@redhat.com,
 Julien Thierry <julien.thierry@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 catalin.marinas@arm.com, valentin.schneider@arm.com,
 linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
 mingo@redhat.com, james.morse@arm.com, luto@kernel.org, brgerst@gmail.com,
 bp@alien8.de, tglx@linutronix.de, torvalds@linux-foundation.org,
 Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 20, 2019 at 02:55:59PM -0800, H. Peter Anvin wrote:
> On 2/19/19 4:48 AM, Will Deacon wrote:
> > 
> > I think you'll still hate this, but could we not disable preemption during
> > the uaccess-enabled region, re-enabling it on the fault path after we've
> > toggled uaccess off and disable it again when we return back to the
> > uaccess-enabled region? Doesn't help with tracing, but it should at least
> > handle the common case.
> > 
> 
> There is a worse problem with this, I still realize: this would mean blocking
> preemption across what could possibly be a *very* large copy_from_user(), for
> example.

I don't think it's legitimate to call copy_{to,from}_user() inside a
user_access_{begin,end} region. You'd need to add some unsafe variants,
which could periodically disable uaccess and call cond_resched() inside
the loop to avoid the problem you're eluding to.

For existing callers of copy_{to,from}_user(), there's no issue as they
don't call into the scheduler during the copy operation. Exceptions are
handled fine by the code in mainline today.

GCC plugins are a cool idea, but I'm just a bit nervous about relying on
them for things like this.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
