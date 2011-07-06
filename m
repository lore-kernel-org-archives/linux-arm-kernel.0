From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Jul 2011 16:41:05 +0200
Subject: [PATCH 1/3] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <20110706130940.GV8286@n2100.arm.linux.org.uk>
References: <1309945678-18813-1-git-send-email-bs14@csr.com>
	<201107061442.05182.arnd@arndb.de>
	<20110706130940.GV8286@n2100.arm.linux.org.uk>
Message-ID: <201107061641.05569.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 July 2011, Russell King - ARM Linux wrote:
> On Wed, Jul 06, 2011 at 02:42:04PM +0200, Arnd Bergmann wrote:
> > Good idea. The related change that I want to do is to conditionalize
> > all drivers that require PC-style I/O on the respective bus they
> > use, so we can also remove the __io macro for platforms that don't
> > need it and catch all drivers using inb/outb at compile time.
> 
> And what about those which use ioport_map() and ioread/write ?

ioport_map should return an error if IO_SPACE_LIMIT is zero.
I also tried just forcing a link error by not providing any
ioport_map in that case, which didn't cause major problems
in my tests. If that works for the general case, I'd prefer that
option.

If we have no drivers using ioport_map, ioread/iowrite automatically
becomes a non-issue.

> The approach of setting IO_SPACE_LIMIT to zero makes those harmless
> even if inb/outb are provided.

I'm not arguing against setting IO_SPACE_LIMIT to zero, I just want
to do more on top of that. There are numerous drivers that we are
able to enable on non-PIO machines that clearly cannot work because
they depend on a bus that's not there. This includes stuff like
gameport, pcmcia, or various rtc.

> > To do that, I'm working on a patch set that splits the 8250
> > driver into separate parts for platform drivers (mostly MMIO)
> > and ISA drivers (mostly PIO), since that seems to be the only
> > driver that we need on non-PIO platforms that uses inb/outb
> > directly.
> 
> I don't really see the point of that given the ioread/iowrite et.al.
> semantics.
> 
> And note that ioread/iowrite are unsupportable on some ARM platforms
> with ISA because of weird addressing techniques (and that renders
> PATA unsupportable on those platforms, while the old IDE stuff can
> continue to work with CF cards.)

Different issue, but I'm sure that they are supportable. What we ended
up doing on the PCIe bus in one of the Cell blades was to encode
special regions in the __iomem token returned from pci_iomap that
would trigger indirect access in iowrite32. For the simple case where
all buses use the same weird addressing, the regular CONFIG_GENERIC_IOMAP
support should be enough already.

	Arnd
