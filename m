From: will.deacon@arm.com (Will Deacon)
Date: Tue, 4 Dec 2012 17:24:24 +0000
Subject: [RFC PATCH 2/2] ARM: SMP support for mach-virt
In-Reply-To: <20121204163555.GH14363@n2100.arm.linux.org.uk>
References: <1354557160-20144-1-git-send-email-will.deacon@arm.com>
 <1354557160-20144-3-git-send-email-will.deacon@arm.com>
 <50BD1FD7.9040000@gmail.com>
 <20121204124047.GM23368@mudshark.cambridge.arm.com>
 <20121204133326.GE14363@n2100.arm.linux.org.uk>
 <20121204134010.GP23368@mudshark.cambridge.arm.com>
 <20121204143724.GF14363@n2100.arm.linux.org.uk>
 <20121204161113.GT23368@mudshark.cambridge.arm.com>
 <20121204163555.GH14363@n2100.arm.linux.org.uk>
Message-ID: <20121204172424.GG5314@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 04, 2012 at 04:35:55PM +0000, Russell King - ARM Linux wrote:
> On Tue, Dec 04, 2012 at 04:11:13PM +0000, Will Deacon wrote:
> > The problem you're describing actually happens when the 3.6 kernel onlines
> > all of the CPUs, because now it has no way to hotplug them off safely. This
> > is also an issue with non-virtualised hardware but we could solve it for the
> > virtual platform by having a para-virtualised device for doing CPU hotplug.
> 
> That situation exists on ARM Ltd platforms where there's no way to
> properly return them back to the boot loader.  We should not be forcing
> this ARM Ltd platform deficiency onto other platforms as part of a
> "design", even virtual platforms.
> 
> Most other real-world platforms out there have a way to power off the
> unused secondary CPUs - Tegra and OMAP both do.

If a virtual machine powers off a virtual CPU, I doubt we want to power of
its corresponding CPU -- that logic can remain in the host. All we need to
do is kill the virtual CPU thread, which we can do easily enough. Booting is
the more difficult problem because we introduce a reliance on a virtual
device being ready incredibly early, essentially hardcoding part of the
virtual machine.

> As far as virtual platforms go, how secondary CPUs are dealt with should
> already have been solved; I really can't imagine that KVM and XEN on
> other architectures end up with CPUs spinning in a loop inside the guest
> kernel waiting for the guest OS to ask them to boot.  Neither can I imagine
> that KVM and XEN end up with CPUs spinning in the guest OS when CPUs are
> asked to be hot-unplugged.

So neither kvmtool or qemu currently support hotplug for kvm guests on any
architectures from what I can tell. Furthermore, kvmtool on ppc (at least)
uses a secondary spinning loop at a fixed offset into the kernel image. I
don't think we should really pay much attention to those other architectures
in this regard!

> > > That happens _before_ the DT has been parsed, so any memreserve stuff
> > > will be ignored.  And it's at that point that your "offline" secondary
> > > CPUs will have their instructions overwritten.
> > > 
> > > That's fine if the pen ends up being at the same place but that's not
> > > something we guarantee.
> > 
> > Having CPUs in limbo between the bootloader the being online in the kernel
> > is something we should just avoid. Isn't that pen __init anyway?
> 
> If you have hotplug enabled, all the secondary bringup code should be
> in the __cpuinit and __cpuinitdata sections.

Right, but if booting a !HOTPLUG kernel via kexec, surely we'd have to clear
that pen of CPUs?

Will
