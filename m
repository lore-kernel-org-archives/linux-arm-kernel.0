From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Jul 2011 18:13:19 +0200
Subject: [PATCH 1/3] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <20110706152546.GE8286@n2100.arm.linux.org.uk>
References: <1309945678-18813-1-git-send-email-bs14@csr.com>
	<201107061641.05569.arnd@arndb.de>
	<20110706152546.GE8286@n2100.arm.linux.org.uk>
Message-ID: <201107061813.19933.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 July 2011, Russell King - ARM Linux wrote:
> Ha, you've no idea what kind of messed up ideas hardware people come up
> with then.  Take this - this is real hardware which I've had Linux
> running on continuously for the last 13 years.  Here is the /proc/ioports:
> 
< skipped lots of interesting information about how messed up the hardware can be>

> So, if you do an ioport_map() to convert from the ISA address to a bus
> specific address, and then add the device specific offset, you end up
> with information lost, and you no longer know how to manipulate the
> cookie into the correct bus address and access type.
> 
> The alternative is you keep the returned ioport cookie the same as the
> ISA address, and do all the conversion in ioread/iowrite - that's even
> more horrible than how it's already doing because then you need to know
> if its real MMIO or IO, and whether it's an 8 bit IO device, 16-bit
> low byte lane IO device, or a 16-bit both byte lane IO device.  Plus
> whether the MMIO is in the broken PCMCIA controller IO space (CPU
> address bit 11 missing and CPU address bit 19 mapped to two bus
> address bits...)

Well, first of all, I never suggested converting drivers to use
iowrite, you brought that up. So as long as the 16-bit ISA driver
keep using inb/outb, an iowrite implementation would not need to
bother about this specific problem and don't even need a private
iowrite implementation but instead move that platform over to use
CONFIG_GENERIC_IOMAP.

What lib/iomap.c does is indeed to look at the address, by default
it assumes that __iomem tokens below 0x10000 are IO ports, while
larger values are MMIO addresses. This appears to work fine on x86,
and AFAICT, it should still work with both the botched PIO mapping
(minus the 16-bit devices) and the botched MMIO mapping, since both
will just end up calling the fixups in arch/arm/mach-ebsa110/io.c.

The only problem you will hit is when there are ISA devices with
MMIO addresses below 0x40000, which is impossible on PCs but
perhaps not on arbitrarily incompatible ISA buses.

	Arnd
