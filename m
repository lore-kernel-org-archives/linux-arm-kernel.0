From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 20 Aug 2014 11:54:08 +0100
Subject: [PATCH] Arm64: convert soft_restart() to assembly code
In-Reply-To: <CAFdej01kDMSTpzdGiRmX8g=E4mZU2_5oiiKzyQ_z7z1jxeCF-A@mail.gmail.com>
References: <1407847365-10873-1-git-send-email-achandran@mvista.com>
 <1408123221.22761.38.camel@smoke>
 <20140815182157.GD21908@leverpostej>
 <CAFdej01kDMSTpzdGiRmX8g=E4mZU2_5oiiKzyQ_z7z1jxeCF-A@mail.gmail.com>
Message-ID: <20140820105408.GG21174@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 20, 2014 at 11:28:52AM +0100, Arun Chandran wrote:
> Hi Mark,

Hi Arun,

> On Fri, Aug 15, 2014 at 11:51 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > Hi Geoff,
> >
> > On Fri, Aug 15, 2014 at 06:20:21PM +0100, Geoff Levand wrote:
> >> Hi Arun,
> >>
> >> On Tue, 2014-08-12 at 18:12 +0530, Arun Chandran wrote:
> >> > soft_restart() will fail on arm64 systems that does not
> >> > quarantee the flushing of cache to PoC with flush_cache_all().
> >> >
> >> > soft_restart(addr)
> >> > {
> >> >     push_to_stack(addr);
> >> >
> >> >     Do mm setup for restart;
> >> >     Flush&turnoff D-cache;
> >> >
> >> >     pop_from_stack(addr); --> fails here as addr is not at PoC
> >> >     cpu_reset(addr) --> Jumps to invalid address
> >> > }
> >>
> >> For the cpu-ops shutdown I'm working on I need a call to move the
> >> secondary processors to an identity mapped spin loop after the identity
> >> map is enabled.  I want to do this in C code, so it needs to happen
> >> after the identity map is enabled, and before the dcache is disabled.
> >>
> >> I think to do this we can keep the existing soft_restart(addr) routine
> >> with something like this:
> >>
> >> void soft_restart(unsigned long addr)
> >> {
> >>       setup_mm_for_reboot();
> >>
> >> #if defined(CONFIG_SMP)
> >>       smp_secondary_shutdown();
> >> #endif
> >>
> >>       cpu_soft_restart(addr);
> >>
> >>       /* Should never get here */
> >>       BUG();
> >> }
> >>
> >
> > I don't follow why you need a hook in the middle of soft_restart. That
> > sounds like a layering violation to me.
> >
> > I assume this is for implementing the spin-table cpu-return-addr idea?
> >
> > If so, what's wrong with something like:
> >
> > #define ADDR_INVALID ((unsigned long)-1)
> > static DEFINE_PER_CPU(unsigned long, return_addr) = ADDR_INVALID;
> >
> > int spin_table_cpu_disable(unsigned int cpu)
> > {
> >         if (per_cpu(return_addr, cpu) != ADDR_INVALID)
> >                 return 0;
> >
> >         return -EOPNOTSUPP;
> > }
> >
> > void spin_table_cpu_die(unsigned int cpu)
> > {
> >         unsigned long release_addr = per_cpu(return_addr, cpu);
> >
> >         /*
> >          * We should have a local_disable(DBG|ASYNC|FIQ|IRQ) function or
> >          * something similar as these are all context synchronising and
> >          * therefore expensive.
> >          */
> >         local_dbg_disable();
> >         local_async_disable();
> >         local_fiq_disable();
> >         arch_local_irq_disable();
> >
> >         soft_restart(release_addr);
> > }
> >
> 
> I am trying the above method for kexec.
> 
> As of now I have hardcoded cpu-return-addr , which is 0x0 in my
> case.
> 
> ##################
> diff --git a/arch/arm64/kernel/smp_spin_table.c
> b/arch/arm64/kernel/smp_spin_table.c
> index e54ceed..e7275b3 100644
> --- a/arch/arm64/kernel/smp_spin_table.c
> +++ b/arch/arm64/kernel/smp_spin_table.c
> @@ -27,6 +27,7 @@
>  #include <asm/cpu_ops.h>
>  #include <asm/cputype.h>
>  #include <asm/smp_plat.h>
> +#include <asm/system_misc.h>
> 
>  #include "cpu-properties.h"
> 
> @@ -97,7 +98,7 @@ static int smp_spin_table_cpu_prepare(unsigned int cpu)
>          * boot-loader's endianess before jumping. This is mandated by
>          * the boot protocol.
>          */
> -       writeq_relaxed(__pa(secondary_holding_entry), release_addr);
> +       writeq_relaxed(__pa(secondary_holding_pen), release_addr);
>         __flush_dcache_area((__force void *)release_addr,
>                             sizeof(*release_addr));
> 
> @@ -135,18 +136,22 @@ static void smp_spin_table_cpu_die(unsigned int cpu)
>  {
>         u64 *release_addr = phys_to_virt(cpu_release_addr[cpu]);
> 
> -       pr_devel("%s:%d: id: %u, holding count: %lu\n", __func__, __LINE__,
> -               smp_processor_id(), secondary_holding_pen_count);
> +       pr_devel("%s:%d: id: %u dying\n", __func__, __LINE__,
> +               smp_processor_id());
> 
>         /* Send cpu back to secondary_holding_pen. */
> 
> +       local_dbg_disable();    // FIXME: need this???
> +       local_async_disable();  // FIXME: need this???
>         local_fiq_disable();    // FIXME: need this???
> +       arch_local_irq_disable();
> 
>         *release_addr = 0;
> +       __flush_dcache_area(release_addr, 8);
> 
>         mb();
> 
> -       secondary_holding_pen();
> +       soft_restart(0);
> 
>         BUG();
>  }
> ###########################
> 
> I can see that my secondary cpu's are not going to the exact same
> state as they were in when I boot a SMP kernel from u-boot.
> 
> [[They are not waiting for addr(secondary_holding_pen()) at
>  release_addr]]
> 
> Like geoff mentioned in another mail do we need to
> to get back to EL2 before re-entering the bootwrapper program?

As I mentioned we do need to ensure that the CPUs are in the mode they
started in, though I'm not sure I follow what you mean by "not waiting".
This could be an orthogonal issue.

What exactly do you see, do the CPUs leave the spin-table, are they
taking exceptions, are they getting stuck in the spin-table, etc?

Are the cpu-release-addr entries getting restored to zero before each
CPU begins polling them?

Cheers,
Mark.
