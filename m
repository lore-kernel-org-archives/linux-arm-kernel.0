From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 13 Jun 2014 13:33:35 -0400 (EDT)
Subject: [PATCH v4 1/6] Documentation: arm: define DT idle states bindings
In-Reply-To: <20140613164954.GA16745@e102568-lin.cambridge.arm.com>
References: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1402503520-8611-2-git-send-email-lorenzo.pieralisi@arm.com>
 <alpine.LFD.2.11.1406111240010.25775@knanqh.ubzr>
 <20140613164954.GA16745@e102568-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.11.1406131306160.25775@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Jun 2014, Lorenzo Pieralisi wrote:

> On Wed, Jun 11, 2014 at 07:15:16PM +0100, Nicolas Pitre wrote:
> > Let's illustrate the different periods on a time line to make it clearer
> > (hmmm let's see how this can be managed on a braille display :-O ):
> > 
> > EXEC:	Normal CPU execution.
> > 
> > PREP:	Preparation phase before committing the hardware to idle mode
> > 	like cache flushing. This is abortable on pending wake-up 
> > 	event conditions. The abort latency is assumed to be negligible 
> > 	(i.e. less than the ENTRY + EXIT duration). If aborted, we go 
> > 	back to EXEC. This phase is optional. If not abortable, this 
> > 	should be included in the ENTRY phase instead.
> > 
> > ENTRY:	The hardware is committed to idle mode. This period must run to
> > 	completion up to IDLE before anything else can happen.
> > 
> > IDLE:	This is the actual power-saving idle period. This may last 
> > 	between 0 and infinite time, until a wake-up event occurs.
> > 
> > EXIT:	Period during which the CPU is brought back to operational
> > 	mode (EXEC).
> > 
> > ...__[EXEC]__|__[PREP]--|__[ENTRY]__|__[IDLE]__|___[EXIT]_--|__[EXEC]__...
> >              |          |           |          |            |
> > 
> >              |<-- entry-latency --->|
> > 
> >                                                |<- exit-  ->|
> >                                                |  latency   |
> > 
> >              |<-------------- min-residency --------------->|
> > 
> >                         |<----- worst_wakeup_latency ------>|
> > 
> > entry-latency: Worst case latency required to enter the idle state.  The 
> > exit_latency may be guaranteed only after entry-latency has passed.
> > 
> > min-residency: Minimum period, including preparation, entry and exit, 
> > for a given power mode to be worthwhile energy wise.  It must be at 
> > least equal to entry_latency + exit_latency.
> > 
> > worst_wakeup_latency: Maximum delay between the signaling of a wake-up 
> > event and the CPU being able to execute normal code again. If not 
> > specified, this is assumed to be entry-latency + exit_latency.
> > 
> > Notes:
> > 
> > The cpuidle code would only care about min-residency to select the most 
> > appropriate mode based on the expected delay before the next event.
> > 
> > The scheduler will care about the following in the near future:
> > 
> > wakeup_delay = exit_latency + max(entry_latency - (now - entry_timestamp), 0)
> > 
> > In other words, the scheduler would wake up the CPU with the shortest 
> > wake-up latency.  This wake-up latency must take into account the entry 
> > latency if that period has not expired.  Here the abortable nature of 
> > the PREP period is ignored on purpose because it cannot be relied upon 
> > (e.g. if the cache is mostly clean then the PREP deadline may occur much 
> > sooner than expected).
> > 
> > And pmqos would only care about worst_wakeup_latency.
> > 
> > So... I hope this is useful.  I think the above ascii art could be part 
> > of your documentation to explain it all.
> 
> I will, it makes perfect sense, let me point out a couple of things:
> 
> 1) we need 4 properties, 1 optional (worst_wakeup_latency, if not
>    present defaults to entry+exit)
> 2) is everyone ok, given these definitions, in sorting idle states using
>    min-residency-us as a rank ?

Yes.

> 3) CPUidle:
>    idle_state.exit_latency = worst-wakeup-latency
>    idle_state.target_residency = min-residency-us

But exit_latency is not necessarily equal to worst-wakeup-latency.  
We'll need any of those 4 values depending on the context.  So I'd add 
entry_latency and worst_wakeup_latency to struct cpuidle_state.  If a 
driver doesn't initialize entry_latency then it can be left to 0, and if 
worst_wakeup_latency is 0 then it should be set to entry_latency + 
exit_latency by the core code.

> 4) PREP (longest period) can be obtained from the other properties, IF it is
>    needed
>    PREP = (entry + exit) - worst_wakeup (if worst_wakeup omitted, PREP = 0)

Sure.  However I'd avoid documenting it.  As I said this period cannot 
be relied upon because it can vary a lot and if you miss its deadline 
you're up for a much longer delay than expected.  It is useful if a 
wake-up event happens during that period and then the latency can be cut 
short opportunistically. But if we get to the point we need to rely on 
this period to improve things then it would be a good idea to question 
why we need to request and immediately abort a state so often to start 
with.


Nicolas
