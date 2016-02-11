From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 11 Feb 2016 14:34:16 +0000
Subject: [RFC v2 09/15] iommu/arm-smmu: relinquish reserved resources on
 domain deletion
In-Reply-To: <1455201262-5259-1-git-send-email-eric.auger@linaro.org>
References: <1455201262-5259-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1455201262-5259-10-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm_smmu_unmap_reserved releases all reserved binding resources:
destroy all bindings, free iova, free iova_domain. This happens
on domain deletion.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 drivers/iommu/arm-smmu.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 9961bfd..ae8a97d 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -363,6 +363,7 @@ struct arm_smmu_reserved_binding {
 	dma_addr_t		iova;
 	size_t			size;
 };
+static void arm_smmu_unmap_reserved(struct iommu_domain *domain);
 
 static struct iommu_ops arm_smmu_ops;
 
@@ -1057,6 +1058,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	 * already been detached.
 	 */
 	arm_smmu_destroy_domain_context(domain);
+	arm_smmu_unmap_reserved(domain);
 	kfree(smmu_domain);
 }
 
@@ -1547,19 +1549,23 @@ unlock:
 	return ret;
 }
 
-static void arm_smmu_free_reserved_iova_domain(struct iommu_domain *domain)
+static void __arm_smmu_free_reserved_iova_domain(struct arm_smmu_domain *sd)
 {
-	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-	struct iova_domain *iovad = smmu_domain->reserved_iova_domain;
+	struct iova_domain *iovad = sd->reserved_iova_domain;
 
 	if (!iovad)
 		return;
 
-	mutex_lock(&smmu_domain->reserved_mutex);
-
 	put_iova_domain(iovad);
 	kfree(iovad);
+}
 
+static void arm_smmu_free_reserved_iova_domain(struct iommu_domain *domain)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+
+	mutex_lock(&smmu_domain->reserved_mutex);
+	__arm_smmu_free_reserved_iova_domain(smmu_domain);
 	mutex_unlock(&smmu_domain->reserved_mutex);
 }
 
@@ -1675,6 +1681,24 @@ unlock:
 	mutex_unlock(&smmu_domain->reserved_mutex);
 }
 
+static void arm_smmu_unmap_reserved(struct iommu_domain *domain)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct rb_node *node;
+
+	mutex_lock(&smmu_domain->reserved_mutex);
+	while ((node = rb_first(&smmu_domain->reserved_binding_list))) {
+		struct arm_smmu_reserved_binding *b =
+			rb_entry(node, struct arm_smmu_reserved_binding, node);
+
+		while (!kref_put(&b->kref, reserved_binding_release))
+			;
+	}
+	smmu_domain->reserved_binding_list = RB_ROOT;
+	__arm_smmu_free_reserved_iova_domain(smmu_domain);
+	mutex_unlock(&smmu_domain->reserved_mutex);
+}
+
 static struct iommu_ops arm_smmu_ops = {
 	.capable			= arm_smmu_capable,
 	.domain_alloc			= arm_smmu_domain_alloc,
-- 
1.9.1
