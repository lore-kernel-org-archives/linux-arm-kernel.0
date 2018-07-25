From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Wed, 25 Jul 2018 17:42:57 +0800
Subject: [PATCH mmc-next 0/3] solve SDHCI DWC MSHC 128MB DMA boundary
 limitation
Message-ID: <20180725174235.1ca764cf@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using DMA, if the DMA addr spans 128MB boundary, we have to split
the DMA transfer into two so that each one doesn't exceed the boundary.

patch1 adds adma_table_num to struct sdhci_host so that driver can
control the ADMA table number.
patch2 introduces adma_write_desc() hook to struct sdhci_ops so that
driver can override it.
patch3 finally solves the 128MB boundary limitation.

Jisheng Zhang (3):
  mmc: sdhci: add adma_table_num member to struct sdhci_host
  mmc: sdhci: introduce adma_write_desc() hook to struct sdhci_ops
  mmc: sdhci-of-dwcmshc: solve 128MB DMA boundary limitation

 drivers/mmc/host/sdhci-of-dwcmshc.c | 41 ++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c            | 48 +++++++++++++++++++----------
 drivers/mmc/host/sdhci.h            |  8 +++++
 3 files changed, 81 insertions(+), 16 deletions(-)

-- 
2.18.0
