From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Jul 2011 14:09:40 +0100
Subject: [PATCH 1/3] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <201107061442.05182.arnd@arndb.de>
References: <1309945678-18813-1-git-send-email-bs14@csr.com>
	<1309945678-18813-2-git-send-email-bs14@csr.com>
	<20110706122501.GU8286@n2100.arm.linux.org.uk>
	<201107061442.05182.arnd@arndb.de>
Message-ID: <20110706130940.GV8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 02:42:04PM +0200, Arnd Bergmann wrote:
> Good idea. The related change that I want to do is to conditionalize
> all drivers that require PC-style I/O on the respective bus they
> use, so we can also remove the __io macro for platforms that don't
> need it and catch all drivers using inb/outb at compile time.

And what about those which use ioport_map() and ioread/write ?

The approach of setting IO_SPACE_LIMIT to zero makes those harmless
even if inb/outb are provided.

> To do that, I'm working on a patch set that splits the 8250
> driver into separate parts for platform drivers (mostly MMIO)
> and ISA drivers (mostly PIO), since that seems to be the only
> driver that we need on non-PIO platforms that uses inb/outb
> directly.

I don't really see the point of that given the ioread/iowrite et.al.
semantics.

And note that ioread/iowrite are unsupportable on some ARM platforms
with ISA because of weird addressing techniques (and that renders
PATA unsupportable on those platforms, while the old IDE stuff can
continue to work with CF cards.)
