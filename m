From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 9 May 2012 17:18:39 +0100
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <20120509141316.GS3955@opensource.wolfsonmicro.com>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <201205081444.30915.arnd@arndb.de>
 <20120508153155.GW15893@opensource.wolfsonmicro.com>
 <201205091243.13206.arnd@arndb.de>
 <20120509141316.GS3955@opensource.wolfsonmicro.com>
Message-ID: <20120509161839.GB10241@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 03:13:16PM +0100, Mark Brown wrote:
> On Wed, May 09, 2012 at 12:43:13PM +0000, Arnd Bergmann wrote:
> > On Tuesday 08 May 2012, Mark Brown wrote:
> 
> > > The trick is allocating a bit for that flag, though I was thinking
> > > earlier on we might be able to get away with carving it out of the bus
> > > specific bits since I think anything using this wouldn't normally be
> > > using resources for anything else except interrupts.  It does mean that
> > > the resource type doesn't do the right thing though.
> 
> > Right, or we could try to kill IORESOURCE_BUS, which is hardly used
> > anywhere and the users either get it wrong (bfin net2272), use it
> > only in one file (acpi, broadcom-pci) or only for printing the
> > contents (pnp).
> 
> Yeah, I looked at that - PCMCIA seems to be the major sticking point and
> the usage there appeared totally sane, though it's possible that if I
> stare at it hard enough I might convince myself that it only needs seven
> bits and we can steal one.

Err what?  PCMCIA doesn't use IORESOURCE_BUS.  (Don't get it confused with
IORESOURCE_BUSY which is totally different).

IORESOURCE_BUS seems to be used for:

net2272: specifying the register index shift value
acpi: to get the start/end PCI bus number values
pnp: for ACPI bus numbers
x86: PCI bus numbering

So it looks like net2272 is abusing this resource type for its own
purposes...  The others look like proper use of this resource type.
