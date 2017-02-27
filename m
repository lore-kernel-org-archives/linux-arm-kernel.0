From: olekstysh@gmail.com (Oleksandr Tyshchenko)
Date: Mon, 27 Feb 2017 14:30:25 +0200
Subject: [PATCH v1 1/2] iommu/io-pgtable-arm: Check for leaf entry before
 dereferencing it
In-Reply-To: <1488198626-1884-1-git-send-email-olekstysh@gmail.com>
References: <1488198626-1884-1-git-send-email-olekstysh@gmail.com>
Message-ID: <1488198626-1884-2-git-send-email-olekstysh@gmail.com>
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
 drivers/iommu/io-pgtable-arm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index feacc54..f9bc6eb 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -335,8 +335,12 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 		if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS)
 			pte |= ARM_LPAE_PTE_NSTABLE;
 		__arm_lpae_set_pte(ptep, pte, cfg);
-	} else {
+	} else if (!iopte_leaf(pte, lvl)) {
 		cptep = iopte_deref(pte, data);
+	} else {
+		/* We require an unmap first */
+		WARN_ON(!selftest_running);
+		return -EEXIST;
 	}
 
 	/* Rinse, repeat */
-- 
2.7.4
