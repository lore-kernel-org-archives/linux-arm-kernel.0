From: will.deacon@arm.com (Will Deacon)
Date: Wed, 30 Apr 2014 14:26:28 +0100
Subject: [RFC PATCH] sched_clock: also call
 register_current_timer_delay() if possible
In-Reply-To: <5360F42C.9080401@linutronix.de>
References: <1398860614-29469-1-git-send-email-bigeasy@linutronix.de>
 <20140430124800.GC21876@arm.com> <5360F42C.9080401@linutronix.de>
Message-ID: <20140430132628.GC15719@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 30, 2014 at 02:01:32PM +0100, Sebastian Andrzej Siewior wrote:
> On 04/30/2014 02:48 PM, Will Deacon wrote:
> > Hi Sebastian,
> 
> Hi Will,
> 
> > As long as sched_clock is guaranteed to be a fixed frequency, always-on
> > clocksource then this could work, but it removes the flexibility of having
> > a separate delay clock and sched clock (is this useful?).
> 
> 
> 
> > Looking at your patch, I noticed that we need to extend the
> > register_current_timer_delay function to deal with clocks that aren't as
> > wide as cycle_t, otherwise we don't delay() for long enough when the clock
> > overflows (this is potentially already an issue for architected timers <
> > 64-bit). Could you cook a patch for that please?
> 
> Sure, I would change the type from long to u64 and fix all users. Would
> that be okay for you?

I don't think that's the problem I was referring to. What I mean is that a
clocksource might overflow at any number of bits, so the delay calculation
needs to take this into account when it does:

	while ((get_cycles() - start) < cycles)

because a premature overflow from get_cycles() will cause us to return
early. The solution is to mask the result of the subtraction before the
comparison to match the width of the clock.

Will
