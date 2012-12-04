From: will.deacon@arm.com (Will Deacon)
Date: Tue, 4 Dec 2012 16:11:13 +0000
Subject: [RFC PATCH 2/2] ARM: SMP support for mach-virt
In-Reply-To: <20121204143724.GF14363@n2100.arm.linux.org.uk>
References: <1354557160-20144-1-git-send-email-will.deacon@arm.com>
 <1354557160-20144-3-git-send-email-will.deacon@arm.com>
 <50BD1FD7.9040000@gmail.com>
 <20121204124047.GM23368@mudshark.cambridge.arm.com>
 <20121204133326.GE14363@n2100.arm.linux.org.uk>
 <20121204134010.GP23368@mudshark.cambridge.arm.com>
 <20121204143724.GF14363@n2100.arm.linux.org.uk>
Message-ID: <20121204161113.GT23368@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 04, 2012 at 02:37:25PM +0000, Russell King - ARM Linux wrote:
> On Tue, Dec 04, 2012 at 01:40:10PM +0000, Will Deacon wrote:
> > On Tue, Dec 04, 2012 at 01:33:26PM +0000, Russell King - ARM Linux wrote:
> > > The memory that these 'offline' CPUs is executing then gets overwritten,
> > > and that's game over for those CPUs.
> > 
> > That's not strictly true. The device-tree passed to the kernel should have a
> > /memreserve/ entry for the SMP pen to avoid exactly this scenario. In real
> > hardware, this still sucks because you have spinning CPUs burning up power
> > but that's not such a problem with a virtual platform.
> 
> Umm.  So let's see.  If I'm running v3.6 stock kernel and want to kexec
> into a v3.7 stock kernel.  The SMP pen is part of the v3.6 kernel, which
> will be located at 32K into the RAM.  The v3.7 kernel will also want to
> occupy the same place.  At some point you have to overwrite the v3.6
> kernel with the v3.7 kernel image.

If the 3.6 kernel didn't bring those CPUs online, they will sit in the
bootloader pen (out of the way of the kernel image) rather than the kernel
pen so I don't think there will be a problem.

The problem you're describing actually happens when the 3.6 kernel onlines
all of the CPUs, because now it has no way to hotplug them off safely. This
is also an issue with non-virtualised hardware but we could solve it for the
virtual platform by having a para-virtualised device for doing CPU hotplug.

> That happens _before_ the DT has been parsed, so any memreserve stuff
> will be ignored.  And it's at that point that your "offline" secondary
> CPUs will have their instructions overwritten.
> 
> That's fine if the pen ends up being at the same place but that's not
> something we guarantee.

Having CPUs in limbo between the bootloader the being online in the kernel
is something we should just avoid. Isn't that pen __init anyway?

Will
