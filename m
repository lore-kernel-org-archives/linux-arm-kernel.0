From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 31 Jul 2013 20:52:50 +0100
Subject: [PATCH v2 RFC 0/8] enable swiotlb-xen on arm and arm64
Message-ID: <alpine.DEB.2.02.1307312048511.4893@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
this patch series enables xen-swiotlb on arm and arm64.

Considering that all guests, including dom0, run on xen on arm with
second stage translation enabled, it follows that without an IOMMU no
guests could actually drive the hardware.

The solution for platforms without an IOMMU is to use swiotlb-xen,
adapted to autotranslate guests. swiotlb-xen provides a set of dma_ops
that can be used by Linux to setup a contiguous buffer in stage-2
addresses and use it for dma operations.
Basically Linux asks Xen to make a buffer contiguous and gets the
machine address for it. This buffer is going to be used by lib/swiotlb.c
to allocate bounce buffers.


The first 3 patches lay the groundwork on arm and arm64 to have
alternative dma_ops and swiotlb.

The forth patch moves Xen initialization earlier so that we already know
whether we are running on Xen at the time of initializing dma_ops on the
platform.

The following patches adapt swiotlb-xen to autotranslate guests (guest
with second stage translation in hardware) and provide an arm
implementation of xen_create_contiguous_region.


Feedback is very welcome.
Cheers,

Stefano



Changes in v2:
- fixed a couple of errors in xen_bus_to_phys, xen_phys_to_bus and
xen_swiotlb_fixup.



Stefano Stabellini (8):
      arm: make SWIOTLB available
      arm: introduce a global dma_ops pointer
      arm64: do not initialize arm64_swiotlb if dma_ops is already set
      xen/arm,arm64: move Xen initialization earlier
      xen: introduce XENMEM_get_dma_buf and xen_put_dma_buf
      xen: make xen_create_contiguous_region return the dma address
      swiotlb-xen: support autotranslate guests
      xen/arm,arm64: enable SWIOTLB_XEN

 arch/arm/Kconfig                      |    8 ++
 arch/arm/common/dmabounce.c           |   10 +-
 arch/arm/include/asm/dma-mapping.h    |   27 ++++++-
 arch/arm/include/asm/xen/hypervisor.h |    6 ++
 arch/arm/include/asm/xen/page.h       |    2 +
 arch/arm/kernel/setup.c               |    2 +
 arch/arm/mm/dma-mapping.c             |    3 +
 arch/arm/xen/Makefile                 |    2 +-
 arch/arm/xen/enlighten.c              |   24 ++++--
 arch/arm/xen/mm.c                     |  117 ++++++++++++++++++++++++++
 arch/arm64/Kconfig                    |    1 +
 arch/arm64/kernel/setup.c             |    2 +
 arch/arm64/mm/dma-mapping.c           |    2 +
 arch/arm64/xen/Makefile               |    2 +-
 arch/x86/xen/mmu.c                    |    4 +-
 drivers/xen/Kconfig                   |    1 -
 drivers/xen/swiotlb-xen.c             |  147 +++++++++++++++++++++++++++++----
 include/xen/interface/memory.h        |   62 ++++++++++++++
 include/xen/xen-ops.h                 |    3 +-
 19 files changed, 390 insertions(+), 35 deletions(-)
 create mode 100644 arch/arm/xen/mm.c

git://git.kernel.org/pub/scm/linux/kernel/git/sstabellini/xen.git swiotlb-xen-2
