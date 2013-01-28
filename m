From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 28 Jan 2013 19:24:45 +0100
Subject: [RFC V2 PATCH 0/8] ARM: kirkwood: cleanup DT conversion
In-Reply-To: <20130128180716.GA9436@obsidianresearch.com>
References: <cover.1358983578.git.jason@lakedaemon.net>
 <cover.1359091286.git.jason@lakedaemon.net>
 <201301251115.47480.arnd@arndb.de>
 <20130125125214.GI1758@titan.lakedaemon.net>
 <CABJ1b_QaTBLgGASTs2yi435jR=LepN-iY97xTLXAu1hZw69Wuw@mail.gmail.com>
 <20130125183407.GC7393@obsidianresearch.com>
 <20130128104008.GA5170@localhost>
 <20130128180716.GA9436@obsidianresearch.com>
Message-ID: <20130128192445.6984e7dd@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Mon, 28 Jan 2013 11:07:16 -0700, Jason Gunthorpe wrote:

> > 2. Also, If we use "ranges" property. How would that work?
> > By reading the property in the addr-map driver or
> > by somehow improving on of_bus to include this new kind of busses?
> 
> The addr-map driver would have to read it, I believe the rules of how
> busses work make this fairly simple:
> 
> 1) very early on the addr-map driver would have to scan the OF tree,
>    find the address of the mbus mapping registers, and the internal
>    register map.
> 2) Verify the mbus window for the internal registers matches the DT
>    This is just a sanity check, if the correct value doesn't come back
>    then the DT doesnt match what the bootloader setup, and some
>    jtag accessible diagnostic can be printed...
> 3) Wipe all the mbus windows
> 4) Register a "marvell,orion-mbus" bus handler somehow
> 5) When OF processes the DT it would call the bus handler for each
>    "marvell,orion-mbus" which should parse the ranges, allocate
>    a free window, program that window then instantiate the child
>    devices.

I am not totally convinced that we want to describe the address
decoding windows in the DT, because it is too static. For example, the
number, size and location of address decoding windows for PCIe
interfaces vary depending on the PCIe devices connected in those PCIe
interfaces. So we clearly do not want to have address decoding windows
fixed in stone in the Device Tree, in my opinion.

Instead, I think the "address decoding window driver" in the kernel
should provide an API for device drivers to request an address decoding
window at a given address, with a given size and target/attribute. This
is already what the PCIe code is doing (I'm going to submit v2 of the
PCIe code soon), and I think we should to the same for other devices as
well.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
