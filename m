From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Wed, 19 Feb 2014 09:38:48 +0100
Subject: pci-mvebu driver on km_kirkwood
In-Reply-To: <20140218212751.07c2aeb5@skate>
References: <51DD88A4.1030506@keymile.com>	<20130710185706.72b124a4@skate>	<51DD9A8C.10608@keymile.com>	<20130711163220.2b3adf38@skate>	<53039894.10905@keymile.com>
 <20140218212751.07c2aeb5@skate>
Message-ID: <53046D98.6020801@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

first of all thank you for your invaluable help!

On 02/18/2014 09:27 PM, Thomas Petazzoni wrote:
> Dear Gerlando Falauto,
>
> On Tue, 18 Feb 2014 18:29:56 +0100, Gerlando Falauto wrote:
>
>> I tried these settings (a long time ago) and everything seemed to work
>> fine. Except, we now have a different problem.
>> Essentially, this device requires 128MB for a given BAR to provide a
>> PCI-to-localbus bridge. (another BAR provides the configuration space to
>> configure chip select regions and so on).
>> Apparently, only the first 64MB of this BAR seem to work correctly with
>> the new driver. As soon as you exceed that, reads (always?) return 0.
>> Other BARs (which are then of course assigned a higher region) seem to
>> work just fine, so it looks like a per-BAR limitation.
>>
>> This was not a problem with a 3.0 kernel. Do you have any idea what
>> could be wrong here?
>> I'm currently using a 3.10 kernel, where your patches for the pci-mvebu
>> driver were forcibly brought in (without full support for the MBUS
>> description at device tree level though).
>
> [...]
>
>> mvebu-pcie pcie-controller.1: PCIe0.0: link up
>> mvebu-pcie pcie-controller.1: PCI host bridge to bus 0000:00
>> pci_bus 0000:00: root bus resource [io  0x1000-0xfffff]
>> pci_bus 0000:00: root bus resource [mem 0xe0000000-0xefffffff]
>> pci_bus 0000:00: root bus resource [bus 00-ff]
>> pci 0000:00:01.0: [11ab:7846] type 01 class 0x060400
>> PCI: bus0: Fast back to back transfers disabled
>> pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>> pci 0000:01:00.0: [10ee:0008] type 00 class 0x050000
>> pci 0000:01:00.0: reg 10: [mem 0x00000000-0x00000fff]
>> pci 0000:01:00.0: reg 14: [mem 0x00000000-0x07ffffff]
>> pci 0000:01:00.0: reg 18: [mem 0x00000000-0x00000fff]
>> pci 0000:01:00.0: reg 1c: [mem 0x00000000-0x007fffff]
>> pci 0000:01:00.0: reg 20: [mem 0x00000000-0x00001fff]
>> pci 0000:01:00.0: reg 24: [mem 0x00000000-0x00000fff]
>> pci 0000:01:00.0: supports D1 D2
>> pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot
>> PCI: bus1: Fast back to back transfers disabled
>> pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
>> pci 0000:00:01.0: BAR 8: assigned [mem 0xe0000000-0xebffffff]
>> pci 0000:01:00.0: BAR 1: assigned [mem 0xe0000000-0xe7ffffff]
>
> So I guess this one is the 128 MB BAR, right?

That's correct.

>
>> pci 0000:01:00.0: BAR 3: assigned [mem 0xe8000000-0xe87fffff]
>> pci 0000:01:00.0: BAR 4: assigned [mem 0xe8800000-0xe8801fff]
>> pci 0000:01:00.0: BAR 0: assigned [mem 0xe8802000-0xe8802fff]
>> pci 0000:01:00.0: BAR 2: assigned [mem 0xe8803000-0xe8803fff]
>> pci 0000:01:00.0: BAR 5: assigned [mem 0xe8804000-0xe8804fff]
>
> So in total, for the device 0000:01:00, the memory region should go
> from 0xe0000000 to 0xe8804fff. This means that a 256 MB window is
> needed for this device, because only power of two sizes are possible
> for MBus windows.
>
> Can you give me the output of /sys/kernel/debug/mvebu-mbus/devices ? It
> will tell us how the MBus windows are configured, as I suspect the
> problem might be here.

Here it goes:

[00] disabled
[01] disabled
[02] disabled
[03] disabled
[04] 00000000ff000000 - 00000000ff010000 : nand
[05] 00000000f4000000 - 00000000f8000000 : vpcie
[06] 00000000fe000000 - 00000000fe010000 : dragonite
[07] 00000000e0000000 - 00000000ec000000 : pcie0.0

So there's something wrong: a 256MB window should go all the way up to 
0xf0000000, and we have 192MB instead and I don't know how that would be 
interpreted.
I couldn't figure out where this range comes from though, as in the 
device tree I now have a size of 256MB (I stupidly set it to 192MB at 
some point, but I now changed it):

# hexdump -C /proc/device-tree/ocp at f1000000/pcie-controller/ranges
  | cut -c1-58
00000000  82 00 00 00 00 00 00 00  00 04 00 00 00 04 00 00
00000010  00 00 00 00 00 00 20 00  82 00 00 00 00 00 00 00
00000020  e0 00 00 00 e0 00 00 00  00 00 00 00 10 00 00 00
                                                ^^^^^^^^^^^
00000030  81 00 00 00 00 00 00 00  00 00 00 00 f0 00 00 00
00000040  00 00 00 00 00 10 00 00
00000048

But apart from that, what I still don't understand is how that could 
have anything to do with my problem. The memory area I'm not able to 
access starts at 0xe4000000.
BAR0, on the other hand, spawns 0xe8802000-0xe8802fff and seems to work 
fine.

Any ideas?

Thanks a lot!
Gerlando
