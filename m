From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 26 Mar 2015 13:43:10 +0100
Subject: [PATCH 07/16] iommu/arm-smmu: Make use of domain_alloc and domain_free
In-Reply-To: <1427373799-18662-1-git-send-email-joro@8bytes.org>
References: <1427373799-18662-1-git-send-email-joro@8bytes.org>
Message-ID: <1427373799-18662-8-git-send-email-joro@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joerg Roedel <jroedel@suse.de>

Implement domain_alloc and domain_free iommu-ops as a
replacement for domain_init/domain_destroy.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/arm-smmu.c | 46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index fc13dd5..5575c3d 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -343,6 +343,7 @@ struct arm_smmu_domain {
 	struct arm_smmu_cfg		cfg;
 	enum arm_smmu_domain_stage	stage;
 	struct mutex			init_mutex; /* Protects smmu pointer */
+	struct iommu_domain		domain;
 };
 
 static struct iommu_ops arm_smmu_ops;
@@ -360,6 +361,11 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ 0, NULL},
 };
 
+static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct arm_smmu_domain, domain);
+}
+
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
 	int i = 0;
@@ -645,7 +651,7 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	u32 fsr, far, fsynr, resume;
 	unsigned long iova;
 	struct iommu_domain *domain = dev;
-	struct arm_smmu_domain *smmu_domain = domain->priv;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	void __iomem *cb_base;
@@ -836,7 +842,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	struct io_pgtable_ops *pgtbl_ops;
 	struct io_pgtable_cfg pgtbl_cfg;
 	enum io_pgtable_fmt fmt;
-	struct arm_smmu_domain *smmu_domain = domain->priv;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 
 	mutex_lock(&smmu_domain->init_mutex);
@@ -958,7 +964,7 @@ out_unlock:
 
 static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 {
-	struct arm_smmu_domain *smmu_domain = domain->priv;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	void __iomem *cb_base;
@@ -985,10 +991,12 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 	__arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
 }
 
-static int arm_smmu_domain_init(struct iommu_domain *domain)
+static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 {
 	struct arm_smmu_domain *smmu_domain;
 
+	if (type != IOMMU_DOMAIN_UNMANAGED)
+		return NULL;
 	/*
 	 * Allocate the domain and initialise some of its data structures.
 	 * We can't really do anything meaningful until we've added a
@@ -996,17 +1004,17 @@ static int arm_smmu_domain_init(struct iommu_domain *domain)
 	 */
 	smmu_domain = kzalloc(sizeof(*smmu_domain), GFP_KERNEL);
 	if (!smmu_domain)
-		return -ENOMEM;
+		return NULL;
 
 	mutex_init(&smmu_domain->init_mutex);
 	spin_lock_init(&smmu_domain->pgtbl_lock);
-	domain->priv = smmu_domain;
-	return 0;
+
+	return &smmu_domain->domain;
 }
 
-static void arm_smmu_domain_destroy(struct iommu_domain *domain)
+static void arm_smmu_domain_free(struct iommu_domain *domain)
 {
-	struct arm_smmu_domain *smmu_domain = domain->priv;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 
 	/*
 	 * Free the domain resources. We assume that all devices have
@@ -1143,7 +1151,7 @@ static void arm_smmu_domain_remove_master(struct arm_smmu_domain *smmu_domain,
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret;
-	struct arm_smmu_domain *smmu_domain = domain->priv;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_master_cfg *cfg;
 
@@ -1187,7 +1195,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 static void arm_smmu_detach_dev(struct iommu_domain *domain, struct device *dev)
 {
-	struct arm_smmu_domain *smmu_domain = domain->priv;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_master_cfg *cfg;
 
 	cfg = find_smmu_master_cfg(dev);
@@ -1203,7 +1211,7 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
 {
 	int ret;
 	unsigned long flags;
-	struct arm_smmu_domain *smmu_domain = domain->priv;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct io_pgtable_ops *ops= smmu_domain->pgtbl_ops;
 
 	if (!ops)
@@ -1220,7 +1228,7 @@ static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 {
 	size_t ret;
 	unsigned long flags;
-	struct arm_smmu_domain *smmu_domain = domain->priv;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct io_pgtable_ops *ops= smmu_domain->pgtbl_ops;
 
 	if (!ops)
@@ -1235,7 +1243,7 @@ static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 					      dma_addr_t iova)
 {
-	struct arm_smmu_domain *smmu_domain = domain->priv;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	struct io_pgtable_ops *ops= smmu_domain->pgtbl_ops;
@@ -1281,7 +1289,7 @@ static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
 {
 	phys_addr_t ret;
 	unsigned long flags;
-	struct arm_smmu_domain *smmu_domain = domain->priv;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct io_pgtable_ops *ops= smmu_domain->pgtbl_ops;
 
 	if (!ops)
@@ -1389,7 +1397,7 @@ static void arm_smmu_remove_device(struct device *dev)
 static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 				    enum iommu_attr attr, void *data)
 {
-	struct arm_smmu_domain *smmu_domain = domain->priv;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 
 	switch (attr) {
 	case DOMAIN_ATTR_NESTING:
@@ -1404,7 +1412,7 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 				    enum iommu_attr attr, void *data)
 {
 	int ret = 0;
-	struct arm_smmu_domain *smmu_domain = domain->priv;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 
 	mutex_lock(&smmu_domain->init_mutex);
 
@@ -1432,8 +1440,8 @@ out_unlock:
 
 static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
-	.domain_init		= arm_smmu_domain_init,
-	.domain_destroy		= arm_smmu_domain_destroy,
+	.domain_alloc		= arm_smmu_domain_alloc,
+	.domain_free		= arm_smmu_domain_free,
 	.attach_dev		= arm_smmu_attach_dev,
 	.detach_dev		= arm_smmu_detach_dev,
 	.map			= arm_smmu_map,
-- 
1.9.1
