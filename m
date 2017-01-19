From: will.deacon@arm.com (Will Deacon)
Date: Thu, 19 Jan 2017 18:19:11 +0000
Subject: [PATCH 1/5] iommu/arm-smmu: Restrict domain attributes to UNMANAGED
 domains
In-Reply-To: <1484849955-1871-1-git-send-email-will.deacon@arm.com>
References: <1484849955-1871-1-git-send-email-will.deacon@arm.com>
Message-ID: <1484849955-1871-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM SMMU drivers provide a DOMAIN_ATTR_NESTING domain attribute,
which allows callers of the IOMMU API to request that the page table
for a domain is installed at stage-2, if supported by the hardware.

Since setting this attribute only makes sense for UNMANAGED domains,
this patch returns -ENODEV if the domain_{get,set}_attr operations are
called on other domain types.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 6 ++++++
 drivers/iommu/arm-smmu.c    | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 4d6ec444a9d6..c254325b0c7a 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1839,6 +1839,9 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 
+	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
+		return -ENODEV;
+
 	switch (attr) {
 	case DOMAIN_ATTR_NESTING:
 		*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
@@ -1854,6 +1857,9 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 	int ret = 0;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 
+	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
+		return -ENODEV;
+
 	mutex_lock(&smmu_domain->init_mutex);
 
 	switch (attr) {
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index a60cded8a6ed..a328ffb75509 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1497,6 +1497,9 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 
+	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
+		return -ENODEV;
+
 	switch (attr) {
 	case DOMAIN_ATTR_NESTING:
 		*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
@@ -1512,6 +1515,9 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 	int ret = 0;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 
+	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
+		return -ENODEV;
+
 	mutex_lock(&smmu_domain->init_mutex);
 
 	switch (attr) {
-- 
2.1.4
