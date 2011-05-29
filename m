From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 29 May 2011 14:19:06 +0100
Subject: [BUG] "sched: Remove rq->lock from the first half of ttwu()"
	locks up on ARM
In-Reply-To: <BANLkTin-5+jE6U-3RrPjPiFVRMGNhvwVEw@mail.gmail.com>
References: <1306412511.1200.90.camel@twins> <20110526122623.GA11875@elte.hu>
	<20110526123137.GG24876@n2100.arm.linux.org.uk>
	<20110526125007.GA27083@elte.hu>
	<BANLkTinUZ7EwN_nBCi_RQ9u8-LBcr_A74g@mail.gmail.com>
	<20110527120629.GA32617@elte.hu>
	<20110527205240.GT24876@n2100.arm.linux.org.uk>
	<20110529102119.GC9489@e102109-lin.cambridge.arm.com>
	<20110529102659.GY24876@n2100.arm.linux.org.uk>
	<BANLkTin-5+jE6U-3RrPjPiFVRMGNhvwVEw@mail.gmail.com>
Message-ID: <20110529131906.GB24876@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 29, 2011 at 01:01:58PM +0100, Catalin Marinas wrote:
> On Sunday, 29 May 2011, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > On Sun, May 29, 2011 at 11:21:19AM +0100, Catalin Marinas wrote:
> >> To avoid extra per-thread flags, we could set a per-cpu variable in
> >> switch_mm() so that we know what to switch the page tables to in the
> >> post-switch hook.
> >
> > Why do we need to add more per-cpu stuff when we already have easy access
> > to the thread flags?
> 
> It could work, I was thinking that we only get an mm structure in the
> post-switch hook.

No.  What we get is the mm structure for the _previous_ task which
was running if the previous task was a lazy-tlb task.  Otherwise it
will be NULL.

What we do get is the 'next' task and 'next' thread by virtue of the
fact that it has become the 'current' task - so current and
current_thread_info() both point at what switch_mm() regarded as the
'next' task/thread.

> BTW, we currently have a per-cpu current_mm variable in context.c
> because switch_mm() is called before switch_to() and the CPU may
> receive an IPI to reset the ASID in this interval. But we can remove
> it entirely if we set the ASID in the post-switch hook and run the
> main switch code with interrupts disabled.

Unconvinced.  If we move the ASID update to the post-switch hook, then
we have the opposite problem - an IPI can sneak in between the dropping
of the IRQ disabling and the post-switch hook.  This could mean that
we end up racing to update the hardware ASID value instead (we may
have read the ASID value from the mm struct, interrupt occurs, changes
the ASID value, returns, we program the old ASID value.)
