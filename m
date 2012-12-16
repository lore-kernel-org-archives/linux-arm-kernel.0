From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Sun, 16 Dec 2012 18:25:56 +0100
Subject: [PATCH/WIP/RFC 10/14] shmobile-ipmmu: Pass a struct shmobile_ipmmu to
 IPMMU functions
In-Reply-To: <1355678760-27357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1350290093-998-1-git-send-email-hdk@igel.co.jp>
 <1355678760-27357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1355678760-27357-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/shmobile-iommu.c |   12 +++---
 drivers/iommu/shmobile-ipmmu.c |   90 +++++++++++++++++++--------------------
 drivers/iommu/shmobile-ipmmu.h |    9 ++--
 3 files changed, 55 insertions(+), 56 deletions(-)

diff --git a/drivers/iommu/shmobile-iommu.c b/drivers/iommu/shmobile-iommu.c
index 1a37be2..423993c 100644
--- a/drivers/iommu/shmobile-iommu.c
+++ b/drivers/iommu/shmobile-iommu.c
@@ -53,7 +53,7 @@ static spinlock_t lock;
 static DEFINE_SPINLOCK(lock_add);
 static struct shmobile_iommu_domain *attached;
 static int num_attached_devices;
-static struct device *ipmmu_access_device;
+static struct shmobile_ipmmu *ipmmu_access_device;
 
 static int shmobile_iommu_domain_init(struct iommu_domain *domain)
 {
@@ -329,20 +329,20 @@ void ipmmu_add_device(struct device *dev)
 	spin_unlock(&lock_add);
 }
 
