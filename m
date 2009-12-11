From: jamie.iles@picochip.com (Jamie Iles)
Date: Fri, 11 Dec 2009 15:41:47 +0000
Subject: [PATCH 1/4] arm: provide a mechanism to reserve performance
	counters
In-Reply-To: <000201ca7a76$fdc9f080$f95dd180$@deacon@arm.com>
References: <000201ca7a76$fdc9f080$f95dd180$@deacon@arm.com>
Message-ID: <20091211154147.GA17176@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2009 at 03:31:21PM -0000, Will Deacon wrote:
> * Jamie Iles <jamie.iles@picochip.com> wrote:
> 
> > To add support for perf events and to allow the hardware
> > counters to be shared with oprofile, we need a way to reserve
> > access to the pmu (performance monitor unit).
> >
> > Signed-off-by: Jamie Iles <jamie.iles <at> picochip.com>
> > ---
> > arch/arm/include/asm/pmu.h |   54 ++++++++++++++++++++++++++++++++++++++++++++
> > arch/arm/kernel/Makefile   |    1 +
> > arch/arm/kernel/pmu.c      |   32 ++++++++++++++++++++++++++
> > arch/arm/mm/Kconfig        |    4 +++
> > 4 files changed, 91 insertions(+), 0 deletions(-)
> > create mode 100644 arch/arm/include/asm/pmu.h
> > create mode 100644 arch/arm/kernel/pmu.c
> 
> Hi Jamie,
> 
> I like the idea of having a separate file for reserving the PMU across subsystems.
> I also think it would be neat to extend it to request the relevant IRQs (or at
> least return the PMU IRQs) once you've got it reserved.
> 
> This way, there will be no need to duplicate the inevitable collection of machine 
> #ifdefs across tools [such as oprofile and perf]. It would also ensure that you can't 
> reserve the PMU if somebody else has claimed the IRQs [and similarly, you can't
> release it without giving them up].
> 
> What do you think?
That sounds like a good plan. How about something like this?

#define MAX_PMU_IRQS	8   /* Maximum number of IRQs for the PMU(s). */
struct pmu_irqs {
	int	    irqs[MAX_PMU_IRQS];
	unsigned    num_irqs;
};

/**
 * reserve_pmu() - reserve the hardware performance counters
 *
 * Reserve the hardware performance counters in the system for exclusive use.
 * The 'struct pmu_irqs' for the system is returned on success, ERR_PTR()
 * encoded error on failure.
 */
struct pmu_irqs *
reserve_pmu(void);

/**
 * release_pmu() - Relinquish control of the performance counters
 *
 * Release the performance counters and allow someone else to use them.
 * Callers must have disabled the counters and released IRQs before calling
 * this. The 'struct pmu_irqs' returned from reserve_pmu() must be passed as
 * a cookie.
 */
void
release_pmu(struct pmu_irqs *irqs);

Jamie
