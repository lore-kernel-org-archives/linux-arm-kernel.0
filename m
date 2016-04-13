From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 13 Apr 2016 15:46:57 +0100
Subject: [PATCH] iommu/arm-smmu: Don't allocate resources for bypass domains
In-Reply-To: <5703A289.30308@linaro.org>
References: <1459527597-10740-1-git-send-email-will.deacon@arm.com>
 <570397F4.8080504@arm.com> <5703A289.30308@linaro.org>
Message-ID: <491c885f61c509d959b04cfb63676bd07e481dea.1460558667.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Until we get fully plumbed into of_iommu_configure, our default
IOMMU_DOMAIN_DMA domains just bypass translation. Since we achieve that
by leaving the stream table entries set to bypass instead of pointing at
a translation context, the context bank we allocate for the domain is
completely wasted. Context banks are typically a rather limited
resource, so don't hog ones we don't need.

Reported-by: Eric Auger <eric.auger@linaro.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 5158feb..7c39ac4 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -826,6 +826,12 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	if (smmu_domain->smmu)
 		goto out_unlock;
 
+	/* We're bypassing these SIDs, so don't allocate an actual context */
+	if (domain->type == IOMMU_DOMAIN_DMA) {
+		smmu_domain->smmu = smmu;
+		goto out_unlock;
+	}
+
 	/*
 	 * Mapping the requested stage onto what we support is surprisingly
 	 * complicated, mainly because the spec allows S1+S2 SMMUs without
@@ -948,7 +954,7 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 	void __iomem *cb_base;
 	int irq;
 
-	if (!smmu)
+	if (!smmu || domain->type == IOMMU_DOMAIN_DMA)
 		return;
 
 	/*
-- 
2.7.3.dirty
