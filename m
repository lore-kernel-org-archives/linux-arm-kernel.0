From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 29 Mar 2018 12:24:52 +0100
Subject: [PATCH] iommu/io-pgtable-arm: Avoid warning with 32-bit phys_addr_t
Message-ID: <7181ab429dc33f407ca53d66ec36d1c4d28f74cd.1522322035.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's not entirely unreasonable for io-pgtable-arm to be built for
configurations with 32-bit phys_addr_t, where the compiler rightly
raises a warning about the 36-bit shift. That particular code path
should never actually *run* on those systems, but we still want it
to compile cleanly, which is easily done by using an unambiguous u64
as the intermediate type instead.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Oops, I managed to totally overlook that phys_addr_t would be
configuration-dependent, sorry :(

If this can't sneak in on top of the SMMU pull, I'll resend it 
as a fix for -rc1. It shouldn't be super-critical.

 drivers/iommu/io-pgtable-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index a5be4c92c5c8..47b64d3b833f 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -211,7 +211,7 @@ static arm_lpae_iopte paddr_to_iopte(phys_addr_t paddr,
 static phys_addr_t iopte_to_paddr(arm_lpae_iopte pte,
 				  struct arm_lpae_io_pgtable *data)
 {
-	phys_addr_t paddr = pte & ARM_LPAE_PTE_ADDR_MASK;
+	u64 paddr = pte & ARM_LPAE_PTE_ADDR_MASK;
 
 	if (data->pg_shift < 16)
 		return paddr;
-- 
2.16.1.dirty
