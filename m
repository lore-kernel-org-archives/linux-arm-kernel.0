From: robin.murphy@arm.com (Robin Murphy)
Date: Tue,  5 Apr 2016 12:39:32 +0100
Subject: [PATCH 3/3] iommu/io-pgtable-arm-v7s: Support IOMMU_MMIO flag
In-Reply-To: <d80a42ceae3a39ef7c593a5181a1742a84c65533.1459854346.git.robin.murphy@arm.com>
References: <d80a42ceae3a39ef7c593a5181a1742a84c65533.1459854346.git.robin.murphy@arm.com>
Message-ID: <0afc84da4755b08c5593cd2403365b6aaf189afc.1459854347.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Teach the short-descriptor format to create Device mappings when asked.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 9488e3c..de5865e 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -258,9 +258,10 @@ static arm_v7s_iopte arm_v7s_prot_to_pte(int prot, int lvl,
 					 struct io_pgtable_cfg *cfg)
 {
 	bool ap = !(cfg->quirks & IO_PGTABLE_QUIRK_NO_PERMS);
-	arm_v7s_iopte pte = ARM_V7S_ATTR_NG | ARM_V7S_ATTR_S |
-			    ARM_V7S_ATTR_TEX(1);
+	arm_v7s_iopte pte = ARM_V7S_ATTR_NG | ARM_V7S_ATTR_S;
 
+	if (!(prot & IOMMU_MMIO))
+		pte |= ARM_V7S_ATTR_TEX(1);
 	if (ap) {
 		pte |= ARM_V7S_PTE_AF | ARM_V7S_PTE_AP_UNPRIV;
 		if (!(prot & IOMMU_WRITE))
@@ -270,7 +271,9 @@ static arm_v7s_iopte arm_v7s_prot_to_pte(int prot, int lvl,
 
 	if ((prot & IOMMU_NOEXEC) && ap)
 		pte |= ARM_V7S_ATTR_XN(lvl);
-	if (prot & IOMMU_CACHE)
+	if (prot & IOMMU_MMIO)
+		pte |= ARM_V7S_ATTR_B;
+	else if (prot & IOMMU_CACHE)
 		pte |= ARM_V7S_ATTR_B | ARM_V7S_ATTR_C;
 
 	return pte;
@@ -279,10 +282,13 @@ static arm_v7s_iopte arm_v7s_prot_to_pte(int prot, int lvl,
 static int arm_v7s_pte_to_prot(arm_v7s_iopte pte, int lvl)
 {
 	int prot = IOMMU_READ;
+	arm_v7s_iopte attr = pte >> ARM_V7S_ATTR_SHIFT(lvl);
 
-	if (pte & (ARM_V7S_PTE_AP_RDONLY << ARM_V7S_ATTR_SHIFT(lvl)))
+	if (attr & ARM_V7S_PTE_AP_RDONLY)
 		prot |= IOMMU_WRITE;
-	if (pte & ARM_V7S_ATTR_C)
+	if ((attr & (ARM_V7S_TEX_MASK << ARM_V7S_TEX_SHIFT)) == 0)
+		prot |= IOMMU_MMIO;
+	else if (pte & ARM_V7S_ATTR_C)
 		prot |= IOMMU_CACHE;
 
 	return prot;
-- 
2.7.3.dirty
