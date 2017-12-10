From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Sun, 10 Dec 2017 15:16:51 -0800
Subject: WARNING: suspicious RCU usage
In-Reply-To: <20171210215433.GQ10595@n2100.armlinux.org.uk>
References: <20171210113930.zimywmxzsutwzzmz@linux-u7w5.ap.freescale.net>
 <20171210120012.GM10595@n2100.armlinux.org.uk>
 <20171210190727.GJ7829@linux.vnet.ibm.com>
 <20171210193438.GP10595@n2100.armlinux.org.uk>
 <20171210213930.GL7829@linux.vnet.ibm.com>
 <20171210215433.GQ10595@n2100.armlinux.org.uk>
Message-ID: <20171210231651.GN7829@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 10, 2017 at 09:54:33PM +0000, Russell King - ARM Linux wrote:
> On Sun, Dec 10, 2017 at 01:39:30PM -0800, Paul E. McKenney wrote:
> > On Sun, Dec 10, 2017 at 07:34:39PM +0000, Russell King - ARM Linux wrote:
> > > On Sun, Dec 10, 2017 at 11:07:27AM -0800, Paul E. McKenney wrote:
> > > > On Sun, Dec 10, 2017 at 12:00:12PM +0000, Russell King - ARM Linux wrote:
> > > > > +Paul
> > > > > 
> > > > > Annoyingly, it looks like calling "complete()" from a dying CPU is
> > > > > triggering the RCU usage warning.  From what I remember, this is an
> > > > > old problem, and we still have no better solution for this other than
> > > > > to persist with the warning.
> > > > 
> > > > I thought that this issue was resolved with tglx's use of IPIs from
> > > > the outgoing CPU.  Or is this due to an additional complete() from the
> > > > ARM code?  If so, could it also use tglx's IPI trick?
> > > 
> > > I don't think it was tglx's IPI trick, I've had code sitting in my tree
> > > for a while for it, but it has its own set of problems which are not
> > > resolvable:
> > > 
> > > 1. it needs more IPIs than we have available on all platforms
> > 
> > OK, I will ask the stupid question...  Is it possible to multiplex
> > the IPIs, for example, by using smp_call_function_single()?
> > 
> > > 2. there's some optional locking in the GIC driver that cause problems
> > >    for the cpu dying path.
> > 
> > On this, I must plead ignorance.
> > 
> > > The concensus last time around was that the IPI solution is a non-
> > > starter, so the seven year proven-reliable solution (disregarding the
> > > RCU warning) persists because I don't think anyone came up with a
> > > better solution.
> > 
> > Seven years already?  Sigh, I don't have the heart to check because
> > I wouldn't want to find out that it has actually been longer.  ;-)
> 
> *Sigh* thanks for what you just said, you do realise that you've just
> said that you don't believe what I write in emails?  FFS.  Is there
> any point in continuing to discuss this if that's the case?  Really?

Sorry to have offended you.  I will leave this matter in your hands.

							Thanx, Paul

> commit 3c030beabf937b1d3b4ecaedfd1fb2f1e2aa0c70
> Author: Russell King <rmk+kernel@arm.linux.org.uk>
> Date:   Tue Nov 30 11:07:35 2010 +0000
> 
>     ARM: CPU hotplug: move cpu_killed completion to core code
> 
>     We always need to wait for the dying CPU to reach a safe state before
>     taking it down, irrespective of the requirements of the platform.
>     Move the completion code into the ARM SMP hotplug code rather than
>     having each platform re-implement this.
> 
>     Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index a30c4094db3a..8c81ff9b3732 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -24,6 +24,7 @@
>  #include <linux/irq.h>
>  #include <linux/percpu.h>
>  #include <linux/clockchips.h>
> +#include <linux/completion.h>
> 
>  #include <asm/atomic.h>
>  #include <asm/cacheflush.h>
> @@ -238,12 +239,20 @@ int __cpu_disable(void)
>         return 0;
>  }
> 
> +static DECLARE_COMPLETION(cpu_died);
> +
>  /*
>   * called on the thread which is asking for a CPU to be shutdown -
>   * waits until shutdown has completed, or it is timed out.
>   */
>  void __cpu_die(unsigned int cpu)
>  {
> +       if (!wait_for_completion_timeout(&cpu_died, msecs_to_jiffies(5000))) {
> +               pr_err("CPU%u: cpu didn't die\n", cpu);
> +               return;
> +       }
> +       printk(KERN_NOTICE "CPU%u: shutdown\n", cpu);
> +
>         if (!platform_cpu_kill(cpu))
>                 printk("CPU%u: unable to kill\n", cpu);
>  }
> @@ -263,9 +272,12 @@ void __ref cpu_die(void)
>         local_irq_disable();
>         idle_task_exit();
> 
> +       /* Tell __cpu_die() that this CPU is now safe to dispose of */
> +       complete(&cpu_died);
> +
>         /*
>          * actual CPU shutdown procedure is at least platform (if not
> -        * CPU) specific
> +        * CPU) specific.
>          */
>         platform_cpu_die(cpu);
> 
> 
> So, 30th Nov 2010 to 10th Dec 2017 is seven years, one week and three
> days to be exact.
> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
> According to speedtest.net: 8.21Mbps down 510kbps up
> 
