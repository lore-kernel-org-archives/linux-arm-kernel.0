From: dianders@chromium.org (Doug Anderson)
Date: Mon, 26 Nov 2018 19:52:27 -0800
Subject: [PATCH v4 2/4] kgdb: Fix kgdb_roundup_cpus() for arches who used
 smp_call_function()
In-Reply-To: <20181114220744.GB4044@brain-police>
References: <20181112182659.245726-1-dianders@chromium.org>
 <20181112182659.245726-3-dianders@chromium.org>
 <20181114220744.GB4044@brain-police>
Message-ID: <CAD=FV=WYa8Hfo0hN8eqTBsjGY7A0nnQBoG1nSrvQ92we+v5kuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Nov 14, 2018 at 2:07 PM Will Deacon <will.deacon@arm.com> wrote:
>
> > +void __weak kgdb_call_nmi_hook(void *ignored)
> > +{
> > +     kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
> > +}
>
> I suppose you could pass the cpu as an argument, but it doesn't really
> matter.

I probably won't change it for now if it doesn't matter...


> Also, I think there are cases where the CSD callback can run without
> having received an IPI, so we could potentially up passing NULL for the regs
> here which probably goes boom.

Hrm, good point.  This is not a new issue so I'd tend to add it to the
TODO list rather than block the series.  I'll also add a comment in
the code since I'm touching it anyway.

Interestingly enough quite a bit of things continue to work just fine
even if this is NULL.  I simulated setting this to NULL for all CPUs
and I could drop into the debugger, type "btc" to backtrace all CPUs,
attach to kgdb, etc.  ...but when I typed "cpu 1" it went boom.  So it
seems like parts of kdb use this but definitely not everything.

Also interesting is that on MIPS this is always NULL.  I have no idea
why but my patch series preserves this oddity.  Presumably if someone
was on a SMP MIPS machine and did "cpu 1" from kdb they'd go boom too.

In general kdb has a lot of crufty stuff like this in it.  We need to
work to get rid of the cruft but one step at a time I think.

I've started a kgdb-wishlist:

https://bugs.chromium.org/p/chromium/issues/list?q=label%3Akgdb-wishlist

...and this is crbug.com/908723


> > +void __weak kgdb_roundup_cpus(void)
> > +{
> > +     call_single_data_t *csd;
> > +     int this_cpu = get_cpu();
>
> Do you actually need to disable preemption here? afaict, irqs are already
> disabled by the kgdb core.

Ah, right.  I can just use raw_smp_processor_id().  Done.  I didn't
try to see if I could use smp_processor_id() since
kgdb_call_nmi_hook() already used raw_smp_processor_id(), but I can
dig if you wish.


> > +     int cpu;
> > +
> > +     for_each_cpu(cpu, cpu_online_mask) {
>
> for_each_online_cpu(cpu) ?

Done.


> I'm assuming this is serialised wrt CPU hotplug somehow?

I doubt it.  I can add it to my wishlist (crbug.com/908722) , but I
don't think it's something I'm going to try to solve right now and
it's definitely not new.  I think we need to make some sort of attempt
in kgdb_cpu_enter() to stop hotplugging, though we'd have to take into
account that we may be entering kgdb in an IRQ context so it might be
hard to grab a mutex.  We need to account for it there since that
function has code like:

> while (kgdb_do_roundup && --time_left &&
>        (atomic_read(&masters_in_kgdb) + atomic_read(&slaves_in_kgdb)) !=
>    online_cpus)
> udelay(1000);

...and that would also be broken if cpus were plugging / unplugging.

In general, at least, the worst case would be that we'd either have an
extra 1 second delay entering the debugger (because we were waiting
for a CPU to respond that's been hotplugged) or we'd enter kgdb
without stopping one of the CPUs.  Neither of those is ideal but I
don't think we'd end up in too bad shape.

Oh, but actually, I guess I should probably check the error return of
smp_call_function_single_async() and if it returns an error I should
unset rounding_up...  That would make things behave slightly better
and is probably right anyway.


Overall: thank you very much for the review and the feedback.  Sorry
I'm not really fixing everything here.  My hope is to move things to a
slightly better state but I don't have time to fix everything.
Hopefully I can find some more time soon to fix more, or perhaps
someone else will.


-Doug
