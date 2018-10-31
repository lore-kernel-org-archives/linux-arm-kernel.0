From: dianders@chromium.org (Doug Anderson)
Date: Wed, 31 Oct 2018 14:41:14 -0700
Subject: [PATCH v2 2/2] kgdb: Fix kgdb_roundup_cpus() for arches who used
 smp_call_function()
In-Reply-To: <20181031184050.sd5opni3mznaapkv@holly.lan>
References: <20181030221843.121254-1-dianders@chromium.org>
 <20181030221843.121254-3-dianders@chromium.org>
 <20181031184050.sd5opni3mznaapkv@holly.lan>
Message-ID: <CAD=FV=V1eHo7Wz31DTMMNi394qwEaESTxJCYVE60Q7hpDEqRmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Oct 31, 2018 at 11:40 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Tue, Oct 30, 2018 at 03:18:43PM -0700, Douglas Anderson wrote:
> > diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> > index f3cadda45f07..9a3f952de6ed 100644
> > --- a/kernel/debug/debug_core.c
> > +++ b/kernel/debug/debug_core.c
> > @@ -55,6 +55,7 @@
> >  #include <linux/mm.h>
> >  #include <linux/vmacache.h>
> >  #include <linux/rcupdate.h>
> > +#include <linux/irq.h>
> >
> >  #include <asm/cacheflush.h>
> >  #include <asm/byteorder.h>
> > @@ -220,6 +221,39 @@ int __weak kgdb_skipexception(int exception, struct pt_regs *regs)
> >       return 0;
> >  }
> >
> > +/*
> > + * Default (weak) implementation for kgdb_roundup_cpus
> > + */
> > +
> > +static DEFINE_PER_CPU(call_single_data_t, kgdb_roundup_csd);
> > +
> > +void __weak kgdb_call_nmi_hook(void *ignored)
> > +{
> > +     kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
> > +}
> > +
> > +void __weak kgdb_roundup_cpus(void)
> > +{
> > +     call_single_data_t *csd;
> > +     int cpu;
> > +
> > +     for_each_cpu(cpu, cpu_online_mask) {
> > +             csd = &per_cpu(kgdb_roundup_csd, cpu);
> > +             smp_call_function_single_async(cpu, csd);
> > +     }
>
> smp_call_function() automatically skips the calling CPU but this code does
> not. It isn't a hard bug since kgdb_nmicallback() does a re-entrancy
> check but I'd still prefer to skip the calling CPU.

I'll incorporate this into the next version.


> As mentioned in another part of the thread we can also add robustness
> by skipping a cpu where csd->flags != 0 (and adding an appropriately
> large comment regarding why). Doing the check directly is abusing
> internal knowledge that smp.c normally keeps to itself so an accessor
> of some kind would be needed.

Sure.  I could add smp_async_func_finished() that just looked like:

int smp_async_func_finished(call_single_data_t *csd)
{
  return !(csd->flags & CSD_FLAG_LOCK);
}

My understanding of all the mutual exclusion / memory barrier concepts
employed by smp.c is pretty weak, though.  I'm hoping that it's safe
to just access the structure and check the bit directly.

...but do you think adding a generic accessor like this is better than
just keeping track of this in kgdb directly?  I could avoid the
accessor by adding a "rounding_up" member to "struct
debuggerinfo_struct" and doing something like this in roundup:

  /* If it didn't round up last time, don't try again */
  if (kgdb_info[cpu].rounding_up)
    continue

  kgdb_info[cpu].rounding_up = true
  smp_call_function_single_async(cpu, csd);

...and then in kgdb_nmicallback() I could just add:

  kgdb_info[cpu].rounding_up = false

In that case we're not adding a generic accessor to smp.c that most
people should never use.


I'll wait to hear back from you if you think the accessor is OK.  It
seems like it might be nice not to have to add something to smp.c just
for this one use case.


> > +}
> > +
> > +static void kgdb_generic_roundup_init(void)
> > +{
> > +     call_single_data_t *csd;
> > +     int cpu;
> > +
> > +     for_each_possible_cpu(cpu) {
> > +             csd = &per_cpu(kgdb_roundup_csd, cpu);
> > +             csd->func = kgdb_call_nmi_hook;
> > +     }
> > +}
>
> I can't help noticing this code is very similar to kgdb_roundup_cpus. Do
> we really gain much from ahead-of-time initializing csd->func?

Oh!  Right...  At first I thought about just trying to put the "csd"
on the stack in kgdb_roundup_cpus() but then I realized that it needed
to persist past the end of kgdb_roundup_cpus().  ...and once I gave up
on the idea of putting it on the stack I decided I needed the init.

...but you're right that I don't really.  The only thing I'm initting
is the function pointer and it totally wouldn't hurt to just init that
over and over again every time kgdb_roundup_cpus() is called.

-Doug
