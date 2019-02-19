Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501FCC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:48:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFDA82146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QodOjVvu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFDA82146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fHqcIPlL3n/vwi/e9HA+Wyv3KJqi2pG8tKdfIPb4jWk=; b=QodOjVvunsl8Ax
	k+d1CUrzrJ7Fj7YKvp1VN7BeMGdmHR+FdNilxNIeavFpxN5/VctLMUH2MYKiMPc1NAeyjho2YKViK
	BmfcFk9oFKhYNMYWXG6kDsbZa3sac0+IEjBToskruzcMQh+j83RRnQInYEDf0WW1ALecUjfGMMPL5
	9nZEecD1lGhH+rcNwOG0f68wn9YhB2Y8qHSDScBD3Fo4y23AzZftDaeG/VeRNRzWQZh5WPG7dX13I
	JtXU3nL/u+Aqt1f8nLfJTcjS+RekvxuP4dCAXbv3Oql0oV5BgQ3moM/NECjULnrR/JgeXF01izQv2
	20YNXoKwDp2fjIa/i4Dw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw4ou-0006zc-FY; Tue, 19 Feb 2019 12:48:20 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw4oq-0006yL-MK
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 12:48:18 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EE0615AB;
 Tue, 19 Feb 2019 04:48:14 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AE0B3F720;
 Tue, 19 Feb 2019 04:48:11 -0800 (PST)
Date: Tue, 19 Feb 2019 12:48:08 +0000
From: Will Deacon <will.deacon@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
Message-ID: <20190219124808.GG8501@fuggles.cambridge.arm.com>
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
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190219090409.GW32494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_044817_110834_78E74DC7 
X-CRM114-Status: GOOD (  35.36  )
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
Cc: jpoimboe@redhat.com, dvlasenk@redhat.com, brgerst@gmail.com,
 Julien Thierry <julien.thierry@arm.com>, catalin.marinas@arm.com,
 valentin.schneider@arm.com, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, mingo@redhat.com, james.morse@arm.com,
 luto@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, bp@alien8.de,
 tglx@linutronix.de, torvalds@linux-foundation.org,
 Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 19, 2019 at 10:04:09AM +0100, Peter Zijlstra wrote:
> On Mon, Feb 18, 2019 at 02:30:21PM -0800, H. Peter Anvin wrote:
> > On 2/16/19 2:30 AM, Peter Zijlstra wrote:
> > > On Fri, Feb 15, 2019 at 08:06:56PM -0800, hpa@zytor.com wrote:
> > >> This implies we invoke schedule -- a restricted operation (consider
> > >> may_sleep) during execution of STAC-enabled code, but *not* as an
> > >> exception or interrupt, since those preserve the flags.
> > > 
> > > Meet preempt_enable().
> > 
> > I believe this falls under "doctor, it hurts when I do that." And it hurts for
> > very good reasons. See below.
> 
> I disagree; the basic rule is that if you're preemptible you must also
> be able to schedule and vice-versa. These AC regions violate this.
> 
> And, like illustrated, it is _very_ easy to get all sorts inside that AC
> crap.
> 
> > >> I have serious concerns about this. This is more or less saying that
> > >> we have left an unlimited gap and have had AC escape.
> > > 
> > > Yes; by allowing normal C in between STAC and CLAC this is so.
> > > 
> > >> Does *anyone* see a need to allow this? I got a question at LPC from
> > >> someone about this, and what they were trying to do once all the
> > >> layers had been unwound was so far down the wrong track for a root
> > >> problem that actually has a very simple solution.
> > > 
> > > Have you read the rest of the thread?
> > > 
> > > All it takes for this to explode is a call to a C function that has
> > > tracing on it in between the user_access_begin() and user_access_end()
> > > things. That is a _very_ easy thing to do.
> > > 
> > > Heck, GCC is allowed to generate that broken code compiling
> > > lib/strnlen_user.c; it doesn't _have_ to inline do_strnlen_user (esp.
> > > with CONFIG_OPTIMIZE_INLINING), and making that a function call would
> > > get us fentry hooks and ftrace and *BOOM*.
> > > 
> > > (Now, of course, its a static function with a single caller, and GCC
> > > isn't _THAT_ stupid, but it could, if it wanted to)
> > > 
> > > Since the bar is _that_ low for mistakes, I figure we'd better fix it.
> > > 
> > 
> > The question is what "fix it" means. 
> 
> It means that when we do schedule, the next task doesn't have AC set,
> and when we schedule back, we'll restore our AC when we had it. Unlike
> the current situation, where the next task will run with AC set.
> 
> IOW, it confines AC to the task context where it was set.
> 
> > I'm really concerned about AC escapes,
> > and everyone else should be, too.
> 
> Then _that_ should be asserted.
> 
> > For an issue specific to tracing, it would be more appropriate to do the
> > appropriate things in the tracing entry/exit than in schedule. Otherwise, we
> > don't want to silently paper over mistakes which could mean that we run a
> > large portion of the kernel without protection we thought we had.
> > 
> > In that sense, calling schedule() with AC set is in fact a great place to have
> > a WARN() or even BUG(), because such an event really could imply that the
> > kernel has been security compromised.
> 
> It is not specific to tracing, tracing is just one of the most trivial
> and non-obvious ways to make it go splat.
> 
> There's lot of fairly innocent stuff that does preempt_disable() /
> preempt_enable(). And just a warning in schedule() isn't sufficient,
> you'd have to actually trigger a reschedule before you know your code is
> bad.
> 
> And like I said; the invariant is: if you're preemptible you can
> schedule and v.v.
> 
> Now, clearly you don't want to mark these whole regions as !preemptible,
> because then you can also not take faults, but somehow you're not
> worried about the whole fault handler, but you are worried about the
> scheduler ?!? How does that work? The fault handler can touch a _ton_
> more code. Heck, the fault handler can schedule.
> 
> So either pre-fault, and run the whole AC crap with preemption disabled
> and retry, or accept that we have to schedule.

I think you'll still hate this, but could we not disable preemption during
the uaccess-enabled region, re-enabling it on the fault path after we've
toggled uaccess off and disable it again when we return back to the
uaccess-enabled region? Doesn't help with tracing, but it should at least
handle the common case.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
