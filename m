From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 18 Sep 2017 16:21:54 +0100
Subject: [PATCH 2/2] iommu/io-pgtable-arm-v7s: Convert to IOMMU API TLB sync
In-Reply-To: <a472d061559a6afcc4631e881e9420944471f461.1505747866.git.robin.murphy@arm.com>
References: <a472d061559a6afcc4631e881e9420944471f461.1505747866.git.robin.murphy@arm.com>
Message-ID: <55dee9ceb8155f2743ef732bd690716e967157e7.1505747866.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the core API issues its own post-unmap TLB sync call, push that
operation out from the io-pgtable-arm-v7s internals into the users. For
now, we leave the invalidation implicit in the unmap operation, since
none of the current users would benefit much from any change to that.

Note that the conversion of msm_iommu is implicit, since that apparently
has no specific TLB sync operation anyway.

CC: Yong Wu <yong.wu@mediatek.com>
CC: Rob Clark <robdclark@gmail.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/io-pgtable-arm-v7s.c |  7 +------
 drivers/iommu/mtk_iommu.c          |  6 ++++++
 drivers/iommu/qcom_iommu.c         | 12 ++++++++++++
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index d665d0dc16e8..397531da8d9c 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -660,16 +660,11 @@ static int arm_v7s_unmap(struct io_pgtable_ops *ops, unsigned long iova,
 			 size_t size)
 {
 	struct arm_v7s_io_pgtable *data = io_pgtable_ops_to_data(ops);
-	size_t unmapped;
 
 	if (WARN_ON(upper_32_bits(iova)))
 		return 0;
 
-	unmapped = __arm_v7s_unmap(data, iova, size, 1, data->pgd);
-	if (unmapped)
-		io_pgtable_tlb_sync(&data->iop);
-
-	return unmapped;
+	return __arm_v7s_unmap(data, iova, size, 1, data->pgd);
 }
 
 static phys_addr_t arm_v7s_iova_to_phys(struct io_pgtable_ops *ops,
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index bd515be5b380..36499e10caa2 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -391,6 +391,11 @@ static size_t mtk_iommu_unmap(struct iommu_domain *domain,
 	return unmapsz;
 }
 
+static void mtk_iommu_iotlb_sync(struct iommu_domain *domain)
+{
+	mtk_iommu_tlb_sync(mtk_iommu_get_m4u_data());
+}
+
 static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 					  dma_addr_t iova)
 {
@@ -490,6 +495,7 @@ static struct iommu_ops mtk_iommu_ops = {
 	.map		= mtk_iommu_map,
 	.unmap		= mtk_iommu_unmap,
 	.map_sg		= default_iommu_map_sg,
+	.iotlb_sync	= mtk_iommu_iotlb_sync,
 	.iova_to_phys	= mtk_iommu_iova_to_phys,
 	.add_device	= mtk_iommu_add_device,
 	.remove_device	= mtk_iommu_remove_device,
diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index c8a587d034b0..49fb82a9a9c6 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -443,6 +443,17 @@ static size_t qcom_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 	return ret;
 }
 
+static void qcom_iommu_iotlb_sync(struct iommu_domain *domain)
+{
+	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
+	struct io_pgtable *pgtable = container_of(qcom_domain->pgtbl_ops,
+						  struct io_pgtable, ops);
+
+	pm_runtime_get_sync(qcom_domain->iommu->dev);
+	qcom_iommu_tlb_sync(pgtable->cookie);
+	pm_runtime_put_sync(qcom_domain->iommu->dev);
+}
+
 static phys_addr_t qcom_iommu_iova_to_phys(struct iommu_domain *domain,
 					   dma_addr_t iova)
 {
@@ -570,6 +581,7 @@ static const struct iommu_ops qcom_iommu_ops = {
 	.map		= qcom_iommu_map,
 	.unmap		= qcom_iommu_unmap,
 	.map_sg		= default_iommu_map_sg,
+	.iotlb_sync	= qcom_iommu_iotlb_sync,
 	.iova_to_phys	= qcom_iommu_iova_to_phys,
 	.add_device	= qcom_iommu_add_device,
 	.remove_device	= qcom_iommu_remove_device,
-- 
2.13.4.dirty
