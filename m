From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 28 Sep 2017 15:55:02 +0100
Subject: [PATCH v2 2/2] iommu/io-pgtable-arm-v7s: Convert to IOMMU API TLB sync
In-Reply-To: <1eaf255a7a334b3b1b100da8b75b73d19c924860.1506610256.git.robin.murphy@arm.com>
References: <1eaf255a7a334b3b1b100da8b75b73d19c924860.1506610256.git.robin.murphy@arm.com>
Message-ID: <e00ef8af9b0dfe89a6680a485f3b27283df2b77b.1506610256.git.robin.murphy@arm.com>
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

v2: Wire up .flush_iotlb_all and cope with uninitialised domains

 drivers/iommu/io-pgtable-arm-v7s.c |  7 +------
 drivers/iommu/mtk_iommu.c          |  7 +++++++
 drivers/iommu/qcom_iommu.c         | 15 +++++++++++++++
 3 files changed, 23 insertions(+), 6 deletions(-)

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
index bd515be5b380..d0c8dfbbd74d 100644
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
@@ -490,6 +495,8 @@ static struct iommu_ops mtk_iommu_ops = {
 	.map		= mtk_iommu_map,
 	.unmap		= mtk_iommu_unmap,
 	.map_sg		= default_iommu_map_sg,
+	.flush_iotlb_all = mtk_iommu_iotlb_sync,
+	.iotlb_sync	= mtk_iommu_iotlb_sync,
 	.iova_to_phys	= mtk_iommu_iova_to_phys,
 	.add_device	= mtk_iommu_add_device,
 	.remove_device	= mtk_iommu_remove_device,
diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index c8a587d034b0..4a2c4378b3db 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -443,6 +443,19 @@ static size_t qcom_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 	return ret;
 }
 
+static void qcom_iommu_iotlb_sync(struct iommu_domain *domain)
+{
+	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
+	struct io_pgtable *pgtable = container_of(qcom_domain->pgtbl_ops,
+						  struct io_pgtable, ops);
+	if (!qcom_domain->pgtbl_ops)
+		return;
+
+	pm_runtime_get_sync(qcom_domain->iommu->dev);
+	qcom_iommu_tlb_sync(pgtable->cookie);
+	pm_runtime_put_sync(qcom_domain->iommu->dev);
+}
+
 static phys_addr_t qcom_iommu_iova_to_phys(struct iommu_domain *domain,
 					   dma_addr_t iova)
 {
@@ -570,6 +583,8 @@ static const struct iommu_ops qcom_iommu_ops = {
 	.map		= qcom_iommu_map,
 	.unmap		= qcom_iommu_unmap,
 	.map_sg		= default_iommu_map_sg,
+	.flush_iotlb_all = qcom_iommu_iotlb_sync,
+	.iotlb_sync	= qcom_iommu_iotlb_sync,
 	.iova_to_phys	= qcom_iommu_iova_to_phys,
 	.add_device	= qcom_iommu_add_device,
 	.remove_device	= qcom_iommu_remove_device,
-- 
2.13.4.dirty
