From: will.deacon@arm.com (Will Deacon)
Date: Tue, 4 Dec 2012 17:16:28 +0000
Subject: [RFC PATCH 2/2] ARM: SMP support for mach-virt
In-Reply-To: <50BE28C6.2010403@gmail.com>
References: <1354557160-20144-1-git-send-email-will.deacon@arm.com>
 <1354557160-20144-3-git-send-email-will.deacon@arm.com>
 <50BD1FD7.9040000@gmail.com>
 <20121204124047.GM23368@mudshark.cambridge.arm.com>
 <20121204133326.GE14363@n2100.arm.linux.org.uk>
 <20121204134010.GP23368@mudshark.cambridge.arm.com>
 <20121204143724.GF14363@n2100.arm.linux.org.uk>
 <20121204161113.GT23368@mudshark.cambridge.arm.com>
 <50BE28C6.2010403@gmail.com>
Message-ID: <20121204171628.GF5314@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 04, 2012 at 04:45:58PM +0000, Rob Herring wrote:
> On 12/04/2012 10:11 AM, Will Deacon wrote:
> > On Tue, Dec 04, 2012 at 02:37:25PM +0000, Russell King - ARM Linux wrote:
> >> Umm.  So let's see.  If I'm running v3.6 stock kernel and want to kexec
> >> into a v3.7 stock kernel.  The SMP pen is part of the v3.6 kernel, which
> >> will be located at 32K into the RAM.  The v3.7 kernel will also want to
> >> occupy the same place.  At some point you have to overwrite the v3.6
> >> kernel with the v3.7 kernel image.
> > 
> > If the 3.6 kernel didn't bring those CPUs online, they will sit in the
> > bootloader pen (out of the way of the kernel image) rather than the kernel
> > pen so I don't think there will be a problem.
> > 
> > The problem you're describing actually happens when the 3.6 kernel onlines
> > all of the CPUs, because now it has no way to hotplug them off safely. This
> > is also an issue with non-virtualised hardware but we could solve it for the
> > virtual platform by having a para-virtualised device for doing CPU hotplug.
> > 
> >> That happens _before_ the DT has been parsed, so any memreserve stuff
> >> will be ignored.  And it's at that point that your "offline" secondary
> >> CPUs will have their instructions overwritten.
> >>
> >> That's fine if the pen ends up being at the same place but that's not
> >> something we guarantee.
> > 
> > Having CPUs in limbo between the bootloader the being online in the kernel
> > is something we should just avoid. Isn't that pen __init anyway?
> 
> Aren't we mixing 2 pens here? You must have some simple bootloader
> containing vector table and a pen that the dtb points to, right? The pen
> you have in the kernel is only needed when hotplug only does a wfi. As
> you don't yet support hotplug, then you can drop all the kernel pen code.

Yes, both qemu and kvmtool have bootloader pens outside of the kernel but
since wfi is not trapped by kvm, the secondaries can be released early due
to a spurious wakeup so we need the second pen.

> If there is no way to reset the core, then couldn't the hotplug code
> tear down the cpu setup and just jump back to 0x0 which then returns to
> the bootloader's pen?

I think hotplug really should be implemented with a virtio device. We just
trap back to the emulation and kill the vcpu thread.

Will
