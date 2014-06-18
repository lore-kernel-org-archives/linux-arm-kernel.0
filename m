From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 18 Jun 2014 17:03:47 -0400 (EDT)
Subject: [PATCH v4 1/6] Documentation: arm: define DT idle states bindings
In-Reply-To: <20140618173648.GB31573@e102568-lin.cambridge.arm.com>
References: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1402503520-8611-2-git-send-email-lorenzo.pieralisi@arm.com>
 <alpine.LFD.2.11.1406111240010.25775@knanqh.ubzr>
 <20140613164954.GA16745@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1406131306160.25775@knanqh.ubzr>
 <20140618173648.GB31573@e102568-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.11.1406181436170.16842@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Jun 2014, Lorenzo Pieralisi wrote:

> On Fri, Jun 13, 2014 at 06:33:35PM +0100, Nicolas Pitre wrote:
> > On Fri, 13 Jun 2014, Lorenzo Pieralisi wrote:
> > 
> > > On Wed, Jun 11, 2014 at 07:15:16PM +0100, Nicolas Pitre wrote:
> > > > Let's illustrate the different periods on a time line to make it clearer
> > > > (hmmm let's see how this can be managed on a braille display :-O ):
> > > > 
> > > > EXEC:	Normal CPU execution.
> > > > 
> > > > PREP:	Preparation phase before committing the hardware to idle mode
> > > > 	like cache flushing. This is abortable on pending wake-up 
> > > > 	event conditions. The abort latency is assumed to be negligible 
> > > > 	(i.e. less than the ENTRY + EXIT duration). If aborted, we go 
> > > > 	back to EXEC. This phase is optional. If not abortable, this 
> > > > 	should be included in the ENTRY phase instead.
> > > > 
> > > > ENTRY:	The hardware is committed to idle mode. This period must run to
> > > > 	completion up to IDLE before anything else can happen.
> > > > 
> > > > IDLE:	This is the actual power-saving idle period. This may last 
> > > > 	between 0 and infinite time, until a wake-up event occurs.
> > > > 
> > > > EXIT:	Period during which the CPU is brought back to operational
> > > > 	mode (EXEC).
> > > > 
> > > > ...__[EXEC]__|__[PREP]--|__[ENTRY]__|__[IDLE]__|___[EXIT]_--|__[EXEC]__...
> > > >              |          |           |          |            |
> > > > 
> > > >              |<-- entry-latency --->|
> > > > 
> > > >                                                |<- exit-  ->|
> > > >                                                |  latency   |
> > > > 
> > > >              |<-------------- min-residency --------------->|
> > > > 
> > > >                         |<----- worst_wakeup_latency ------>|
> > > > 
> > > > entry-latency: Worst case latency required to enter the idle state.  The 
> > > > exit_latency may be guaranteed only after entry-latency has passed.
> > > > 
> > > > min-residency: Minimum period, including preparation, entry and exit, 
> > > > for a given power mode to be worthwhile energy wise.  It must be at 
> > > > least equal to entry_latency + exit_latency.
> 
> Ok, a minor tweak to the diagram above, min-residency should include
> energy costs related to idle entry and exit, but not the exit-latency
> itself, as long as the energy costs implied by exiting the state are
> factored out in the min-residency-us property.

s/factored out /factored in/

> Hence, to sum it up, I attached below the updated bindings patch:
> 
> I think we are close to an agreement, if anyone disagrees please shout
> as soon as possible so that we can still integrate changes.

Comments:

[...]

> +- state node
> +
> +	Description: must be child of the idle-states node
> +
> +	The state node name shall follow standard device tree naming
> +	rules ([5], 2.2.1 "Node names"), in particular state nodes which
> +	are siblings within a single common parent must be given a unique name.
> +
> +	The idle state entered by executing the wfi instruction (idle_standby
> +	SBSA,[3][4]) is considered standard on all ARM platforms and therefore
> +	must not be listed.
> +
> +	To correctly specify idle states timing and energy related properties,
> +	the following definitions identify the different execution phases
> +	a CPU goes through to enter and exit idle states and the implied
> +	energy metrics:
> +
> +	..__[EXEC]__|__[PREP]__|__[ENTRY]__|__[IDLE]__|__[EXIT]__|__[EXEC]__..
> +		    |          |           |          |          |
> +
> +		    |<------ entry ------->|
> +		    |       latency        |
> +						      |<- exit ->|
> +						      |  latency |
> +		    |<-------- min-residency -------->|
> +			       |<-------  wakeup-latency ------->|
> +
> +	EXEC:	Normal CPU execution.
> +
> +	PREP:	Preparation phase before committing the hardware to idle mode
> +		like cache flushing. This is abortable on pending wake-up
> +		event conditions. The abort latency is assumed to be negligible
> +		(i.e. less than the ENTRY + EXIT duration). If aborted, CPU
> +		goes back to EXEC. This phase is optional. If not abortable,
> +		this should be included in the ENTRY phase instead.
> +
> +	ENTRY:	The hardware is committed to idle mode. This period must run
> +		to completion up to IDLE before anything else can happen.
> +
> +	IDLE:	This is the actual energy-saving idle period. This may last
> +		between 0 and infinite time, until a wake-up event occurs.
> +
> +	EXIT:	Period during which the CPU is brought back to operational
> +		mode (EXEC).
> +
> +	With the definitions provided above, the following list represents
> +	the valid properties for a state node:
[...]

I really think the definitions and timing diagram ought to be 
prominently presented at the beginning of the document in a separate 
section for it rather than being burried in a binding section.  Extra 
discussion points from this thread could go there as well, i.e. the 
reason for each timing parameter, etc.  The latest comment from Santosh 
shows that this is never too clear.

For example, your explanation of what the min residency represents at 
the top of this email should belong to such a section.  Similarly for 
the worst wake-up latency.

Then we could refer to it when defining binding parameters.


Nicolas
