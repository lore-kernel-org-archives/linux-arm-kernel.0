From: Marc.Zyngier@arm.com (Marc Zyngier)
Date: Fri, 27 May 2011 11:44:38 +0100
Subject: [PATCH 0/4] ARM: smp_twd: mpcore_wdt: Fix MPCORE watchdog setup
In-Reply-To: <20110527082640.GC16394@infomag.iguana.be>
References: <1286185540-19569-1-git-send-email-vkuzmichev@mvista.com>
	<20110527082640.GC16394@infomag.iguana.be>
Message-ID: <1306493078.27474.269.camel@e102391-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-05-27 at 10:26 +0200, Wim Van Sebroeck wrote:
> Hi Vitaly,
> 
> > From: Vitaly Kuzmichev <vkuzmichev@mvista.com>
> > 
> > The series of patches fixes various bugs in ARM MPCORE watchdog setup.
> > They also introduce some changes in common SMP_TWD timer setup code.
> > The PATCH 1/4 adds an exported function to obtain calibrated timer rate
> > in mpcore_wdt. However, this solution might be unacceptable, so we may
> > discuss another 2 variants:
> >  1) use clock framework
> >    This may require to fix all MPCORE boards clock implementations.
> >  2) copy calibration loop to mpcore_wdt
> >    However, this increases boot time.
> > 
> > 
> > Vitaly Kuzmichev (4):
> >   ARM: smp_twd: mpcore_wdt: Fix watchdog counter loading
> >   ARM: smp_twd: Fix typo in twd_timer_rate printout
> >   ARM: mpcore_wdt: Fix WDIOC_SETOPTIONS handling
> >   ARM: mpcore_wdt: Fix timer mode setup
> > 
> >  arch/arm/include/asm/smp_twd.h |    7 +++++++
> >  arch/arm/kernel/smp_twd.c      |    8 +++++++-
> >  drivers/watchdog/mpcore_wdt.c  |   29 +++++++++++++++++++++--------
> >  3 files changed, 35 insertions(+), 9 deletions(-)
> 
> What's the status on this? I don't recall having seen any answers from ARM community.

Overall, I'm not too happy about patch #1. Exposing some "random"
internal state of the timer doesn't seem the right thing to me.

Furthermore, the internal rate of the TWD changes with the CPU
frequency. Blindly trusting the calibrated value at boot time is a nice
way to see the watchdog kicking in unexpectedly when frequency is
increased.

I suggest you have a look at this patch:
https://patchwork.kernel.org/patch/801472/

Together with a cpufreq notifier, this "smp_twd" clock looks like a much
better option. Over time, all platform would be converted to that
particular clock, and the problem would be solved in a much nicer way.

Cheers,

	M.
-- 
Reality is an implementation detail.
