From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Wed, 10 Jul 2013 21:56:01 +0200
Subject: pci-mvebu driver on km_kirkwood
In-Reply-To: <51DD9A8C.10608@keymile.com>
References: <51DD88A4.1030506@keymile.com> <20130710185706.72b124a4@skate>
 <51DD9A8C.10608@keymile.com>
Message-ID: <51DDBC51.4050009@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

I guess I understand now....

 >>> pci 0000:00:01.0: BAR 8: can't assign mem (size 0xc000000)

this is the BAR for the bridge, your virtual PCI host device, whose size 
is calculated dynamically depending on what is found on the underlying 
hardware.
So compared to the legacy driver which was relying on the real hardware 
BARs (where I could get /some/ BARs to work, namely the biggest one 
which was taking up the whole 128M), here it's an all-or-nothing approach.
As a matter of fact, everything works fine if I explicitly disable the 
biggest BAR with a trick:

mvebu-pcie pcie-controller.1: PCIe0.0: link up
mvebu-pcie pcie-controller.1: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x1000-0xfffff]
pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
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
pci 0000:01:00.0: disabling BAR 1: [mem 0x00000000-0x07ffffff] TOO BIG 
(alignment 0x1000)
pci 0000:00:01.0: BAR 8: assigned [mem 0xe0000000-0xe0bfffff]
pci 0000:01:00.0: BAR 3: assigned [mem 0xe0000000-0xe07fffff]
pci 0000:01:00.0: BAR 4: assigned [mem 0xe0800000-0xe0801fff]
pci 0000:01:00.0: BAR 0: assigned [mem 0xe0802000-0xe0802fff]
pci 0000:01:00.0: BAR 2: assigned [mem 0xe0803000-0xe0803fff]
pci 0000:01:00.0: BAR 5: assigned [mem 0xe0804000-0xe0804fff]
pci 0000:00:01.0: PCI bridge to [bus 01]
pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xe0bfffff]

So this seems to be the final solution (without the hack above):

--- a/arch/arm/boot/dts/kirkwood-98dx4122.dtsi
+++ b/arch/arm/boot/dts/kirkwood-98dx4122.dtsi
                         bus-range = <0x00 0xff>;

                         ranges = <0x82000000 0 0x00040000 0x00040000 0 
0x00002000   /* Port 0.0 registers */
-                                 0x82000000 0 0xe0000000 0xe0000000 0 
0x08000000   /* non-prefetchable memory */
+                                 0x82000000 0 0xe0000000 0xe0000000 0 
0x0c000000   /* non-prefetchable memory */
                                   0x81000000 0 0          0xe8000000 0 
