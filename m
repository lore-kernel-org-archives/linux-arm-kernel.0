From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 20 Aug 2014 12:21:03 +0100
Subject: [PATCH] Arm64: convert soft_restart() to assembly code
In-Reply-To: <CAMJs5B_gadfJ4Ase1qpCAf5cBytMzMNaLpWugAArgUCvrMq+xw@mail.gmail.com>
References: <1407847365-10873-1-git-send-email-achandran@mvista.com>
 <1408123221.22761.38.camel@smoke>
 <20140815182157.GD21908@leverpostej>
 <1408128799.22761.47.camel@smoke>
 <20140818160253.GB3302@leverpostej>
 <CAMJs5B9iCKBsSSbXvX6Y+QpOcUgEVtjBcWkcLonu3761_BkPsg@mail.gmail.com>
 <20140820104850.GF21174@leverpostej>
 <CAMJs5B_gadfJ4Ase1qpCAf5cBytMzMNaLpWugAArgUCvrMq+xw@mail.gmail.com>
Message-ID: <20140820112102.GA21734@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> >> > I just realised that this is still missing the jump to EL2 that I
> >> > mentioned a while back.
> >> >
> >> > I think what we need to do is:
> >> >
> >> > * Have KVM (if present) tears itself down prior to cpu_die, restoring
> >> >   the __hyp_stub_vectors in VBAR_EL2 and disabling the MMU, and caches.
> >> >
> >> > * Add a mechanism to __hyp_stub_vectors to allow a hypercall to
> >> >   call a function at EL2. We should be able to replace the current
> >> >   hyp_stub el1_sync handler with that, and rework KVM to call a function
> >> >   at EL2 to setup VBAR_EL2 appropriately at init time.
> >> >
> >> Why do you need to change the current mechanism?  Is this due to the
> >> CPU being in a different state when restarted with the MMU enabled in
> >> EL2 or something like that?
> >
> > Something like that, yes.
> >
> > For hotplug with spin-table we need to return CPUs to the spin-table in
> > the mode they entered to prevent mismatched modes when we throw those
> > CPUs back into the kernel. For kexec we need to move the final CPU up to
> > the mode it started in before we branch to the new kernel. If we don't
> > do that then we either get mismatched modes or lose the use of EL2.
> >
> > Whatever mechanism we use for this needs to be independent of KVM.
> > Ideally this would be in the hyp_stub vectors and we'd have KVM tear
> > itself down at EL2 and restore the hyp_stub before we offline a CPU.
> >
> > I'd rather not have a custom set of EL2 vectors that the spin-table code
> > has to install via the curent mechanism, so IMO reworking the hyp stub
> > to implement a simple function call hypercall would be preferable.  KVM
> > can use that to set up its vectors and the spin-table and kexec code
> > could use to leave the kernel at EL2.
> >
> So you'd still always assume the hyp-stub mechanism has the MMU turned
> off at EL2, but just make it easier for callers to deal with,
> essentially.

Yes. I'd only expect this would be used by a few assembly functions that
would assume a very bare EL2 (only expecting what we initialize in
el2_setup). Having a function call hypercall just makes it easier for
callers and prevents a proliferation of temporary EL2 vectors.

> As far as I can tell, there shouldn't be any problems
> converting the hyp-stub API to specify a function to call in EL2
> rather than the current method of replacing the vectors.
> 
> Letting KVM tear itself down and re-establish the hyp-stub API as it
> was at boot time seems completely reasonable to me.

That's exactly what I was hoping to hear. :)

Now the only thing to figure out is what that tear-down hangs off of.

I thought that would go in kvm_arch_hardware_disable, but it doesn't
look like we use either of kvm_arch_hardware_{enable,disable}. I guess
that would fall in the hyp_init_cpu_notify notifier call.

Is there a reason we have our own notifier rather than using the
kvm_arch_hardware_{enable,disable} calls?

Cheers,
Mark.
