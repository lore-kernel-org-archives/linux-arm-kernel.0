From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 12 Dec 2013 10:44:01 -0800
Subject: [PATCH v2 5/9] clocksource/cadence_ttc: Adjust interval in clock
 notifier
In-Reply-To: <52A9A8EA.3080609@linaro.org>
References: <1385514296-26702-1-git-send-email-soren.brinkmann@xilinx.com>
 <1385514296-26702-6-git-send-email-soren.brinkmann@xilinx.com>
 <52A9A8EA.3080609@linaro.org>
Message-ID: <d0dac978-75a1-4df2-bd2b-b497e34b568a@AM1EHSMHS009.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Thu, Dec 12, 2013 at 01:15:38PM +0100, Daniel Lezcano wrote:
> On 11/27/2013 02:04 AM, Soren Brinkmann wrote:
> >The clockevent has to be reprogrammed if the timer's input
> >clock frequency changes and the timer is in periodic mode, in order to
> >maintain the correct timer interval.
> >
> >Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> >---
> >v2:
> >  - adjust the timer interval while the timer interrupt is disabled
> >---
> >  drivers/clocksource/cadence_ttc_timer.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> >diff --git a/drivers/clocksource/cadence_ttc_timer.c b/drivers/clocksource/cadence_ttc_timer.c
> >index 246d018d1e63..77517675653e 100644
> >--- a/drivers/clocksource/cadence_ttc_timer.c
> >+++ b/drivers/clocksource/cadence_ttc_timer.c
> >@@ -322,6 +322,9 @@ static int ttc_rate_change_clockevent_cb(struct notifier_block *nb,
> >  	switch (event) {
> >  	case POST_RATE_CHANGE:
> >  	{
> >+		/* update cached frequency */
> >+		ttc->freq = ndata->new_rate;
> >+
> >  		/*
> >  		 * clockevents_update_freq should be called with IRQ disabled on
> >  		 * the CPU the timer provides events for. The timer we use is
> >@@ -329,12 +332,15 @@ static int ttc_rate_change_clockevent_cb(struct notifier_block *nb,
> >  		 * cores.
> >  		 */
> >  		disable_irq(ttcce->ce.irq);
> >+
> >  		clockevents_update_freq(&ttcce->ce,
> >  				ndata->new_rate / PRESCALE);
> >-		enable_irq(ttcce->ce.irq);
> >
> >-		/* update cached frequency */
> >-		ttc->freq = ndata->new_rate;
> >+		if (ttcce->ce.mode == CLOCK_EVT_MODE_PERIODIC)
> >+			ttc_set_interval(ttc, DIV_ROUND_CLOSEST(ttc->freq,
> >+						PRESCALE * HZ));
> >+
> >+		enable_irq(ttcce->ce.irq);
> >
> >  		/* fall through */
> >  	}
> 
> When looking at the smp_twd.c, there is a similar need.
Right, but with my proposed patches a call to clockevents_update_freq()
should be all that is needed.

> 
> There are a couple of notifier used on for cpufreq and one for clock
> rate change.
Only one is actually used I think, depending on what kernel
infrastructure is available.

> 
> Wouldn't make sense to add the notifier calls and registration in
> the time framework and add the callbacks in the dev ops ? The switch
> would be in the timer framework and perhaps the irq disabling may be
> easier to deal with ?
I don't think that works - at least not that easy -  because timers could
have all different input clocks. The twd is kind of special since it always
uses the CPU clock.  And - unfortunately - our TTC implementation on Zynq
does it similar. But that is not the generic case and I don't know if it
makes sense/is possible to handle this in the timer core. It would mean the
timer core would need to keep track of the timers + their input clocks.
I was hoping that Zynq, twd and arm_global_timer are rather the
exception and that the majority of timer HW is provided a fixed and stable
input frequency - as the arm generic timer spec demands.

	S?ren
