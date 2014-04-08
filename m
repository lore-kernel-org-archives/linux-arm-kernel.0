From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 8 Apr 2014 23:50:17 +0200
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <2FF5F2FD-2DAC-4E51-87A0-90DBAFE6AA01@xyratex.com>
References: <20140405193435.50d8dd81@skate>
 <54BB31A2B04145E8908E0183FAB6B61B@fatboyfat.co.uk>
 <alpine.DEB.2.10.1404061631130.4683@vroombuntu>
 <20140408171309.09bbf968@skate> <20140408174034.79df403e@skate>
 <20140408175545.1b4d55a5@skate>
 <20140408171417.GB27776@obsidianresearch.com>
 <20140408175324.GH11052@1wt.eu>
 <20140408180828.GC32490@obsidianresearch.com>
 <20140408191514.GJ11052@1wt.eu>
 <20140408192141.GH32490@obsidianresearch.com>
 <2FF5F2FD-2DAC-4E51-87A0-90DBAFE6AA01@xyratex.com>
Message-ID: <20140408235017.2ae3816a@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Matthew Minter,

On Tue, 8 Apr 2014 21:17:47 +0100, Matthew Minter wrote:

> This is just a guess but perhaps the best we could do would be to round up but also add logic to fail completely if adding a PCI device would cause a window to overlap?

Rounding up does not work. Let me try to explain why.

The PCI core enumerates all the BARs into your device and decides that
it should be mapped from 0xe0000000 to 0xe0900000 (9 MB). The PCI core
writes those values into the BAR of the emulated bridge in the
pci-mvebu driver. The pci-mvebu driver captures this write, and figures
out that 9 MB is not good for a MBus window. So it rounds it up to 16
MB, from 0xe0000000 to 0xe1000000, and configures the MBus window. Your
device will work perfectly fine.

Now, the PCI core goes on and enumerate the next device. This device
needs 1 MB of memory space. From the PCI core point of view, only
0xe0000000 to 0xe0900000 is occupied, so for the next device, it may
well decide to use 0xe0900000 -> 0xe0a00000, write this to the BAR of
the emulated bridge, which will lead the emulated bridge to try to
create a window for this area... which isn't possible as it overlaps
the previous window.

Conclusion: rounding up the size of the BARs cannot be done without the
cooperation of the PCI core.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
