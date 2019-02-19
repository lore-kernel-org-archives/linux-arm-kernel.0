Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE25C10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:04:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01A3C2146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z/cT2Eq/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A3C2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6MM+F2o//hX10+kOOhCUX7ExZrkQnDIN1AKOqzx57fs=; b=Z/cT2Eq/4LOSWs
	bukWDaSl8seU0n+zBZeugliMxD1ayuYBXC+NEtbRbtRY4tsomkHxvg2anoBXWlLNbqzyaJ478neO0
	fhp00TWNCLcWUjLEq/FFmjCy7vuJRb2efOhOvTkInGOhUr7JCdY/fBq6GJ9av/X00OquIDxu1P6sP
	m1qpPlwcDYKdXDeCzMp6e4FBBUkaMGlpQonM3zKqboGQSZ5qQwEJaMXW1k0rxLvFFW56OrxI0SAn6
	bqGuICc4XhosGeaMEuZ20bFknQXH3IHy68Kp08GhXCU//B892IqCWVTn+EteWS0+HAtzkz2eGcaiY
	fuTTHL8j6AlDOQDmyNfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw1K3-0000yO-Gx; Tue, 19 Feb 2019 09:04:15 +0000
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw1K1-0000y5-2B; Tue, 19 Feb 2019 09:04:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 7A1B7286B87C3; Tue, 19 Feb 2019 10:04:09 +0100 (CET)
Date: Tue, 19 Feb 2019 10:04:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
Message-ID: <20190219090409.GW32494@hirez.programming.kicks-ass.net>
References: <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com>
 <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
 <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
 <20190216103044.GR32494@hirez.programming.kicks-ass.net>
 <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

On Mon, Feb 18, 2019 at 02:30:21PM -0800, H. Peter Anvin wrote:
> On 2/16/19 2:30 AM, Peter Zijlstra wrote:
> > On Fri, Feb 15, 2019 at 08:06:56PM -0800, hpa@zytor.com wrote:
> >> This implies we invoke schedule -- a restricted operation (consider
> >> may_sleep) during execution of STAC-enabled code, but *not* as an
> >> exception or interrupt, since those preserve the flags.
> > 
> > Meet preempt_enable().
> 
> I believe this falls under "doctor, it hurts when I do that." And it hurts for
> very good reasons. See below.

I disagree; the basic rule is that if you're preemptible you must also
be able to schedule and vice-versa. These AC regions violate this.

And, like illustrated, it is _very_ easy to get all sorts inside that AC
crap.

> >> I have serious concerns about this. This is more or less saying that
> >> we have left an unlimited gap and have had AC escape.
> > 
> > Yes; by allowing normal C in between STAC and CLAC this is so.
> > 
> >> Does *anyone* see a need to allow this? I got a question at LPC from
> >> someone about this, and what they were trying to do once all the
> >> layers had been unwound was so far down the wrong track for a root
> >> problem that actually has a very simple solution.
> > 
> > Have you read the rest of the thread?
> > 
> > All it takes for this to explode is a call to a C function that has
> > tracing on it in between the user_access_begin() and user_access_end()
> > things. That is a _very_ easy thing to do.
> > 
> > Heck, GCC is allowed to generate that broken code compiling
> > lib/strnlen_user.c; it doesn't _have_ to inline do_strnlen_user (esp.
> > with CONFIG_OPTIMIZE_INLINING), and making that a function call would
> > get us fentry hooks and ftrace and *BOOM*.
> > 
> > (Now, of course, its a static function with a single caller, and GCC
> > isn't _THAT_ stupid, but it could, if it wanted to)
> > 
> > Since the bar is _that_ low for mistakes, I figure we'd better fix it.
> > 
> 
> The question is what "fix it" means. 

It means that when we do schedule, the next task doesn't have AC set,
and when we schedule back, we'll restore our AC when we had it. Unlike
the current situation, where the next task will run with AC set.

IOW, it confines AC to the task context where it was set.

> I'm really concerned about AC escapes,
> and everyone else should be, too.

Then _that_ should be asserted.

> For an issue specific to tracing, it would be more appropriate to do the
> appropriate things in the tracing entry/exit than in schedule. Otherwise, we
> don't want to silently paper over mistakes which could mean that we run a
> large portion of the kernel without protection we thought we had.
> 
> In that sense, calling schedule() with AC set is in fact a great place to have
> a WARN() or even BUG(), because such an event really could imply that the
> kernel has been security compromised.

It is not specific to tracing, tracing is just one of the most trivial
and non-obvious ways to make it go splat.

There's lot of fairly innocent stuff that does preempt_disable() /
preempt_enable(). And just a warning in schedule() isn't sufficient,
you'd have to actually trigger a reschedule before you know your code is
bad.

And like I said; the invariant is: if you're preemptible you can
schedule and v.v.

Now, clearly you don't want to mark these whole regions as !preemptible,
because then you can also not take faults, but somehow you're not
worried about the whole fault handler, but you are worried about the
scheduler ?!? How does that work? The fault handler can touch a _ton_
more code. Heck, the fault handler can schedule.

So either pre-fault, and run the whole AC crap with preemption disabled
and retry, or accept that we have to schedule.

> Does that make more sense?

It appears to me you're going about it backwards.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
