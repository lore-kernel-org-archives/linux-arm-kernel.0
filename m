From: olekstysh@gmail.com (Oleksandr Tyshchenko)
Date: Mon, 27 Feb 2017 14:30:26 +0200
Subject: [PATCH v1 2/2] iommu/io-pgtable-arm-v7s: Check for leaf entry before
 dereferencing it
In-Reply-To: <1488198626-1884-1-git-send-email-olekstysh@gmail.com>
References: <1488198626-1884-1-git-send-email-olekstysh@gmail.com>
Message-ID: <1488198626-1884-3-git-send-email-olekstysh@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Do a check for already installed leaf entry at the current level before
dereferencing it in order to avoid walking the page table down with
wrong pointer to the next level.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 1c049e2..8d6ca28 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -422,8 +422,12 @@ static int __arm_v7s_map(struct arm_v7s_io_pgtable *data, unsigned long iova,
 			pte |= ARM_V7S_ATTR_NS_TABLE;
 
 		__arm_v7s_set_pte(ptep, pte, 1, cfg);
-	} else {
+	} else if (ARM_V7S_PTE_IS_TABLE(pte, lvl)) {
 		cptep = iopte_deref(pte, lvl);
+	} else {
+		/* We require an unmap first */
+		WARN_ON(!selftest_running);
+		return -EEXIST;
 	}
 
 	/* Rinse, repeat */
-- 
2.7.4
