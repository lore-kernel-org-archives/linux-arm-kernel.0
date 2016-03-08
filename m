From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 8 Mar 2016 14:45:24 +0100
Subject: Broken PCIe on Synology DS414
In-Reply-To: <20160305143445.827496739A@mail.nwl.cc>
References: <20160305143445.827496739A@mail.nwl.cc>
Message-ID: <20160308144524.5f47c217@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Phil,

On Sat, 5 Mar 2016 15:36:31 +0100, Phil Sutter wrote:

> Commit c466d997bb160 ("ARM: mvebu: define crypto SRAM ranges for all
> armada-xp boards") breaks PCIe on the MV78230 based Synology DS414. The
> kernel does not complain, but 'lspci' does not show a single device.
> Reverting this commit cures vanilla 4.5-rc6 again for me.
> 
> Seems like the ranges declared for crypto SRAM conflict with PCIe
> controller ones in some way. Looking at the DT files, all MV78230 based
> devices should be affected, not just the DS414.
> 
> Is this a known problem? Please let me know if there is anything I can
> do to further analyze the issue.

Thanks for reporting the issue. There is indeed an issue with the
crypto SRAM region overlapping with the PCIe aperture. However, this
does not prevent 'lspci' from enumerating the device.

I've tested with 3 different PCIe devices, and got two different
behavior:

 * With 2 PCIe cards (Intel e1000e NIC and some Marvell AHCI SATA
   controller), the PCIe memory region has a size smaller than 1 MB.
   Since the PCIe aperture starts at 0xf8000000 and the crypto SRAM
   mapping at 0xf8100000, this leaves 1 MB of space, which is enough to
   map the resources of those PCIe cards. Both cards are properly
   enumerated (visible in lspci) and usable.

 * With another PCIe card (Intel IGB NIC), the PCIe memory region has a
   size of 8 MB, so it cannot be created at 0xf8000000 as it would
   overlap with the crypto SRAM region. And indeed at boot time, I get:

[    3.302213] igb: Copyright (c) 2007-2014 Intel Corporation.
[    3.307841] pci 0000:00:09.0: enabling device (0140 -> 0143)
[    3.313539] mvebu_mbus: cannot add window '4:f8', conflicts with another window
[    3.320870] mvebu-pcie soc:pcie-controller: Could not create MBus window at [mem 0xf8000000-0xf87fffff]: -22
[    3.330811] Unhandled fault: external abort on non-linefetch (0x1008) at 0xf08c0018

   And the kernel crashes, because the IGB driver tries to access its
   PCIe device memory region, which isn't mapped in the physical
   address space because the MBus window has not been created.

   However, this *only* happens because I have the IGB driver enabled
   in my kernel. If I disable it in my kernel configuration, I can boot
   my system just fine, and the IGB PCIe NIC appears in lspci:

# /usr/sbin/lspci 
00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 7846 (rev 02)
00:09.0 PCI bridge: Marvell Technology Group Ltd. Device 7846 (rev 02)
00:0a.0 PCI bridge: Marvell Technology Group Ltd. Device 7846 (rev 02)
02:00.0 Ethernet controller: Intel Corporation 82575EB Gigabit Network Connection (rev 02)
02:00.1 Ethernet controller: Intel Corporation 82575EB Gigabit Network Connection (rev 02)

In other words, while the crypto SRAM range overlapping issue prevents
from *using* certain PCIe devices, it certainly cannot prevent them
from being enumerated in lspci. So if your issue is that a PCI device
doesn't appear in lspci, then the problem is elsewhere.

You can try to simply remove the crypto SRAM ranges in your .dts file,
and see if it improves the situation. But I would be very surprised if
it did, since the MBus windows are not related to enumerating PCI
devices.

I'll cook and send a patch to fix the crypto SRAM ranges nonetheless.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
