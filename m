From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Dec 2009 17:34:38 -0000
Subject: [PATCH 1/4] arm: provide a mechanism to reserve
	performance	counters
In-Reply-To: <20091211173012.GK4164@wear.picochip.com>
References: <20091211154147.GA17176@wear.picochip.com>
	<000301ca7a85$e38e18e0$aaaa4aa0$@deacon@arm.com>
	<20091211173012.GK4164@wear.picochip.com>
Message-ID: <000401ca7a88$370adc40$a52094c0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Jamie Iles [mailto:jamie.iles at picochip.com]
> Sent: 11 December 2009 17:30

> I was just looking at that. I've changed all of the oprofile models but I'm
> not sure what to do for mpcore as it also has the SCU and the setup. How about
> I also add the following calls?
> 
> /* Reserve the SCU in the same manner as the PMU. */
> struct pmu_irqs *reserve_scu(void):
> 
> /* Release the SCU in the same manner as the PMU. */
> void release_scu(struct pmu_irqs *);
> 
> /* Initialise the PMU. For SMP systems this will be setting the IRQ affinity.
>  * For other systems this may be a nop. */
> int init_pmu(void);
> 
> /* Initialise the SCU. For SMP systems this will be setting the IRQ affinity.
>  * For other systems this may be a nop. */
> int init_scu(void);

I'm not sure I like that as much since the SCU is only explicitly used for v6 profiling.
In v7, the SCU events are accessed and programmed via the PMU interface. Additionally, the
SCU is parameterised by its base address as well as its interrupts.

Perhaps you could add it with #ifdef CONFIG_CPU_V6 around the SCU functions and then
perf and oprofile can use the functions only when they are actually needed.

Will
