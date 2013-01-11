From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 11 Jan 2013 14:31:01 +0000
Subject: [PATCHv2 06/11] arm: arch_timer: factor out register accessors
In-Reply-To: <50F01456.3030001@ti.com>
References: <1357747640-18594-1-git-send-email-mark.rutland@arm.com>
 <1357747640-18594-7-git-send-email-mark.rutland@arm.com>
 <50F01456.3030001@ti.com>
Message-ID: <20130111143101.GC19765@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 01:32:06PM +0000, Santosh Shilimkar wrote:
> On Wednesday 09 January 2013 09:37 PM, Mark Rutland wrote:
> > Currently the arch_timer register accessors are thrown together with
> > the main driver, preventing us from porting the driver to other
> > architectures.
> >
> > This patch moves the register accessors into a header file, as with
> > the arm64 version. Constants required by the accessors are also moved.
> >
> > Additionally isbs are added in arch_timer_get_cnt{v,p}ct to prevent
> > the cpu from speculating the reads and returning stale values.
> >
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> >   arch/arm/include/asm/arch_timer.h |  101 +++++++++++++++++++++++++++++++++++++
> >   arch/arm/kernel/arch_timer.c      |   92 ---------------------------------
> >   2 files changed, 101 insertions(+), 92 deletions(-)
> >
> > diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
> > index d40229d..701f2b7 100644
> > --- a/arch/arm/include/asm/arch_timer.h
> > +++ b/arch/arm/include/asm/arch_timer.h
> > @@ -1,13 +1,114 @@
> >   #ifndef __ASMARM_ARCH_TIMER_H
> >   #define __ASMARM_ARCH_TIMER_H
> >
> > +#include <asm/barrier.h>
> >   #include <asm/errno.h>
> > +
> >   #include <linux/clocksource.h>
> > +#include <linux/types.h>
> >
> >   #ifdef CONFIG_ARM_ARCH_TIMER
> >   int arch_timer_of_register(void);
> >   int arch_timer_sched_clock_init(void);
> >   struct timecounter *arch_timer_get_timecounter(void);
> > +
> > +#define ARCH_TIMER_CTRL_ENABLE		(1 << 0)
> > +#define ARCH_TIMER_CTRL_IT_MASK		(1 << 1)
> > +#define ARCH_TIMER_CTRL_IT_STAT		(1 << 2)
> > +
> > +#define ARCH_TIMER_REG_CTRL		0
> > +#define ARCH_TIMER_REG_TVAL		1
> > +
> > +#define ARCH_TIMER_PHYS_ACCESS		0
> > +#define ARCH_TIMER_VIRT_ACCESS		1
> > +
> > +/*
> > + * These register accessors are marked inline so the compiler can
> > + * nicely work out which register we want, and chuck away the rest of
> > + * the code. At least it does so with a recent GCC (4.6.3).
> > + */
> > +static inline void arch_timer_reg_write(const int access, const int reg, u32 val)
> > +{
> > +	if (access == ARCH_TIMER_PHYS_ACCESS) {
> > +		switch (reg) {
> > +		case ARCH_TIMER_REG_CTRL:
> > +			asm volatile("mcr p15, 0, %0, c14, c2, 1" : : "r" (val));
> > +			break;
> > +		case ARCH_TIMER_REG_TVAL:
> > +			asm volatile("mcr p15, 0, %0, c14, c2, 0" : : "r" (val));
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (access == ARCH_TIMER_VIRT_ACCESS) {
> > +		switch (reg) {
> > +		case ARCH_TIMER_REG_CTRL:
> > +			asm volatile("mcr p15, 0, %0, c14, c3, 1" : : "r" (val));
> > +			break;
> > +		case ARCH_TIMER_REG_TVAL:
> > +			asm volatile("mcr p15, 0, %0, c14, c3, 0" : : "r" (val));
> > +			break;
> > +		}
> > +	}
> > +
> > +	isb();
> > +}
> The isb() additions is actually a sepoerate fix. I suggest you to split
> the subject patch into 1) Movement of header data 2) isb() additions.
> 
> Feel free to add my ack on updated patches if you agree.

Thanks, will do.

> Regards,
> Santosh
> 
> 

Mark.
