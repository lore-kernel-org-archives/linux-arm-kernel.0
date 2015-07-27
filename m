From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 27 Jul 2015 13:29:00 +0100
Subject: [PATCH 03/18] iommu: tegra-smmu: fix iova_to_phys() method
In-Reply-To: <20150727122824.GH7557@n2100.arm.linux.org.uk>
References: <20150727122824.GH7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZJhWe-00043f-KS@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

iova_to_phys() has several problems:
(a) iova_to_phys() is supposed to return 0 if there is no entry present
    for the iova.
(b) if as_get_pte() fails, we oops the kernel by dereferencing a NULL
    pointer.  Really, we should not even be trying to allocate a page
    table at all, but should only be returning the presence of the 2nd
    level page table.  This will be fixed in a subsequent patch.

Treat both of these conditions as "no mapping" conditions.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/iommu/tegra-smmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index c1f2e521dc52..083354903a1a 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -592,6 +592,9 @@ static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
 	u32 *pte;
 
 	pte = as_get_pte(as, iova, &page);
+	if (!pte || !*pte)
+		return 0;
+
 	pfn = *pte & as->smmu->pfn_mask;
 
 	return PFN_PHYS(pfn);
-- 
2.1.0
