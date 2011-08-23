From: Ian.Jackson@eu.citrix.com (Ian Jackson)
Date: Tue, 23 Aug 2011 17:38:28 +0100
Subject: [Android-virt] ARM processor mode, kernel startup, Hyp / secure
	state
In-Reply-To: <CANM98qLC2mLvXZwqurZvn-8VBR_KyQdK3Q=icU3k=95KKvJoSg@mail.gmail.com>
References: <20051.48809.945431.800543@mariner.uk.xensource.com>
	<CANM98qLC2mLvXZwqurZvn-8VBR_KyQdK3Q=icU3k=95KKvJoSg@mail.gmail.com>
Message-ID: <20051.55172.517979.705559@mariner.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Christoffer Dall writes ("Re: [Android-virt] ARM processor mode, kernel startup, Hyp / secure state"):
> There are a couple of things with the existing KVM ARM approach with
> the trivial boot wrapper which need to be fixed, though: firstly,
> there should be separate trampolines for hypervisor mode and for
> secure state.  That allows the two features to be used independently.
> Secondly, the trivial trampolines should be part of the kernel proper
> and their lifetime should not extend across the bootloader interface.
> 
> How are you imagining the first point? To have a fixed address and
> being able to issue an HVC instead of SMC from within the kernel if
> booted in non-secure?

I was thinking that if the kernel is booted in hyp mode (non-secure
obviously, then), the kernel would set HVBAR to point to a little
pretend hypervisor vector table whose only functionality was to be
able to set HVBAR.  Then later, when you load the kvm module (say),
this would be used (once per cpu) to set HVBAR to the actual vector
table.

This is the only way to make things work if secure state is in use for
something else (whether by the firmware, or by some other kernel
feature).

> As it is now, I thought the kernel could run in both secure and
> non-secure mode. If this is true, is it not a simple and useful
> feature that should be preserved?

This is a good point.  Yes, the kernel can run in both secure and
non-secure states.  However, if you want to use kvm, this is no longer
the case.  kvm wants to use hyp mode and hyp mode is only available in
the non-secure state.  And if you let the kernel get properly booted
in secure state, switching it to non-secure state while it is running
would be quite painful - you'd have to do a very complicated dance to
make sure the non-secure state was set up just right, etc.

>  1. The kernel will advertise via ELF notes what modes it may be
>    started in.  The possible modes will be:
>       (i)   secure monitor mode
>       (ii)  non-secure hypervisor mode
>       (iii) non-secure kernel mode
> 
> hmm, so you would have to choose _one_ of these at compile time and
> your image is bound to be run in the specific mode? How about when
> you're actually running in a VM, should it then be in mode (iii)?

No, I'm proposing that you'd choose one _or more_ of these at compile
time.  Most modern Linux kernels would support all three.  The Xen
hypervisor (which has to be booted via the same interface) would
support only (ii) and (iii).

> What are the benefits from the kernel being aware of its mode if we
> ignore initialization and handle that somehow else?

I'm not sure what you mean by "being aware of its mode".  If you mean
"being aware of the security state", then there is no direct benefit
just of that /awareness/.  However, a kernel which knows that it is
running in non-secure state but which has also set up a hook to allow
it to use secure state, could later (eg when a kernel module is
loaded) use the secure state for exciting functionality (eg, crypto
key storage, or the like).

If you mean "being aware of kernel mode vs. hyp mode", then the answer
is that the kernel cannot generally run in hyp mode, but if you want
to use kvm it needs access to hyp mode.  So the startup arrangements
need to arrange that the kvm kernel module can get back into hyp mode
when it wants to.

> so you're suggesting a method that causes the kernel never to be
> able to run isolated in secure mode?

You're right that that was the implication of my proposal.  However,
if that's something that people want to do then my proposal needs to
be modified.  But to understand that better, I'd like to understand
why you would want to run the whole kernel in secure state.  What
would you use the non-secure state for ?

If this is indeed a requirement, one option would be to simply say
that a kernel may be started in secure kernel state.  But there is a
difficulty: the kernel needs to be told somehow that it is in secure
kernel state, so that it knows that it can use the non-secure state.

>  2. This cpu startup process must happen very early - before paging
>    is enabled, in any case, so before RAM is really available.
>    However, it produces two bits of information: 1. does the
>    kernel own secure state; 2. does the kernel own hyp mode.
>    Where should this information be stored ?
> 
> so, per (1) I would think no. (2) if the kernel uses KVM, yes.

Um.  What I meant is: these two bits of information vary according to
how the kernel has been booted.  They don't have fixed answers.

>  4. I'm not very familiar with the KVM on ARM code.  How much would
>    have to be changed to existing KVM on ARM to make it conform to
>    the above scheme ?  In particular it would have to not use SMC to
>    adjust the HVBAR; instead, it would have to take control of HVBAR
>    once per CPU.
> 
> This is a tiny adjustment - we were planning to fit this with the community wishes anyhow.

Right.

Thanks,
Ian.
