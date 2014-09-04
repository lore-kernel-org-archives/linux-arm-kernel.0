From: will.deacon@arm.com (Will Deacon)
Date: Thu,  4 Sep 2014 17:50:00 +0100
Subject: [PATCH 2/7] iommu/arm-smmu: add support for multi-master iommu groups
In-Reply-To: <1409849405-17347-1-git-send-email-will.deacon@arm.com>
References: <1409849405-17347-1-git-send-email-will.deacon@arm.com>
Message-ID: <1409849405-17347-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Whilst the driver currently creates one IOMMU group per device, this
will soon change when we start supporting non-transparent PCI bridges
which require all upstream masters to be assigned to the same address
space.

This patch reworks our IOMMU group code so that we can easily support
multi-master groups. The master configuration (streamids and smrs) is
stored as private iommudata on the group, whilst the low-level attach/detach
code is updated to avoid double alloc/free when dealing with multiple
masters sharing the same SMMU configuration. This unifies device
handling, regardless of whether the device sits on the platform or pci
bus.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu.c | 62 ++++++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 958ae8194afe..ef6623dbba9a 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -431,17 +431,17 @@ static void parse_driver_options(struct arm_smmu_device *smmu)
 	} while (arm_smmu_options[++i].opt);
 }
 
-static struct device *dev_get_master_dev(struct device *dev)
+static struct device_node *dev_get_dev_node(struct device *dev)
 {
 	if (dev_is_pci(dev)) {
 		struct pci_bus *bus = to_pci_dev(dev)->bus;
 
 		while (!pci_is_root_bus(bus))
 			bus = bus->parent;
-		return bus->bridge->parent;
+		return bus->bridge->parent->of_node;
 	}
 
-	return dev;
+	return dev->of_node;
 }
 
 static struct arm_smmu_master *find_smmu_master(struct arm_smmu_device *smmu,
@@ -466,15 +466,10 @@ static struct arm_smmu_master *find_smmu_master(struct arm_smmu_device *smmu,
 }
 
 static struct arm_smmu_master_cfg *
-find_smmu_master_cfg(struct arm_smmu_device *smmu, struct device *dev)
+find_smmu_master_cfg(struct device *dev)
 {
-	struct arm_smmu_master *master;
-
-	if (dev_is_pci(dev))
-		return dev->archdata.iommu;
-
-	master = find_smmu_master(smmu, dev->of_node);
-	return master ? &master->cfg : NULL;
+	struct iommu_group *group = iommu_group_get(dev);
+	return group ? iommu_group_get_iommudata(group) : NULL;
 }
 
 static int insert_smmu_master(struct arm_smmu_device *smmu,
@@ -550,7 +545,7 @@ static struct arm_smmu_device *find_smmu_for_device(struct device *dev)
 {
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_master *master = NULL;
-	struct device_node *dev_node = dev_get_master_dev(dev)->of_node;
+	struct device_node *dev_node = dev_get_dev_node(dev);
 
 	spin_lock(&arm_smmu_devices_lock);
 	list_for_each_entry(smmu, &arm_smmu_devices, list) {
@@ -1156,9 +1151,10 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
 
+	/* Devices in an IOMMU group may already be configured */
 	ret = arm_smmu_master_configure_smrs(smmu, cfg);
 	if (ret)
-		return ret;
+		return ret == -EEXIST ? 0 : ret;
 
 	for (i = 0; i < cfg->num_streamids; ++i) {
 		u32 idx, s2cr;
@@ -1179,6 +1175,10 @@ static void arm_smmu_domain_remove_master(struct arm_smmu_domain *smmu_domain,
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
 
+	/* An IOMMU group is torn down by the first device to be removed */
+	if ((smmu->features & ARM_SMMU_FEAT_STREAM_MATCH) && !cfg->smrs)
+		return;
+
 	/*
 	 * We *must* clear the S2CR first, because freeing the SMR means
 	 * that it can be re-allocated immediately.
@@ -1200,7 +1200,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	struct arm_smmu_device *smmu, *dom_smmu;
 	struct arm_smmu_master_cfg *cfg;
 
-	smmu = dev_get_master_dev(dev)->archdata.iommu;
+	smmu = find_smmu_for_device(dev);
 	if (!smmu) {
 		dev_err(dev, "cannot attach to SMMU, is it on the same bus?\n");
 		return -ENXIO;
@@ -1228,7 +1228,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	}
 
 	/* Looks ok, so add the device to the domain */
-	cfg = find_smmu_master_cfg(smmu_domain->smmu, dev);
+	cfg = find_smmu_master_cfg(dev);
 	if (!cfg)
 		return -ENODEV;
 
@@ -1240,7 +1240,7 @@ static void arm_smmu_detach_dev(struct iommu_domain *domain, struct device *dev)
 	struct arm_smmu_domain *smmu_domain = domain->priv;
 	struct arm_smmu_master_cfg *cfg;
 
-	cfg = find_smmu_master_cfg(smmu_domain->smmu, dev);
+	cfg = find_smmu_master_cfg(dev);
 	if (cfg)
 		arm_smmu_domain_remove_master(smmu_domain, cfg);
 }
@@ -1554,17 +1554,19 @@ static int __arm_smmu_get_pci_sid(struct pci_dev *pdev, u16 alias, void *data)
 	return 0; /* Continue walking */
 }
 
+static void __arm_smmu_release_pci_iommudata(void *data)
+{
+	kfree(data);
+}
+
 static int arm_smmu_add_device(struct device *dev)
 {
 	struct arm_smmu_device *smmu;
+	struct arm_smmu_master_cfg *cfg;
 	struct iommu_group *group;
+	void (*releasefn)(void *) = NULL;
 	int ret;
 
-	if (dev->archdata.iommu) {
-		dev_warn(dev, "IOMMU driver already assigned to device\n");
-		return -EINVAL;
-	}
-
 	smmu = find_smmu_for_device(dev);
 	if (!smmu)
 		return -ENODEV;
@@ -1576,7 +1578,6 @@ static int arm_smmu_add_device(struct device *dev)
 	}
 
 	if (dev_is_pci(dev)) {
-		struct arm_smmu_master_cfg *cfg;
 		struct pci_dev *pdev = to_pci_dev(dev);
 
 		cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
@@ -1592,11 +1593,20 @@ static int arm_smmu_add_device(struct device *dev)
 		 */
 		pci_for_each_dma_alias(pdev, __arm_smmu_get_pci_sid,
 				       &cfg->streamids[0]);
-		dev->archdata.iommu = cfg;
+		releasefn = __arm_smmu_release_pci_iommudata;
 	} else {
-		dev->archdata.iommu = smmu;
+		struct arm_smmu_master *master;
+
+		master = find_smmu_master(smmu, dev->of_node);
+		if (!master) {
+			ret = -ENODEV;
+			goto out_put_group;
+		}
+
+		cfg = &master->cfg;
 	}
 
+	iommu_group_set_iommudata(group, cfg, releasefn);
 	ret = iommu_group_add_device(group, dev);
 
 out_put_group:
@@ -1606,10 +1616,6 @@ out_put_group:
 
 static void arm_smmu_remove_device(struct device *dev)
 {
-	if (dev_is_pci(dev))
-		kfree(dev->archdata.iommu);
-
-	dev->archdata.iommu = NULL;
 	iommu_group_remove_device(dev);
 }
 
-- 
2.1.0
