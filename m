From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Wed, 21 Feb 2018 15:59:13 -0700
Subject: [PATCH 03/14] iommu: Create a base struct for io_mm
In-Reply-To: <20180221225924.30737-1-jcrouse@codeaurora.org>
References: <20180221225924.30737-1-jcrouse@codeaurora.org>
Message-ID: <20180221225924.30737-4-jcrouse@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support both shared mm sva pagetables as well as
io-pgtable backed tables add a base structure to
io_mm so that the two styles can share the same idr.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 drivers/iommu/arm-smmu-v3.c |  8 ++++----
 drivers/iommu/iommu-sva.c   | 50 ++++++++++++++++++++++++++++++---------------
 include/linux/iommu.h       | 11 +++++++++-
 3 files changed, 47 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 26935a9a5a97..4736a2bf39cf 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2454,7 +2454,7 @@ static int arm_smmu_mm_attach(struct iommu_domain *domain, struct device *dev,
 	if (!attach_domain)
 		return 0;
 
-	return ops->set_entry(ops, io_mm->pasid, smmu_mm->cd);
+	return ops->set_entry(ops, io_mm->base.pasid, smmu_mm->cd);
 }
 
 static void arm_smmu_mm_detach(struct iommu_domain *domain, struct device *dev,
@@ -2466,9 +2466,9 @@ static void arm_smmu_mm_detach(struct iommu_domain *domain, struct device *dev,
 	struct arm_smmu_master_data *master = dev->iommu_fwspec->iommu_priv;
 
 	if (detach_domain)
-		ops->clear_entry(ops, io_mm->pasid, smmu_mm->cd);
+		ops->clear_entry(ops, io_mm->base.pasid, smmu_mm->cd);
 
-	arm_smmu_atc_inv_master_all(master, io_mm->pasid);
+	arm_smmu_atc_inv_master_all(master, io_mm->base.pasid);
 	/* TODO: Invalidate all mappings if last and not DVM. */
 }
 
@@ -2478,7 +2478,7 @@ static void arm_smmu_mm_invalidate(struct iommu_domain *domain,
 {
 	struct arm_smmu_master_data *master = dev->iommu_fwspec->iommu_priv;
 
-	arm_smmu_atc_inv_master_range(master, io_mm->pasid, iova, size);
+	arm_smmu_atc_inv_master_range(master, io_mm->base.pasid, iova, size);
 	/*
 	 * TODO: Invalidate mapping if not DVM
 	 */
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index d7b231cd7355..5fc689b1ef72 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -161,13 +161,15 @@ io_mm_alloc(struct iommu_domain *domain, struct device *dev,
 	io_mm->mm		= mm;
 	io_mm->notifier.ops	= &iommu_mmu_notifier;
 	io_mm->release		= domain->ops->mm_free;
+	io_mm->base.type	= IO_TYPE_MM;
+
 	INIT_LIST_HEAD(&io_mm->devices);
 
 	idr_preload(GFP_KERNEL);
 	spin_lock(&iommu_sva_lock);
-	pasid = idr_alloc_cyclic(&iommu_pasid_idr, io_mm, dev_param->min_pasid,
-				 dev_param->max_pasid + 1, GFP_ATOMIC);
-	io_mm->pasid = pasid;
+	pasid = idr_alloc_cyclic(&iommu_pasid_idr, &io_mm->base,
+		dev_param->min_pasid, dev_param->max_pasid + 1, GFP_ATOMIC);
+	io_mm->base.pasid = pasid;
 	spin_unlock(&iommu_sva_lock);
 	idr_preload_end();
 
@@ -200,7 +202,7 @@ io_mm_alloc(struct iommu_domain *domain, struct device *dev,
 	 * 0 so no user could get a reference to it. Free it manually.
 	 */
 	spin_lock(&iommu_sva_lock);
-	idr_remove(&iommu_pasid_idr, io_mm->pasid);
+	idr_remove(&iommu_pasid_idr, io_mm->base.pasid);
 	spin_unlock(&iommu_sva_lock);
 
 err_free_mm:
@@ -231,7 +233,7 @@ static void io_mm_release(struct kref *kref)
 	io_mm = container_of(kref, struct io_mm, kref);
 	WARN_ON(!list_empty(&io_mm->devices));
 
-	idr_remove(&iommu_pasid_idr, io_mm->pasid);
+	idr_remove(&iommu_pasid_idr, io_mm->base.pasid);
 
 	/*
 	 * If we're being released from mm exit, the notifier callback ->release
@@ -286,7 +288,7 @@ static int io_mm_attach(struct iommu_domain *domain, struct device *dev,
 {
 	int ret;
 	bool attach_domain = true;
-	int pasid = io_mm->pasid;
+	int pasid = io_mm->base.pasid;
 	struct iommu_bond *bond, *tmp;
 	struct iommu_param *dev_param = dev->iommu_param;
 
@@ -378,7 +380,7 @@ static int iommu_signal_mm_exit(struct iommu_bond *bond)
 	if (!dev->iommu_param || !dev->iommu_param->mm_exit)
 		return 0;
 
-	return dev->iommu_param->mm_exit(dev, io_mm->pasid, bond->drvdata);
+	return dev->iommu_param->mm_exit(dev, io_mm->base.pasid, bond->drvdata);
 }
 
 /*
@@ -410,7 +412,7 @@ static void iommu_notifier_release(struct mmu_notifier *mn, struct mm_struct *mm
 	list_for_each_entry_safe(bond, next, &io_mm->devices, mm_head) {
 		if (iommu_signal_mm_exit(bond))
 			dev_WARN(bond->dev, "possible leak of PASID %u",
-				 io_mm->pasid);
+				 io_mm->base.pasid);
 
 		io_mm_detach_all_locked(bond);
 	}
@@ -585,6 +587,7 @@ int iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, int *pasid,
 			  unsigned long flags, void *drvdata)
 {
 	int i, ret;
+	struct io_base *io_base = NULL;
 	struct io_mm *io_mm = NULL;
 	struct iommu_domain *domain;
 	struct iommu_bond *bond = NULL, *tmp;
@@ -605,7 +608,12 @@ int iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, int *pasid,
 
 	/* If an io_mm already exists, use it */
 	spin_lock(&iommu_sva_lock);
-	idr_for_each_entry(&iommu_pasid_idr, io_mm, i) {
+	idr_for_each_entry(&iommu_pasid_idr, io_base, i) {
+		if (io_base->type != IO_TYPE_MM)
+			continue;
+
+		io_mm = container_of(io_base, struct io_mm, base);
+
 		if (io_mm->mm != mm || !io_mm_get_locked(io_mm))
 			continue;
 
@@ -636,7 +644,7 @@ int iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, int *pasid,
 	if (ret)
 		io_mm_put(io_mm);
 	else
-		*pasid = io_mm->pasid;
+		*pasid = io_mm->base.pasid;
 
 	return ret;
 }
@@ -659,6 +667,7 @@ EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
 int iommu_sva_unbind_device(struct device *dev, int pasid)
 {
 	int ret = -ESRCH;
+	struct io_base *io_base;
 	struct io_mm *io_mm;
 	struct iommu_domain *domain;
 	struct iommu_bond *bond = NULL;
@@ -674,12 +683,14 @@ int iommu_sva_unbind_device(struct device *dev, int pasid)
 	iommu_fault_queue_flush(dev);
 
 	spin_lock(&iommu_sva_lock);
-	io_mm = idr_find(&iommu_pasid_idr, pasid);
-	if (!io_mm) {
+	io_base = idr_find(&iommu_pasid_idr, pasid);
+	if (!io_base || io_base->type != IO_TYPE_MM) {
 		spin_unlock(&iommu_sva_lock);
 		return -ESRCH;
 	}
 
+	io_mm = container_of(io_base, struct io_mm, base);
+
 	list_for_each_entry(bond, &io_mm->devices, mm_head) {
 		if (bond->dev == dev) {
 			io_mm_detach_locked(bond);
@@ -777,16 +788,21 @@ EXPORT_SYMBOL_GPL(iommu_unregister_mm_exit_handler);
  */
 struct mm_struct *iommu_sva_find(int pasid)
 {
+	struct io_base *io_base;
 	struct io_mm *io_mm;
 	struct mm_struct *mm = NULL;
 
 	spin_lock(&iommu_sva_lock);
-	io_mm = idr_find(&iommu_pasid_idr, pasid);
-	if (io_mm && io_mm_get_locked(io_mm)) {
-		if (mmget_not_zero(io_mm->mm))
-			mm = io_mm->mm;
+	io_base = idr_find(&iommu_pasid_idr, pasid);
+	if (io_base && io_base->type == IO_TYPE_MM) {
+		io_mm = container_of(io_base, struct io_mm, base);
+
+		if (io_mm_get_locked(io_mm)) {
+			if (mmget_not_zero(io_mm->mm))
+				mm = io_mm->mm;
 
-		io_mm_put_locked(io_mm);
+			io_mm_put_locked(io_mm);
+		}
 	}
 	spin_unlock(&iommu_sva_lock);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e2c49e583d8d..e998389cf195 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -110,8 +110,17 @@ struct iommu_domain {
 	struct list_head mm_list;
 };
 
+enum iommu_io_type {
+	IO_TYPE_MM,
+};
+
+struct io_base {
+	int type;
+	int pasid;
+};
+
 struct io_mm {
-	int			pasid;
+	struct io_base		base;
 	struct list_head	devices;
 	struct kref		kref;
 #if defined(CONFIG_MMU_NOTIFIER)
-- 
2.16.1
