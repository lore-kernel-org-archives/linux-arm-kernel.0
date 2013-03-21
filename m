From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 21 Mar 2013 17:59:13 +0100
Subject: [PATCH v3 for 3.10] Introduce a Marvell EBU MBus driver
Message-ID: <1363885160-6870-1-git-send-email-thomas.petazzoni@free-electrons.com>
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

The driver can only be probed using a legacy (non-DT)
mvebu_mbus_init() function call. This allows: 1/ to migrate the five
families of Marvell EBU SoCs to use this driver and 2/ to postpone the
work on defining a correct DT binding for this driver.

Note that this driver is only a consolidation, and that further
improvements to the address decoding handling could be done in the
future (dynamically allocating the physical range using
request_resource(), describing some of the static windows in DT,
etc.). We intentionally do not want those improvements to be done
right now, in order to keep the amount of changes reasonable. The
driver as it is is sufficient to cover the existing needs, and the
needs of the upcoming PCIe driver and Device Bus driver.

This patch set is based on arm-soc/mvebu/cleanup, which already
includes 3 patches from previous versions of this patch
set. Therefore, those 3 cleanup patches are no longer included.

Summary of the patch set:

 * Patch 1 introduces the mvebu-mbus driver itself, with the support
   for all 5 Marvell EBU SoC families. Note that the driver is
   compiled through a blind option, because we don't want the driver
   to be compiled in unless the corresponding sub-architecture has
   been migrated to use it: as explained above, compiling the driver
   conflicts with compiling the plat-orion/addr-map.c code.

 * Patch 2 to 6 moves each Marvell EBU sub-architecture to use the
   mvebu-mbus driver.

 * Patch 7 removes the now unused plat-orion/addr-map.c code.

Changes since v2:

 * Remove the DT binding, and use the mvebu_mbus_init() function call
   in all Marvell EBU SoC families. Requested by Arnd Bergmann.

 * Fix the MV78xx0 code, after reports of issues by Gregory Clement
   when testing on this platform.

 * Remove the 3 patches that have been merged by Arnd in
   arm-soc/mvebu-cleanup.

Changes since v1:

 * Fix the compatible string used in armada-370.dtsi: it was
   incorrectly using marvell,armadaxp-mbus instead of
   marvell,armada370-mbus.

 * Fix the reg = <...> property for Kirkwood and Dove, the address for
   the devices address decoding windows was not correct.

 * Fix a 'git rebase -i' mistake that lead to have some code that
   should have been in PATCH 4 (the driver code) into PATCH 5
   (switching mach-mvebu to use the driver).

 * Fix the Device Tree documentation of the driver, which was giving a
   wrong address.

 * And since I didn't want to do a v2 just to fix my stupid mistakes,
   I also added a big comment at the beginning of the driver's code
   that explains what the driver is doing.

Sebastian, Andrew, Gregory, it would be good if you could retest this
new version on Dove, Kirkwood and MV78xx0 respectively. Thanks!

For easier testing, I've pushed a branch at:

  https://github.com/MISL-EBU-System-SW/mainline-public/commits/marvell-mvebu-mbus-v3

Since other drivers will depend on this one, I'd appreciate if this
code could be merged early in the 3.10 cycle.

Thanks for your reviews,

Thomas
