From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 24 Mar 2014 17:17:49 +0100
Subject: [PATCH 0/3] ARM: implement workaround for Cortex-A9/PL310/PCIe
 deadlock
Message-ID: <1395677872-32741-1-git-send-email-thomas.petazzoni@free-electrons.com>
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

 * PATCH 1/3 adds the necessary infrastructure to allow PCIe I/O
   regions to be mapped as strongly-ordered.

 * PATCH 2/3 extends the l2x0 cache driver to be able to pass the
   information on whether hardware I/O coherency is used or not, and
   in the former case, disable the outer_cache_sync operation.

 * PATCH 3/3 uses both of the added infrastructures, as well as the
   existing infrastructure to customize the behavior of ioremap() on a
   per-platform basis, to implement the workaround for the Armada 375
   and 38x SOCs.

Patches 1/3 and 2/3 apply on 3.14-rc1. Patch 3/3 applies on top of the
'[PATCH 00/10] ARM: mvebu: Hardware coherency support for Armada 375
and 38x' patch set. But for now, I'm mainly interested in hearing
about patches 1/3 and 2/3.

Please let me know what you think about the proposed solution.

Thanks!

Thomas

Thomas Petazzoni (3):
  ARM: mm: allow sub-architectures to override PCI I/O memory type
  ARM: mm: add support for HW coherent systems in PL310
  ARM: mvebu: implement L2/PCIe deadlock workaround

 arch/arm/include/asm/hardware/cache-l2x0.h |  1 +
 arch/arm/include/asm/io.h                  |  6 ++++++
 arch/arm/mach-mvebu/board-v7.c             | 31 +++++++++++++++++++++++++++++-
 arch/arm/mm/cache-l2x0.c                   | 22 ++++++++++++++++++++-
 arch/arm/mm/ioremap.c                      |  9 ++++++++-
 5 files changed, 66 insertions(+), 3 deletions(-)

-- 
1.8.3.2
