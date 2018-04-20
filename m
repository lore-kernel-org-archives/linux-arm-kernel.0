From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 20 Apr 2018 12:41:18 +0100
Subject: [RFC PATCH 3/3] arm64: stacktrace: Prevent looping and invalid
 stack transitions
In-Reply-To: <20180420111950.GN16308@e103592.cambridge.arm.com>
References: <1524221179-19473-1-git-send-email-Dave.Martin@arm.com>
 <1524221179-19473-4-git-send-email-Dave.Martin@arm.com>
 <20180420105814.a7ntoqslbsgzluia@lakrids.cambridge.arm.com>
 <20180420111950.GN16308@e103592.cambridge.arm.com>
Message-ID: <20180420114118.irlzqku6xbxrp3uf@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2018 at 12:19:50PM +0100, Dave Martin wrote:
> On Fri, Apr 20, 2018 at 11:58:14AM +0100, Mark Rutland wrote:
> > On Fri, Apr 20, 2018 at 11:46:19AM +0100, Dave Martin wrote:
> > > The assumption that we can place the possible stacks (task, IRQ,
> > > overflow, SDEI) in a strict order is based on a quick review of
> > > entry.S, but I may have this wrong... in which case the approach
> > > proposed in this patch may need tweaking (or may not work at all).
> > 
> > We have a partial ordering where we can transition between stacks:
> > 
> > 	task -> irq -> {overflow,sdei}
> > 
> > The only problem that I'm aware of is that you could go either way:
> > 
> > 	overflow -> sdei
> > 	sdei -> overflow
> 
> > In either case, there's a fatal error, and it would be very nice to get
> > the most reliable stacktrace possible rather than terminating early.
> 
> Agreed, where we must choose between a possibly-incomplete backtrace or
> a possibly-incorrect backtrace, we should probably err on the side of
> completeness.
> 
> To what extent do we claim to cope with recursive stack overflows?

We don't claim to handle this at all.

If we overflow on the overflow stack, we'll try to reuse the overflow
stack, and things go badly.

We *could* add a per-cpu flag to say already-overflowed, and go into a
WFI loop upon a recursive overflow, but we can't do something reliably
fatal in this case.

> We could get something like
> 
> task -> overflow -> irq -> overflow -> sdei -> overflow

We only transition task -> irq, and not overflow -> irq.

In irq_stack_entry, we only transition to the IRQ stack if we're on a
task stack, so we can't have overflow -> irq.

I believe that the worst case is something like:

task -> irq -> overflow -> sdei -> overflow.

... but at that point we're very much dead, and can't reliably unwind
past the SDEI stack.

We could have flags saying if we've hit a particular stack before, and
when transitioning, abort if we've already been on that stack.

> (We can also take a single nested SDE, but if the sdei stack already
> overflowed I think we're basically dead if that happens here, unless
> SDEI checks for this and continues on the overflow stack if that
> happens).

The overflow handler won't return to the first SDE stack, so that's
fatal, but not much worse than taking a regular SDE while on the
overflow stack.

IIUC to take a nested SDE, the first has to be a normal SDE, and the
second a critical SDE. With VMAP_STACK, those use separate stacks, and
thus the second SDE shouldn't corrupt the contest of the first.

Without VMAP_STACK, the overflow isn't handled reliably anyhow.

Thanks,
Mark.
