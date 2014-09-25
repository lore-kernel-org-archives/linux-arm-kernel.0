From: atull@opensource.altera.com (atull)
Date: Thu, 25 Sep 2014 10:06:10 -0500
Subject: [PATCH 1/2] socfpga: hotplug: put cpu1 in wfi
In-Reply-To: <20140924212803.GD5182@n2100.arm.linux.org.uk>
References: <1411590449-9794-1-git-send-email-atull@opensource.altera.com>
 <1411590449-9794-2-git-send-email-atull@opensource.altera.com>
 <20140924212803.GD5182@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.02.1409251002090.693@atx-linux-37>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Sep 2014, Russell King - ARM Linux wrote:

Hi Russell,

> On Wed, Sep 24, 2014 at 03:27:28PM -0500, atull at opensource.altera.com wrote:
> > diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
> > index 5356a72..1d5f8ad 100644
> > --- a/arch/arm/mach-socfpga/platsmp.c
> > +++ b/arch/arm/mach-socfpga/platsmp.c
> > @@ -34,6 +34,10 @@ static int socfpga_boot_secondary(unsigned int cpu, struct task_struct *idle)
> >  	int trampoline_size = &secondary_trampoline_end - &secondary_trampoline;
> >  
> >  	if (cpu1start_addr) {
> > +		/* This will put CPU #1 into reset.*/
> > +		__raw_writel(RSTMGR_MPUMODRST_CPU1,
> > +			     rst_manager_base_addr + 0x10);
> 
> If you can place CPU1 into reset, then why not place it into reset during
> hot unplug?

It's a chip weirdness.  We can reset CPU1 briefly, but if we leave it in
reset, it results in power consumption going up.

> 
> > @@ -86,10 +90,12 @@ static void __init socfpga_smp_prepare_cpus(unsigned int max_cpus)
> >   */
> >  static void socfpga_cpu_die(unsigned int cpu)
> >  {
> > -	cpu_do_idle();
> > +	/* Flush the L1 data cache. */
> > +	flush_cache_all();
> 
> Why do you think that's necessary?
> 
> This potentially flushes *all* levels of the cache, including L2, which
> is not a nice thing to do if you have another CPU running.  Secondly,
> the core code has already called flush_cache_louis() _twice_ for you
> immediately prior to calling your cpu_die() function explicitly to
> remove any L1 data.
> 
> The only data which should remain are speculative prefetches and stack
> data specific to _this_ CPU (which could include dirty cache lines
> associated with the stack frame to enter your cpu_die function.)
> None of these cache lines are of any interest to other CPUs in the
> system, so there's no need for them to be written back prior to the
> CPU being reset or powered down for hot unplug.
> 

Then it's clear we don't need that.  I'll take it out in v2.

Thanks for the review!

Alan
