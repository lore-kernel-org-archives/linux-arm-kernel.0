From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 29 Nov 2012 10:48:30 -0500 (EST)
Subject: [PATCH v2] ARM: implement optimized percpu variable access
In-Reply-To: <50B77B99.6070701@gmail.com>
References: <1354200764-23751-1-git-send-email-robherring2@gmail.com>
 <20121129150509.GB19866@mudshark.cambridge.arm.com>
 <50B77B99.6070701@gmail.com>
Message-ID: <alpine.LFD.2.02.1211291046160.4576@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 29 Nov 2012, Rob Herring wrote:

> 
> 
> On 11/29/2012 09:05 AM, Will Deacon wrote:
> > Hi Rob,
> > 
> > Thanks for the v2. One comment inline...
> > 
> > On Thu, Nov 29, 2012 at 02:52:44PM +0000, Rob Herring wrote:
> >> From: Rob Herring <rob.herring@calxeda.com>
> >>
> >> Use the previously unused TPIDRPRW register to store percpu offsets.
> >> TPIDRPRW is only accessible in PL1, so it can only be used in the kernel.
> >>
> >> This replaces 2 loads with a mrc instruction for each percpu variable
> >> access. With hackbench, the performance improvement is 1.4% on Cortex-A9
> >> (highbank). Taking an average of 30 runs of "hackbench -l 1000" yields:
> >>
> >> Before: 6.2191
> >> After: 6.1348
> >>
> >> Will Deacon reported similar delta on v6 with 11MPCore.
> >>
> >> The asm "memory" constraints are needed here to ensure the percpu offset
> >> gets reloaded. Testing by Will found that this would not happen in
> >> __schedule() which is a bit of a special case as preemption is disabled
> >> but the execution can move cores.
> >>
> >> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> >> Acked-by: Will Deacon <will.deacon@arm.com>
> >> ---
> >> Changes in v2:
> >> - Add asm "memory" constraint
> >> - Only enable on v6K and v7 and avoid enabling for v6 SMP_ON_UP
> >> - Fix missing initialization of TPIDRPRW for resume path
> >> - Move cpu_init to beginning of secondary_start_kernel to ensure percpu
> >>   variables can be accessed as early as possible.
> > 
> > [...]
> > 
> >> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> >> index fbc8b26..aadcca7 100644
> >> --- a/arch/arm/kernel/smp.c
> >> +++ b/arch/arm/kernel/smp.c
> >> @@ -296,6 +296,8 @@ asmlinkage void __cpuinit secondary_start_kernel(void)
> >>  	struct mm_struct *mm = &init_mm;
> >>  	unsigned int cpu;
> >>  
> >> +	cpu_init();
> >> +
> >>  	/*
> >>  	 * The identity mapping is uncached (strongly ordered), so
> >>  	 * switch away from it before attempting any exclusive accesses.
> >> @@ -315,7 +317,6 @@ asmlinkage void __cpuinit secondary_start_kernel(void)
> >>  
> >>  	printk("CPU%u: Booted secondary processor\n", cpu);
> >>  
> >> -	cpu_init();
> >>  	preempt_disable();
> >>  	trace_hardirqs_off();
> > 
> > It's really not safe moving the cpu_init that early because we're running
> > strongly ordered at that point, so locks aren't working.
> 
> I'll drop this hunk. Nicolas had concerns, but I've checked all the
> functions prior to cpu_init and don't see any percpu variable accesses.

Be defensive in your code my friend.  It is not because there is none 
today that this won't happen ever.

> It could be an issue if we made current be a percpu var like x86-64, but
> I don't see any advantage to doing that.

Maybe someone else will have another use for it.  You never know.


Nicolas
