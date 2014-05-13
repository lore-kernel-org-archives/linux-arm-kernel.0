From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 13 May 2014 12:10:35 +0200
Subject: [PATCHv2 0/4] ARM: implement workaround for Cortex-A9/PL310/PCIe
 deadlock
Message-ID: <1399975839-5311-1-git-send-email-thomas.petazzoni@free-electrons.com>
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

The following four patches address the problem in the following way:

 * PATCH 1/4 fixes a minor issue in drivers/of, which prevents from
   using of_update_property() early enough in the boot.

 * PATCH 2/4 adds the necessary infrastructure to allow PCIe I/O
   regions to be mapped as strongly-ordered.

 * PATCH 3/4 extends the l2x0 cache driver with a new compatible
   string "arm,pl310-coherent-cache" which is associated to a
   different set of L2 cache maintenance operations having ->sync set
   to NULL.

 * PATCH 4/4 uses both of the added infrastructures, as well as the
   existing infrastructure to customize the behavior of ioremap() on a
   per-platform basis, to implement the workaround for the Armada 375
   and 38x SOCs.

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

Thomas Petazzoni (4):
  of: make of_update_property() usable earlier in the boot process
  ARM: mm: allow sub-architectures to override PCI I/O memory type
  ARM: mm: add support for HW coherent systems in PL310
  ARM: mvebu: implement L2/PCIe deadlock workaround

 Documentation/devicetree/bindings/arm/l2cc.txt |  2 +
 arch/arm/include/asm/io.h                      |  6 +++
 arch/arm/mach-mvebu/board-v7.c                 | 55 ++++++++++++++++++++++++++
 arch/arm/mm/cache-l2x0.c                       | 21 ++++++++++
 arch/arm/mm/ioremap.c                          |  9 ++++-
 drivers/of/base.c                              |  5 +++
 6 files changed, 97 insertions(+), 1 deletion(-)

-- 
1.9.2
