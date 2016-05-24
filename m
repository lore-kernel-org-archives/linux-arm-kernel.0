From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 24 May 2016 08:28:06 +0200
Subject: [PATCH 0/4] dma-mapping: Constify dma_attrs
Message-ID: <1464071290-15948-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The patchset is divided into two parts:
1. (patch 1-3): Constify dma_attrs passed to some of functions. The
   first patch is a dependency for all other. This is not intrusive.

2. patch 4: request for comments, constify dma_attrs everywhere (struct
   dma_map_ops and implementations).
   Constness may protect from certain coding bugs and, what is more
   important, is a direct documentation of how the core deals
   with passed data. Some of the dma-mapping users allocate attrs
   on the stack so the ownership cannot be transferred. 'Const' here
   means exactly that - the ownership stays with the caller.

   Unfortunately this cannot be done separately per-implementation
   without introducing build warnings so the patch touches multiple
   subsystems. Maybe using some casts in intermediate steps might help
   splitting it into separate patches?

   This is not finished because there is no point of my effort if
   I will hear short NACK soon. :)

Comments are welcomed.

Best regards,
Krzysztof

Krzysztof Kozlowski (4):
  dma-mapping: Constify attrs passed to dma_get_attr
  ARM: dma-mapping: Constify attrs passed to internal functions
  arm64: dma-mapping: Constify attrs passed to internal functions
  dma-mapping: Constify dma_attrs

 arch/arm/include/asm/dma-mapping.h | 12 +++---
 arch/arm/mm/dma-mapping.c          | 87 ++++++++++++++++++++------------------
 arch/arm/xen/mm.c                  |  4 +-
 arch/arm64/mm/dma-mapping.c        | 53 +++++++++++------------
 drivers/iommu/dma-iommu.c          |  6 +--
 include/linux/dma-attrs.h          |  3 +-
 include/linux/dma-iommu.h          |  6 +--
 include/linux/dma-mapping.h        | 34 ++++++++-------
 include/linux/swiotlb.h            |  9 ++--
 lib/dma-noop.c                     |  9 ++--
 lib/swiotlb.c                      |  9 ++--
 11 files changed, 123 insertions(+), 109 deletions(-)

-- 
1.9.1
