From: jamie.iles@picochip.com (Jamie Iles)
Date: Fri, 11 Dec 2009 17:30:12 +0000
Subject: [PATCH 1/4] arm: provide a mechanism to reserve performance
	counters
In-Reply-To: <000301ca7a85$e38e18e0$aaaa4aa0$@deacon@arm.com>
References: <20091211154147.GA17176@wear.picochip.com>
	<000301ca7a85$e38e18e0$aaaa4aa0$@deacon@arm.com>
Message-ID: <20091211173012.GK4164@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2009 at 05:17:59PM -0000, Will Deacon wrote:
> That looks good to me. This allows SMP systems to set the affinity of the PMU
> IRQs too if need be - or should this also be done here? It might also be worth making
> the returned struct const to stop people poking, but I'm not sure.
> 
> I've got some oprofile patches which I hope to post soon - I'll put a note in the
> covering letter to say they should be modified to use these PMU functions when they make
> it in.
I was just looking at that. I've changed all of the oprofile models but I'm
not sure what to do for mpcore as it also has the SCU and the setup. How about
I also add the following calls?

/* Reserve the SCU in the same manner as the PMU. */
struct pmu_irqs *reserve_scu(void):

/* Release the SCU in the same manner as the PMU. */
void release_scu(struct pmu_irqs *);

/* Initialise the PMU. For SMP systems this will be setting the IRQ affinity.
 * For other systems this may be a nop. */
int init_pmu(void);

/* Initialise the SCU. For SMP systems this will be setting the IRQ affinity.
 * For other systems this may be a nop. */
int init_scu(void);

Jamie
