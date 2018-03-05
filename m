From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon, 05 Mar 2018 22:50:58 +0800
Subject: Question about a quirky (DesignWare) PCIe RC in Allwinner H6
Message-ID: <1520261458.33502.10.camel@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

I'm trying to implement a driver for the quirky (DW) PCIe RC in the
Allwinner H6 SoC.

The quirk is that only the "dbi" space is always mapped, but at the
same time only 64KiB of other spaces (config, downstream IO and non-
prefetchable memory) are accessible. To access a certain address the
high 16-bit of the address (all bus addresses in H6 SoC are 32-bit
despite the CPU is 64-bit) needs to be written into the
PCIE_ADDR_PAGE_CFG register (a vendor-defined register in DBI space).
So the access to these spaces cannot be processed correctly with just
readl/writel, as the existing code does.

Is it possible to workaround this in the PCI subsystem of Linux?

(I have thought a workaround that only maps the current accessible
64KiB with the MMU, and when accessing the non-accessible part, catch
the page fault and re-setup the map to the new 64KiB page. But surely
it will kill the performance.)

Thanks,
Icenowy
