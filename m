From: pullip.cho@samsung.com (Cho KyongHo)
Date: Wed, 26 Dec 2012 10:54:26 +0900
Subject: [PATCH v6 11/12] iommu/exynos: add literal name of System MMU for
 debugging
Message-ID: <003e01cde30b$ef82bb00$ce883100$%cho@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds System MMU name to the driver data of each System
MMU. It is used by fault information.

Signed-off-by: KyongHo Cho <pullip.cho@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 72 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 70921e9..9753e0e 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -26,6 +26,7 @@
 #include <linux/list.h>
 #include <linux/memblock.h>
 #include <linux/export.h>
+#include <linux/string.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 
@@ -180,6 +181,7 @@ struct exynos_iommu_domain {
 	short *lv2entcnt; /* free lv2 entry counter for each section */
 	spinlock_t lock; /* lock for this structure */
 	spinlock_t pgtablelock; /* lock for modifying page table @ pgtable */
+	const char *fault_info; /* debugging information for fault */
 };
 
 /* exynos_iommu_owner
@@ -224,6 +226,7 @@ struct sysmmu_drvdata {
 	struct iommu_domain *domain;
 	unsigned long pgtable;
 	bool runtime_active;
+	const char **mmuname;
 	void __iomem *sfrbases[0];
 };
 
@@ -601,25 +604,29 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 {
 	/* SYSMMU is in blocked when interrupt occurred. */
 	struct sysmmu_drvdata *data = dev_id;
-	struct resource *irqres;
-	struct platform_device *pdev;
+	struct exynos_iommu_owner *owner = NULL;
 	enum exynos_sysmmu_inttype itype = SYSMMU_FAULT_UNKNOWN;
 	unsigned long addr = -1;
-
 	int i, ret = -ENOSYS;
 
-	spin_lock(&data->lock);
+	if (data->master)
+		owner = data->master->archdata.iommu;
+
+	if (owner)
+		spin_lock(&owner->lock);
 
 	WARN_ON(!is_sysmmu_active(data));
 
-	pdev = to_platform_device(data->sysmmu);
-	for (i = 0; i < (pdev->num_resources / 2); i++) {
-		irqres = platform_get_resource(pdev, IORESOURCE_IRQ, i);
+	for (i = 0; i < data->nsfrs; i++) {
+		struct resource *irqres;
+		irqres = platform_get_resource(
+				to_platform_device(data->sysmmu),
+				IORESOURCE_IRQ, i);
 		if (irqres && ((int)irqres->start == irq))
 			break;
 	}
 
-	if (i < pdev->num_resources) {
+	if (i < data->nsfrs) {
 		itype = (enum exynos_sysmmu_inttype)
 			__ffs(__raw_readl(data->sfrbases[i] + REG_INT_STATUS));
 		if (WARN_ON(!((itype >= 0) && (itype < SYSMMU_FAULT_UNKNOWN))))
@@ -629,11 +636,17 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 				data->sfrbases[i] + fault_reg_offset[itype]);
 	}
 
-	if (data->domain)
+	if ((itype >= SYSMMU_FAULTS_NUM) || (itype < SYSMMU_PAGEFAULT))
+		itype = SYSMMU_FAULT_UNKNOWN;
+
+	if (data->domain) {
+		struct exynos_iommu_domain *priv = data->domain->priv;
+		priv->fault_info = data->mmuname[i];
 		ret = report_iommu_fault(data->domain,
 					data->master, addr, itype);
-	else
+	} else {
 		__show_fault_information(__va(data->pgtable), itype, addr);
+	}
 
 	if (ret == -ENOSYS)
 		pr_err("NO SYSTEM MMU FAULT HANDLER REGISTERED FOR %s\n",
@@ -651,7 +664,8 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 
 	sysmmu_unblock(data->sfrbases[i]);
 
-	spin_unlock(&data->lock);
+	if (owner)
+		spin_unlock(&owner->lock);
 
 	return IRQ_HANDLED;
 }
@@ -1028,6 +1042,30 @@ err_dev_put:
 	return ret;
 }
 
+static void __init __sysmmu_init_mmuname(struct device *sysmmu,
+					struct sysmmu_drvdata *drvdata)
+{
+	int i;
+	const char *mmuname;
+
+	if (of_property_count_strings(sysmmu->of_node, "mmuname") !=
+							drvdata->nsfrs)
+		return;
+
+	drvdata->mmuname = (void *)drvdata->sfrbases +
+				sizeof(drvdata->sfrbases[0]) * drvdata->nsfrs;
+
+	for (i = 0; i < drvdata->nsfrs; i++) {
+		if (of_property_read_string_index(sysmmu->of_node,
+					"mmuname", i, &mmuname))
+			dev_err(sysmmu, "Failed read mmuname[%d]\n", i);
+		else
+			drvdata->mmuname[i] = kstrdup(mmuname, GFP_KERNEL);
+		if (!drvdata->mmuname[i])
+			drvdata->mmuname[i] = "noname";
+	}
+}
+
 static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 {
 	int i, ret;
@@ -1039,9 +1077,14 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	ret = of_property_count_strings(pdev->dev.of_node, "mmuname");
+	if (ret != (int)(pdev->num_resources / 2))
+		ret = 0;
+
 	data = devm_kzalloc(dev,
 			sizeof(*data)
-			+ sizeof(*data->sfrbases) * (pdev->num_resources / 2),
+			+ sizeof(*data->sfrbases) * (pdev->num_resources / 2)
+			+ sizeof(*data->mmuname) * ret,
 			GFP_KERNEL);
 	if (!data) {
 		dev_err(dev, "Not enough memory\n");
@@ -1084,6 +1127,8 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 
 	ret = __sysmmu_setup(dev, data);
 	if (!ret) {
+		__sysmmu_init_mmuname(dev, data);
+
 		data->sysmmu = dev;
 		spin_lock_init(&data->lock);
 
@@ -1211,7 +1256,8 @@ static int exynos_iommu_fault_handler(struct iommu_domain *domain,
 {
 	struct exynos_iommu_domain *priv = domain->priv;
 
-	dev_err(dev, "System MMU Generated FAULT!\n\n");
+	dev_err(dev, "System MMU '%s' Generated FAULT!\n\n",
+				priv->fault_info ?  priv->fault_info : "");
 	__show_fault_information(priv->pgtable, iova, flags);
 
 	return -ENOSYS;
-- 
1.8.0
