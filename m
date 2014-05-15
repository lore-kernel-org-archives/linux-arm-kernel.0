From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 15 May 2014 11:18:36 +0200
Subject: [PATCHv3 0/3] ARM: implement workaround for Cortex-A9/PL310/PCIe
 deadlock
Message-ID: <1400145519-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
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

The following three patches address the problem in the following way:

 * PATCH 1/3 adds the necessary infrastructure to allow
   sub-architecture to override the memory type used to map PCIe I/O
   regions. It has been Acked by Catalin, and should be routed through
   Russell's tree.

 * PATCH 2/3 extends the l2x0 cache driver with a new property
   "dma-coherent", valid for the PL310, which makes the driver use a
   different set of L2 cache maintenance operations having ->sync set
   to NULL. This patch should be routed through Russell's tree.

 * PATCH 3/3 uses both of the added infrastructures, as well as the
   existing infrastructure to customize the behavior of ioremap() on a
   per-platform basis, to implement the workaround for the Armada 375
   and 38x SOCs. This patch should go through the mvebu maintainers
   tree. However, it has a build dependency on PATCH 1/3 that needs to
   be taken into account.

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
  ARM: mm: allow sub-architectures to override PCI I/O memory type
  ARM: mm: add support for HW coherent systems in PL310
  ARM: mvebu: implement L2/PCIe deadlock workaround

 Documentation/devicetree/bindings/arm/l2cc.txt |  3 ++
 arch/arm/include/asm/io.h                      |  6 +++
 arch/arm/mach-mvebu/board-v7.c                 | 51 ++++++++++++++++++++++++++
 arch/arm/mm/cache-l2x0.c                       | 24 ++++++++++++
 arch/arm/mm/ioremap.c                          |  9 ++++-
 5 files changed, 92 insertions(+), 1 deletion(-)

-- 
1.9.3
