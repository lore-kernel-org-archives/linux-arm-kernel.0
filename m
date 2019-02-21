Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720CFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:06:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4223120855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FTkGceRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4223120855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HVTlbQVkQTvOE8IGfd0UafEa9Yln5PLhLgvkiGoT2Jg=; b=FTkGceRlDjRSmt
	k4TQZE3uGnkAFsGQhp3R9jtkHoHkH7A66OYeVOy3cvYYo3qI9JrzANnlWsvQlOTAHa8e5kfgpKk2i
	3/4x1Tb975e9WcMocWhU2I8l1kjHTeBiPV6zJK4e6IIbUL2nLSQES2WYIZ1+2hdOG/Sog4jW0zc1L
	uC1tNp5b0Ovg46C330kcad/p//XgviJbwekhigj0am0w/XqQLlpj5YHloGj5cmTAvwsOkcmycSDq+
	o1CD3WpT8Ex7ZbaUKfJCW4Y4L3zBdikD3vHeX3sMNigKqljUTjLLtmCdGJUutxwO0vGVxoDQ/Acrf
	HYKS99UPPxr/HDpXzymQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwn7w-0005jt-Er; Thu, 21 Feb 2019 12:06:56 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwn7u-0005jS-3m
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 12:06:55 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBAB780D;
 Thu, 21 Feb 2019 04:06:53 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C73C83F5C1;
 Thu, 21 Feb 2019 04:06:50 -0800 (PST)
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
To: "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will.deacon@arm.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
 <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
 <20190216103044.GR32494@hirez.programming.kicks-ass.net>
 <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <20190219090409.GW32494@hirez.programming.kicks-ass.net>
 <20190219124808.GG8501@fuggles.cambridge.arm.com>
 <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <cb221e71-243d-fdbd-1d18-b175bc88979b@arm.com>
Date: Thu, 21 Feb 2019 12:06:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_040654_163804_A60BC7AC 
X-CRM114-Status: GOOD (  23.02  )
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
Cc: dvlasenk@redhat.com, jpoimboe@redhat.com, catalin.marinas@arm.com,
 valentin.schneider@arm.com, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, mingo@redhat.com, james.morse@arm.com,
 luto@kernel.org, brgerst@gmail.com, bp@alien8.de, tglx@linutronix.de,
 torvalds@linux-foundation.org, Ingo Molnar <mingo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 20/02/2019 22:55, H. Peter Anvin wrote:
> On 2/19/19 4:48 AM, Will Deacon wrote:
>>
>> I think you'll still hate this, but could we not disable preemption during
>> the uaccess-enabled region, re-enabling it on the fault path after we've
>> toggled uaccess off and disable it again when we return back to the
>> uaccess-enabled region? Doesn't help with tracing, but it should at least
>> handle the common case.
>>
> 
> There is a worse problem with this, I still realize: this would mean blocking
> preemption across what could possibly be a *very* large copy_from_user(), for
> example.
> 

Yes, that's a good point. And I guess a userspace program could forcibly
trigger the kernel into a large copy_from/to_user(), knowingly disabling
preemption.

I don't know how bad this could get.

> Exceptions *have* to handle this; there is no way around it. Perhaps the
> scheduler isn't the right place to put these kinds of asserts, either.
> 

Maybe I'm misunderstanding what you mean with "Exceptions *have* to
handle this". Isn't the fact that the AC/PAN flags gets saved on
exception entry and set back to "user accesses disabled" already
handling it? Or are you referring to something else?

So far my understanding is that the exception/interrupt case is fine.
The worrying case is what gets called in the user access regions
(schedule(), preempt_enable(), tracing...).

Did I get lost somewhere?

> Now, __fentry__ is kind of a special beast; in some ways it is an "exception
> implemented as a function call"; on x86 one could even consider using an INT
> instruction in order to reduce the NOP footprint in the unarmed case.  Nor is
> __fentry__ a C function; it has far more of an exception-like ABI.
> *Regardless* of what else we do, I believe __fentry__ ought to
> save/disable/restore AC, just like an exception does.
> 

That does make sense to me. However it doesn't solve the issue of
calling (or preventing to call) some function that rescheds.


> The idea of using s/a gcc plugin/objtool/ for this isn't really a bad idea.
> Obviously the general problem is undecidable :) but the enforcement of some
> simple, fairly draconian rules ("as tight as possible, but no tighter")
> shouldn't be a huge problem.
> 
> An actual gcc plugin -- which would probably be quite complex -- could make
> gcc itself aware of user space accesses and be able to rearrange them to
> minimize STAC/CLAC and avoid kernel-space accesses inside those brackets.
> 

Not sure I get this. The data that is retrieved from/stored user space
is generally obtained from/saved into kernel-space address. And when you
start the user_access_begin() it means you plan on doing a bunch of user
access, so I wouldn't expect to be able to batch everything into registers.

Cheers,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
