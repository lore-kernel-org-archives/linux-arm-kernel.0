From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Wed, 21 Feb 2018 15:59:16 -0700
Subject: [PATCH 06/14] iommu: arm-smmu: Add side-band function to specific
 pasid callbacks
In-Reply-To: <20180221225924.30737-1-jcrouse@codeaurora.org>
References: <20180221225924.30737-1-jcrouse@codeaurora.org>
Message-ID: <20180221225924.30737-7-jcrouse@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just allowing a client driver to create and manage a
a software pasid isn't interesting if the client driver doesn't have
enough information about the pagetable to be able to use it. Add a
side band function for arm-smmu that lets the client device register
pasid operations to pass the relevant pagetable information to the
client driver whenever a new pasid is created or destroyed

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/arm-smmu.h | 18 ++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 include/linux/arm-smmu.h

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 42f5bfa3e26e..81c781705e22 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -50,6 +50,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/arm-smmu.h>
 
 #include <linux/amba/bus.h>
 
@@ -253,6 +254,8 @@ struct arm_smmu_domain {
 
 	spinlock_t			pasid_lock;
 	struct list_head		pasid_list;
+	const struct arm_smmu_pasid_ops	*pasid_ops;
+	void				*pasid_data;
 };
 
 struct arm_smmu_option_prop {
@@ -294,6 +297,10 @@ static void arm_smmu_pasid_free(struct iommu_domain *domain, int pasid)
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_pasid *node, *obj = NULL;
 
+	if (smmu_domain->pasid_ops && smmu_domain->pasid_ops->remove_pasid)
+		smmu_domain->pasid_ops->remove_pasid(pasid,
+			smmu_domain->pasid_data);
+
 	spin_lock(&smmu_domain->pasid_lock);
 	list_for_each_entry(node, &smmu_domain->pasid_list, node) {
 		if (node->pasid == pasid) {
@@ -386,6 +393,26 @@ static int arm_smmu_pasid_alloc(struct iommu_domain *domain, struct device *dev,
 	obj->domain = domain;
 	obj->pasid = pasid;
 
+	if (smmu_domain->pasid_ops && smmu_domain->pasid_ops->install_pasid) {
+		int ret;
+		u64 ttbr;
+
+		if (smmu_domain->cfg.fmt == ARM_SMMU_CTX_FMT_AARCH32_S)
+			ttbr = pgtbl_cfg.arm_v7s_cfg.ttbr[0];
+		else
+			ttbr = pgtbl_cfg.arm_lpae_s1_cfg.ttbr[0];
+
+		ret = smmu_domain->pasid_ops->install_pasid(pasid, ttbr,
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
@@ -2046,6 +2073,19 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
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
2.16.1
