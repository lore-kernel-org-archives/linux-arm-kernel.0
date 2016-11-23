From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 23 Nov 2016 17:18:46 +0000
Subject: System/uncore PMUs and unit aggregation
In-Reply-To: <20161118111017.GA22798@hardcore>
References: <20161117181708.GT22855@arm.com> <20161118111017.GA22798@hardcore>
Message-ID: <20161123171846.GP24624@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2016 at 12:10:17PM +0100, Jan Glauber wrote:
> On Thu, Nov 17, 2016 at 06:17:08PM +0000, Will Deacon wrote:

> > Speaking to Mark earlier today, we came up with the following rough rules
> > for drivers that present multiple hardware units as a single PMU:
> > 
> >   1. If the units share some part of the programming interface (e.g. control
> >      registers or interrupts), then they must be handled by the same PMU.
> >      Otherwise, they should be treated independently as separate PMU
> >      instances.
> 
> Can you elaborate why they should be treated independent in the later
> case? What is the problem with going through a list and writing the
> control register per unit?

For one thing, event groups spanning those units cannot be scheduled
atomically (some events would be counting while others were not),
violating group semantics.

> >   3. Summing the counters across units is only permitted if the units
> >      can all be started and stopped atomically. Otherwise, the counters
> >      should be exposed individually. It's up to the driver author to
> >      decide what makes sense to sum.
> 
> Do you mean started/stopped atomically across units?

Yes. If some units are counting while others are not, values can be
skewed, and therefore potentially misleading.

> > For Cavium ThunderX, it's not clear whether or not the individual units
> > could be expressed as separate PMUs, or whether they're caught by one of
> > the rules above. The Qualcomm L2 looks like it's doing the right thing
> > and we can't quite work out what the Hisilicon Hip0x topology looks like,
> > since the interaction with djtag is confusing.
> 
> On Cavium ThunderX the current patches add 4 PMU types, which unfortunately
> are all handled different. The L2C-TAD and OCX-TLK have control
> registers per unit. The LMC and L2C-CBC don't have control registers,
> (free-running counters). So rule 1 might be too restrictive.
> 
> I've not looked into groups, would these allow to merge counters from
> different PMUs in the kernel?

No; event groups are strictly single PMU, with the sole exception that
software events may be placed inside a hardware event group (since
there's no start/stop logic required for SW events).

Thanks,
Mark.
