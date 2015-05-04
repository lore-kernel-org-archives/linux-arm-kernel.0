From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 04 May 2015 12:30:26 +0200
Subject: [PATCH v6 27/26] iommu: exynos: add system suspend/resume support
In-Reply-To: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1430735426-23172-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When system goes into suspend state, iommu should save it's state and
restore after system resume. This is handled by 'late' pm ops to ensure
that sysmmu will be suspended after its master devices and restored
before them.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
Hello,

This patch got lost in the rebase, I'm really sorry. Please process it
together with other iommu patches from "[PATCH v6 00/25] Exynos SYSMMU
(IOMMU) integration with DT and DMA-mapping subsystem" patchset.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland
---
 drivers/iommu/exynos-iommu.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 821797328c52..074e6cb05cc8 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -606,6 +606,36 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int exynos_sysmmu_suspend(struct device *dev)
+{
+	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "suspend\n");
+	if (is_sysmmu_active(data)) {
+		__sysmmu_disable_nocount(data);
+		pm_runtime_put(dev);
+	}
+	return 0;
+}
+
+static int exynos_sysmmu_resume(struct device *dev)
+{
+	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "resume\n");
+	if (is_sysmmu_active(data)) {
+		pm_runtime_get_sync(dev);
+		__sysmmu_enable_nocount(data);
+	}
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops sysmmu_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(exynos_sysmmu_suspend, exynos_sysmmu_resume)
+};
+
 static const struct of_device_id sysmmu_of_match[] __initconst = {
 	{ .compatible	= "samsung,exynos-sysmmu", },
 	{ },
@@ -616,6 +646,7 @@ static struct platform_driver exynos_sysmmu_driver __refdata = {
 	.driver	= {
 		.name		= "exynos-sysmmu",
 		.of_match_table	= sysmmu_of_match,
+		.pm		= &sysmmu_pm_ops,
 	}
 };
 
-- 
1.9.2
