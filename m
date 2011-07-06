From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Jul 2011 23:21:14 +0200
Subject: [PATCH 1/3] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <20110706205059.GW8286@n2100.arm.linux.org.uk>
References: <1309945678-18813-1-git-send-email-bs14@csr.com>
	<201107062231.51117.arnd@arndb.de>
	<20110706205059.GW8286@n2100.arm.linux.org.uk>
Message-ID: <201107062321.15102.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 July 2011 22:50:59 Russell King - ARM Linux wrote:
> On Wed, Jul 06, 2011 at 10:31:50PM +0200, Arnd Bergmann wrote:
> > Just as a follow-up, this is what I was referring to in the other
> > sub-thread. Setting NO_IOPORT and removing __io does work for a lot
> > of things today, but breaks randconfig builds left and right. I want
> > to clean that up by adding 'depends on HAS_IOPORT' at the correct places
> > and then switch all platforms that don't need it to remove __io.
> 
> It's not that easy.  NO_IOPORT was brought in by Viro to work around
> various platforms which broke - such as RiscPC.  Viro was well aware
> of that platform, and we had a discussion about it.
> 
> The conclusion (I think) was that NO_IOPORT was to prevent ioport_map()
> et.al. on platforms which couldn't provide a sane definition - eg:
> 
> (11 Feb 2007)...
> 19:50 < rmk> inb(port) | inb(port + 1) << 8 is not identical to addr = ioport_map(port); readb(addr) | readb(addr + 1)
> 19:51 < rmk> inb(port) | inb(port + 1) << 8 is identical to addr = ioport_map(port); readb(addr) | readb(addr + (1 << 2))
> 19:53 < rmk> inw(port) | inw(port + 2) equates to addr = ioport_map(port); readw(addr) | readw(addr + (2 << 2))
> 
> So, while the above referred to platform uses inb etc, it sets
> NO_IOPORT to stop the devres breakage, which in turn disables
> HAS_IOPORT.
> 
> So, HAS_IOPORT does not mean the ISA/PCI accessors are not provided.
> It means there will be no devres support for it and ioport_map() is
> probably missing.
> 
> I've added Viro to this thread in case he'd like to correct me (if he
> remembers the background to HAS_IOPORT/NO_IOPORT etc.)

Thanks for the exact reference. You've mentioned this before and I tried
to find the discussion but couldn't.

I understand that the original meaning of NO_IOPORT/HAS_IOPORT is very
limited, and I would like to extend it in a way to allow both the
scenario with inb/outb but without ioport_map and the case where you
have no PIO space at all.

CONFIG_HAS_IOPORT is nice in that it mirrors CONFIG_HAS_IOMEM for
readl/writel, so my preferred solution would be to repurpose that
symbol to mean that inb/outb are available, while introducing a
new symbol to mean that ioport_map is also available, e.g.
CONFIG_HAS_IOPORT_MAP for the cases where we now use CONFIG_HAS_IOPORT.

	Arnd
