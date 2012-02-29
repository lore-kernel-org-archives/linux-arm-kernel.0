From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Feb 2012 23:21:54 +0000
Subject: [PATCH v2 19/28] ARM: Add fixed PCI i/o mapping
In-Reply-To: <201202292243.13923.arnd@arndb.de>
References: <1330547147-22867-1-git-send-email-robherring2@gmail.com>
 <201202292153.03056.arnd@arndb.de> <4F4EA694.5060003@gmail.com>
 <201202292243.13923.arnd@arndb.de>
Message-ID: <20120229232154.GG16999@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 29, 2012 at 10:43:13PM +0000, Arnd Bergmann wrote:
> On Wednesday 29 February 2012, Rob Herring wrote:
> > No, then the mapping will fail. I do need to double check all the
> > mappings and make sure there is no overlap but we only care on the PCI
> > platforms I converted.
> > 
> > Also, it should be noted this shrinks the i/o space on some platforms.
> > dove and kirkwood had 1MB x 2 buses and now have 64KB per bus. ixp2000 I
> > think has 32MB with a note saying they need "a lot". Is there really a
> > use for lots of i/o space?
> 
> Given that each PCI bus only wires up the lower 64k, I'd say no ;-)

That's incorrect.  There's no "wires up" option there.  Addresses and
data are transferred over a common set of 32 wires on 32-bit PCI, and
the bus has separate 'address' and 'data' phases.  If you only wire up
16 of those lines, then things aren't going to work (because you won't
be able to access bytes 2,3 of each word.)

However, there's a separate issue here:
(1) do peripherals decode the upper 16 bits programmed into their IO BARs?
    Some do.
(2) are host PCI controllers capable of generating IO accesses in the
    lower 64k bus address region?

I think while I was fiddling with an IOP platform years ago that it did
not work with PCI setup to only use the lower 64k bus address region
for IO accesses.  So I'd suggest a certain amount of care is required
here.

> My guess is that they used 1MB ranges in order to benefit from section
> mapping. In case of ixp2000, I only see 64k in the resource:
> 
> static struct resource ixp2000_pci_io_space = {
>         .start  = 0x00010000,
>         .end    = 0x0001ffff,
>         .flags  = IORESOURCE_IO,
>         .name   = "PCI I/O Space"
> };
> 
> The part that I don't understand here is why the resource starts at
> 64k and is another 64k in size. I think we need to double-check this
> in order to be sure whether we have to put the pci io space into the
> first or the second 64k chunk of the new mapping area.
> 
> Hmm, I guess you meant ixp23xx, not ixp2000, which indeed has
> 
> static struct resource ixp23xx_pci_io_space = {
>         .start  = 0x00000100,
>         .end    = 0x01ffffff,
>         .flags  = IORESOURCE_IO,
>         .name   = "PCI I/O Space"
> };
> 
> This seems to be done just for simplicity in the implementation,
> to keep all parts of the PCI controller 32MB aligned, I can't
> see any real technical reason why it would be useful othewise.

It's certainly a weird way to avoid ISA addresses.  Note that these
will control the set of bus addresses which get assigned within PCI.
