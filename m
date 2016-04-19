From: eric.auger@linaro.org (Eric Auger)
Date: Tue, 19 Apr 2016 16:56:34 +0000
Subject: [PATCH v7 10/10] iommu/arm-smmu: call iommu_free_reserved_iova_domain
 on domain destruction
In-Reply-To: <1461084994-2355-1-git-send-email-eric.auger@linaro.org>
References: <1461084994-2355-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1461084994-2355-11-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the domain gets destroyed, let's make sure all reserved iova
resources get released.

Choice is made to put that call in arm-smmu(-v3).c to do something similar
to what was done for iommu_put_dma_cookie.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v7: new
---
 drivers/iommu/arm-smmu-v3.c | 2 ++
 drivers/iommu/arm-smmu.c    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index a077a35..afd0dac 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -22,6 +22,7 @@
 
 #include <linux/delay.h>
 #include <linux/dma-iommu.h>
+#include <linux/dma-reserved-iommu.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/iommu.h>
@@ -1444,6 +1445,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 
 	iommu_put_dma_cookie(domain);
+	iommu_free_reserved_iova_domain(domain);
 	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
 
 	/* Free the CD and ASID, if we allocated them */
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 8cd7b8a..492339f 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -30,6 +30,7 @@
 
 #include <linux/delay.h>
 #include <linux/dma-iommu.h>
+#include <linux/dma-reserved-iommu.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
@@ -1009,6 +1010,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	 * already been detached.
 	 */
 	iommu_put_dma_cookie(domain);
+	iommu_free_reserved_iova_domain(domain);
 	arm_smmu_destroy_domain_context(domain);
 	kfree(smmu_domain);
 }
-- 
1.9.1
