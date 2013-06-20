From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Thu, 20 Jun 2013 13:58:41 +0300
Subject: [PATCH 0/3][RESEND] How to pass IOMMU map attr via DMA API?
Message-ID: <1371725924-13957-1-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In Tegra SoC, IOMMU can set some mapping attribute for each page, for
exmaple, READable, and WRITEable. We'd like to use this feature
*newly* for robustness, where read-only pages can be protected from
being overwritten by wrong operation. We have been using IOMMU via DMA
mapping API(ARM). DMA mapping API currently doesn't use "prot"
parameter when calling IOMMU API. So this series tries to pass "struct
dma_attrs *attrs" via "int prot" in IOMMU API. I'm not so sure if this
implementation is right or not because:

- Casting (struct dma_attrs *) to (int) in DMA API doesn't look nice.
- IOMMU layer needs to cast (int) back to (struct dma_attrs *) again,
  which can be considered as violation of layers.

If you have any implementations/suggestions, it would be really helpful.

This series isn't applied cleanly but this is posted to request for
comments.

Hiroshi Doyu (3):
  common: DMA-mapping: add DMA_ATTR_READ_ONLY attribute
  ARM: dma-mapping: Pass DMA attrs as IOMMU prot
  iommu/tegra: smmu: Support read-only mapping

 arch/arm/mm/dma-mapping.c  | 34 +++++++++++++++++++++-------------
 drivers/iommu/tegra-smmu.c | 41 +++++++++++++++++++++++++++++------------
 include/linux/dma-attrs.h  |  1 +
 3 files changed, 51 insertions(+), 25 deletions(-)

-- 
1.8.1.5
