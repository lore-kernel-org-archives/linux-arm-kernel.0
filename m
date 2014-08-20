From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 20 Aug 2014 11:48:50 +0100
Subject: [PATCH] Arm64: convert soft_restart() to assembly code
In-Reply-To: <CAMJs5B9iCKBsSSbXvX6Y+QpOcUgEVtjBcWkcLonu3761_BkPsg@mail.gmail.com>
References: <1407847365-10873-1-git-send-email-achandran@mvista.com>
 <1408123221.22761.38.camel@smoke>
 <20140815182157.GD21908@leverpostej>
 <1408128799.22761.47.camel@smoke>
 <20140818160253.GB3302@leverpostej>
 <CAMJs5B9iCKBsSSbXvX6Y+QpOcUgEVtjBcWkcLonu3761_BkPsg@mail.gmail.com>
Message-ID: <20140820104850.GF21174@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 06:33:36PM +0100, Christoffer Dall wrote:
> On Mon, Aug 18, 2014 at 6:02 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > Hi Geoff,
> >
> > On Fri, Aug 15, 2014 at 07:53:19PM +0100, Geoff Levand wrote:
> >> Hi Mark,
> >>
> >> On Fri, 2014-08-15 at 19:21 +0100, Mark Rutland wrote:
> >> > On Fri, Aug 15, 2014 at 06:20:21PM +0100, Geoff Levand wrote:
> >> > > For the cpu-ops shutdown I'm working on I need a call to move the
> >> > > secondary processors to an identity mapped spin loop after the identity
> >> > > map is enabled.  I want to do this in C code, so it needs to happen
> >> > > after the identity map is enabled, and before the dcache is disabled.
> >> > >
> >> > > I think to do this we can keep the existing soft_restart(addr) routine
> >> > > with something like this:
> >> > >
> >> > > void soft_restart(unsigned long addr)
> >> > > {
> >> > >   setup_mm_for_reboot();
> >> > >
> >> > > #if defined(CONFIG_SMP)
> >> > >   smp_secondary_shutdown();
> >> > > #endif
> >> > >
> >> > >   cpu_soft_restart(addr);
> >> > >
> >> > >   /* Should never get here */
> >> > >   BUG();
> >> > > }
> >> > >
> >> >
> >> > I don't follow why you need a hook in the middle of soft_restart. That
> >> > sounds like a layering violation to me.
> >> >
> >> > I assume this is for implementing the spin-table cpu-return-addr idea?
> >>
> >> Yes.
> >>
> >> > If so, what's wrong with something like:
> >>
> >> > void spin_table_cpu_die(unsigned int cpu)
> >> > {
> >> >     unsigned long release_addr = per_cpu(return_addr, cpu);
> >> >
> >> >     /*
> >> >      * We should have a local_disable(DBG|ASYNC|FIQ|IRQ) function or
> >> >      * something similar as these are all context synchronising and
> >> >      * therefore expensive.
> >> >      */
> >> >     local_dbg_disable();
> >> >     local_async_disable();
> >> >     local_fiq_disable();
> >> >     arch_local_irq_disable();
> >> >
> >> >     soft_restart(release_addr);
> >> > }
> >>
> >> OK, this is a much simpler way than what I was thinking, which
> >> was to have the secondaries spin in the kernel until the main
> >> cpu shutdown.  I'll switch over to this, thanks.
> >
> > I just realised that this is still missing the jump to EL2 that I
> > mentioned a while back.
> >
> > I think what we need to do is:
> >
> > * Have KVM (if present) tears itself down prior to cpu_die, restoring
> >   the __hyp_stub_vectors in VBAR_EL2 and disabling the MMU, and caches.
> >
> > * Add a mechanism to __hyp_stub_vectors to allow a hypercall to
> >   call a function at EL2. We should be able to replace the current
> >   hyp_stub el1_sync handler with that, and rework KVM to call a function
> >   at EL2 to setup VBAR_EL2 appropriately at init time.
> >
> Why do you need to change the current mechanism?  Is this due to the
> CPU being in a different state when restarted with the MMU enabled in
> EL2 or something like that?

Something like that, yes.

For hotplug with spin-table we need to return CPUs to the spin-table in
the mode they entered to prevent mismatched modes when we throw those
CPUs back into the kernel. For kexec we need to move the final CPU up to
the mode it started in before we branch to the new kernel. If we don't
do that then we either get mismatched modes or lose the use of EL2.

Whatever mechanism we use for this needs to be independent of KVM. 
Ideally this would be in the hyp_stub vectors and we'd have KVM tear
itself down at EL2 and restore the hyp_stub before we offline a CPU.

I'd rather not have a custom set of EL2 vectors that the spin-table code
has to install via the curent mechanism, so IMO reworking the hyp stub
to implement a simple function call hypercall would be preferable.  KVM
can use that to set up its vectors and the spin-table and kexec code
could use to leave the kernel at EL2.

Cheers,
Mark.