0x00100000>; /* downstream I/O */

                         pcie at 1,0 {

Does the above make sense? Am I setting up overlapping ranges this way?
Could I make it 0x10000000 so to have 256M?

Thanks a lot!
Gerlando

On 07/10/2013 07:31 PM, Gerlando Falauto wrote:
> Hi Thomas,
>
> first of all thanks for your quick feedback.
>
> On 07/10/2013 06:57 PM, Thomas Petazzoni wrote:
>> Gerlando,
>>
>> On Wed, 10 Jul 2013 18:15:32 +0200, Gerlando Falauto wrote:
>>
>>> I am trying to use the pci-mvebu driver on one of our km_kirkwood
>>> boards. The board is based on Marvell's 98dx4122, which should
>>> essentially be 6281 compatible.
>>
>> Was this platform working with the old PCIe driver in mach-kirkwood/ ?
>
> Yes, though we had to trick it a little bit to get both the internal
> switch and this PCIe device working:
>
> - this PCIe device requires to map 256M of memory as opposed to just 128
> - we need a virtual PCIe device to connect to the internal switch, which
> must be mapped at 0xf4000000 (normally used for the NAND which must then
> move to 0xff000000)
>
> But apart from the huge BAR (0x07ffffff aka 128M) for the PCIe device
> not being mappable, the rest was normally working just fine even without
> the above changes (i.e. the other BARs were mapped fine).
>
>>
>>> The code I took from jcooper's repo:
>>>
>>>     http://git.infradead.org/users/jcooper/linux.git
>>>
>>> I took the tag
>>>
>>>     dt-3.11-6
>>>
>>> on top of which I merged:
>>>
>>>     mvebu/pcie
>>>     mvebu/pcie_bridge
>>>     mvebu/pcie_kirkwood
>>
>> Could you instead use the latest master from Linus tree? That would
>> avoid merge conflicts, and ensure you have all the necessary pieces.
>
> Oops, I had no idea all this had gotten merged already.
> Quite honestly, I have no idea how to track this kind of stuff (i.e. did
> a given patch ever got merged and where?) but that's a different topic.
>
>>> Only with the latest merge did I get some conflict on
>>> kirkwood.dtsi:
>>>
>>> <<<<<<< HEAD
>>>         ranges = <0x00000000 0xf1000000 0x0100000
>>>                   0xf4000000 0xf4000000 0x0000400
>>> =======
>>>         ranges = <0x00000000 0xf1000000 0x4000000
>>>                   0xe0000000 0xe0000000 0x8100000
>>
>> The first cannot work, because it lacks the range for the PCIe. The
>> second should work. The correct merge should be:
>>
>>           ranges = <0x00000000 0xf1000000 0x0100000
>>                     0xf4000000 0xf4000000 0x0000400
>>                     0xe0000000 0xe0000000 0x8100000>;
>>
>> i.e, we've added the PCIe range (last line) and splitted the SRAM into
>> its own range (or something like that, don't remember the details, but
>> Ezequiel can confirm).
>
> OK that's a good starting point.
>
>>> <<<<<<< HEAD
>>> Kirkwood: MV88F6281-A0, TCLK=200000000.
>>> Feroceon L2: Cache support initialised, in WT override mode.
>>> mvebu-pcie pcie-controller.1: PCIe0.0: link up
>>> mvebu-pcie pcie-controller.1: PCI host bridge to bus 0000:00
>>> pci_bus 0000:00: root bus resource [io  0x1000-0xfffff]
>>> pci_bus 0000:00: root bus resource [mem 0xffffffff-0x07fffffe]
>>> pci_bus 0000:00: root bus resource [bus 00-ff]
>>> pci 0000:00:01.0: [11ab:7846] type 01 class 0x060400
>>> PCI: bus0: Fast back to back transfers disabled
>>> pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]),
>>> reconfiguring
>>> pci 0000:01:00.0: [10ee:0008] type 00 class 0x050000
>>> pci 0000:01:00.0: reg 10: [mem 0x00000000-0x00000fff]
>>> pci 0000:01:00.0: reg 14: [mem 0x00000000-0x07ffffff]
>>> pci 0000:01:00.0: reg 18: [mem 0x00000000-0x00000fff]
>>> pci 0000:01:00.0: reg 1c: [mem 0x00000000-0x007fffff]
>>> pci 0000:01:00.0: reg 20: [mem 0x00000000-0x00001fff]
>>> pci 0000:01:00.0: reg 24: [mem 0x00000000-0x00000fff]
>>> pci 0000:01:00.0: supports D1 D2
>>> pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot
>>> PCI: bus1: Fast back to back transfers disabled
>>> pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
>>> pci 0000:00:01.0: BAR 8: can't assign mem (size 0xc000000)
>>> pci 0000:01:00.0: BAR 1: can't assign mem (size 0x8000000)
>>> pci 0000:01:00.0: BAR 3: can't assign mem (size 0x800000)
>>> pci 0000:01:00.0: BAR 4: can't assign mem (size 0x2000)
>>> pci 0000:01:00.0: BAR 0: can't assign mem (size 0x1000)
>>> pci 0000:01:00.0: BAR 2: can't assign mem (size 0x1000)
>>> pci 0000:01:00.0: BAR 5: can't assign mem (size 0x1000)
>>> pci 0000:00:01.0: PCI bridge to [bus 01]
>>
>> The first test you did cannot work at all, due to the incorrect ranges.
>>
>> If you have the PCIe working with the old driver, can you pastebin
>> somewhere the complete boot log, as well as the output of "lspci
>> -vvv" ?
>
> OK, I will.
> In the meantime, what I got to establish is that by manually disabling
> the two biggest resources
>
>  >> pci 0000:00:01.0: BAR 8: can't assign mem (size 0xc000000)
>  >> pci 0000:01:00.0: BAR 1: can't assign mem (size 0x8000000)
>
> i.e. something like:
>
> -281,6 +282,10 @@ static void assign_requested_resources_sorted(struct
> list_head *head,
>          list_for_each_entry(dev_res, head, list) {
>                  res = dev_res->res;
>                  idx = res - &dev_res->dev->resource[0];
> +
> +               if (resource_size(res) < 0x8000000)
> +               {
> +
>
> at least I can get the following ones to be assigned correctly:
>
> mvebu-pcie pcie-controller.2: PCIe0.0: link up
> mvebu-pcie pcie-controller.2: PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io  0x1000-0xfffff]
> pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
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
> pci 0000:01:00.0: BAR 3: assigned [mem 0x04000000-0x047fffff]
> pci 0000:01:00.0: BAR 3: set to [mem 0x04000000-0x047fffff] (PCI address
> [0x4000000-0x47fffff])
> pci 0000:01:00.0: BAR 4: assigned [mem 0x04800000-0x04801fff]
> pci 0000:01:00.0: BAR 4: set to [mem 0x04800000-0x04801fff] (PCI address
> [0x4800000-0x4801fff])
> pci 0000:01:00.0: BAR 0: assigned [mem 0x04802000-0x04802fff]
> pci 0000:01:00.0: BAR 0: set to [mem 0x04802000-0x04802fff] (PCI address
> [0x4802000-0x4802fff])
> pci 0000:01:00.0: BAR 2: assigned [mem 0x04803000-0x04803fff]
> pci 0000:01:00.0: BAR 2: set to [mem 0x04803000-0x04803fff] (PCI address
> [0x4803000-0x4803fff])
> pci 0000:01:00.0: BAR 5: assigned [mem 0x04804000-0x04804fff]
> pci 0000:01:00.0: BAR 5: set to [mem 0x04804000-0x04804fff] (PCI address
> [0x4804000-0x4804fff])
> pci 0000:00:01.0: PCI bridge to [bus 01]
> pci 0000:00:01.0:   bridge window [mem 0x04000000-0x0fffffff]
> PCI: enabling device 0000:00:01.0 (0140 -> 0143)
>
>
> Which is a bit weird because in the past these huge assignments would
> just fail but the following ones would work just fine.
>
>>
>>> Compared to a working configuration, here I see a spurious
>>>
>
> I assume the
>
>>>     pci 0000:00:01.0: BAR 8: can't assign mem (size 0xc000000)
>>>
>
> comes from the switch but I have no idea how to find it out.
> I'm quite sure this is the first time I'm seeing BAR 8.
>
>>> which I don't understand, plus all others which are failing.
>>>
>>> It's weird how with the second configuration:
>>>
>>>     mvebu-pcie pcie-controller.2: PCIe0.0: link up
>>>     mvebu-pcie pcie-controller.2: PCI host bridge to bus 0000:00
>>>     pci_bus 0000:00: root bus resource [io  0x1000-0xfffff]
>>>     pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
>>>
>>> I get a second mvebu-pcie pcie-controller.2, although with a more
>>> reasonable memory range.
>>
>> A second mvebu-pcie controller? Is your Device Tree correct?
>
> Whoops, my fault. There's just one pcie-controller.2, it's just that
> with the correct ranges the nand.1 node gets created as well, and these
> (platform?) devices are numbered sequentially, regardless of their type.
>
>>
>> I'm not really sure to understand what's going on here. Can you post
>> the complete boot log, and test with the latest Linus git tree, where
>> all the PCIe support got merged?
>
> I sure will.
> Thanks for the heads-up.
>
> Thanks a lot!
> Gerlando
>
>>
>> Thanks!
>>
>> Thomas
>>
>
