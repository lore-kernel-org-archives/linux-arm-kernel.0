From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 Mar 2015 18:15:37 +0000
Subject: [PATCH 4/4] iommu/io-pgtable-arm: avoid speculative walks through
 TTBR1
In-Reply-To: <1426875337-12808-1-git-send-email-will.deacon@arm.com>
References: <1426875337-12808-1-git-send-email-will.deacon@arm.com>
Message-ID: <1426875337-12808-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Although we set TCR.T1SZ to 0, the input address range covered by TTBR1
is actually calculated using T0SZ in this case on the ARM SMMU. This
could theoretically lead to speculative table walks through physical
address zero, leading to all sorts of fun and games if we have MMIO
regions down there.

This patch avoids the issue by setting EPD1 to disable walks through
the unused TTBR1 register.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/io-pgtable-arm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index b610a8dee238..4e460216bd16 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -116,6 +116,8 @@
 #define ARM_32_LPAE_TCR_EAE		(1 << 31)
 #define ARM_64_LPAE_S2_TCR_RES1		(1 << 31)
 
+#define ARM_LPAE_TCR_EPD1		(1 << 23)
+
 #define ARM_LPAE_TCR_TG0_4K		(0 << 14)
 #define ARM_LPAE_TCR_TG0_64K		(1 << 14)
 #define ARM_LPAE_TCR_TG0_16K		(2 << 14)
@@ -621,6 +623,9 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 	}
 
 	reg |= (64ULL - cfg->ias) << ARM_LPAE_TCR_T0SZ_SHIFT;
+
+	/* Disable speculative walks through TTBR1 */
+	reg |= ARM_LPAE_TCR_EPD1;
 	cfg->arm_lpae_s1_cfg.tcr = reg;
 
 	/* MAIRs */
-- 
2.1.4
