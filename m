From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 19 Jun 2013 09:30:43 -0700
Subject: [PATCHv7 01/11] clockevents: Prefer CPU local devices over
 global devices
In-Reply-To: <20130618102257.GH6809@e106331-lin.cambridge.arm.com>
References: <1370291642-13259-2-git-send-email-sboyd@codeaurora.org>
 <51B0A6E8.20909@linaro.org> <20130606180425.GQ599@codeaurora.org>
 <51B10D85.1060507@linaro.org> <20130606223848.GR599@codeaurora.org>
 <20130612214435.GE10823@codeaurora.org> <51B991EF.70800@linaro.org>
 <alpine.LFD.2.02.1306131331430.22970@ionos>
 <20130613183950.GA32061@codeaurora.org>
 <20130618102257.GH6809@e106331-lin.cambridge.arm.com>
Message-ID: <20130619163043.GA6300@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On 06/18, Mark Rutland wrote:
> On Thu, Jun 13, 2013 at 07:39:50PM +0100, Stephen Boyd wrote:
> > On 06/13, Thomas Gleixner wrote:
> > > On Thu, 13 Jun 2013, Daniel Lezcano wrote:
> > > > I prefer Thomas to have a look at it and ack it. I changed Cc to To for
> > > > Thomas.
> > > 
> > > The patch does not apply on tip timers/core. The code has been
> > > reworked a month ago. Please work against tip timers/core. That's
> > > where this stuff ends up.
> > > 
> > 
> > Ah, I thought your patch series had stalled. Here is a refreshed
> > patch. Every other patch in this series applies cleanly to tip
> > timers/core so I don't want to resend them again unless
> > absolutely necessary.
> > 
> > -----8<-----
> > Subject: [PATCH v8] clockevents: Prefer CPU local devices over global devices
> > 
> > On an SMP system with only one global clockevent and a dummy
> > clockevent per CPU we run into problems. We want the dummy
> > clockevents to be registered as the per CPU tick devices, but
> > we can only achieve that if we register the dummy clockevents
> > before the global clockevent or if we artificially inflate the
> > rating of the dummy clockevents to be higher than the rating
> > of the global clockevent. Failure to do so leads to boot
> > hangs when the dummy timers are registered on all other CPUs
> > besides the CPU that accepted the global clockevent as its tick
> > device and there is no broadcast timer to poke the dummy
> > devices.
> > 
> > If we're registering multiple clockevents and one clockevent is
> > global and the other is local to a particular CPU we should
> > choose to use the local clockevent regardless of the rating of
> > the device. This way, if the clockevent is a dummy it will take
> > the tick device duty as long as there isn't a higher rated tick
> > device and any global clockevent will be bumped out into
> > broadcast mode, fixing the problem described above.
> > 
> > Reported-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: John Stultz <john.stultz@linaro.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> I've just tested this atop of tip/timers/core on a tc2, using only the
> sp804. As previously, without the patch boot hangs, and with the patch
> I'm able to reach userspace and do useful things.
> 
> Tested-by: Mark Rutland <mark.rutland@arm.com>
> 
> Thanks for working on this, Stephen.

Can you pick up the first two patches in this series please? And
preferably make a stable branch that can be pulled into arm-soc?
Then I can send the rest through the arm-soc tree.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
