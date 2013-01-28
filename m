From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 28 Jan 2013 11:43:51 -0700
Subject: [RFC V2 PATCH 0/8] ARM: kirkwood: cleanup DT conversion
In-Reply-To: <20130128192445.6984e7dd@skate>
References: <cover.1358983578.git.jason@lakedaemon.net>
 <cover.1359091286.git.jason@lakedaemon.net>
 <201301251115.47480.arnd@arndb.de>
 <20130125125214.GI1758@titan.lakedaemon.net>
 <CABJ1b_QaTBLgGASTs2yi435jR=LepN-iY97xTLXAu1hZw69Wuw@mail.gmail.com>
 <20130125183407.GC7393@obsidianresearch.com>
 <20130128104008.GA5170@localhost>
 <20130128180716.GA9436@obsidianresearch.com>
 <20130128192445.6984e7dd@skate>
Message-ID: <20130128184351.GD9436@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 07:24:45PM +0100, Thomas Petazzoni wrote:

> > 1) very early on the addr-map driver would have to scan the OF tree,
> >    find the address of the mbus mapping registers, and the internal
> >    register map.
> > 2) Verify the mbus window for the internal registers matches the DT
> >    This is just a sanity check, if the correct value doesn't come back
> >    then the DT doesnt match what the bootloader setup, and some
> >    jtag accessible diagnostic can be printed...
> > 3) Wipe all the mbus windows
> > 4) Register a "marvell,orion-mbus" bus handler somehow
> > 5) When OF processes the DT it would call the bus handler for each
> >    "marvell,orion-mbus" which should parse the ranges, allocate
> >    a free window, program that window then instantiate the child
> >    devices.

[..]
 
> Instead, I think the "address decoding window driver" in the kernel
> should provide an API for device drivers to request an address decoding
> window at a given address, with a given size and target/attribute. This
> is already what the PCIe code is doing (I'm going to submit v2 of the
> PCIe code soon), and I think we should to the same for other devices as
> well.

Sure, but that isn't exclusive with setting up the bulk of the windows
through DT - the tegra PCI-E driver can use a request API for its
dynamic windows, while everyone else can be setup by having the DT bus
declarations automatically request the proper windows.

All this would do is replace the tables of window configurations in
the board files with a DT representation of the same table.

Jason
