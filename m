From: gakula@caviumnetworks.com (Geetha sowjanya)
Date: Wed, 10 May 2017 17:01:56 +0530
Subject: [v5 2/4] ACPI/IORT: Fixup SMMUv3 resource size for Cavium ThunderX2
 SMMUv3 model
In-Reply-To: <1494415918-13770-1-git-send-email-gakula@caviumnetworks.com>
References: <1494415918-13770-1-git-send-email-gakula@caviumnetworks.com>
Message-ID: <1494415918-13770-3-git-send-email-gakula@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linu Cherian <linu.cherian@cavium.com>

Cavium ThunderX2 implementation doesn't support second page in SMMU
register space. Hence, resource size is set as 64k for this model.

Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
Signed-off-by: Geetha Sowjanya <geethasowjanya.akula@cavium.com>
---
 drivers/acpi/arm64/iort.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index c5fecf9..23c5350 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -833,12 +833,20 @@ static void __init arm_smmu_v3_init_resources(struct resource *res,
 {
 	struct acpi_iort_smmu_v3 *smmu;
 	int num_res = 0;
+	unsigned long size = SZ_128K;
 
 	/* Retrieve SMMUv3 specific data */
 	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
 
+	/*
+	 * Override the size, for Cavium ThunderX2 implementation
+	 * which doesn't support the page 1 SMMU register space.
+	 */
+	if (smmu->model == ACPI_IORT_SMMU_V3_CAVIUM_CN99XX)
+		size = SZ_64K;
+
 	res[num_res].start = smmu->base_address;
-	res[num_res].end = smmu->base_address + SZ_128K - 1;
+	res[num_res].end = smmu->base_address + size - 1;
 	res[num_res].flags = IORESOURCE_MEM;
 
 	num_res++;
-- 
1.8.3.1
