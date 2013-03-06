From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  6 Mar 2013 14:43:36 +0100
Subject: [PATCH 3.10] Introduce a Marvell EBU MBus driver
Message-ID: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

As part of the work to write a DT-powered PCIe driver for Marvell SoCs
that sits in drivers/pci/host/, it appeared that including
<mach/addr-map.h> from the PCIe driver to get access to address
decoding windows functions was not acceptable.

In order to fix this problem, this patch set introduces a driver for
the Marvell EBU MBus driver in drivers/bus/mvebu-mbus.c. It
consolidates into a single driver the address decoding code that was
spread in mach-{mvebu,kirkwood,orion5x,mv78xx0,dove}/addr-map.c and
plat-orion/addr-map.c. The driver provides two APIs:

 * A mv_mbus_dram_info() that is used by many Marvell device drivers
   throughout the tree to get the list of DRAM address decoding
   windows they have to set up. This API was previously implemented in
   plat-orion/addr-map.c and is kept unchanged in order to not change
   the drivers.

 * mvebu_mbus_add_window() / mvebu_mbus_del_window() functions to add
   and remove address decoding windows for a given device. Those
   functions have to be called either from the platform code, or from
   device drivers.

The driver can be probed either using Device Tree informations, or
using a legacy mvbus_mbus_init() function call. This allows us to
migrate the five families of Marvell EBU SoCs to use this driver.

Note that this driver is only a consolidation, and that further
improvements to the address decoding handling could be done in the
future (dynamically allocating the physical range using
request_resource(), describing some of the static windows in DT,
etc.). We intentionally do not want those improvements to be done
right now, in order to keep the amount of changes reasonable. The
driver as it is is sufficient to cover the existing needs, and the
needs of the upcoming PCIe driver and Device Bus driver.

Summary of the patch set:

 * Patch 1 makes the compilation of plat-orion/addr-map.c conditional
   on a per-SoC family basis. This allows patches 5 to 9 to
   progressively move each SoC family to use the mvebu-mbus driver
   instead of the mach-<foo>/addr-map.c + plat-orion/addr-map.c
   code. Notice that the plat-orion/addr-map.c code cannot be compiled
   in a kernel that has the mvebu-mbus, due to the namespace conflict
   on the mv_mbus_dram_info() function.

 * Patch 2 and 3 ensures that all places that need to have access to
   the list of DRAM address decoding windows do so by using the public
   mv_mbus_dram_info() rather than directly accessing an internal
   structure.

 * Patch 4 introduces the mvebu-mbus driver itself, with the support
   for all 5 Marvell EBU SoC families. Note that the driver is
   compiled through a blind option, because we don't want the driver
   to be compiled in unless the corresponding sub-architecture has
   been migrated to use it: as explained above, compiling the driver
   conflicts with compiling the plat-orion/addr-map.c code.

 * Patch 5 to 9 moves each Marvell EBU sub-architecture to use the
   mvebu-mbus driver.

 * Patch 10 removes the now unused plat-orion/addr-map.c code.

The code has been tested on Armada 370 and Armada XP platforms (by
me), on Kirkwood DT and non-DT platforms (by Andrew Lunn), on Dove DT
platforms (by Sebastian Hesselbarth) and on Orion5x non-DT platforms
(by me).

The code applies on top of the marvell-3.9-fixes-tag I have sent at
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-March/152999.html. For
easier testing, I've pushed a branch at:

  https://github.com/MISL-EBU-System-SW/mainline-public/commits/marvell-mvebu-mbus-v1

Since other drivers will depend on this one, I'd appreciate if this
code could be merged early in the 3.10 cycle.

Thanks for your reviews,

Thomas
