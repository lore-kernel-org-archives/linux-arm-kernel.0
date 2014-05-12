From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Mon, 12 May 2014 11:45:00 +0530
Subject: [PATCH v13 15/19] iommu/exynos: enhanced error messages
In-Reply-To: <1399875304-19948-1-git-send-email-shaik.ameer@samsung.com>
References: <1399875304-19948-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <1399875304-19948-16-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cho KyongHo <pullip.cho@samsung.com>

Some redundant error message is removed and some error messages
are changed to error level from debug level.

Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
---
 drivers/iommu/exynos-iommu.c |   23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index d18dc37..7188b47 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -525,7 +525,7 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		dev_dbg(dev, "Unable to find IRQ resource\n");
+		dev_err(dev, "Unable to find IRQ resource\n");
 		return irq;
 	}
 
@@ -787,10 +787,8 @@ static int lv2set_page(sysmmu_pte_t *pent, phys_addr_t paddr, size_t size,
 								short *pgcnt)
 {
 	if (size == SPAGE_SIZE) {
-		if (!lv2ent_fault(pent)) {
-			WARN(1, "Trying mapping on 4KiB where mapping exists");
+		if (WARN_ON(!lv2ent_fault(pent)))
 			return -EADDRINUSE;
-		}
 
 		*pent = mk_lv2ent_spage(paddr);
 		pgtable_flush(pent, pent + 1);
@@ -798,9 +796,7 @@ static int lv2set_page(sysmmu_pte_t *pent, phys_addr_t paddr, size_t size,
 	} else { /* size == LPAGE_SIZE */
 		int i;
 		for (i = 0; i < SPAGES_PER_LPAGE; i++, pent++) {
-			if (!lv2ent_fault(pent)) {
-				WARN(1,
-				"Trying mapping on 64KiB where mapping exists");
+			if (WARN_ON(!lv2ent_fault(pent))) {
 				if (i > 0)
 					memset(pent - i, 0, sizeof(*pent) * i);
 				return -EADDRINUSE;
@@ -847,8 +843,8 @@ static int exynos_iommu_map(struct iommu_domain *domain, unsigned long l_iova,
 	}
 
 	if (ret)
-		pr_debug("%s: Failed to map iova %#x/%#zx bytes\n",
-							__func__, iova, size);
+		pr_err("%s: Failed(%d) to map %#zx bytes @ %#x\n",
+			__func__, ret, size, iova);
 
 	spin_unlock_irqrestore(&priv->pgtablelock, flags);
 
@@ -872,7 +868,7 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
 	ent = section_entry(priv->pgtable, iova);
 
 	if (lv1ent_section(ent)) {
-		if (size < SECT_SIZE) {
+		if (WARN_ON(size < SECT_SIZE)) {
 			err_pgsize = SECT_SIZE;
 			goto err;
 		}
@@ -907,7 +903,7 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
 	}
 
 	/* lv1ent_large(ent) == true here */
-	if (size < LPAGE_SIZE) {
+	if (WARN_ON(size < LPAGE_SIZE)) {
 		err_pgsize = LPAGE_SIZE;
 		goto err;
 	}
@@ -929,9 +925,8 @@ done:
 err:
 	spin_unlock_irqrestore(&priv->pgtablelock, flags);
 
-	WARN(1,
-	"%s: Failed due to size(%#zx) @ %#x is smaller than page size %#zx\n",
-	__func__, size, iova, err_pgsize);
+	pr_err("%s: Failed: size(%#zx) @ %#x is smaller than page size %#zx\n",
+		__func__, size, iova, err_pgsize);
 
 	return 0;
 }
-- 
1.7.9.5
