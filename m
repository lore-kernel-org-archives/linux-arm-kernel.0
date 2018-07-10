From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 10 Jul 2018 18:17:15 +0100
Subject: [RFC PATCH 0/4] Stop losing firmware-set DMA masks
Message-ID: <cover.1531239284.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Whilst the common firmware code invoked by dma_configure() initialises
devices' DMA masks according to limitations described by the respective
properties ("dma-ranges" for OF and _DMA/IORT for ACPI), the nature of
the dma_set_mask() API leads to that information getting lost when
well-behaved drivers probe and set a 64-bit mask, since in general
there's no way to tell the difference between a firmware-described mask
(which should be respected) and whatever default may have come from the
bus code (which should be replaced outright). This can break DMA on
systems with certain IOMMU topologies (e.g. [1]) where the IOMMU driver
only knows its maximum supported address size, not how many of those
address bits might actually be wired up between any of its input
interfaces and the associated DMA master devices. Similarly, some PCIe
root complexes only have a 32-bit native interface on their host bridge,
which leads to the same DMA-address-truncation problem in systems with a
larger physical memory map and RAM above 4GB (e.g. [2]).

These patches attempt to deal with this in the simplest way possible by
generalising the specific quirk for 32-bit bridges into an arbitrary
mask which can then also be plumbed into the firmware code. In the
interest of being minimally invasive, I've only included a point fix
for the IOMMU issue as seen on arm64 - there may be further tweaks
needed in DMA ops to catch all possible incarnations of this problem,
but this initial RFC is mostly about the impact beyond the dma-mapping
subsystem itself.

Robin.


[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/580804.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-December/474443.html

Robin Murphy (4):
  dma-mapping: Generalise dma_32bit_limit flag
  ACPI/IORT: Set bus DMA mask as appropriate
  of/device: Set bus DMA mask as appropriate
  iommu/dma: Respect bus DMA limit for IOVAs

 arch/x86/kernel/pci-dma.c | 2 +-
 drivers/acpi/arm64/iort.c | 1 +
 drivers/iommu/dma-iommu.c | 3 +++
 drivers/of/device.c       | 1 +
 include/linux/device.h    | 6 +++---
 kernel/dma/direct.c       | 2 +-
 6 files changed, 10 insertions(+), 5 deletions(-)

-- 
2.17.1.dirty
