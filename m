From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 11 Dec 2009 18:07:02 +0000
Subject: [PATCH 1/4] arm: provide a mechanism to reserve performance
	counters
In-Reply-To: <000401ca7a88$370adc40$a52094c0$@deacon@arm.com>
References: <20091211154147.GA17176@wear.picochip.com>
	<20091211173012.GK4164@wear.picochip.com>
	<000401ca7a88$370adc40$a52094c0$@deacon@arm.com>
Message-ID: <20091211180702.GL4164@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2009 at 05:34:38PM -0000, Will Deacon wrote:
> > From: Jamie Iles [mailto:jamie.iles at picochip.com]
> > Sent: 11 December 2009 17:30
> 
> > I was just looking at that. I've changed all of the oprofile models but I'm
> > not sure what to do for mpcore as it also has the SCU and the setup. How about
> > I also add the following calls?
> > 
> > /* Reserve the SCU in the same manner as the PMU. */
> > struct pmu_irqs *reserve_scu(void):
> > 
> > /* Release the SCU in the same manner as the PMU. */
> > void release_scu(struct pmu_irqs *);
> > 
> > /* Initialise the PMU. For SMP systems this will be setting the IRQ affinity.
> >  * For other systems this may be a nop. */
> > int init_pmu(void);
> > 
> > /* Initialise the SCU. For SMP systems this will be setting the IRQ affinity.
> >  * For other systems this may be a nop. */
> > int init_scu(void);
> 
> I'm not sure I like that as much since the SCU is only explicitly used for v6 profiling.
> In v7, the SCU events are accessed and programmed via the PMU interface. Additionally, the
> SCU is parameterised by its base address as well as its interrupts.
> 
> Perhaps you could add it with #ifdef CONFIG_CPU_V6 around the SCU functions and then
> perf and oprofile can use the functions only when they are actually needed.
Ok, I agree with you on that. Actually, the only v6 SMP system that uses the
SCU in mainline is realview. My patches for perf events only use the PMU so
the only user of the SCU is oprofile so lets leave it where it is. If someone
else adds support for the SCU in the perf events code then we can revisit this
later.

I'll make the {reserve,release}_pmu() functions take/return const pointers and
I'll add the init_pmu() call for setting the IRQ affinity as the perf events
code will need this too. 

Jamie
