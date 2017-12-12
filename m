From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Tue, 12 Dec 2017 11:31:37 -0800
Subject: [PATCH] ARM: CPU hotplug: Delegate complete() to surviving CPU
In-Reply-To: <20171212174046.gn4t3qeck3bq7scw@tarshish>
References: <20171212172059.GA11875@linux.vnet.ibm.com>
 <20171212174046.gn4t3qeck3bq7scw@tarshish>
Message-ID: <20171212193137.GF7829@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 12, 2017 at 07:40:46PM +0200, Baruch Siach wrote:
> Hi Paul,
> 
> On Tue, Dec 12, 2017 at 09:20:59AM -0800, Paul E. McKenney wrote:
> > The ARM implementation of arch_cpu_idle_dead() invokes complete(), but
> > does so after RCU has stopped watching the outgoing CPU, which results
> > in lockdep complaints because complete() invokes functions containing RCU
> > readers.  This patch therefore uses Thomas Gleixner's trick of delegating
> > the complete() call to a surviving CPU via smp_call_function_single().
> > 
> > Reported-by: Peng Fan <van.freenix@gmail.com>
> > Reported-by: Russell King - ARM Linux <linux@armlinux.org.uk>
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Tested-by: Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Fabio reported only once, though he might have tested twice.

Actually, he did test twice.  Apparently this patch has problems
with CONFIG_BL_SWITCHER=y kernels.

But yes, I guess I did get a bit carried away with the Tested-by's,
didn't I?  ;-)

							Thanx, Paul

> baruch
> 
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: <linux-arm-kernel@lists.infradead.org>
> > 
> > diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> > index b4fbf00ee4ad..75f85e20aafa 100644
> > --- a/arch/arm/kernel/smp.c
> > +++ b/arch/arm/kernel/smp.c
> > @@ -267,6 +267,14 @@ void __cpu_die(unsigned int cpu)
> >  }
> >  
> >  /*
> > + * Invoke complete() on behalf of the outgoing CPU.
> > + */
> > +static void arch_cpu_idle_dead_complete(void *arg)
> > +{
> > +	complete(&cpu_died);
> > +}
> > +
> > +/*
> >   * Called from the idle thread for the CPU which has been shutdown.
> >   *
> >   * Note that we disable IRQs here, but do not re-enable them
> > @@ -293,9 +301,11 @@ void arch_cpu_idle_dead(void)
> >  	/*
> >  	 * Tell __cpu_die() that this CPU is now safe to dispose of.  Once
> >  	 * this returns, power and/or clocks can be removed at any point
> > -	 * from this CPU and its cache by platform_cpu_kill().
> > +	 * from this CPU and its cache by platform_cpu_kill().  We cannot
> > +	 * call complete() this late, so we delegate it to an online CPU.
> >  	 */
> > -	complete(&cpu_died);
> > +	smp_call_function_single(cpumask_first(cpu_online_mask),
> > +				 arch_cpu_idle_dead_complete, NULL, 0);
> >  
> >  	/*
> >  	 * Ensure that the cache lines associated with that completion are
> 
> -- 
>      http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
>    - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
> 
