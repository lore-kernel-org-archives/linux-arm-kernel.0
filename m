From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Jun 2012 11:18:22 +0100
Subject: mach/io.h cleanup and removal question
In-Reply-To: <4FD207C9.5010006@gmail.com>
References: <20120608102040.GA26034@lunn.ch>
 <20120608114316.GC15555@n2100.arm.linux.org.uk> <4FD207C9.5010006@gmail.com>
Message-ID: <20120618101822.GA12029@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 08, 2012 at 09:10:17AM -0500, Rob Herring wrote:
> Agreed. The next step is moving all i/o space to a fixed virtual address
> and for this we want to make i/o windows 64K.
> 
> However, I think you may also have a problem with
> ORION5X_PCIE_IO_BUS_BASE and the resource start. The i/o resource start
> should really be 0 and then the __io() macro should add the virtual i/o
> base address. However, Russell has mentioned previously that some chips
> may not work correctly with i/o space at 0 (PCI bus addresses, not host).
> 
> Do you have cards with i/o that you can test or know what devices are
> used with this platform?

I/O cards themselves should not be a problem - remember, they're designed
and tested in x86 PCs where IO space is only at 0-0xffff inclusive.  Many
of these cards will only decode up to 16 bits of IO address anyway, and
they'll ignore the higher order PCI address bits (because... x86 PC,
what's the point of any more.)

The problem seems to be any PCI bridges, whether they're P2P or the host
to PCI bridge, and whether it can do address translation.  In other words,
do they just forward the host bus physical address for IO accesses -
which means any PCI card doing a full 32-bit decode on their IO BARs is
not going to work when programmed in the 0-0xffff range.

It's all rather horrible, and it can _only_ be changed and checked by
people who have access to the physical boards _and_ at least one PCI
card known to do the full 32-bit IO decode, or who are adept enough
with analysers or scopes be able to analyse the PCI bus.
