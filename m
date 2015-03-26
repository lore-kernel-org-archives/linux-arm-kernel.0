From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 26 Mar 2015 13:43:16 +0100
Subject: [PATCH 13/16] iommu/ipmmu-vmsa: Make use of domain_alloc and
 domain_free
In-Reply-To: <1427373799-18662-1-git-send-email-joro@8bytes.org>
References: <1427373799-18662-1-git-send-email-joro@8bytes.org>
Message-ID: <1427373799-18662-14-git-send-email-joro@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joerg Roedel <jroedel@suse.de>

Implement domain_alloc and domain_free iommu-ops as a
replacement for domain_init/domain_destroy.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/ipmmu-vmsa.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 10186ca..274c08d 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -38,7 +38,7 @@ struct ipmmu_vmsa_device {
 
 struct ipmmu_vmsa_domain {
 	struct ipmmu_vmsa_device *mmu;
-	struct iommu_domain *io_domain;
+	struct iommu_domain io_domain;
 
 	struct io_pgtable_cfg cfg;
 	struct io_pgtable_ops *iop;
@@ -56,6 +56,11 @@ struct ipmmu_vmsa_archdata {
 static DEFINE_SPINLOCK(ipmmu_devices_lock);
 static LIST_HEAD(ipmmu_devices);
 
+static struct ipmmu_vmsa_domain *to_vmsa_domain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct ipmmu_vmsa_domain, io_domain);
+}
+
 #define TLB_LOOP_TIMEOUT		100	/* 100us */
 
 /* -----------------------------------------------------------------------------
@@ -428,7 +433,7 @@ static irqreturn_t ipmmu_domain_irq(struct ipmmu_vmsa_domain *domain)
 	 * TODO: We need to look up the faulty device based on the I/O VA. Use
 	 * the IOMMU device for now.
 	 */
-	if (!report_iommu_fault(domain->io_domain, mmu->dev, iova, 0))
+	if (!report_iommu_fault(&domain->io_domain, mmu->dev, iova, 0))
 		return IRQ_HANDLED;
 
 	dev_err_ratelimited(mmu->dev,
@@ -448,7 +453,7 @@ static irqreturn_t ipmmu_irq(int irq, void *dev)
 		return IRQ_NONE;
 
 	io_domain = mmu->mapping->domain;
-	domain = io_domain->priv;
+	domain = to_vmsa_domain(io_domain);
 
 	return ipmmu_domain_irq(domain);
 }
@@ -457,25 +462,25 @@ static irqreturn_t ipmmu_irq(int irq, void *dev)
  * IOMMU Operations
  */
 
-static int ipmmu_domain_init(struct iommu_domain *io_domain)
+static struct iommu_domain *ipmmu_domain_alloc(unsigned type)
 {
 	struct ipmmu_vmsa_domain *domain;
 
+	if (type != IOMMU_DOMAIN_UNMANAGED)
+		return NULL;
+
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (!domain)
-		return -ENOMEM;
+		return NULL;
 
 	spin_lock_init(&domain->lock);
 
-	io_domain->priv = domain;
-	domain->io_domain = io_domain;
-
-	return 0;
+	return &domain->io_domain;
 }
 
-static void ipmmu_domain_destroy(struct iommu_domain *io_domain)
+static void ipmmu_domain_free(struct iommu_domain *io_domain)
 {
-	struct ipmmu_vmsa_domain *domain = io_domain->priv;
+	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 
 	/*
 	 * Free the domain resources. We assume that all devices have already
@@ -491,7 +496,7 @@ static int ipmmu_attach_device(struct iommu_domain *io_domain,
 {
 	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
 	struct ipmmu_vmsa_device *mmu = archdata->mmu;
-	struct ipmmu_vmsa_domain *domain = io_domain->priv;
+	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 	unsigned long flags;
 	unsigned int i;
 	int ret = 0;
@@ -532,7 +537,7 @@ static void ipmmu_detach_device(struct iommu_domain *io_domain,
 				struct device *dev)
 {
 	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
-	struct ipmmu_vmsa_domain *domain = io_domain->priv;
+	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 	unsigned int i;
 
 	for (i = 0; i < archdata->num_utlbs; ++i)
@@ -546,7 +551,7 @@ static void ipmmu_detach_device(struct iommu_domain *io_domain,
 static int ipmmu_map(struct iommu_domain *io_domain, unsigned long iova,
 		     phys_addr_t paddr, size_t size, int prot)
 {
-	struct ipmmu_vmsa_domain *domain = io_domain->priv;
+	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 
 	if (!domain)
 		return -ENODEV;
@@ -557,7 +562,7 @@ static int ipmmu_map(struct iommu_domain *io_domain, unsigned long iova,
 static size_t ipmmu_unmap(struct iommu_domain *io_domain, unsigned long iova,
 			  size_t size)
 {
-	struct ipmmu_vmsa_domain *domain = io_domain->priv;
+	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 
 	return domain->iop->unmap(domain->iop, iova, size);
 }
@@ -565,7 +570,7 @@ static size_t ipmmu_unmap(struct iommu_domain *io_domain, unsigned long iova,
 static phys_addr_t ipmmu_iova_to_phys(struct iommu_domain *io_domain,
 				      dma_addr_t iova)
 {
-	struct ipmmu_vmsa_domain *domain = io_domain->priv;
+	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 
 	/* TODO: Is locking needed ? */
 
@@ -737,8 +742,8 @@ static void ipmmu_remove_device(struct device *dev)
 }
 
 static const struct iommu_ops ipmmu_ops = {
-	.domain_init = ipmmu_domain_init,
-	.domain_destroy = ipmmu_domain_destroy,
+	.domain_alloc = ipmmu_domain_alloc,
+	.domain_free = ipmmu_domain_free,
 	.attach_dev = ipmmu_attach_device,
 	.detach_dev = ipmmu_detach_device,
 	.map = ipmmu_map,
-- 
1.9.1
