From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 19 Apr 2016 17:01:32 +0100
Subject: [PATCH 2/2] arm64/dma-mapping: Remove default domain workaround
In-Reply-To: <d5297227e1501e722235a6cd2b22d1285d3f9135.1461080622.git.robin.murphy@arm.com>
References: <d5297227e1501e722235a6cd2b22d1285d3f9135.1461080622.git.robin.murphy@arm.com>
Message-ID: <c7bbf94e73dadab667cf66326dbbb6dfc5ff877c.1461080622.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the IOMMU core now taking care of default domains for groups
regardless of bus type, we can gleefully rip out this stop-gap, as
slight recompense for having to expand the other one.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/mm/dma-mapping.c | 52 +++++++--------------------------------------
 1 file changed, 8 insertions(+), 44 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 607e70911173..fd8b9426f140 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -804,57 +804,24 @@ struct iommu_dma_notifier_data {
 static LIST_HEAD(iommu_dma_masters);
 static DEFINE_MUTEX(iommu_dma_notifier_lock);
 
-/*
- * Temporarily "borrow" a domain feature flag to to tell if we had to resort
- * to creating our own domain here, in case we need to clean it up again.
- */
-#define __IOMMU_DOMAIN_FAKE_DEFAULT		(1U << 31)
-
 static bool do_iommu_attach(struct device *dev, const struct iommu_ops *ops,
 			   u64 dma_base, u64 size)
 {
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 
 	/*
-	 * Best case: The device is either part of a group which was
-	 * already attached to a domain in a previous call, or it's
-	 * been put in a default DMA domain by the IOMMU core.
+	 * If the IOMMU driver has the DMA domain support that we require,
+	 * then the IOMMU core will have already configured a group for this
+	 * device, and allocated the default domain for that group.
 	 */
-	if (!domain) {
-		/*
-		 * Urgh. The IOMMU core isn't going to do default domains
-		 * for non-PCI devices anyway, until it has some means of
-		 * abstracting the entirely implementation-specific
-		 * sideband data/SoC topology/unicorn dust that may or
-		 * may not differentiate upstream masters.
-		 * So until then, HORRIBLE HACKS!
-		 */
-		domain = ops->domain_alloc(IOMMU_DOMAIN_DMA);
-		if (!domain)
-			goto out_no_domain;
-
-		domain->ops = ops;
-		domain->type = IOMMU_DOMAIN_DMA | __IOMMU_DOMAIN_FAKE_DEFAULT;
-
-		if (iommu_attach_device(domain, dev))
-			goto out_put_domain;
+	if (!domain || iommu_dma_init_domain(domain, dma_base, size)) {
+		pr_warn("Failed to set up IOMMU for device %s; retaining platform DMA ops\n",
+			dev_name(dev));
+		return false;
 	}
 
-	if (iommu_dma_init_domain(domain, dma_base, size))
-		goto out_detach;
-
 	dev->archdata.dma_ops = &iommu_dma_ops;
 	return true;
-
-out_detach:
-	iommu_detach_device(domain, dev);
-out_put_domain:
-	if (domain->type & __IOMMU_DOMAIN_FAKE_DEFAULT)
-		iommu_domain_free(domain);
-out_no_domain:
-	pr_warn("Failed to set up IOMMU for device %s; retaining platform DMA ops\n",
-		dev_name(dev));
-	return false;
 }
 
 static void queue_iommu_attach(struct device *dev, const struct iommu_ops *ops,
@@ -971,11 +938,8 @@ void arch_teardown_dma_ops(struct device *dev)
 {
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 
-	if (domain) {
+	if (WARN_ON(domain))
 		iommu_detach_device(domain, dev);
-		if (domain->type & __IOMMU_DOMAIN_FAKE_DEFAULT)
-			iommu_domain_free(domain);
-	}
 
 	dev->archdata.dma_ops = NULL;
 }
-- 
2.8.1.dirty
