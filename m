Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C917C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:56:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 552002087B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DcoVneEe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 552002087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DDFBVXAiBdJH+UkvfFafLwfkoXuGXDcwacht433FVwo=; b=DcoVneEeUonJSp
	p1SWT4/XWj8PFZdhJrHuiACiXvzgbUwSrx5F/Mb3ZrkxxyBpJDzgoHLZ1xtQ8HNHhRsZo3Sjw6Ubm
	5eooufZlnay9nucPjLM93BWfMNltoYCwtjR8Cc5ZMk+B1V1fIkE/V5Vzu8HWcEZawKeSoGgGY1oEM
	RA2WHEGZQAZ7BAA+i2ybpSUYpjl4Glu9RekGUQxVKFA3T0NqxcA/X4fTmc/JALMIeTPFnQj0JJowN
	D05io7lVYxAbZ1cOeyXr4TfqYvMP9KUJ/5i3uAlJJdvEZVsbTSMICd/6HeyaNKDA3/IXgJB49Ue0t
	zGWICVYIX/dVwoDoLV/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwan5-0008L9-GR; Wed, 20 Feb 2019 22:56:35 +0000
Received: from terminus.zytor.com ([198.137.202.136] helo=mail.zytor.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwan2-0008Km-8w
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 22:56:33 +0000
Received: from carbon-x1.hos.anvin.org
 ([IPv6:2601:646:8680:2bb1:1b64:2c6c:6ec3:aa41])
 (authenticated bits=0)
 by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x1KMu5t23732554
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
 Wed, 20 Feb 2019 14:56:05 -0800
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
To: Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>
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
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com>
Date: Wed, 20 Feb 2019 14:55:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190219124808.GG8501@fuggles.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_145632_317934_B5D3A27D 
X-CRM114-Status: GOOD (  14.57  )
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
 valentin.schneider@arm.com, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, mingo@redhat.com, james.morse@arm.com,
 luto@kernel.org, brgerst@gmail.com, bp@alien8.de, tglx@linutronix.de,
 torvalds@linux-foundation.org, Ingo Molnar <mingo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/19/19 4:48 AM, Will Deacon wrote:
> 
> I think you'll still hate this, but could we not disable preemption during
> the uaccess-enabled region, re-enabling it on the fault path after we've
> toggled uaccess off and disable it again when we return back to the
> uaccess-enabled region? Doesn't help with tracing, but it should at least
> handle the common case.
> 

There is a worse problem with this, I still realize: this would mean blocking
preemption across what could possibly be a *very* large copy_from_user(), for
example.

Exceptions *have* to handle this; there is no way around it. Perhaps the
scheduler isn't the right place to put these kinds of asserts, either.

Now, __fentry__ is kind of a special beast; in some ways it is an "exception
implemented as a function call"; on x86 one could even consider using an INT
instruction in order to reduce the NOP footprint in the unarmed case.  Nor is
__fentry__ a C function; it has far more of an exception-like ABI.
*Regardless* of what else we do, I believe __fentry__ ought to
save/disable/restore AC, just like an exception does.

The idea of using s/a gcc plugin/objtool/ for this isn't really a bad idea.
Obviously the general problem is undecidable :) but the enforcement of some
simple, fairly draconian rules ("as tight as possible, but no tighter")
shouldn't be a huge problem.

An actual gcc plugin -- which would probably be quite complex -- could make
gcc itself aware of user space accesses and be able to rearrange them to
minimize STAC/CLAC and avoid kernel-space accesses inside those brackets.

Finally, of course, there is the option of simply outlawing this practice as a
matter of policy and require that all structures be accessed through a limited
set of APIs. As I recall, the number of places where there were
performance-critical regions which could not use the normal accessors are
fairly small (signal frames being the main one.) Doing bulk copy to/from
kernel memory and then accessing them from there would have some performance
cost, but would eliminate the need for this complexity entirely.

	-hpa

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
