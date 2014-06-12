From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 12 Jun 2014 17:09:29 +0200
Subject: [PATCHv5 0/3] ARM: implement workaround for Cortex-A9/PL310/PCIe
 deadlock
Message-ID: <1402585772-10405-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, Will, Catalin,

This patch series adresses a problem that affects the newer Marvell
Armada 375 and 38x SOCs, based on Cortex-A9+PL310, combined with the
Marvell PCIe hardware unit. When the hardware I/O coherency is
enabled, the combination of Cortex-A9/PL310/Marvell PCIe hardware unit
will quickly cause a deadlock when the PCIe bus is stressed.

The workaround for this problem has been suggested by ARM, and
consists in two things:

 (1) Map the PCIe regions as strongly-ordered

 (2) Disable the outer cache sync of the PL310 when hardware I/O
     coherency is used, since it is unneeded and causes the deadlock.

Some of the problems have already been solved and the corresponding
patches merged mainline. However, due to the L2CC cleanup done by
Russell King, the change to the PL310 driver was not merged, and there
are some consequences to the L2CC cleanup that need to be
addressed. The following three patches address those problems:

 * PATCH 1/3 extends the l2x0 cache driver with a new property
   "arm,io-coherent", valid for the PL310, which makes the driver
   disable the outer cache sync operation. This patch should be routed
   through Russell's tree.

 * PATCH 2/3 moves the registration of a quirk later, and is merely a
   preparation for PATCH 3/3. It should be merged by the mvebu
   maintainers.

 * PATCH 3/3 moves the initialization of the SCU, coherency and
   mvebu-mbus earlier (to ->init_irq instead of ->init_time), because
   we must adjust the Device Tree property of the PL310 cache
   controller *before* the L2CC driver is initialized, and it is
   initialized right after ->init_irq() is called. It should be merged
   by the mvebu maintainers.

This patch series is based on the current Linus tree, at
dfb945473ae8528fd885607b6fa843c676745e0c. Let me know if this is the
right tree to base this code on, or if it should be based on some
other version or tree.

Without this patch series, doing heavy PCIe traffic (like running 6 or
7 parallel dd processes reading from a SATA drive) during a few dozens
of seconds is sufficient to completely deadlock the system, so this is
really a bug fix.

Changes since v5:

 - Drop patches that have been merged during the 3.16 merge window.

 - Adapt the L2CC driver changes to the cleanups made by Russell King.

 - Add patches to ensure the L2CC DT property is added before the L2CC
   driver is initialized.

Changes since v4:

 - Re-introduce the patch to allow sub-architectures to override the
   memory type used for PCI I/O mappings, since switching to
   strongly-ordered for all platforms does not seem to be well
   accepted/understood at this point.

 - Remove the of_device_is_compatible() check for the PL310, when
   testing for 'arm,io-coherent'. Suggested by Rob Herring. However,
   the code tetsing 'arm,io-coherent' cannot be moved into
   pl310_of_setup(), because this function is called *before* the
   'outer_cache' structure is initialized.

 - Add a separate patch to use the pci_ioremap_set_mem_type() API in
   mach-mvebu/coherency.c.

Changes since v3:

 - Withdrawn all Acked-by tags since the changes compared to v3 are
   quite significant.

 - Instead of introducing a small mechanism to allow each
   sub-architecture to override the memory type used for PCI I/O
   mappings, simply make all of them mapped MT_UNCACHED instead of
   MT_DEVICE, as suggested by Arnd Bergmann. This also has the nice
   consequence that there is no longer a build dependency between
   PATCH 3/3 and PATCH 1/3. Suggested by Arnd Bergmann.

 - Change the name of the new property of the PL310 DT binding from
   the too generic 'dma-coherent' to 'arm,io-coherent'. Suggested by
   Rob Herring.

 - Instead of adding a complete set of L2 cache operations in
   cache-l2x0.c, simply nullify the outer_cache.sync operation when
   'arm,io-coherent' is specified. Suggested by Rob Herring.

 - Move the Armada 375/38x specific code from mach-mvebu/board-v7.c to
   mach-mvebu/coherency.c, which makes more sense. Suggested by Arnd
   Bergmann.

Changes since v2:

 - Added Acked-by from Catalin on "ARM: mm: allow sub-architectures to
   override PCI I/O memory type".

 - Dropped the patch fixing the of_update_property() function, since
   we're no longer using it.

 - Instead of using a different compatible string to identify PL310
   used in an I/O coherent configuration, use a separate boolean
   property. Suggested by Catalin.

 - Rework the mach-mvebu/coherency.c to add the boolean property
   "dma-coherent" when needed instead of updating the compatible
   string of the cache controller.

Changes since v1:

 - Instead of introducing separate l2x0 initialization functions, rely
   on a separate compatible string to identify whether we're coherent
   or not. The compatible string *has* to be modified at runtime,
   because Armada 375 and 38x are only I/O coherent when in SMP
   mode. In non-SMP mode, they are not I/O coherent, so we cannot
   change the DT to 'arm,pl310-coherent-cache'.

 - Addition of the drivers/of fix to be able to use
   of_update_property() early and fix up the PL310 compatible string,
   as explained in the previous item.

Thanks!

Thomas

Thomas Petazzoni (3):
  ARM: mm: add support for HW coherent systems in PL310 cache
  ARM: mvebu: move Armada 375 external abort logic as a quirk
  ARM: mvebu: update L2/PCIe deadlock workaround after L2CC cleanup

 Documentation/devicetree/bindings/arm/l2cc.txt |  3 +++
 arch/arm/mach-mvebu/board-v7.c                 | 29 +++++++++++++++---------
 arch/arm/mm/cache-l2x0.c                       | 31 ++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 10 deletions(-)

-- 
2.0.0
