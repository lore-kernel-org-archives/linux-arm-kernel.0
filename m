From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Feb 2012 22:43:13 +0000
Subject: [PATCH v2 19/28] ARM: Add fixed PCI i/o mapping
In-Reply-To: <4F4EA694.5060003@gmail.com>
References: <1330547147-22867-1-git-send-email-robherring2@gmail.com>
 <201202292153.03056.arnd@arndb.de> <4F4EA694.5060003@gmail.com>
Message-ID: <201202292243.13923.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 February 2012, Rob Herring wrote:
> No, then the mapping will fail. I do need to double check all the
> mappings and make sure there is no overlap but we only care on the PCI
> platforms I converted.
> 
> Also, it should be noted this shrinks the i/o space on some platforms.
> dove and kirkwood had 1MB x 2 buses and now have 64KB per bus. ixp2000 I
> think has 32MB with a note saying they need "a lot". Is there really a
> use for lots of i/o space?

Given that each PCI bus only wires up the lower 64k, I'd say no ;-)

My guess is that they used 1MB ranges in order to benefit from section
mapping. In case of ixp2000, I only see 64k in the resource:

static struct resource ixp2000_pci_io_space = {
        .start  = 0x00010000,
        .end    = 0x0001ffff,
        .flags  = IORESOURCE_IO,
        .name   = "PCI I/O Space"
};

The part that I don't understand here is why the resource starts at
64k and is another 64k in size. I think we need to double-check this
in order to be sure whether we have to put the pci io space into the
first or the second 64k chunk of the new mapping area.

Hmm, I guess you meant ixp23xx, not ixp2000, which indeed has

static struct resource ixp23xx_pci_io_space = {
        .start  = 0x00000100,
        .end    = 0x01ffffff,
        .flags  = IORESOURCE_IO,
        .name   = "PCI I/O Space"
};

This seems to be done just for simplicity in the implementation,
to keep all parts of the PCI controller 32MB aligned, I can't
see any real technical reason why it would be useful othewise.

	Arnd
