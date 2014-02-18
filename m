From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Tue, 18 Feb 2014 18:29:56 +0100
Subject: pci-mvebu driver on km_kirkwood
In-Reply-To: <20130711163220.2b3adf38@skate>
References: <51DD88A4.1030506@keymile.com>	<20130710185706.72b124a4@skate>	<51DD9A8C.10608@keymile.com>
 <20130711163220.2b3adf38@skate>
Message-ID: <53039894.10905@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

sorry for bringing up an old topic again...

On 07/11/2013 04:32 PM, Thomas Petazzoni wrote:
> Dear Gerlando Falauto,
>
> On Wed, 10 Jul 2013 19:31:56 +0200, Gerlando Falauto wrote:
>
>> Yes, though we had to trick it a little bit to get both the internal
>> switch and this PCIe device working:
>>
>> - this PCIe device requires to map 256M of memory as opposed to just 128
>> - we need a virtual PCIe device to connect to the internal switch, which
>> must be mapped at 0xf4000000 (normally used for the NAND which must then
>> move to 0xff000000)
>
> Aah, if you need 256 MB, then you need to adjust the ranges, because
> by default there is only 128 MB for PCIe memory. So, you would need
> something like:
>
> So, within the pcie-controller node, you should do something like:
>
> 			ranges = <0x82000000 0 0x00040000 0x00040000 0 0x00002000   /* Port 0.0 registers */
> 				  0x82000000 0 0xe0000000 0xe0000000 0 0x10000000   /* non-prefetchable memory */
> 			          0x81000000 0 0          0xf0000000 0 0x00100000>; /* downstream I/O */
>
> and in the ranges property at the ocp { } level, you should do something like:
>
>
> 		ranges = <0x00000000 0xf1000000 0x0100000
> 		          0xe0000000 0xe0000000 0x10100000 /* PCIE */
> 		          0xf4000000 0xf4000000 0x0000400
> 		          0xf5000000 0xf5000000 0x0000400>;
>
> Basically, before the change the configuration was:
>
>   * 128 MB of PCIe memory at 0xe0000000
>   * 1 MB of PCIe I/O at 0xe8000000
>
> After the change, you have:
>
>   * 256 MB of PCIe memory at 0xe0000000
>   * 1 MB of PCIe I/O at 0xf0000000
>

I tried these settings (a long time ago) and everything seemed to work 
fine. Except, we now have a different problem.
Essentially, this device requires 128MB for a given BAR to provide a 
PCI-to-localbus bridge. (another BAR provides the configuration space to 
configure chip select regions and so on).
Apparently, only the first 64MB of this BAR seem to work correctly with 
the new driver. As soon as you exceed that, reads (always?) return 0.
Other BARs (which are then of course assigned a higher region) seem to 
work just fine, so it looks like a per-BAR limitation.

This was not a problem with a 3.0 kernel. Do you have any idea what 
could be wrong here?
I'm currently using a 3.10 kernel, where your patches for the pci-mvebu 
driver were forcibly brought in (without full support for the MBUS 
description at device tree level though).

Thank you very much in advance,

Gerlando

P.S. Here's the relevant portion of the startup log so to give you an 
idea of the layout:

mvebu-pcie pcie-controller.1: PCIe0.0: link up
mvebu-pcie pcie-controller.1: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x1000-0xfffff]
pci_bus 0000:00: root bus resource [mem 0xe0000000-0xefffffff]
pci_bus 0000:00: root bus resource [bus 00-ff]
pci 0000:00:01.0: [11ab:7846] type 01 class 0x060400
PCI: bus0: Fast back to back transfers disabled
pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:01:00.0: [10ee:0008] type 00 class 0x050000
pci 0000:01:00.0: reg 10: [mem 0x00000000-0x00000fff]
pci 0000:01:00.0: reg 14: [mem 0x00000000-0x07ffffff]
pci 0000:01:00.0: reg 18: [mem 0x00000000-0x00000fff]
pci 0000:01:00.0: reg 1c: [mem 0x00000000-0x007fffff]
pci 0000:01:00.0: reg 20: [mem 0x00000000-0x00001fff]
pci 0000:01:00.0: reg 24: [mem 0x00000000-0x00000fff]
pci 0000:01:00.0: supports D1 D2
pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot
PCI: bus1: Fast back to back transfers disabled
pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
pci 0000:00:01.0: BAR 8: assigned [mem 0xe0000000-0xebffffff]
pci 0000:01:00.0: BAR 1: assigned [mem 0xe0000000-0xe7ffffff]
pci 0000:01:00.0: BAR 3: assigned [mem 0xe8000000-0xe87fffff]
pci 0000:01:00.0: BAR 4: assigned [mem 0xe8800000-0xe8801fff]
pci 0000:01:00.0: BAR 0: assigned [mem 0xe8802000-0xe8802fff]
pci 0000:01:00.0: BAR 2: assigned [mem 0xe8803000-0xe8803fff]
pci 0000:01:00.0: BAR 5: assigned [mem 0xe8804000-0xe8804fff]
pci 0000:00:01.0: PCI bridge to [bus 01]
pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xebffffff]
PCI: enabling device 0000:00:01.0 (0140 -> 0143)
