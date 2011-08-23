From: Ian.Jackson@eu.citrix.com (Ian Jackson)
Date: Tue, 23 Aug 2011 17:59:37 +0100
Subject: ARM processor mode, kernel startup, Hyp / secure state
In-Reply-To: <CA+wbFdcv_BsHaVwoqgF5yx6scXOodHkKjdVtarqJwjy_GFrAJQ@mail.gmail.com>
References: <20051.48809.945431.800543@mariner.uk.xensource.com>
	<CA+wbFdcv_BsHaVwoqgF5yx6scXOodHkKjdVtarqJwjy_GFrAJQ@mail.gmail.com>
Message-ID: <20051.56441.597373.780997@mariner.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave Martin writes ("Re: ARM processor mode, kernel startup, Hyp / secure state"):
> I think the Secure World / Normal World distinction may be a red
> herring.  The kernel currently just stays in whatever world it was
> started in, and doesn't have support for being the bridge between
> worlds.  If the kernel is started in the Normal World, this will be
> because something else occupies the Secure World, and so Linux
> won't have direct access to that anyway.  Conversely, if Linux is
> started in the Secure World, it can always access the monitor state
> if this is really desired -- the monitor is at the same level of privilege
> as the other Secure World privileged modes.

If Linux is booted in the secure world, it will have to switch to the
non-secure world at boot if it is to use kvm.

> I haven't seen a compelling reason why this would need to change;
> do you have a particular scenario in mind?

The non-secure world doesn't have hyp mode, which is needed by kvm.

So if kvm might be loaded later (and we don't really want to rule that
out at boot time unless we can help it) then the kernel needs either
  - to be started in the secure world, to know this, and switch to
    the non-secure world while installing appropriate trampoline(s)
  - to be started in hyp mode, and switch to kernel mode while
    installing an appropriate trampoline
  - something more horrible (eg the bootloader provides the
    trampoline; or switch the running system to the non-secure world
    when the desire for kvm becomes evident)

> Starting the kernel in Hyp mode may be reasonable in this scenario.
> 
> I think this is actually backwards-compatible, because in both an
> uncompressed kernel and a zImage, pretty much the first thing that
> happens is a switch to SVC mode at present.  So an older kernel
> will just transparently end up in SVC mode as if nothing unusual had
> happened.

Do all relevant existing kernels unconditionally switch to kernel
mode at the start ?

> The boot procotol would need to define the initial hypervisor state:
> basically, a dormant identity configuration with all traps and fancy
> features turned off.

Right.  Helpfully, that is (more or less) the processor reset state.

> With only minor changes, I think a kernel supporting this boot protocol
> could run the zImage decompressor in Hyp mode, and then set up
> a stub HVC handler when reaching the main kernel entry point.
> It's certainly worth investigating.

I haven't checked the decompressor but I don't see why it wouldn't
work in hyp mode.  I can try it easily enough.

Ian.
