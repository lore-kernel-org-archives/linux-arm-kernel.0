From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 19 May 2015 15:20:35 +0200
Subject: [PATCH v7 15/25] iommu/exynos: Add system suspend/resume support
In-Reply-To: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1432041645-11172-16-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When system goes into suspend state, iommu should save it's state and
restore after system resume. This is handled by 'late' pm ops to ensure
that sysmmu will be suspended after its master devices and restored
before them.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index fcd23e9c409a..15551f17fa37 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -601,6 +601,36 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
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
@@ -611,6 +641,7 @@ static struct platform_driver exynos_sysmmu_driver __refdata = {
 	.driver	= {
 		.name		= "exynos-sysmmu",
 		.of_match_table	= sysmmu_of_match,
+		.pm		= &sysmmu_pm_ops,
 	}
 };
 
-- 
1.9.2
