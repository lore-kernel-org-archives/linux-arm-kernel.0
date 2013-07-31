From: finn@uni-bremen.de (Finn Hoffmann)
Date: Wed, 31 Jul 2013 11:43:22 +0200
Subject: NSA310 + DT
In-Reply-To: <20130731111414.47e7670b@skate>
References: <20130710073706.GA28212@lunn.ch> <51F6A0DC.3020501@uni-bremen.de>
 <20130729192112.GY29916@titan.lakedaemon.net>
 <20130729204315.GK24782@lunn.ch> <51F78DA6.8010307@uni-bremen.de>
 <20130730144752.GR24782@lunn.ch> <20130730172407.3aab15c6@skate>
 <51F7EBB9.7000504@uni-bremen.de> <20130730191943.49f8070c@skate>
 <20130730183610.GT24782@lunn.ch> <51F814A0.2050403@uni-bremen.de>
 <20130730232316.10dc7019@skate> <20130731111414.47e7670b@skate>
Message-ID: <51F8DC3A.6010007@uni-bremen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Am 31.07.2013 11:14, schrieb Thomas Petazzoni:
> Hello Finn,
>
> On Tue, 30 Jul 2013 23:23:16 +0200, Thomas Petazzoni wrote:
>
>> Thanks for this log. I need a bit of time to analyze this with the
>> PCI-to-PCI bridge specification, and I'll cook up a new patch,
>> hopefully tomorrow.
>>
>> Thanks again a lot for taking the time to report this bug and test the
>> patches,
> Ok, here is another patch that completely disables prefetchable
> support, which hopefully should make the PCI stuff fallback on normal
> memory. Could you try this one, and again report lspci -v + the
> contents of the debugfs file that lists the mbus windows?
>
> I've worked more on the prefetchable support, but doing it right with
> the PCI-to-PCI bridge emulation is a bit complex.
>
> Thanks!
>
> Thomas
>
Hi Thomas,
here you are.
Network is working.
Thanks
Finn


$ lspci -v
00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 7846 (prog-if 
00 [Normal decode])
         Flags: bus master, fast devsel, latency 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 00010000-00010fff
         Memory behind bridge: e0000000-e00fffff
         Prefetchable memory behind bridge: 00000000-000fffff

01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL8111/8168B PCI Express Gigabit Ethernet controller (rev)
         Subsystem: Realtek Semiconductor Co., Ltd. TEG-ECTX Gigabit 
PCI-E Adapter [Trendnet]
         Flags: bus master, fast devsel, latency 0, IRQ 9
         I/O ports at 10000 [size=256]
         Memory at e0014000 (64-bit, prefetchable) [size=4K]
         Memory at e0010000 (64-bit, prefetchable) [size=16K]
         [virtual] Expansion ROM at e0000000 [disabled] [size=64K]
         Capabilities: <access denied>
         Kernel driver in use: r8169

# cat /sys/kernel/debug/mvebu-mbus/devices
[00] 00000000e8010000 - 00000000e8020000 : pcie0.0 (remap 0000000000010000)
[01] disabled
[02] disabled
[03] disabled
[04] 00000000f4000000 - 00000000f4010000 : nand
[05] 00000000f5000000 - 00000000f5010000 : sram
[06] 00000000e0000000 - 00000000e0100000 : pcie0.0
[07] disabled

bootlog excerpt:
mvebu-pcie pcie-controller.1: PCIe0.0: link up
mvebu-pcie pcie-controller.1: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x1000-0xfffff]
pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
pci_bus 0000:00: root bus resource [bus 00-ff]
PCI: bus0: Fast back to back transfers disabled
pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
PCI: bus1: Fast back to back transfers disabled
pci 0000:00:01.0: BAR 8: assigned [mem 0xe0000000-0xe00fffff]
pci 0000:00:01.0: BAR 7: assigned [io  0x10000-0x10fff]
pci 0000:01:00.0: BAR 6: assigned [mem 0xe0000000-0xe000ffff pref]
pci 0000:01:00.0: BAR 4: assigned [mem 0xe0010000-0xe0013fff 64bit pref]
pci 0000:01:00.0: BAR 2: assigned [mem 0xe0014000-0xe0014fff 64bit pref]
pci 0000:01:00.0: BAR 0: assigned [io  0x10000-0x100ff]
pci 0000:00:01.0: PCI bridge to [bus 01]
pci 0000:00:01.0:   bridge window [io  0x10000-0x10fff]
pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xe00fffff]
PCI: enabling device 0000:00:01.0 (0140 -> 0143)
