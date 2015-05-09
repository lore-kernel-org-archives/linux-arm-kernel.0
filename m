From: dtor@chromium.org (Dmitry Torokhov)
Date: Fri, 8 May 2015 17:05:44 -0700
Subject: [PATCH] iommu: exynos: tell kmemleak to ignore 2nd level page tables
Message-ID: <20150509000544.GA29904@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Cross <ccross@android.com>

The pointers to the 2nd level page tables are converted to 1st level
page table entries, which means kmemleak can't find them and assumes
they have been leaked.  Call kmemleak_ignore on the 2nd level page
tables to prevent them from showing up in kmemleak reports.

Signed-off-by: Colin Cross <ccross@android.com>
Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
---
 drivers/iommu/exynos-iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index dc14fec4..16920b2 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -855,6 +855,7 @@ static sysmmu_pte_t *alloc_lv2entry(struct exynos_iommu_domain *priv,
 			return ERR_PTR(-ENOMEM);
 
 		*sent = mk_lv1ent_page(virt_to_phys(pent));
+		kmemleak_ignore(pent);
 		*pgcounter = NUM_LV2ENTRIES;
 		pgtable_flush(pent, pent + NUM_LV2ENTRIES);
 		pgtable_flush(sent, sent + 1);
-- 
2.2.0.rc0.207.ga3a616c


-- 
Dmitry
