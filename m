From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 19 Mar 2015 16:39:55 +0000
Subject: [PATCH] arm64: percpu: Make this_cpu accessors pre-empt safe
In-Reply-To: <20150319162753.GC4751@arm.com>
References: <1426776751-20526-1-git-send-email-steve.capper@linaro.org>
 <20150319154435.GC25967@leverpostej>
 <20150319160008.GA4751@arm.com>
 <20150319161143.GE25967@leverpostej>
 <20150319162753.GC4751@arm.com>
Message-ID: <20150319163955.GG25967@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 04:27:53PM +0000, Will Deacon wrote:
> On Thu, Mar 19, 2015 at 04:11:44PM +0000, Mark Rutland wrote:
> > On Thu, Mar 19, 2015 at 04:00:09PM +0000, Will Deacon wrote:
> > > On Thu, Mar 19, 2015 at 03:44:36PM +0000, Mark Rutland wrote:
> > > > On Thu, Mar 19, 2015 at 02:52:31PM +0000, Steve Capper wrote:
> > > > > +/*
> > > > > + * Modules aren't allowed to use preempt_enable_no_resched, and it is
> > > > > + * undef'ed. If we are unable to use preempt_enable_no_resched, then
> > > > > + * fallback to the standard preempt_enable.
> > > > > + */
> > > > > +#ifdef preempt_enable_no_resched
> > > > > +#define __pcp_preempt_enable()	preempt_enable_no_resched()
> > > > > +#else
> > > > > +#define __pcp_preempt_enable()	preempt_enable()
> > > > > +#endif /* preempt_enable_no_resched */
> > > > 
> > > > I think it would be worth mentioning in the comment why we want to use
> > > > preempt_enable_no_resched where possible (e.g. read-modify-cmpxchg
> > > > sequences where we want to have as few retries as possible).
> > > 
> > > Hmm, I'm not sure I agree with that. In the interest of throughput, I can
> > > understand that you want to minimise the retries but since preempt kernels
> > > are all about minimising latency then actually scheduling when a cmpxchg
> > > loop fail sounds pretty ideal to me.
> > 
> > I'm on about scheduling at the end of the read, before the cmpxchg. It's
> > basically asking for another thread to make the read stale (and hence
> > the cmpxchg is very likely to fail).
> 
> /me gets introduced to SLUB's slab_alloc_node.
> 
> > Scheduling after the cmpxchg is fine.
> 
> I still don't think the slub code warrants using preempt_enable_no_resched,
> for a number of reasons:
> 
>   (1) s390 uses preempt_enable, so it doesn't appear to be the end of the
>       world
> 
>   (2) The slub code is well aware of what it's doing, but doesn't consider
>       it an issue:
> 
>       * [...] We may switch back and forth between cpus while
>       * reading from one cpu area. That does not matter as long
>       * as we end up on the original cpu again when doing
>       * the cmpxchg.

Sure, the code is correct regardless, on both of these points.

>   (3) Preemption isn't actually an issue here -- CPU migration is. I'd
>       expect that to be a lot rarer.

That's not true: in a read-modify-cmpxchg loop (even on a UP system) if
you get preempted at the end of the read and another thread modifies
your datastructure, then your subsequent cmpxchg will fail. So any
preemption could cause you to have to retry, so you want to miminise
potential preemptions.

Note that this is a performance argument rather than a correctness
argument.

>   (4) Having different preempt behaviour depending on whether or not
>       something is built as a module is bloody horrible

Agreed.

Mark.
