From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 26 May 2011 14:37:34 +0200
Subject: [BUG] "sched: Remove rq->lock from the first half of ttwu()"
	locks up on ARM
In-Reply-To: <20110526123137.GG24876@n2100.arm.linux.org.uk>
References: <1306260792.27474.133.camel@e102391-lin.cambridge.arm.com>
	<1306272750.2497.79.camel@laptop> <1306343335.21578.65.camel@twins>
	<1306358128.21578.107.camel@twins>
	<BANLkTi=XbTXQsu3jUEvQyCfBy6-aRnqSpw@mail.gmail.com>
	<1306405979.1200.63.camel@twins>
	<1306407759.27474.207.camel@e102391-lin.cambridge.arm.com>
	<1306409575.1200.71.camel@twins> <1306412511.1200.90.camel@twins>
	<20110526122623.GA11875@elte.hu>
	<20110526123137.GG24876@n2100.arm.linux.org.uk>
Message-ID: <1306413454.1200.92.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-05-26 at 13:31 +0100, Russell King - ARM Linux wrote:
> On Thu, May 26, 2011 at 02:26:23PM +0200, Ingo Molnar wrote:
> > 
> > * Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > Sort this by reverting to the old behaviour for this situation and 
> > > perform a full remote wake-up.
> > 
> > Btw., ARM should consider switching most of its subarchitectures to 
> > !__ARCH_WANT_INTERRUPTS_ON_CTXSW - enabling irqs during context 
> > switches is silly and now expensive as well.
> 
> Not going to happen.  The reason we do it is because most of the CPUs
> have to (slowly) flush their caches during switch_mm(), and to have
> IRQs off over the cache flush means that we lose IRQs.
> 
> So it's not silly at all, bit a technical requirement imposed by the
> cache architecture.
> 
> If it's become expensive through development, it suggests that the
> development did not take account of the issues we have on ARM.

Its not more expensive than it was before this patch series, and the
case in question is relatively rare (guesstimate, lacking measurements)
so ARM should benefit from most of the optimization provided.
