From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 22 Jun 2017 16:53:50 +0100
Subject: [PATCH v2 1/8] iommu/io-pgtable-arm-v7s: Check table PTEs more
 precisely
In-Reply-To: <cover.1498145008.git.robin.murphy@arm.com>
References: <cover.1498145008.git.robin.murphy@arm.com>
Message-ID: <769fe7c1a4d3a4165943b1a0c1443be3508d224c.1498145008.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Whilst we don't support the PXN bit at all, so should never encounter a
level 1 section or supersection PTE with it set, it would still be wise
to check both table type bits to resolve any theoretical ambiguity.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: No change

 drivers/iommu/io-pgtable-arm-v7s.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 8d6ca28c3e1f..a490db032c51 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -92,7 +92,8 @@
 #define ARM_V7S_PTE_TYPE_CONT_PAGE	0x1
 
 #define ARM_V7S_PTE_IS_VALID(pte)	(((pte) & 0x3) != 0)
-#define ARM_V7S_PTE_IS_TABLE(pte, lvl)	(lvl == 1 && ((pte) & ARM_V7S_PTE_TYPE_TABLE))
+#define ARM_V7S_PTE_IS_TABLE(pte, lvl) \
+	((lvl) == 1 && (((pte) & 0x3) == ARM_V7S_PTE_TYPE_TABLE))
 
 /* Page table bits */
 #define ARM_V7S_ATTR_XN(lvl)		BIT(4 * (2 - (lvl)))
-- 
2.12.2.dirty
