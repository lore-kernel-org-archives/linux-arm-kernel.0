From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Feb 2015 21:05:52 +0100
Subject: Extending the Marvell MBus DT binding to create remappable windows
In-Reply-To: <20150216182805.529a0071@free-electrons.com>
References: <20150216182805.529a0071@free-electrons.com>
Message-ID: <2546568.bLP37K1160@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 February 2015 18:28:05 Thomas Petazzoni wrote:

> Now, on the newly released Armada 39x SoC, the networking complex
> requires some MBus windows, and one of them needs to be configured
> with a certain "remap" value. Those windows are not dynamic like the
> PCIe ones: they should be defined statically in the Device Tree, just
> like the MBus window for a NOR flash.

Ok
 
> Unfortunately, it seems we designed the Device Tree binding for MBus
> without this use case in mind: there is no way in the MBus DT binding
> to specify a "remap" address for a certain window.

We did? I thought that the binding allowed the case you described,
but it's quite possible that I'm missing something.

> Do you have an idea on how we could extend the MBus Device Tree
> binding to encode this additional information?
> 
> If you want to learn more about this remappable attribute, look at the
> public Armada XP datasheet
> (http://www.marvell.com/embedded-processors/armada-xp/assets/ARMADA-XP-Functional-SpecDatasheet.pdf),
> section 3.1.1 for example. This section is only about PCIe remapping,
> but the same happens for other devices. Also look at the description
> of register 0x20008 (table 182, page 631), it describes the remap
> register for window 0.

Looking at for example arch/arm/boot/dts/armada-xp-netgear-rn2120.dts,
I find the following mbus ranges

            ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
                      MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000>;
                         ^                ^ ^     ^         ^
                         a                b c     c         d

and here the table should get set up from the fields like

a) mbus target (32 bit)
b) mbus-local address (32 bit)
c) cpu-physical address (64 bit)
d) window size

with the registers from the spec, this seems to map to

a) 0x00020000
b) 0x00020008
c) 0x00020004
d) 0x00020000

so you just need to put the remap-address into the second cell and ensure
that it is correctly evaluated by the driver.

Did you miss that part of the binding, or did I miss what you are
trying to say?

	Arnd
