From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 27 Oct 2014 15:08:15 +0000
Subject: [PATCH v7 0/8] introduce GNTTABOP_cache_flush
Message-ID: <alpine.DEB.2.02.1410261621200.22875@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
this patch series introduces support for GNTTABOP_cache_flush to perform
cache maintenance operation on foreign pages and reverts the current
code based on XENFEAT_grant_map_identity.

It also provides a very slow fallback by bouncing on the swiotlb buffer,
in case the hypercall is not available.

v7 introduces a flag named dma_coherent in dev_archdata and an accessor
function named is_device_dma_coherent in asm/dma-mapping.h under arm and
arm64.


Changes in v7:
- rebased on 3.18-rc1;
- rename is_dma_coherent to is_device_dma_coherent and move it to
asm/dma-mapping.h on arm and arm64;
- introduce a dma_coherent flag on arm and arm64;
- set the flags from set_arch_dma_coherent_ops.

Changes in v6:
- rename xen_is_dma_coherent to is_dma_coherent;
- use of_dma_is_coherent to detect the dma coherency of a device;
- remove arch/arm64/include/asm/xen/page-coherent.h, include
../../arm/include/asm/xen/page-coherent.h instead;
- fix indentation.

Changes in v5:
- introduce xen_is_dma_coherent as a xen specific function;
- call xen_is_dma_coherent instead of is_dma_coherent;
- introduce xen_is_dma_coherent to
arch/arm64/include/asm/xen/page-coherent.h;
- do not remove arch/arm64/include/asm/xen/page-coherent.h, add
the missing dma_ops calls from it;
- fix indentation;
- rename hypercall_flush to hypercall_cflush;
- remove spurious change.

Changes in v4:
- remove outer_*_range call;
- introduce is_dma_coherent;
- use is_dma_coherent in arch/arm/xen/mm32.c;
- merge xen/mm32.c into xen/mm.c;
- xen/arm/arm64: introduce xen_arch_need_swiotlb;
- avoid bouncing dma map operations that involve foreign grants and
non-coherent devices if GNTTABOP_cache_flush is provided by Xen.

Changes in v3:
- fix the cache maintenance op call to match what Linux does natively;
- update the hypercall interface to match Xen.

Changes in v2:
- remove the definition of XENFEAT_grant_map_identity;
- update the hypercall interface to match Xen;
- call the interface on a single page at a time.


Stefano Stabellini (8):
      xen/arm: remove handling of XENFEAT_grant_map_identity
      xen/arm: remove outer_*_range call
      arm64: introduce is_device_dma_coherent
      arm: introduce is_device_dma_coherent
      xen/arm: use is_device_dma_coherent
      xen/arm/arm64: merge xen/mm32.c into xen/mm.c
      xen/arm/arm64: introduce xen_arch_need_swiotlb
      xen/arm: introduce GNTTABOP_cache_flush

 arch/arm/include/asm/device.h              |    1 +
 arch/arm/include/asm/dma-mapping.h         |    6 +
 arch/arm/include/asm/xen/page.h            |    4 +
 arch/arm/xen/Makefile                      |    2 +-
 arch/arm/xen/enlighten.c                   |    5 -
 arch/arm/xen/mm.c                          |  159 ++++++++++++++++++++++
 arch/arm/xen/mm32.c                        |  202 ----------------------------
 arch/arm64/include/asm/device.h            |    1 +
 arch/arm64/include/asm/dma-mapping.h       |    6 +
 arch/arm64/include/asm/xen/page-coherent.h |   44 +-----
 arch/x86/include/asm/xen/page.h            |    7 +
 drivers/xen/swiotlb-xen.c                  |    5 +-
 include/xen/interface/features.h           |    3 -
 include/xen/interface/grant_table.h        |   19 +++
 14 files changed, 209 insertions(+), 255 deletions(-)
 delete mode 100644 arch/arm/xen/mm32.c
