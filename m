From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 10 Jul 2013 18:57:06 +0200
Subject: pci-mvebu driver on km_kirkwood
In-Reply-To: <51DD88A4.1030506@keymile.com>
References: <51DD88A4.1030506@keymile.com>
Message-ID: <20130710185706.72b124a4@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gerlando,

On Wed, 10 Jul 2013 18:15:32 +0200, Gerlando Falauto wrote:

> I am trying to use the pci-mvebu driver on one of our km_kirkwood 
> boards. The board is based on Marvell's 98dx4122, which should 
> essentially be 6281 compatible.

Was this platform working with the old PCIe driver in mach-kirkwood/ ?


> The code I took from jcooper's repo:
> 
>    http://git.infradead.org/users/jcooper/linux.git
> 
> I took the tag
> 
>    dt-3.11-6
> 
> on top of which I merged:
> 
>    mvebu/pcie
>    mvebu/pcie_bridge
>    mvebu/pcie_kirkwood

Could you instead use the latest master from Linus tree? That would
avoid merge conflicts, and ensure you have all the necessary pieces.

> Only with the latest merge did I get some conflict on
> kirkwood.dtsi:
> 
> <<<<<<< HEAD
> 		ranges = <0x00000000 0xf1000000 0x0100000		
> 		          0xf4000000 0xf4000000 0x0000400
> =======
> 		ranges = <0x00000000 0xf1000000 0x4000000
> 		          0xe0000000 0xe0000000 0x8100000

The first cannot work, because it lacks the range for the PCIe. The
second should work. The correct merge should be:

 		ranges = <0x00000000 0xf1000000 0x0100000		
 		          0xf4000000 0xf4000000 0x0000400
 		          0xe0000000 0xe0000000 0x8100000>;

i.e, we've added the PCIe range (last line) and splitted the SRAM into
its own range (or something like that, don't remember the details, but
Ezequiel can confirm).

> <<<<<<< HEAD
> Kirkwood: MV88F6281-A0, TCLK=200000000.
> Feroceon L2: Cache support initialised, in WT override mode.
> mvebu-pcie pcie-controller.1: PCIe0.0: link up
> mvebu-pcie pcie-controller.1: PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io  0x1000-0xfffff]
> pci_bus 0000:00: root bus resource [mem 0xffffffff-0x07fffffe]
> pci_bus 0000:00: root bus resource [bus 00-ff]
> pci 0000:00:01.0: [11ab:7846] type 01 class 0x060400
> PCI: bus0: Fast back to back transfers disabled
> pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> pci 0000:01:00.0: [10ee:0008] type 00 class 0x050000
> pci 0000:01:00.0: reg 10: [mem 0x00000000-0x00000fff]
> pci 0000:01:00.0: reg 14: [mem 0x00000000-0x07ffffff]
> pci 0000:01:00.0: reg 18: [mem 0x00000000-0x00000fff]
> pci 0000:01:00.0: reg 1c: [mem 0x00000000-0x007fffff]
> pci 0000:01:00.0: reg 20: [mem 0x00000000-0x00001fff]
> pci 0000:01:00.0: reg 24: [mem 0x00000000-0x00000fff]
> pci 0000:01:00.0: supports D1 D2
> pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot
> PCI: bus1: Fast back to back transfers disabled
> pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> pci 0000:00:01.0: BAR 8: can't assign mem (size 0xc000000)
> pci 0000:01:00.0: BAR 1: can't assign mem (size 0x8000000)
> pci 0000:01:00.0: BAR 3: can't assign mem (size 0x800000)
> pci 0000:01:00.0: BAR 4: can't assign mem (size 0x2000)
> pci 0000:01:00.0: BAR 0: can't assign mem (size 0x1000)
> pci 0000:01:00.0: BAR 2: can't assign mem (size 0x1000)
> pci 0000:01:00.0: BAR 5: can't assign mem (size 0x1000)
> pci 0000:00:01.0: PCI bridge to [bus 01]

The first test you did cannot work at all, due to the incorrect ranges.

If you have the PCIe working with the old driver, can you pastebin
somewhere the complete boot log, as well as the output of "lspci
-vvv" ?

> Compared to a working configuration, here I see a spurious
> 
>    pci 0000:00:01.0: BAR 8: can't assign mem (size 0xc000000)
> 
> which I don't understand, plus all others which are failing.
> 
> It's weird how with the second configuration:
> 
>    mvebu-pcie pcie-controller.2: PCIe0.0: link up
>    mvebu-pcie pcie-controller.2: PCI host bridge to bus 0000:00
>    pci_bus 0000:00: root bus resource [io  0x1000-0xfffff]
>    pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
> 
> I get a second mvebu-pcie pcie-controller.2, although with a more 
> reasonable memory range.

A second mvebu-pcie controller? Is your Device Tree correct?

I'm not really sure to understand what's going on here. Can you post
the complete boot log, and test with the latest Linus git tree, where
all the PCIe support got merged?

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
