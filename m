From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 28 Jan 2013 11:07:16 -0700
Subject: [RFC V2 PATCH 0/8] ARM: kirkwood: cleanup DT conversion
In-Reply-To: <20130128104008.GA5170@localhost>
References: <cover.1358983578.git.jason@lakedaemon.net>
 <cover.1359091286.git.jason@lakedaemon.net>
 <201301251115.47480.arnd@arndb.de>
 <20130125125214.GI1758@titan.lakedaemon.net>
 <CABJ1b_QaTBLgGASTs2yi435jR=LepN-iY97xTLXAu1hZw69Wuw@mail.gmail.com>
 <20130125183407.GC7393@obsidianresearch.com>
 <20130128104008.GA5170@localhost>
Message-ID: <20130128180716.GA9436@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >         // MBUS Decoder window for NAND
> >         nand at f4000000 {
> >                 #address-cells = <1>;
> >                 #size-cells = <1>;
> >                 compatible = "simple-bus", "marvell,orion-mbus";
> > 		mbus-target = 0xXXXXX;
> >                 ranges = <0 0xf4000000 0x10000>;
> > 
> >                 nand at 0 {
> >                         cle = <0>;
> >                         ale = <1>;
> >                         bank-width = <1>;
> >                         chip-delay = <50>;
> >                         compatible = "marvell,orion-nand";
> >                         reg = <0x0 0x400>;
> >                 };
> >         };
> > 
> 
> This is a nice idea.
> 
> I have a few questions, though.
> 
> 1. Are you sure we should use "ranges" property?
> In this case it's not an address translation but rather
> and address window configuration.

Yes, you'd use ranges with an identity transation. The purpose is so
that child OF blocks are all relative to the start of the decode
region. This way changing the address of the HW block behind the mbus
window is simply done by changing the ranges property.

Note the reg on the nand is starting at offset 0, so ranges will
translate that to 0xf4000000. Similar for the internal regs.

> I would think we could add a new "windows" property to reflect
> address window configuration.

My arrangement above would have each "marvell,orion-mbus" specify the
mbus-target, which I imagined to be all the HW specific bits (target,
attributes, etc). The addr-map driver would select a window for this
bus and then assign those bits to it.

> 2. Also, If we use "ranges" property. How would that work?
> By reading the property in the addr-map driver or
> by somehow improving on of_bus to include this new kind of busses?

The addr-map driver would have to read it, I believe the rules of how
busses work make this fairly simple:

1) very early on the addr-map driver would have to scan the OF tree,
   find the address of the mbus mapping registers, and the internal
   register map.
2) Verify the mbus window for the internal registers matches the DT
   This is just a sanity check, if the correct value doesn't come back
   then the DT doesnt match what the bootloader setup, and some
   jtag accessible diagnostic can be printed...
3) Wipe all the mbus windows
4) Register a "marvell,orion-mbus" bus handler somehow
5) When OF processes the DT it would call the bus handler for each
   "marvell,orion-mbus" which should parse the ranges, allocate
   a free window, program that window then instantiate the child
   devices.

Jason
