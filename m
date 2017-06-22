From: gakula@caviumnetworks.com (Geetha sowjanya)
Date: Thu, 22 Jun 2017 17:35:36 +0530
Subject: [PATCH v9 1/3] ACPI/IORT: Fixup SMMUv3 resource size for Cavium
 ThunderX2 SMMUv3 model
In-Reply-To: <1498133138-20244-1-git-send-email-gakula@caviumnetworks.com>
References: <1498133138-20244-1-git-send-email-gakula@caviumnetworks.com>
Message-ID: <1498133138-20244-2-git-send-email-gakula@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linu Cherian <linu.cherian@cavium.com>

Cavium ThunderX2 implementation doesn't support second page in SMMU
register space. Hence, resource size is set as 64k for this model.

Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
Signed-off-by: Geetha Sowjanya <geethasowjanya.akula@cavium.com>
---
 drivers/acpi/arm64/iort.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index c5fecf9..c166f3e 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -828,6 +828,18 @@ static int __init arm_smmu_v3_count_resources(struct acpi_iort_node *node)
 	return num_res;
 }
 
+static unsigned long arm_smmu_v3_resource_size(struct acpi_iort_smmu_v3 *smmu)
+{
+	/*
+	 * Override the size, for Cavium ThunderX2 implementation
+	 * which doesn't support the page 1 SMMU register space.
+	 */
+	if (smmu->model == ACPI_IORT_SMMU_V3_CAVIUM_CN99XX)
+		return SZ_64K;
+
+	return SZ_128K;
+}
+
 static void __init arm_smmu_v3_init_resources(struct resource *res,
 					      struct acpi_iort_node *node)
 {
@@ -838,7 +850,8 @@ static void __init arm_smmu_v3_init_resources(struct resource *res,
 	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
 
 	res[num_res].start = smmu->base_address;
-	res[num_res].end = smmu->base_address + SZ_128K - 1;
+	res[num_res].end = smmu->base_address +
+				arm_smmu_v3_resource_size(smmu) - 1;
 	res[num_res].flags = IORESOURCE_MEM;
 
 	num_res++;
-- 
1.7.1
