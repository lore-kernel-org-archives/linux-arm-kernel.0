From: jim2101024@gmail.com (Jim Quinlan)
Date: Wed, 19 Sep 2018 10:32:06 -0400
Subject: [PATCH v5 11/12] ARM64: add dma remap for BrcmSTB PCIe
In-Reply-To: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
Message-ID: <1537367527-20773-12-git-send-email-jim2101024@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BrcmSTB PCIe controller needs to remap DMA accesses to it because
of the requirements of its interface with the SOC memory controllers.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/Kconfig        |  1 +
 drivers/pci/controller/pcie-brcmstb.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 8daa621..4394430 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -284,6 +284,7 @@ config PCIE_BRCMSTB
 	depends on OF && PCI_MSI
 	depends on SOC_BRCMSTB
 	default ARCH_BRCMSTB || BMIPS_GENERIC
+	select ARCH_HAS_PHYS_TO_DMA if ARM64
 	help
 	  Say Y here to enable PCIe host controller support for
 	  Broadcom Settop Box SOCs.  A Broadcom SOC will may have
diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index a805d87..ae9df8e 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -974,6 +974,18 @@ phys_addr_t brcm_dma_to_phys(struct device *dev, dma_addr_t dev_addr)
 	return (phys_addr_t)dev_addr;
 }
 
+#if defined(CONFIG_ARM64)
+dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
+{
+	return brcm_phys_to_dma(dev, paddr);
+}
+
+phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dev_addr)
+{
+	return brcm_dma_to_phys(dev, dev_addr);
+}
+#endif
+
 static int brcm_pcie_add_controller(struct brcm_pcie *pcie)
 {
 	int i, ret = 0;
-- 
1.9.0.138.g2de3478
