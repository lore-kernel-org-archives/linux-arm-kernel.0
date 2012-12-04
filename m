From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 4 Dec 2012 16:35:55 +0000
Subject: [RFC PATCH 2/2] ARM: SMP support for mach-virt
In-Reply-To: <20121204161113.GT23368@mudshark.cambridge.arm.com>
References: <1354557160-20144-1-git-send-email-will.deacon@arm.com>
 <1354557160-20144-3-git-send-email-will.deacon@arm.com>
 <50BD1FD7.9040000@gmail.com>
 <20121204124047.GM23368@mudshark.cambridge.arm.com>
 <20121204133326.GE14363@n2100.arm.linux.org.uk>
 <20121204134010.GP23368@mudshark.cambridge.arm.com>
 <20121204143724.GF14363@n2100.arm.linux.org.uk>
 <20121204161113.GT23368@mudshark.cambridge.arm.com>
Message-ID: <20121204163555.GH14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 04, 2012 at 04:11:13PM +0000, Will Deacon wrote:
> On Tue, Dec 04, 2012 at 02:37:25PM +0000, Russell King - ARM Linux wrote:
> > On Tue, Dec 04, 2012 at 01:40:10PM +0000, Will Deacon wrote:
> > > On Tue, Dec 04, 2012 at 01:33:26PM +0000, Russell King - ARM Linux wrote:
> > > > The memory that these 'offline' CPUs is executing then gets overwritten,
> > > > and that's game over for those CPUs.
> > > 
> > > That's not strictly true. The device-tree passed to the kernel should have a
> > > /memreserve/ entry for the SMP pen to avoid exactly this scenario. In real
> > > hardware, this still sucks because you have spinning CPUs burning up power
> > > but that's not such a problem with a virtual platform.
> > 
> > Umm.  So let's see.  If I'm running v3.6 stock kernel and want to kexec
> > into a v3.7 stock kernel.  The SMP pen is part of the v3.6 kernel, which
> > will be located at 32K into the RAM.  The v3.7 kernel will also want to
> > occupy the same place.  At some point you have to overwrite the v3.6
> > kernel with the v3.7 kernel image.
> 
> If the 3.6 kernel didn't bring those CPUs online, they will sit in the
> bootloader pen (out of the way of the kernel image) rather than the kernel
> pen so I don't think there will be a problem.

... or in the case of sane hardware, the CPUs will be powered down.

> The problem you're describing actually happens when the 3.6 kernel onlines
> all of the CPUs, because now it has no way to hotplug them off safely. This
> is also an issue with non-virtualised hardware but we could solve it for the
> virtual platform by having a para-virtualised device for doing CPU hotplug.

That situation exists on ARM Ltd platforms where there's no way to
properly return them back to the boot loader.  We should not be forcing
this ARM Ltd platform deficiency onto other platforms as part of a
"design", even virtual platforms.

Most other real-world platforms out there have a way to power off the
unused secondary CPUs - Tegra and OMAP both do.

As far as virtual platforms go, how secondary CPUs are dealt with should
already have been solved; I really can't imagine that KVM and XEN on
other architectures end up with CPUs spinning in a loop inside the guest
kernel waiting for the guest OS to ask them to boot.  Neither can I imagine
that KVM and XEN end up with CPUs spinning in the guest OS when CPUs are
asked to be hot-unplugged.

> > That happens _before_ the DT has been parsed, so any memreserve stuff
> > will be ignored.  And it's at that point that your "offline" secondary
> > CPUs will have their instructions overwritten.
> > 
> > That's fine if the pen ends up being at the same place but that's not
> > something we guarantee.
> 
> Having CPUs in limbo between the bootloader the being online in the kernel
> is something we should just avoid. Isn't that pen __init anyway?

If you have hotplug enabled, all the secondary bringup code should be
in the __cpuinit and __cpuinitdata sections.
