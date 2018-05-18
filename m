From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Fri, 18 May 2018 15:34:50 -0600
Subject: [PATCH 06/16] iommu: arm-smmu: Add side-band function for specific
 PASID callbacks
In-Reply-To: <20180518213500.31595-1-jcrouse@codeaurora.org>
References: <20180518213500.31595-1-jcrouse@codeaurora.org>
Message-ID: <20180518213500.31595-7-jcrouse@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just allowing a client driver to create and manage a
a private PASID isn't interesting if the client driver doesn't have
enough information about the pagetable to be able to use it. Add a
side band function for arm-smmu that lets the client device register
pasid operations to pass the relevant pagetable information to the
client driver whenever a new PASID is created or destroyed

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/arm-smmu.h | 18 ++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 include/linux/arm-smmu.h

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 5c7c135bbb44..100797a07be0 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -50,6 +50,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/arm-smmu.h>
 
 #include <linux/amba/bus.h>
 
@@ -254,6 +255,8 @@ struct arm_smmu_domain {
 
 	spinlock_t			pasid_lock;
 	struct list_head		pasid_list;
+	const struct arm_smmu_pasid_ops	*pasid_ops;
+	void				*pasid_data;
 };
 
 struct arm_smmu_option_prop {
@@ -296,6 +299,10 @@ static void arm_smmu_mm_detach(struct iommu_domain *domain, struct device *dev,
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_pasid *node, *obj = NULL;
 
+	if (smmu_domain->pasid_ops && smmu_domain->pasid_ops->remove_pasid)
+		smmu_domain->pasid_ops->remove_pasid(io_mm->pasid,
+			smmu_domain->pasid_data);
+
 	spin_lock(&smmu_domain->pasid_lock);
 	list_for_each_entry(node, &smmu_domain->pasid_list, node) {
 		if (node->pasid == io_mm->pasid) {
@@ -392,6 +399,26 @@ static int arm_smmu_mm_attach(struct iommu_domain *domain, struct device *dev,
 	obj->domain = domain;
 	obj->pasid = io_mm->pasid;
 
+	if (smmu_domain->pasid_ops && smmu_domain->pasid_ops->install_pasid) {
+		int ret;
+		u64 ttbr;
+
+		if (smmu_domain->cfg.fmt == ARM_SMMU_CTX_FMT_AARCH32_S)
+			ttbr = pgtbl_cfg.arm_v7s_cfg.ttbr;
+		else
+			ttbr = pgtbl_cfg.arm_lpae_s1_cfg.ttbr;
+
+		ret = smmu_domain->pasid_ops->install_pasid(io_mm->pasid, ttbr,
+			smmu_domain->cfg.asid, smmu_domain->pasid_data);
+
+		if (ret) {
+			free_io_pgtable_ops(obj->pgtbl_ops);
+			kfree(obj);
+
+			return ret;
+		}
+	}
+
 	spin_lock(&smmu_domain->pasid_lock);
 	list_add_tail(&obj->node, &smmu_domain->pasid_list);
 	spin_unlock(&smmu_domain->pasid_lock);
@@ -2156,6 +2183,19 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+void arm_smmu_add_pasid_ops(struct iommu_domain *domain,
+	const struct arm_smmu_pasid_ops *ops, void *data)
+{
+	struct arm_smmu_domain *smmu_domain;
+
+	if (domain) {
+		smmu_domain = to_smmu_domain(domain);
+		smmu_domain->pasid_ops = ops;
+		smmu_domain->pasid_data = data;
+	}
+}
+EXPORT_SYMBOL_GPL(arm_smmu_add_pasid_ops);
+
 struct arm_smmu_match_data {
 	enum arm_smmu_arch_version version;
 	enum arm_smmu_implementation model;
diff --git a/include/linux/arm-smmu.h b/include/linux/arm-smmu.h
new file mode 100644
index 000000000000..c14ca52231bf
--- /dev/null
+++ b/include/linux/arm-smmu.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved. */
+
+#ifndef ARM_SMMU_H_
+#define ARM_SMMU_H_
+
+struct iommu_domain;
+
+struct arm_smmu_pasid_ops {
+	int (*install_pasid)(int pasid, u64 ttbr, u32 asid, void *data);
+	void (*remove_pasid)(int pasid, void *data);
+};
+
+
+void arm_smmu_add_pasid_ops(struct iommu_domain *domain,
+	const struct arm_smmu_pasid_ops *ops, void *data);
+
+#endif
-- 
2.17.0