-int ipmmu_iommu_init(struct device *dev)
+int ipmmu_iommu_init(struct shmobile_ipmmu *ipmmu)
 {
-	dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
-	l1pool = dma_pool_create("shmobile-iommu-pgtable1", dev,
+	dma_set_coherent_mask(ipmmu->dev, DMA_BIT_MASK(32));
+	l1pool = dma_pool_create("shmobile-iommu-pgtable1", ipmmu->dev,
 				 L1_SIZE, L1_ALIGN, 0);
 	if (!l1pool)
 		goto nomem_pool1;
-	l2pool = dma_pool_create("shmobile-iommu-pgtable2", dev,
+	l2pool = dma_pool_create("shmobile-iommu-pgtable2", ipmmu->dev,
 				 L2_SIZE, L2_ALIGN, 0);
 	if (!l2pool)
 		goto nomem_pool2;
 	spin_lock_init(&lock);
 	attached = NULL;
-	ipmmu_access_device = dev;
+	ipmmu_access_device = ipmmu;
 	bus_set_iommu(&platform_bus_type, &shmobile_iommu_ops);
 	if (shmobile_iommu_attach_all_devices())
 		pr_err("shmobile_iommu_attach_all_devices failed\n");
diff --git a/drivers/iommu/shmobile-ipmmu.c b/drivers/iommu/shmobile-ipmmu.c
index b308292..9858c91 100644
--- a/drivers/iommu/shmobile-ipmmu.c
+++ b/drivers/iommu/shmobile-ipmmu.c
@@ -34,99 +34,97 @@
 #define IMCTR1_TLBEN (1 << 0)
 #define IMCTR1_FLUSH (1 << 1)
 
-static void ipmmu_reg_write(struct shmobile_ipmmu *priv, unsigned long reg_off,
+static void ipmmu_reg_write(struct shmobile_ipmmu *ipmmu, unsigned long reg_off,
 			    unsigned long data)
 {
-	iowrite32(data, priv->ipmmu_base + reg_off);
+	iowrite32(data, ipmmu->ipmmu_base + reg_off);
 }
 
-void ipmmu_tlb_flush(struct device *dev)
+void ipmmu_tlb_flush(struct shmobile_ipmmu *ipmmu)
 {
-	struct shmobile_ipmmu *priv;
-
-	if (!dev)
+	if (!ipmmu)
 		return;
-	priv = dev_get_drvdata(dev);
-	mutex_lock(&priv->flush_lock);
-	if (priv->tlb_enabled)
-		ipmmu_reg_write(priv, IMCTR1, IMCTR1_FLUSH | IMCTR1_TLBEN);
+
+	mutex_lock(&ipmmu->flush_lock);
+	if (ipmmu->tlb_enabled)
+		ipmmu_reg_write(ipmmu, IMCTR1, IMCTR1_FLUSH | IMCTR1_TLBEN);
 	else
-		ipmmu_reg_write(priv, IMCTR1, IMCTR1_FLUSH);
-	mutex_unlock(&priv->flush_lock);
+		ipmmu_reg_write(ipmmu, IMCTR1, IMCTR1_FLUSH);
+	mutex_unlock(&ipmmu->flush_lock);
 }
 
-void ipmmu_tlb_set(struct device *dev, unsigned long phys, int size, int asid)
+void ipmmu_tlb_set(struct shmobile_ipmmu *ipmmu, unsigned long phys, int size,
+		   int asid)
 {
-	struct shmobile_ipmmu *priv;
-
-	if (!dev)
+	if (!ipmmu)
 		return;
-	priv = dev_get_drvdata(dev);
-	mutex_lock(&priv->flush_lock);
+
+	mutex_lock(&ipmmu->flush_lock);
 	switch (size) {
 	default:
-		priv->tlb_enabled = 0;
+		ipmmu->tlb_enabled = 0;
 		break;
 	case 0x2000:
-		ipmmu_reg_write(priv, IMTTBCR, 1);
-		priv->tlb_enabled = 1;
+		ipmmu_reg_write(ipmmu, IMTTBCR, 1);
+		ipmmu->tlb_enabled = 1;
 		break;
 	case 0x1000:
-		ipmmu_reg_write(priv, IMTTBCR, 2);
-		priv->tlb_enabled = 1;
+		ipmmu_reg_write(ipmmu, IMTTBCR, 2);
+		ipmmu->tlb_enabled = 1;
 		break;
 	case 0x800:
-		ipmmu_reg_write(priv, IMTTBCR, 3);
-		priv->tlb_enabled = 1;
+		ipmmu_reg_write(ipmmu, IMTTBCR, 3);
+		ipmmu->tlb_enabled = 1;
 		break;
 	case 0x400:
-		ipmmu_reg_write(priv, IMTTBCR, 4);
-		priv->tlb_enabled = 1;
+		ipmmu_reg_write(ipmmu, IMTTBCR, 4);
+		ipmmu->tlb_enabled = 1;
 		break;
 	case 0x200:
-		ipmmu_reg_write(priv, IMTTBCR, 5);
-		priv->tlb_enabled = 1;
+		ipmmu_reg_write(ipmmu, IMTTBCR, 5);
+		ipmmu->tlb_enabled = 1;
 		break;
 	case 0x100:
-		ipmmu_reg_write(priv, IMTTBCR, 6);
-		priv->tlb_enabled = 1;
+		ipmmu_reg_write(ipmmu, IMTTBCR, 6);
+		ipmmu->tlb_enabled = 1;
 		break;
 	case 0x80:
-		ipmmu_reg_write(priv, IMTTBCR, 7);
-		priv->tlb_enabled = 1;
+		ipmmu_reg_write(ipmmu, IMTTBCR, 7);
+		ipmmu->tlb_enabled = 1;
 		break;
 	}
-	ipmmu_reg_write(priv, IMTTBR, phys);
-	ipmmu_reg_write(priv, IMASID, asid);
-	mutex_unlock(&priv->flush_lock);
+	ipmmu_reg_write(ipmmu, IMTTBR, phys);
+	ipmmu_reg_write(ipmmu, IMASID, asid);
+	mutex_unlock(&ipmmu->flush_lock);
 }
 
 static int ipmmu_probe(struct platform_device *pdev)
 {
+	struct shmobile_ipmmu *ipmmu;
 	struct resource *res;
-	struct shmobile_ipmmu *priv;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "cannot get platform resources\n");
 		return -ENOENT;
 	}
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
+	ipmmu = devm_kzalloc(&pdev->dev, sizeof(*ipmmu), GFP_KERNEL);
+	if (!ipmmu) {
 		dev_err(&pdev->dev, "cannot allocate device data\n");
 		return -ENOMEM;
 	}
-	mutex_init(&priv->flush_lock);
-	priv->ipmmu_base = devm_ioremap_nocache(&pdev->dev, res->start,
+	mutex_init(&ipmmu->flush_lock);
+	ipmmu->dev = &pdev->dev;
+	ipmmu->ipmmu_base = devm_ioremap_nocache(&pdev->dev, res->start,
 						resource_size(res));
-	if (!priv->ipmmu_base) {
+	if (!ipmmu->ipmmu_base) {
 		dev_err(&pdev->dev, "ioremap_nocache failed\n");
 		return -ENOMEM;
 	}
-	platform_set_drvdata(pdev, priv);
-	ipmmu_reg_write(priv, IMCTR1, 0x0); /* disable TLB */
-	ipmmu_reg_write(priv, IMCTR2, 0x0); /* disable PMB */
-	ipmmu_iommu_init(&pdev->dev);
+	platform_set_drvdata(pdev, ipmmu);
+	ipmmu_reg_write(ipmmu, IMCTR1, 0x0); /* disable TLB */
+	ipmmu_reg_write(ipmmu, IMCTR2, 0x0); /* disable PMB */
+	ipmmu_iommu_init(ipmmu);
 	return 0;
 }
 
diff --git a/drivers/iommu/shmobile-ipmmu.h b/drivers/iommu/shmobile-ipmmu.h
index 5c17a46..1458a97 100644
--- a/drivers/iommu/shmobile-ipmmu.h
+++ b/drivers/iommu/shmobile-ipmmu.h
@@ -2,18 +2,19 @@
 #define __SHMOBILE_IPMMU_H__
 
 struct shmobile_ipmmu {
+	struct device *dev;
 	void __iomem *ipmmu_base;
 	int tlb_enabled;
 	struct mutex flush_lock;
 };
 
 #ifdef CONFIG_SHMOBILE_IPMMU_TLB
-void ipmmu_tlb_flush(struct device *ipmmu_dev);
-void ipmmu_tlb_set(struct device *ipmmu_dev, unsigned long phys, int size,
+void ipmmu_tlb_flush(struct shmobile_ipmmu *ipmmu);
+void ipmmu_tlb_set(struct shmobile_ipmmu *ipmmu, unsigned long phys, int size,
 		   int asid);
-int ipmmu_iommu_init(struct device *dev);
+int ipmmu_iommu_init(struct shmobile_ipmmu *ipmmu);
 #else
-static int ipmmu_iommu_init(struct device *dev)
+static int ipmmu_iommu_init(struct shmobile_ipmmu *ipmmu)
 {
 	return -EINVAL;
 }
-- 
1.7.8.6
