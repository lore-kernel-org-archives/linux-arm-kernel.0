From: will.deacon@arm.com (Will Deacon)
Date: Tue, 21 Feb 2012 13:32:28 +0000
Subject: [PATCH] ARM: perf: do not handle deleted counter in irq handler
 to avoid oops
In-Reply-To: <1329799058-27082-1-git-send-email-tom.leiming@gmail.com>
References: <1329799058-27082-1-git-send-email-tom.leiming@gmail.com>
Message-ID: <20120221133228.GK19696@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ming Lei,

Thanks for the patch. I looked at this in the past since there was a buggy
FPGA flying about that could fire spurious overflows but I didn't get round
to doing anything with the patches.

On Tue, Feb 21, 2012 at 04:37:38AM +0000, Ming Lei wrote:
> The patch adds one check in irq handler to skip handling deleted
> counter for avoiding oops.
> 
> When one counter is deleted, event reference(hw_events->events[idx])
> will be cleared but the hw overflow status may be kept, so the
> hw event may be handled and oops will be triggered in irq handler if
> pmu irq from other events come.

Interesting, I'd not considered the case where the counter overflows while
we are in the process of disabling it. That needs fixing.

> The another candidate fix is to clear the overflow status for the
> event in arm_pmu->disable(), but looks it is a bit more complicated
> and has no obvious advantage than the fix in this patch.

It's not much more complicated and it does have the advantage that we avoid
taking an extra interrupt and also avoid the unlikely case where we take an
interrupt in the context of a task using perf different from the one in which
the counter overflowed, leading to false accounting.

> ---
>  arch/arm/kernel/perf_event_v7.c     |    3 ++-
>  arch/arm/kernel/perf_event_xscale.c |    2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)

I have a couple of patches that solve this by (a) clearing the overflow flag
when disabling the counter for ARMv7 and (b) adding the event checks to the
interrupt handlers in case the hardware is misbehaving.

I'll post them shortly (you can add your signed-off-by to the second one if you
like).

Cheers,

Will
