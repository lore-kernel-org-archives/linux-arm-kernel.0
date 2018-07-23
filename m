From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 23 Jul 2018 23:16:05 +0100
Subject: [PATCH v2 0/7] Stop losing firmware-set DMA masks
Message-ID: <cover.1532382222.git.robin.murphy@arm.com>
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
needed in DMA ops (e.g. in arch/arm/ and other OF users) to catch all
possible incarnations of this problem, but at least any that I'm not
fixing here have always been broken. It is also noteworthy that
of_dma_get_range() has never worked properly for the way PCI host
bridges are passed into of_dma_configure() - I'll be working on
further patches to sort that out once this part is done.

Changes since v1 (RFC):
- Pull in patch #1 (previously sent separately) to avoid conflicts
- Fix up comment and silly build-breaking typo in patch #2
- Add patches #6 and #7 since fiddling with coherent masks no longer
  serves a reasonable purpose

Robin.


[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/580804.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-December/474443.html

Robin Murphy (7):
  ACPI/IORT: Support address size limit for root complexes
  dma-mapping: Generalise dma_32bit_limit flag
  ACPI/IORT: Set bus DMA mask as appropriate
  of/device: Set bus DMA mask as appropriate
  iommu/dma: Respect bus DMA limit for IOVAs
  ACPI/IORT: Don't set default coherent DMA mask
  OF: Don't set default coherent DMA mask

 arch/x86/kernel/pci-dma.c |  2 +-
 drivers/acpi/arm64/iort.c | 50 ++++++++++++++++++++++++++++-----------
 drivers/iommu/dma-iommu.c |  3 +++
 drivers/of/device.c       | 21 ++++++++--------
 include/linux/device.h    |  6 ++---
 kernel/dma/direct.c       |  6 ++---
 6 files changed, 57 insertions(+), 31 deletions(-)

-- 
2.17.1.dirty
