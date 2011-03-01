From: fernando.lugo@ti.com (Fernando Guzman Lugo)
Date: Tue,  1 Mar 2011 13:46:33 -0600
Subject: [PATCH] OMAP:iommu - pgd and pte entries weren't getting flushed out
In-Reply-To: <1299008793-27428-1-git-send-email-fernando.lugo@ti.com>
References: <1299008793-27428-1-git-send-email-fernando.lugo@ti.com>
Message-ID: <1299008793-27428-2-git-send-email-fernando.lugo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hari Kanigeri <h-kanigeri2@ti.com>

pgd and pte entries weren't getting flushed out leading to MMU faults.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/plat-omap/iommu.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index aeb2c33..e9473ff 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -508,7 +508,7 @@ static u32 *iopte_alloc(struct iommu *obj, u32 *iopgd, u32 da)
 			return ERR_PTR(-ENOMEM);
 
 		*iopgd = virt_to_phys(iopte) | IOPGD_TABLE;
-		flush_iopgd_range(iopgd, iopgd);
+		flush_iopgd_range(iopgd, iopgd + 1);
 
 		dev_vdbg(obj->dev, "%s: a new pte:%p\n", __func__, iopte);
 	} else {
@@ -537,7 +537,7 @@ static int iopgd_alloc_section(struct iommu *obj, u32 da, u32 pa, u32 prot)
 	}
 
 	*iopgd = (pa & IOSECTION_MASK) | prot | IOPGD_SECTION;
-	flush_iopgd_range(iopgd, iopgd);
+	flush_iopgd_range(iopgd, iopgd + 1);
 	return 0;
 }
 
@@ -554,7 +554,7 @@ static int iopgd_alloc_super(struct iommu *obj, u32 da, u32 pa, u32 prot)
 
 	for (i = 0; i < 16; i++)
 		*(iopgd + i) = (pa & IOSUPER_MASK) | prot | IOPGD_SUPER;
-	flush_iopgd_range(iopgd, iopgd + 15);
+	flush_iopgd_range(iopgd, iopgd + 16);
 	return 0;
 }
 
@@ -567,7 +567,7 @@ static int iopte_alloc_page(struct iommu *obj, u32 da, u32 pa, u32 prot)
 		return PTR_ERR(iopte);
 
 	*iopte = (pa & IOPAGE_MASK) | prot | IOPTE_SMALL;
-	flush_iopte_range(iopte, iopte);
+	flush_iopte_range(iopte, iopte + 1);
 
 	dev_vdbg(obj->dev, "%s: da:%08x pa:%08x pte:%p *pte:%08x\n",
 		 __func__, da, pa, iopte, *iopte);
@@ -592,7 +592,7 @@ static int iopte_alloc_large(struct iommu *obj, u32 da, u32 pa, u32 prot)
 
 	for (i = 0; i < 16; i++)
 		*(iopte + i) = (pa & IOLARGE_MASK) | prot | IOPTE_LARGE;
-	flush_iopte_range(iopte, iopte + 15);
+	flush_iopte_range(iopte, iopte + 16);
 	return 0;
 }
 
@@ -763,7 +763,7 @@ void iopgtable_clear_entry_all(struct iommu *obj)
 			iopte_free(iopte_offset(iopgd, 0));
 
 		*iopgd = 0;
-		flush_iopgd_range(iopgd, iopgd);
+		flush_iopgd_range(iopgd, iopgd + 1);
 	}
 
 	flush_iotlb_all(obj);
-- 
1.7.0.4
