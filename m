From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  7 Dec 2012 23:04:23 +0100
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
Message-ID: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series of patches introduces PCIe support for the Marvell Armada
370 and Armada XP. Even though the code is working, this first posting
is done as a RFC, as there are a number of remaining questions to
solve.

First, a quick description of the patches:

 * Patch 1 fixes a problem in lib/devres.c that prevents certain
   PCI-related functions from being visible on NO_IOPORT platforms.

 * Patch 2 slightly improves the Armada 370 gatable clock driver as a
   preparation for the PCIe introduction.

 * Patch 3 and 4 are cleanup/refactoring of the common plat-orion
   address decoding code, in preparation for further changes related
   to PCIe.

 * Patch 5 introduces in the common plat-orion address decoding code
   functions to allocate/free an address decoding window. Until now,
   the address decoding windows were configured statically. With
   Armada XP having up to 10 PCIe interfaces, we don't want to
   allocate useless address decoding windows statically, so we move to
   a more dynamic model in which address decoding windows are
   configured only for the PCIe interfaces that are actually in use.

 * Patch 6 improves the Armada 370/XP specific address decoding code
   to provide functions that add and remove an address decoding window
   for a given PCIe interface. It relies on the common functions added
   in patch 5.

 * Patch 7 makes the common plat-orion PCIe code available on
   PLAT_ORION platforms such as ARCH_MVEBU.

 * Patch 8 contains the Armada 370/XP PCIe driver itself, that
   implements the necessary operations required by the ARM PCI core,
   and configures the address decoding windows as needed. This driver
   relies on a Device Tree description of the PCIe interfaces.

 * Patch 9 marks the ARCH_MVEBU platform has having PCI available,
   which allows the compilation of the PCIe support.

 * Patches 10 and 11 add the SoC-level Device Tree informations
   related to PCIe for Armada 370 and Armada XP.

 * Patch 12, 13, 14 and 15 add the board-level Device Tree
   informations related to PCIe for the Armada XP DB, Armada 370 DB,
   PlatHome OpenBlocks AX3-4 and GlobalScale Mirabox boards.

 * Patch 16 updates mvebu_defconfig with PCI and USB support.

In the pending issues:

 * The most annoying problem is that when the hw_pci->setup()
   operation is called, we don't know the size of the memory and I/O
   regions that each PCI device will need. And on Marvell SoCs, for
   each PCI device, we have to set up an address decoding window that
   associates a portion of the physical address space with a given
   device. For now, we allocate 64 MB for each of those address
   decoding windows that point to PCIe memory regions, even if many
   PCIe devices need only a few KBs of memory regions. This
   over-allocation is an issue as we may have up to 10 PCIe interfaces
   on Armada XP, therefore consuming up to 640 MB of physical address
   space. And still, the 64 MB choice we have made may be too small
   for some PCIe devices (but is way too large for many of them).

   Therefore, we would need a way of knowing the size of the different
   BARs for each PCI device, in order to appropriately configure our
   address decoding windows. Suggestions on how to achieve that are
   welcome.

 * Contrary to the PCIe support for older Marvell SoCs, this one is a
   regular platform driver. Therefore, should it be stored in some
   other directory in drivers/pci/ ? If so, how do we handle the fact
   that our PCIe driver needs to call address decoding functions that
   will continue to be exposed through arch/arm/mach-mvebu/ specific
   code and headers ?

 * The PCIe driver is currently initialized at the subsys_initcall()
   level, and not the more classical module_init() level. The reason
   is that module_init() initialization is too late, and the PCI
   quirks code tries to access PCI devices before our PCI driver had
   the chance to create the address decoding windows that are
   mandatory to access the PCIe devices on Marvell SoCs. Is this a
   problem?

 * Is the Device Tree binding OK ? Compared to other Device Tree
   bindings for PCI controllers in the PowerPC world, we have a lot
   less addresses hardcoded in the Device Tree, as those addresses are
   allocated dynamically at runtime.

My TODO-list also contains:

 * If the driver gets moved to some common place like drivers/pci/,
   use it for mach-kirkwood, mach-mv78xx0 and mach-dove, and maybe
   mach-orion5x.

 * Figure out how all PCIe interfaces are used on the PlatHome
   OpenBricks AX3-4 platform. For now, only the one corresponding to
   the internal mini-PCIe slot is supported, but the japanese
   technical documentation seems to mention an USB controller on the
   PCIe bus. I've already asked the manufacturer more details about
   this.

 * Probably a lot more things after this first round of reviews :-)

This patch set applies on top of arm-soc/for-next, and has been pushed
at:

  git://github.com/MISL-EBU-System-SW/mainline-public.git marvell-pcie-v1

Thanks,

Thomas
