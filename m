From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 11 Apr 2013 21:45:56 +0200
Subject: [PATCHv2 08/10] arm: kirkwood: convert QNAP TS219 to use DT for
 the PCIe interface
In-Reply-To: <20130411052432.GP13524@lunn.ch>
References: <1365632436-25367-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1365632436-25367-9-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130411003301.GH28693@titan.lakedaemon.net>
 <20130411052432.GP13524@lunn.ch>
Message-ID: <20130411194556.GB5061@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi Jason
> 
> It has been broken for a while, hence the FIXME!
> 
> Looking at the old style code, only a machine whos bootloader passed
> the machine ID ts219 has PCI. This is the only difference between
> ts219 and all other similar devices that use this DT description.
> 
> The FIXME comment is referring to a comment in the code:
> 
>         MPP44_GPIO,             /* Board ID: 0: TS-11x, 1: TS-21x */
> 
> so it seems like you can read this gpio line but strictly, this tells
> you how many disks bays the box has, and not if its a ts219.
> 
> I've hacked around with PCI driver on my QNAP TS119P+, which does not
> have any PCI devices, and never had any problems with the driver
> enabled and finding two empty PCI busses. PCI does not share any pins
> with anything else. So i think it is safe to just enable it for all
> devices.
> 
> I will test it out on my device and report back.

Hi Jason

Once i hacked around the DT issue, i have it booting and detecting the
PCI:

root at qnap:~# lspci -v
00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 7846 (prog-if 00 [Norm)
        Flags: bus master, 66MHz, user-definable features, ?? devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Capabilities: [fc] <chain broken>

As expected, nothing on the bus.

In the kernel log is:

mvebu-pcie pcie-controller.1: PCIe0.0: link up
mvebu-pcie pcie-controller.1: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x1000-0xfffff]
pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
pci_bus 0000:00: root bus resource [bus 00-ff]
pci 0000:00:01.0: [11ab:7846] type 01 class 0x060400
PCI: bus0: Fast back to back transfers disabled
pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
PCI: bus1: Fast back to back transfers enabled
pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
pci 0000:00:01.0: PCI bridge to [bus 01]
PCI: enabling device 0000:00:01.0 (0140 -> 0143)
 
root at qnap:/debug/mvebu-mbus# cat devices 
[00] disabled
[01] disabled
[02] disabled
[03] disabled
[04] 00000000f4000000 - 00000000f4010000 : nand
[05] 00000000f5000000 - 00000000f5010000 : sram
[06] disabled
[07] disabled

So i guess that means its not allocated any windows either.

I will go investigate the PEX clock strapping as suggested by Jason.

  Andrew
