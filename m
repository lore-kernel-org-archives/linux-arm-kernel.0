From: will.deacon@arm.com (Will Deacon)
Date: Fri, 10 Mar 2017 20:49:32 +0000
Subject: [PATCH v2 1/5] iommu/arm-smmu: Restrict domain attributes to
 UNMANAGED domains
In-Reply-To: <1489178976-15353-1-git-send-email-will.deacon@arm.com>
References: <1489178976-15353-1-git-send-email-will.deacon@arm.com>
Message-ID: <1489178976-15353-2-git-send-email-will.deacon@arm.com>
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
index 5806a6acc94e..3d38e682071a 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1837,6 +1837,9 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 
+	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
+		return -EINVAL;
+
 	switch (attr) {
 	case DOMAIN_ATTR_NESTING:
 		*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
@@ -1852,6 +1855,9 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 	int ret = 0;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 
+	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
+		return -EINVAL;
+
 	mutex_lock(&smmu_domain->init_mutex);
 
 	switch (attr) {
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index abf6496843a6..6426819348be 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1549,6 +1549,9 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 
+	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
+		return -EINVAL;
+
 	switch (attr) {
 	case DOMAIN_ATTR_NESTING:
 		*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
@@ -1564,6 +1567,9 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 	int ret = 0;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 
+	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
+		return -EINVAL;
+
 	mutex_lock(&smmu_domain->init_mutex);
 
 	switch (attr) {
-- 
2.1.4
