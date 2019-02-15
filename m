Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3673AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:35:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 098DB206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KsxDeb0m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098DB206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uDLsatbw/DN3CDk2AmTHgMrCAmmTG1Fhus2dDsp+VYM=; b=KsxDeb0muOJ8aC
	j7CBaV8OaHfn+Kt90EutBmwS+VvBA7rZdabo1qqRi5BvV95IOKUYyPMkUhmcfhgN/GXq6l1sY8Ebr
	dRETaD2ZbY+PFB6p6kvceOzLhR9Q+PII59V8d7UX1j7AzaSlxOlZrSsj/nR5rWYIxc4fNF4OU9Q98
	tA6ATVqbu8WpVO2+fsNiKUdRAEJ/lDTknodIYWlThuZOcXmrMRZL+jrdhnrngC86GaXMqNLwT6Y0S
	6upmk2PyWfaLQQHZ/jm3qGiVlvPhjSUO55mZPw4FfY2zsYW2G2CXr5Jld1X6lH2leCiG2Bn2bvBms
	s2151cf3srSHif/t1lSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guiKY-0006jR-55; Fri, 15 Feb 2019 18:35:22 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guiKV-0006im-1j
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 18:35:20 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBBB4A78;
 Fri, 15 Feb 2019 10:35:11 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A8543F589;
 Fri, 15 Feb 2019 10:35:08 -0800 (PST)
Date: Fri, 15 Feb 2019 18:35:05 +0000
From: Will Deacon <will.deacon@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3 2/2] locking/rwsem: Optimize down_read_trylock()
Message-ID: <20190215183505.GB15084@fuggles.cambridge.arm.com>
References: <1550089932-6888-1-git-send-email-longman@redhat.com>
 <1550089932-6888-3-git-send-email-longman@redhat.com>
 <20190214103333.GH32494@hirez.programming.kicks-ass.net>
 <9e01d4ef-56df-7af8-a0f5-b49644e298bf@redhat.com>
 <CAHk-=whKmuranma_HUOKBbDJHGmdWZr9MYW-+cmGzsOiJ2N1Sg@mail.gmail.com>
 <CAHk-=wi03J1jurebJNHPxGCVss7ARAN+2JuVthEGoEx=qkT4dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=wi03J1jurebJNHPxGCVss7ARAN+2JuVthEGoEx=qkT4dQ@mail.gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_103519_098905_977B41F3 
X-CRM114-Status: GOOD (  21.45  )
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
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-xtensa@linux-xtensa.org,
 Davidlohr Bueso <dave@stgolabs.net>, linux-ia64@vger.kernel.org,
 Tim Chen <tim.c.chen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-hexagon@vger.kernel.org,
 the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 sparclinux@vger.kernel.org, Waiman Long <longman@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 10:09:44AM -0800, Linus Torvalds wrote:
> On Thu, Feb 14, 2019 at 9:51 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > The arm64 numbers scaled horribly even before, and that's because
> > there is too much ping-pong, and it's probably because there is no
> > "stickiness" to the cacheline to the core, and thus adding the extra
> > loop can make the ping-pong issue even worse because now there is more
> > of it.
> 
> Actually, if it's using the ll/sc, then I don't see why arm64 should
> even change. It doesn't really even change the pattern: the initial
> load of the value is just replaced with a "ll" that gets a non-zero
> value, and then we re-try without even doing the "sc" part.

So our cmpxchg() has a prefetch-with-intent-to-modify instruction before the
'll' part, which will attempt to grab the line unique the first time round.
The 'll' also has acquire semantics, so there's the chance for the
micro-architecture to handle that badly too.

I think that the problem with the proposed changed change is that whenever a
reader tries to acquire an rwsem that is already held for read, it will
always fail the first cmpxchg(), so in this situation the read path is
considerably slower than before.

> End result: exact same "load once, then do ll/sc to update". Just
> using a slightly different instruction pattern.
> 
> But maybe "ll" does something different to the cacheline than a regular "ld"?
> 
> Alternatively, the machine you used is using LSE, and the "swp" thing
> has some horrid behavior when it fails.

Depending on where the data is, the LSE instructions may execute outside of
the CPU (e.g. in a cache controller) and so could add latency to a failing
CAS.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
