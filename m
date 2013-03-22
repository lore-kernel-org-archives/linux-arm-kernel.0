From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Mar 2013 11:05:31 +0000
Subject: Integrator PCI base dilemma
In-Reply-To: <514B098E.8020608@gmail.com>
References: <CACRpkdaOjFhWR21w5x_rR_60ffQF3Ym_MQd2svNyzm0guwOUoQ@mail.gmail.com>
 <514A4C30.9080402@gmail.com>
 <CACRpkdbLjhg-EuTBM4-_-xWV+_dDoA-RNo3FOUDN8Ka0w77sGA@mail.gmail.com>
 <514B098E.8020608@gmail.com>
Message-ID: <20130322110531.GX4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 08:22:22AM -0500, Rob Herring wrote:
> On 03/21/2013 04:16 AM, Linus Walleij wrote:
> > Well the VGA console is supposed to be as early as possible so
> > in some sense it's like an earlyprint dilemma. The way the mechanism
> > works right now is to give a raw pointer into the remapped
> > PCI non-prefetched memory, then the VGA console assumes that
> > the VGA device will be right there, att offset zero.
> > 
> > (Maybe there is some guarantee that PCI VGA devices will appear
> > first in that memory space, or it would be hard to do stunts like
> > this... I admit I haven't done much of PCI in my life.)
> 
> I believe it is setup by the BIOS and fixed on x86. There's probably
> some bootloader setup assumptions for ARM.

All VGA cards need to be initialized before use.  On x86, that happens as
a result of the BIOS loading and running an BIOSes on any cards in the
system - starting with any VGA BIOS first.  VGA BIOSes do all sorts of
different weird stuff, so running them on non-x86 is non-trivial.  VGA
BIOSes can and do poke at other bits of PC hardware.

> Does VGA need all 16MB as well?

The only real chunk that needs to be mapped is the 640K-1MB region, which
is what x86 "removes" from system RAM and uses for VGA and BIOSes.

> >> For the config space, how much do you really need? You could ioremap
> >> this on demand. I think this issue came up before on another platform
> >> where the config space was very sparsely accessed.
> > 
> > Yes I think you're right here. So there may be a way to avoid the
> > big chunk of 16MiB remapping and avoid using a static offset for this.
> > 
> > So I end up only keeping one 16MiB remapping for the memory and
> > another static mapping for the I/O memoryspace.
> > 
> > And we basically have no way to get rid of these static maps :-/
> 
> You don't really have to get rid of the static map necessarily. It just
> needs to be more generic. If you fix the virtual address across
> platforms, then you just need to get the phys address out of the DT.

Exactly.
