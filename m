From: sricharan@codeaurora.org (Sricharan R)
Date: Fri, 17 Jul 2015 22:23:23 +0530
Subject: [RFC PATCH 2/4] iommu/arm-smmu: Add xlate callback for initializing
 master devices from dt
In-Reply-To: <1437152005-25092-1-git-send-email-sricharan@codeaurora.org>
References: <1437152005-25092-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1437152005-25092-3-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds of_xlate callback to arm-smmu driver. xlate callback
is called during device registration from DT for those master
devices attached to iommus using generic iommu bindings.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 8c4eb43..2cf65ab 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -321,6 +321,7 @@ struct arm_smmu_device {
 	unsigned int			*irqs;
 
 	struct list_head		list;
+	struct device_node		*node;
 	struct rb_root			masters;
 };
 
@@ -1434,6 +1435,38 @@ out_unlock:
 	return ret;
 }
 
+static int arm_smmu_of_xlate(struct device *dev,
+			     struct of_phandle_args *spec)
+{
+	struct arm_smmu_device *smmu;
+	struct arm_smmu_master *master;
+	int streamid;
+
+	spin_lock(&arm_smmu_devices_lock);
+	list_for_each_entry(smmu, &arm_smmu_devices, list) {
+		if (smmu->node == spec->np)
+			break;
+	}
+	spin_unlock(&arm_smmu_devices_lock);
+
+	if (!smmu || (smmu->node != spec->np))
+		return -ENODEV;
+
+	spec->np = dev->of_node;
+
+	master = find_smmu_master(smmu, spec->np);
+	if (!master) {
+		if (register_smmu_master(smmu, smmu->dev, spec))
+			return -ENODEV;
+	} else {
+		streamid = master->cfg.num_streamids;
+		master->cfg.streamids[streamid] = spec->args[0];
+		master->cfg.num_streamids++;
+	}
+
+	return 0;
+}
+
 static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_init		= arm_smmu_domain_init,
@@ -1449,6 +1482,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.domain_get_attr	= arm_smmu_domain_get_attr,
 	.domain_set_attr	= arm_smmu_domain_set_attr,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
+	.of_xlate		= arm_smmu_of_xlate,
 };
 
 static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
@@ -1782,6 +1816,8 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 		}
 	}
 
+	smmu->node = dev->of_node;
+
 	INIT_LIST_HEAD(&smmu->list);
 	spin_lock(&arm_smmu_devices_lock);
 	list_add(&smmu->list, &arm_smmu_devices);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
