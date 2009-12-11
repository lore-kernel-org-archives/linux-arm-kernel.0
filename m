From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Dec 2009 17:17:59 -0000
Subject: [PATCH 1/4] arm: provide a mechanism to reserve
	performance	counters
In-Reply-To: <20091211154147.GA17176@wear.picochip.com>
References: <000201ca7a76$fdc9f080$f95dd180$@deacon@arm.com>
	<20091211154147.GA17176@wear.picochip.com>
Message-ID: <000301ca7a85$e38e18e0$aaaa4aa0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Jamie Iles [mailto:jamie.iles at picochip.com]
> Sent: 11 December 2009 15:42

> > What do you think?
> That sounds like a good plan. How about something like this?
> 
> #define MAX_PMU_IRQS	8   /* Maximum number of IRQs for the PMU(s). */
> struct pmu_irqs {
> 	int	    irqs[MAX_PMU_IRQS];
> 	unsigned    num_irqs;
> };
> 
> /**
>  * reserve_pmu() - reserve the hardware performance counters
>  *
>  * Reserve the hardware performance counters in the system for exclusive use.
>  * The 'struct pmu_irqs' for the system is returned on success, ERR_PTR()
>  * encoded error on failure.
>  */
> struct pmu_irqs *
> reserve_pmu(void);
> 
> /**
>  * release_pmu() - Relinquish control of the performance counters
>  *
>  * Release the performance counters and allow someone else to use them.
>  * Callers must have disabled the counters and released IRQs before calling
>  * this. The 'struct pmu_irqs' returned from reserve_pmu() must be passed as
>  * a cookie.
>  */
> void
> release_pmu(struct pmu_irqs *irqs);

That looks good to me. This allows SMP systems to set the affinity of the PMU
IRQs too if need be - or should this also be done here? It might also be worth making
the returned struct const to stop people poking, but I'm not sure.

I've got some oprofile patches which I hope to post soon - I'll put a note in the
covering letter to say they should be modified to use these PMU functions when they make
it in.

Will
