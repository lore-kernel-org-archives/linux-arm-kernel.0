From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 12 Jan 2015 17:51:13 +0000
Subject: [PATCH 1/4] iommu: allow building iova.c independently
In-Reply-To: <cover.1420822848.git.robin.murphy@arm.com>
References: <cover.1420822848.git.robin.murphy@arm.com>
Message-ID: <defa67ffdfcb7cc3752b9cf44e0ebe8c0a06395a.1420822848.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for sharing the IOVA allocator, split it out under its
own Kconfig symbol.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/Kconfig  | 4 ++++
 drivers/iommu/Makefile | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 325188e..a839ca9 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -13,6 +13,9 @@ menuconfig IOMMU_SUPPORT
 
 if IOMMU_SUPPORT
 
+config IOMMU_IOVA
+	bool
+
 config OF_IOMMU
        def_bool y
        depends on OF && IOMMU_API
@@ -91,6 +94,7 @@ config INTEL_IOMMU
 	bool "Support for Intel IOMMU using DMA Remapping Devices"
 	depends on PCI_MSI && ACPI && (X86 || IA64_GENERIC)
 	select IOMMU_API
+	select IOMMU_IOVA
 	select DMAR_TABLE
 	help
 	  DMA remapping (DMAR) devices support enables independent address
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 7b976f2..0b1b94e 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -1,13 +1,14 @@
 obj-$(CONFIG_IOMMU_API) += iommu.o
 obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
+obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o msm_iommu_dev.o
 obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
 obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
 obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
 obj-$(CONFIG_DMAR_TABLE) += dmar.o
-obj-$(CONFIG_INTEL_IOMMU) += iova.o intel-iommu.o
+obj-$(CONFIG_INTEL_IOMMU) += intel-iommu.o
 obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
 obj-$(CONFIG_IRQ_REMAP) += intel_irq_remapping.o irq_remapping.o
 obj-$(CONFIG_OMAP_IOMMU) += omap-iommu.o
-- 
1.9.1
