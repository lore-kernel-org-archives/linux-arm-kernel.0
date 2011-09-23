From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 Sep 2011 21:44:07 +0100
Subject: [RFC] Shrink sched_clock some more
In-Reply-To: <alpine.LFD.2.00.1109221414200.12663@xanadu.home>
References: <20110922153611.GC8072@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1109221414200.12663@xanadu.home>
Message-ID: <20110923204407.GU17169@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2011 at 02:16:59PM -0400, Nicolas Pitre wrote:
> On Thu, 22 Sep 2011, Russell King - ARM Linux wrote:
> 
> > ... by getting rid of the fixed-constant optimization, and moving the
> > update code into arch/arm/kernel/sched_clock.c.
> > 
> > Platforms now only have to supply a function to read the sched_clock
> > register, and some basic information such as the number of significant
> > bits and the tick rate.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Nice.  Too bad for the fixed-constant optimization, but it wasn't used 
> enough to justify the bloat.

It's a shame to see it go - we _could_ work around that without making
anything worse over this code by merely making it an indirect call via
a common sched_clock() in arch/arm/kernel/sched_clock.c - iow:

unsigned long long notrace sched_clock(void)
{
	return real_sched_clock ? real_sched_clock() : 0ULL;
}

We have to have an indirection somewhere to allow the implementations of
the underlying timer to be switched.

However, as you say, there's not enough users of the fixed-constant stuff
to make it worth while keeping.
