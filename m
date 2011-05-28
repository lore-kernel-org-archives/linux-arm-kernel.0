From: peterz@infradead.org (Peter Zijlstra)
Date: Sat, 28 May 2011 15:13:01 +0200
Subject: [BUG] "sched: Remove rq->lock from the first half of ttwu()"
	locks up on ARM
In-Reply-To: <20110527205240.GT24876@n2100.arm.linux.org.uk>
References: <BANLkTi=XbTXQsu3jUEvQyCfBy6-aRnqSpw@mail.gmail.com>
	<1306405979.1200.63.camel@twins>
	<1306407759.27474.207.camel@e102391-lin.cambridge.arm.com>
	<1306409575.1200.71.camel@twins> <1306412511.1200.90.camel@twins>
	<20110526122623.GA11875@elte.hu>
	<20110526123137.GG24876@n2100.arm.linux.org.uk>
	<20110526125007.GA27083@elte.hu>
	<BANLkTinUZ7EwN_nBCi_RQ9u8-LBcr_A74g@mail.gmail.com>
	<20110527120629.GA32617@elte.hu>
	<20110527205240.GT24876@n2100.arm.linux.org.uk>
Message-ID: <1306588381.2497.481.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-05-27 at 21:52 +0100, Russell King - ARM Linux wrote:
> On Fri, May 27, 2011 at 02:06:29PM +0200, Ingo Molnar wrote:
> > The expectations are to have irqs off (we are holding the runqueue 
> > lock if !__ARCH_WANT_INTERRUPTS_ON_CTXSW), so that's not workable i 
> > suspect.
> 
> Just a thought, but we _might_ be able to avoid a lot of this hastle if
> we had a new arch hook in finish_task_switch(), after finish_lock_switch()
> returns but before the old MM is dropped.

I'd be more than willing to provide this.

> For the new ASID-based switch_mm(), we currently do this:
> 
> 1. check ASID validity
> 2. flush branch predictor
> 3. set reserved ASID value
> 4. set new page tables
> 5. set new ASID value
> 
> This will be shortly changed to:
> 
> 1. check ASID validity
> 2. flush branch predictor
> 3. set swapper_pg_dir tables
> 4. set new ASID value
> 5. set new page tables
> 
> We could change switch_mm() to only do:
> 
> 1. flush branch predictor
> 2. set swapper_pg_dir tables
> 3. check ASID validity
> 4. set new ASID value
> 
> At this point, we have no user mappings, and so nothing will be using the
> ASID at this point.  Then in a new post-finish_lock_switch() arch hook:
> 
> 5. check whether we need to do flushing as a result of ASID change
> 6. set new page tables
> 
> I think this may simplify the ASID code.  It needs prototyping out,
> reviewing and testing, but I think it may work.
> 
> And I think it may also be workable with the CPUs which need to flush
> the caches on context switches - we can postpone their page table
> switch to this new arch hook too, which will mean we wouldn't require
> __ARCH_WANT_INTERRUPTS_ON_CTXSW on ARM at all.
> 
> Any thoughts (if you've followed what I'm going on about) ?

Yeah, definitely worth a try, you mentioned on IRC the problem of
detecting if switch_mm() happened in the new arch hook. Since
switch_mm() gets a @next pointer we can set a TIF flag there and have
the new arch hook test for that and conditionally perform the required
work.

Now, supposing we can get ARM to not rely on
__ARCH_WANT_INTERRUPTS_ON_CTXSW anymore, there's only microblaze left,
Michal, would a similar scheme work for you? If so we can fully
deprecate and remove this exception from the scheduler (yay!).
