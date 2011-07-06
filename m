From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Jul 2011 21:50:59 +0100
Subject: [PATCH 1/3] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <201107062231.51117.arnd@arndb.de>
References: <1309945678-18813-1-git-send-email-bs14@csr.com>
	<CAGsJ_4xntJHz_CzCaTuyCbDrePzxO+esPFxTfZZ1TTnZFy4w=Q@mail.gmail.com>
	<20110706191000.GN8286@n2100.arm.linux.org.uk>
	<201107062231.51117.arnd@arndb.de>
Message-ID: <20110706205059.GW8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 10:31:50PM +0200, Arnd Bergmann wrote:
> Just as a follow-up, this is what I was referring to in the other
> sub-thread. Setting NO_IOPORT and removing __io does work for a lot
> of things today, but breaks randconfig builds left and right. I want
> to clean that up by adding 'depends on HAS_IOPORT' at the correct places
> and then switch all platforms that don't need it to remove __io.

It's not that easy.  NO_IOPORT was brought in by Viro to work around
various platforms which broke - such as RiscPC.  Viro was well aware
of that platform, and we had a discussion about it.

The conclusion (I think) was that NO_IOPORT was to prevent ioport_map()
et.al. on platforms which couldn't provide a sane definition - eg:

(11 Feb 2007)...
19:50 < rmk> inb(port) | inb(port + 1) << 8 is not identical to addr = ioport_map(port); readb(addr) | readb(addr + 1)
19:51 < rmk> inb(port) | inb(port + 1) << 8 _is_ identical to addr = ioport_map(port); readb(addr) | readb(addr + (1 << 2))
19:53 < rmk> inw(port) | inw(port + 2) equates to addr = ioport_map(port); readw(addr) | readw(addr + (2 << 2))

So, while the above referred to platform uses inb etc, it sets
NO_IOPORT to stop the devres breakage, which in turn disables
HAS_IOPORT.

So, HAS_IOPORT does not mean the ISA/PCI accessors are not provided.
It means there will be no devres support for it and ioport_map() is
probably missing.

I've added Viro to this thread in case he'd like to correct me (if he
remembers the background to HAS_IOPORT/NO_IOPORT etc.)
