From: omar.luna@linaro.org (Omar Ramirez Luna)
Date: Fri, 15 Jun 2012 20:56:03 -0500
Subject: [PATCH 5/6] ARM: OMAP2+: iommu: add reset handling
In-Reply-To: <1339811764-5337-1-git-send-email-omar.luna@linaro.org>
References: <1339811764-5337-1-git-send-email-omar.luna@linaro.org>
Message-ID: <1339811764-5337-6-git-send-email-omar.luna@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent changes in hwmod now require for drivers to handle reset
lines. Otherwise iommu initialization will fail.

Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>
---
 arch/arm/mach-omap2/omap-iommu.c        |    6 ++++++
 arch/arm/plat-omap/include/plat/iommu.h |    6 ++++++
 drivers/iommu/omap-iommu.c              |   20 ++++++++++++++++++--
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
index 02d98ce..96eecd8 100644
--- a/arch/arm/mach-omap2/omap-iommu.c
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -37,6 +37,12 @@ static int __init omap_iommu_dev_init(struct omap_hwmod *oh, void *unused)
 	pdata->da_start = a->da_start;
 	pdata->da_end = a->da_end;
 
+	if (oh->rst_lines_cnt == 1) {
+		pdata->reset_name = oh->rst_lines->name;
+		pdata->assert_reset = omap_device_assert_hardreset;
+		pdata->deassert_reset = omap_device_deassert_hardreset;
+	}
+
 	pdev = omap_device_build("omap-iommu", i, oh, pdata, sizeof(*pdata),
 				NULL, 0, 0);
 
diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
index ed56424..bb15b85 100644
--- a/arch/arm/plat-omap/include/plat/iommu.h
+++ b/arch/arm/plat-omap/include/plat/iommu.h
@@ -13,6 +13,8 @@
 #ifndef __MACH_IOMMU_H
 #define __MACH_IOMMU_H
 
+#include <linux/platform_device.h>
+
 struct iotlb_entry {
 	u32 da;
 	u32 pa;
@@ -119,9 +121,13 @@ struct omap_mmu_dev_attr {
 struct iommu_platform_data {
 	const char *name;
 	const char *clk_name;
+	const char *reset_name;
 	int nr_tlb_entries;
 	u32 da_start;
 	u32 da_end;
+
+	int (*assert_reset)(struct platform_device *pdev, const char *name);
+	int (*deassert_reset)(struct platform_device *pdev, const char *name);
 };
 
 /**
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 93d7d84..f0d6865 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -125,13 +125,23 @@ EXPORT_SYMBOL_GPL(omap_iommu_arch_version);
 static int iommu_enable(struct omap_iommu *obj)
 {
 	int err;
+	struct platform_device *pdev = to_platform_device(obj->dev);
+	struct iommu_platform_data *pdata = pdev->dev.platform_data;
 
-	if (!obj)
+	if (!obj || !pdata)
 		return -EINVAL;
 
 	if (!arch_iommu)
 		return -ENODEV;
 
+	if (pdata->deassert_reset) {
+		err = pdata->deassert_reset(pdev, pdata->reset_name);
+		if (err) {
+			dev_err(obj->dev, "deassert_reset failed: %d\n", err);
+			return err;
+		}
+	}
+
 	clk_enable(obj->clk);
 
 	err = arch_iommu->enable(obj);
@@ -142,7 +152,10 @@ static int iommu_enable(struct omap_iommu *obj)
 
 static void iommu_disable(struct omap_iommu *obj)
 {
-	if (!obj)
+	struct platform_device *pdev = to_platform_device(obj->dev);
+	struct iommu_platform_data *pdata = pdev->dev.platform_data;
+
+	if (!obj || !pdata)
 		return;
 
 	clk_enable(obj->clk);
@@ -150,6 +163,9 @@ static void iommu_disable(struct omap_iommu *obj)
 	arch_iommu->disable(obj);
 
 	clk_disable(obj->clk);
+
+	if (pdata->assert_reset)
+		pdata->assert_reset(pdev, pdata->reset_name);
 }
 
 /*
-- 
1.7.4.1
