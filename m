From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 23 Aug 2011 20:06:17 +0100
Subject: ARM processor mode, kernel startup, Hyp / secure state
In-Reply-To: <20051.56441.597373.780997@mariner.uk.xensource.com>
References: <20051.48809.945431.800543@mariner.uk.xensource.com>
	<CA+wbFdcv_BsHaVwoqgF5yx6scXOodHkKjdVtarqJwjy_GFrAJQ@mail.gmail.com>
	<20051.56441.597373.780997@mariner.uk.xensource.com>
Message-ID: <CA+wbFde1otouQWm1crQEm3w1X6pJrVOnDmBit9TwKh+b1vW70w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2011 at 5:59 PM, Ian Jackson <Ian.Jackson@eu.citrix.com> wrote:
> Dave Martin writes ("Re: ARM processor mode, kernel startup, Hyp / secure state"):
>> I think the Secure World / Normal World distinction may be a red
>> herring. ?The kernel currently just stays in whatever world it was
>> started in, and doesn't have support for being the bridge between
>> worlds. ?If the kernel is started in the Normal World, this will be
>> because something else occupies the Secure World, and so Linux
>> won't have direct access to that anyway. ?Conversely, if Linux is
>> started in the Secure World, it can always access the monitor state
>> if this is really desired -- the monitor is at the same level of privilege
>> as the other Secure World privileged modes.
>
> If Linux is booted in the secure world, it will have to switch to the
> non-secure world at boot if it is to use kvm.
>
>> I haven't seen a compelling reason why this would need to change;
>> do you have a particular scenario in mind?
>
> The non-secure world doesn't have hyp mode, which is needed by kvm.

You mean "the secure world doesn't have hyp mode"?  Fair point if so;
I was forgetting this.

>
> So if kvm might be loaded later (and we don't really want to rule that
> out at boot time unless we can help it) then the kernel needs either
> ?- to be started in the secure world, to know this, and switch to
> ? ?the non-secure world while installing appropriate trampoline(s)
> ?- to be started in hyp mode, and switch to kernel mode while
> ? ?installing an appropriate trampoline

This feels like the preferable approach -- it makes no sense to require
the kernel to be started in the Secure World if we want to install
a hypervisor.

There might be some sense in *requiring* the bootloader to start the kernel
in the Normal World and in hyp mode if kvm (or other kernel-hosted hypervisor)
is to be used.  If you weren't booted this way then tough, you can't
use kvm.

If you allow the kernel to be started in the Secure World, it can switch
to the Normal World on boot, but this is in practice a complex,
platform-specific procecure: you need to reprogram protection controllers
etc. to move all the peripherals and RAM into the Normal World,

Currently, I believe none of the needed code to accomplish this is in
the kernel, because there's been no prior need for it.  Implemting this
would potentially require work for every board >= ARMv6Z.
Bootloader maintainers might argue with that though: general-purpose
bootloaders probably won't have this code either yet, for the same reasons.
If there is real secure firmware, it will of course set all this up before
invoking the bootloader.  But otherwise, _someone_ has to do it...

> ?- something more horrible (eg the bootloader provides the
> ? ?trampoline; or switch the running system to the non-secure world
> ? ?when the desire for kvm becomes evident)

I agree with "horrible" :)

In particular, switching to the Normal World after boot is going to be
extremely horrible given the need to move peripherals and RAM into
the Normal world while somehow not pulling the floor from under your
feet...

>
>> Starting the kernel in Hyp mode may be reasonable in this scenario.
>>
>> I think this is actually backwards-compatible, because in both an
>> uncompressed kernel and a zImage, pretty much the first thing that
>> happens is a switch to SVC mode at present. ?So an older kernel
>> will just transparently end up in SVC mode as if nothing unusual had
>> happened.
>
> Do all relevant existing kernels unconditionally switch to kernel
> mode at the start ?

In practice, I think so.  Take a look at arch/arm/kernel/head.S and
arch/arm/boot/compressed/head.S.  Really, it's interrupts which get
disabled at these entry points -- but prior to ARMv6 it used to be
simpler to set the mode too since you couldn't force the interrupt
mask bits using a single MSR instruction without also setting the
processor mode.

Looking at compressed/head.S, it looks like the CPSR is only touched
by read-modify-write on the interrupt bits, or not at all.  So this
code is probably transparent to the initial CPU mode without
modification.

>
>> The boot procotol would need to define the initial hypervisor state:
>> basically, a dormant identity configuration with all traps and fancy
>> features turned off.
>
> Right. ?Helpfully, that is (more or less) the processor reset state.

Even if it isn't, I think it makes sense to place this requirement on
the bootloader.
But you're probably right.

Cheers
---Dave
