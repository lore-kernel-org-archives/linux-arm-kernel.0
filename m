From: khilman@ti.com (Kevin Hilman)
Date: Thu, 31 Mar 2011 15:09:45 -0700
Subject: [PATCH 06/10] omap2+: Remove gptimer_wakekup for now
In-Reply-To: <20110328222142.4046.4677.stgit@baageli.muru.com> (Tony
	Lindgren's message of "Mon, 28 Mar 2011 15:21:43 -0700")
References: <20110328221501.4046.41079.stgit@baageli.muru.com>
	<20110328222142.4046.4677.stgit@baageli.muru.com>
Message-ID: <87zkob6ixi.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> This removes the support for setting the wake-up timer for debugging.
>
> Later on we can reserve gptimer1 for PM code only and have similar
> functionality.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

While we work on an alternative, rather than completely remove this
functionality, below is a very small patch (replaces $SUBJECT patch)
that will keep the current wakeup-from-suspend timer for PM debug
working.

Note that GPT1 fs not just used for wakeups from suspend.  GPT1 needs to
also be the clockevent (at least during idle) so that next-timer
interrupts during idle are also programmed for GPT1.

Here is what I see as a possible "real" solution.  Let's see if we're on
the same page.

- GPT1 reserved for "special" PM wakeup
- GPT2 used as high-resolution clockevent (using sys_clk, but stops during idle)
- GPT3 (or counter_32k) used as clocksource depending on Kconfig

Whenever we're going idle (or suspend), we have to effectively switch
the clockevent from GPT2 to GPT1.  I assume this is what you have in
mind as well.

We'll need to dig into the clockevent (and tick broadcast) code to get
this to work on UP.  On SMP, the C3STOP flag is used to signify that at
clockevent will stop during specific power states, so an alternate
clockevent is used, but IIUC, this doesn't currently work the same on
UP.  I think Santosh has looked into this more recently than I have.
Santosh, if you have any recent status on this, could you share?  I'll
gladly work on the clockevent layer if necessary for this.

Tony, in the mean time, can you use something like the patch below
instead of $SUBJECT patch?  At least we won't loose functionality while
working on this feature.

Kevin
