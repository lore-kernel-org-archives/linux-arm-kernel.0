From: will.deacon@arm.com (Will Deacon)
Date: Thu, 29 Nov 2012 15:26:52 +0000
Subject: [PATCH v2] ARM: implement optimized percpu variable access
In-Reply-To: <50B77B99.6070701@gmail.com>
References: <1354200764-23751-1-git-send-email-robherring2@gmail.com>
 <20121129150509.GB19866@mudshark.cambridge.arm.com>
 <50B77B99.6070701@gmail.com>
Message-ID: <20121129152651.GC19866@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 29, 2012 at 03:13:29PM +0000, Rob Herring wrote:
> On 11/29/2012 09:05 AM, Will Deacon wrote:
> > On Thu, Nov 29, 2012 at 02:52:44PM +0000, Rob Herring wrote:
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
> It could be an issue if we made current be a percpu var like x86-64, but
> I don't see any advantage to doing that.

I dunno, moving it before printk as Russell suggested is probably a good
idea as that code certainly isn't trivial and could easily tickle per-cpu
accesses in certain configurations.

Will
