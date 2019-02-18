Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB9AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:31:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 995B72146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V0O8q4F2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995B72146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tZs0z+YOYKyK6qnPzYk63rcAXwomgPMByQuQ6E5cG2A=; b=V0O8q4F2qymdQp
	2+Ca5o2KYSbqL0dVQhSTMZpETlO2z1wCMzRsx24MxlyYo7uL1vtYl3Dyw08QSd/bZsIfpv1cwMg5e
	wKOvC8lPJWyRVYlyqU0ySzbZkopcaku3EwCAtVDIKBprjniRbE+k9jCNCPg2164qXOTWkxDV3CoO/
	GtAgihUgFsFlkKCL6SAYEiCNTRRL9jtnBHvdj6ISnSAh1NOVEHWsZm0clZ6tIBiGwmPTzz2y47zJI
	nFNUwpadWhkwSveVhB+596lrVt093Z9p626wRAJMmpuTN4VkpAAK8l2bo+nDof7hZBfMH78PB1msH
	TT0NbI0pbFtJyeWWqUMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvrRI-0002Go-92; Mon, 18 Feb 2019 22:31:04 +0000
Received: from terminus.zytor.com ([198.137.202.136] helo=mail.zytor.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvrRE-0002GO-Dr
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 22:31:01 +0000
Received: from carbon-x1.hos.anvin.org
 ([IPv6:2601:646:8680:2bb1:1b64:2c6c:6ec3:aa41])
 (authenticated bits=0)
 by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x1IMURDP2770168
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
 Mon, 18 Feb 2019 14:30:27 -0800
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
To: Peter Zijlstra <peterz@infradead.org>
References: <20190213140025.GB6346@brain-police>
 <20190213142524.GW32494@hirez.programming.kicks-ass.net>
 <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com>
 <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
 <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
 <20190216103044.GR32494@hirez.programming.kicks-ass.net>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
Date: Mon, 18 Feb 2019 14:30:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190216103044.GR32494@hirez.programming.kicks-ass.net>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_143100_473210_77C8FEF3 
X-CRM114-Status: GOOD (  19.39  )
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
 Julien Thierry <julien.thierry@arm.com>, catalin.marinas@arm.com,
 valentin.schneider@arm.com, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
 mingo@redhat.com, james.morse@arm.com, luto@kernel.org, brgerst@gmail.com,
 bp@alien8.de, tglx@linutronix.de, torvalds@linux-foundation.org,
 Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/16/19 2:30 AM, Peter Zijlstra wrote:
> On Fri, Feb 15, 2019 at 08:06:56PM -0800, hpa@zytor.com wrote:
>> This implies we invoke schedule -- a restricted operation (consider
>> may_sleep) during execution of STAC-enabled code, but *not* as an
>> exception or interrupt, since those preserve the flags.
> 
> Meet preempt_enable().

I believe this falls under "doctor, it hurts when I do that." And it hurts for
very good reasons. See below.

>> I have serious concerns about this. This is more or less saying that
>> we have left an unlimited gap and have had AC escape.
> 
> Yes; by allowing normal C in between STAC and CLAC this is so.
> 
>> Does *anyone* see a need to allow this? I got a question at LPC from
>> someone about this, and what they were trying to do once all the
>> layers had been unwound was so far down the wrong track for a root
>> problem that actually has a very simple solution.
> 
> Have you read the rest of the thread?
> 
> All it takes for this to explode is a call to a C function that has
> tracing on it in between the user_access_begin() and user_access_end()
> things. That is a _very_ easy thing to do.
> 
> Heck, GCC is allowed to generate that broken code compiling
> lib/strnlen_user.c; it doesn't _have_ to inline do_strnlen_user (esp.
> with CONFIG_OPTIMIZE_INLINING), and making that a function call would
> get us fentry hooks and ftrace and *BOOM*.
> 
> (Now, of course, its a static function with a single caller, and GCC
> isn't _THAT_ stupid, but it could, if it wanted to)
> 
> Since the bar is _that_ low for mistakes, I figure we'd better fix it.
> 

The question is what "fix it" means. I'm really concerned about AC escapes,
and everyone else should be, too.

For an issue specific to tracing, it would be more appropriate to do the
appropriate things in the tracing entry/exit than in schedule. Otherwise, we
don't want to silently paper over mistakes which could mean that we run a
large portion of the kernel without protection we thought we had.

In that sense, calling schedule() with AC set is in fact a great place to have
a WARN() or even BUG(), because such an event really could imply that the
kernel has been security compromised.

Does that make more sense?

	-hpa

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
