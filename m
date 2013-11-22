From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 22 Nov 2013 10:06:34 -0800
Subject: [PATCH 4/7] clocksource/cadence_ttc: Adjust interval in clock
 notifier
In-Reply-To: <52825779.2050106@linaro.org>
References: <1383945677-29674-1-git-send-email-soren.brinkmann@xilinx.com>
 <1383945677-29674-5-git-send-email-soren.brinkmann@xilinx.com>
 <52825779.2050106@linaro.org>
Message-ID: <e1bb716e-96dc-4da0-ba92-3a5492b5ba59@CO1EHSMHS007.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Tue, Nov 12, 2013 at 05:29:45PM +0100, Daniel Lezcano wrote:
> On 11/08/2013 10:21 PM, Soren Brinkmann wrote:
> >The clockevent has to be reprogrammed if the timer's input
> >clock frequency changes and the timer is in periodic mode, in order to
> >maintain the correct timer interval.
> >
> >Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> >---
> >  drivers/clocksource/cadence_ttc_timer.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> >diff --git a/drivers/clocksource/cadence_ttc_timer.c b/drivers/clocksource/cadence_ttc_timer.c
> >index a92350b55d32..68a336038d8f 100644
> >--- a/drivers/clocksource/cadence_ttc_timer.c
> >+++ b/drivers/clocksource/cadence_ttc_timer.c
> >@@ -338,6 +338,10 @@ static int ttc_rate_change_clockevent_cb(struct notifier_block *nb,
> >  		/* update cached frequency */
> >  		ttc->freq = ndata->new_rate;
> >
> >+		if (ttcce->ce.mode == CLOCK_EVT_MODE_PERIODIC)
> >+			ttc_set_interval(ttc, DIV_ROUND_CLOSEST(ttc->freq,
> >+						PRESCALE * HZ));
> >+
> 
> Couldn't be racy ?
I guess you're right. What would be the proper way to resolve it? If we
look at a little more code things look like this:

	local_irq_save(flags);                                           
	clockevents_update_freq(&ttcce->ce,                              
	                ndata->new_rate / PRESCALE);                     
	local_irq_restore(flags);                                        
	                                                                 
	/* update cached frequency */                                    
	ttc->freq = ndata->new_rate;                                     
	                                                                 
	if (ttcce->ce.mode == CLOCK_EVT_MODE_PERIODIC)                   
	        ttc_set_interval(ttc, DIV_ROUND_CLOSEST(ttc->freq,       
	                                PRESCALE * HZ));

Would it be enough to move the ttc_set_interval() call within the
section where local IRQs are disabled? I have the feeling for this timer
the local_irq_save() may in general not be the right option since the
timer is not CPU local.
Should we probably change this do irq_disable(ttcce->ce.irq)?

	Thanks,
	S?ren
