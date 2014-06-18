From: will.deacon@arm.com (Will Deacon)
Date: Wed, 18 Jun 2014 13:31:19 +0100
Subject: [PATCH RFC v1 1/2] documentation/iommu: Add description of
 Hisilicon System MMU binding
In-Reply-To: <836ade98fe6141f58476bf981ac5a6bf@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1401975430-2648-1-git-send-email-thunder.leizhen@huawei.com>
 <5537408.I9tiuCA96J@wuerfel> <20140616164517.GY16758@arm.com>
 <8028011.DbLMpGku5b@wuerfel> <20140616182645.GD16758@arm.com>
 <836ade98fe6141f58476bf981ac5a6bf@BL2PR03MB468.namprd03.prod.outlook.com>
Message-ID: <20140618123104.GI32699@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 12:10:11PM +0100, Varun Sethi wrote:
> Hi Will,

Hello,

> > Ok. If Thierry's binding gets in for 3.17, then I'll try to convert the
> > ARM SMMU driver over to it for 3.18 providing we don't grow any in-tree
> > users of the existing binding in the meantime (or 3.17 depending on how
> > early it gets queued).
> > 
> > Sound fair?
> Would you be considering the handling of hot plug masters in the arm-smmu
> driver while incorporating the new binding?

Not yet, no. I've not seen any bindings going near hotplug yet, so somebody
would have to propose an extension to what we have.

Note that I *have* been playing with PCI on the ARM SMMU (see the patch
below) but I currently just assume RequesterID == StreamID, which is true
for the platform I'm using.

Will

--->8

commit a492cdaa266afc087e7d27692030455690fbca62
Author: Will Deacon <will.deacon@arm.com>
Date:   Thu May 1 18:05:08 2014 +0100

    iommu/arm-smmu: add support for PCI master devices
    
    This patch extends the ARM SMMU driver so that it can handle PCI master
    devices in addition to platform devices described in the device tree.
    
    The driver is informed about the PCI host controller in the DT via a
    phandle to the host controller in the mmu-masters property. The host
    controller is then added to the master tree for that SMMU, just like a
    normal master (although it probably doesn't advertise any StreamIDs).
    
    When a device is added to the PCI bus, we set the archdata.iommu pointer
    for that device to describe its StreamID (actually its RequesterID for
    the moment). This allows us to re-use our existing data structures using
    the host controller of_node for everything apart from StreamID
    configuration, where we reach into the archdata for the information we
    require.
    
    Signed-off-by: Will Deacon <will.deacon@arm.com>

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 1599354e974d..0e2a12bd58a2 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -39,6 +39,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -329,14 +330,7 @@ struct arm_smmu_smr {
 	u16				id;
 };
 
-struct arm_smmu_master {
-	struct device_node		*of_node;
-
-	/*
-	 * The following is specific to the master's position in the
-	 * SMMU chain.
-	 */
-	struct rb_node			node;
+struct arm_smmu_master_cfg {
 	int				num_streamids;
 	u16				streamids[MAX_MASTER_STREAMIDS];
 
@@ -347,6 +341,17 @@ struct arm_smmu_master {
 	struct arm_smmu_smr		*smrs;
 };
 
+struct arm_smmu_master {
+	struct device_node		*of_node;
+
+	/*
+	 * The following is specific to the master's position in the
+	 * SMMU chain.
+	 */
+	struct rb_node			node;
+	struct arm_smmu_master_cfg	cfg;
+};
+
 struct arm_smmu_device {
 	struct device			*dev;
 	struct device_node		*parent_of_node;
@@ -437,6 +442,18 @@ static void parse_driver_options(struct arm_smmu_device *smmu)
 	} while (arm_smmu_options[++i].opt);
 }
 
+static struct device *dev_get_master_dev(struct device *dev)
+{
+	if (dev_is_pci(dev)) {
+		struct pci_bus *bus = to_pci_dev(dev)->bus;
+		while (!pci_is_root_bus(bus))
+			bus = bus->parent;
+		return bus->bridge->parent;
+	}
+
+	return dev;
+}
+
 static struct arm_smmu_master *find_smmu_master(struct arm_smmu_device *smmu,
 						struct device_node *dev_node)
 {
@@ -457,6 +474,18 @@ static struct arm_smmu_master *find_smmu_master(struct arm_smmu_device *smmu,
 	return NULL;
 }
 
+static struct arm_smmu_master_cfg *
+find_smmu_master_cfg(struct arm_smmu_device *smmu, struct device *dev)
+{
+	struct arm_smmu_master *master;
+
+	if (dev_is_pci(dev))
+		return dev->archdata.iommu;
+
+	master = find_smmu_master(smmu, dev_get_master_dev(dev)->of_node);
+	return master ? &master->cfg : NULL;
+}
+
 static int insert_smmu_master(struct arm_smmu_device *smmu,
 			      struct arm_smmu_master *master)
 {
@@ -508,11 +537,11 @@ static int register_smmu_master(struct arm_smmu_device *smmu,
 	if (!master)
 		return -ENOMEM;
 
-	master->of_node		= masterspec->np;
-	master->num_streamids	= masterspec->args_count;
+	master->of_node			= masterspec->np;
+	master->cfg.num_streamids	= masterspec->args_count;
 
-	for (i = 0; i < master->num_streamids; ++i)
-		master->streamids[i] = masterspec->args[i];
+	for (i = 0; i < master->cfg.num_streamids; ++i)
+		master->cfg.streamids[i] = masterspec->args[i];
 
 	return insert_smmu_master(smmu, master);
 }
@@ -537,6 +566,42 @@ out_unlock:
 	return parent;
 }
 
+static struct arm_smmu_device *find_parent_smmu_for_device(struct device *dev)
+{
+	struct arm_smmu_device *child, *parent, *smmu;
+	struct arm_smmu_master *master = NULL;
+	struct device_node *dev_node = dev_get_master_dev(dev)->of_node;
+
+	spin_lock(&arm_smmu_devices_lock);
+	list_for_each_entry(parent, &arm_smmu_devices, list) {
+		smmu = parent;
+
+		/* Try to find a child of the current SMMU. */
+		list_for_each_entry(child, &arm_smmu_devices, list) {
+			if (child->parent_of_node == parent->dev->of_node) {
+				/* Does the child sit above our master? */
+				master = find_smmu_master(child, dev_node);
+				if (master) {
+					smmu = NULL;
+					break;
+				}
+			}
+		}
+
+		/* We found some children, so keep searching. */
+		if (!smmu) {
+			master = NULL;
+			continue;
+		}
+
+		master = find_smmu_master(smmu, dev_node);
+		if (master)
+			break;
+	}
+	spin_unlock(&arm_smmu_devices_lock);
+	return master ? smmu : NULL;
+}
+
 static int __arm_smmu_alloc_bitmap(unsigned long *map, int start, int end)
 {
 	int idx;
@@ -853,7 +918,8 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 }
 
 static int arm_smmu_init_domain_context(struct iommu_domain *domain,
-					struct device *dev)
+					struct device *dev,
+					struct arm_smmu_device *device_smmu)
 {
 	int irq, ret, start;
 	struct arm_smmu_domain *smmu_domain = domain->priv;
@@ -866,15 +932,15 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	 * early, and therefore check that the root SMMU does indeed have
 	 * a StreamID for the master in question.
 	 */
-	parent = dev->archdata.iommu;
+	parent = device_smmu;
 	smmu_domain->output_mask = -1;
 	do {
 		smmu = parent;
 		smmu_domain->output_mask &= (1ULL << smmu->s2_output_size) - 1;
 	} while ((parent = find_parent_smmu(smmu)));
 
-	if (!find_smmu_master(smmu, dev->of_node)) {
-		dev_err(dev, "unable to find root SMMU for device\n");
+	if (!find_smmu_master_cfg(smmu, dev)) {
+		dev_err(dev, "unable to find root SMMU config for device\n");
 		return -ENODEV;
 	}
 
@@ -918,7 +984,8 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 
 	root_cfg->smmu = smmu;
 	arm_smmu_init_context_bank(smmu_domain);
-	return ret;
+	smmu_domain->leaf_smmu = device_smmu;
+	return 0;
 
 out_free_context:
 	__arm_smmu_free_bitmap(smmu->context_map, root_cfg->cbndx);
@@ -1054,7 +1121,7 @@ static void arm_smmu_domain_destroy(struct iommu_domain *domain)
 }
 
 static int arm_smmu_master_configure_smrs(struct arm_smmu_device *smmu,
-					  struct arm_smmu_master *master)
+					  struct arm_smmu_master_cfg *cfg)
 {
 	int i;
 	struct arm_smmu_smr *smrs;
@@ -1063,18 +1130,18 @@ static int arm_smmu_master_configure_smrs(struct arm_smmu_device *smmu,
 	if (!(smmu->features & ARM_SMMU_FEAT_STREAM_MATCH))
 		return 0;
 
-	if (master->smrs)
+	if (cfg->smrs)
 		return -EEXIST;
 
-	smrs = kmalloc(sizeof(*smrs) * master->num_streamids, GFP_KERNEL);
+	smrs = kmalloc(sizeof(*smrs) * cfg->num_streamids, GFP_KERNEL);
 	if (!smrs) {
-		dev_err(smmu->dev, "failed to allocate %d SMRs for master %s\n",
-			master->num_streamids, master->of_node->name);
+		dev_err(smmu->dev, "failed to allocate %d SMRs\n",
+			cfg->num_streamids);
 		return -ENOMEM;
 	}
 
 	/* Allocate the SMRs on the root SMMU */
-	for (i = 0; i < master->num_streamids; ++i) {
+	for (i = 0; i < cfg->num_streamids; ++i) {
 		int idx = __arm_smmu_alloc_bitmap(smmu->smr_map, 0,
 						  smmu->num_mapping_groups);
 		if (IS_ERR_VALUE(idx)) {
@@ -1085,18 +1152,18 @@ static int arm_smmu_master_configure_smrs(struct arm_smmu_device *smmu,
 		smrs[i] = (struct arm_smmu_smr) {
 			.idx	= idx,
 			.mask	= 0, /* We don't currently share SMRs */
-			.id	= master->streamids[i],
+			.id	= cfg->streamids[i],
 		};
 	}
 
 	/* It worked! Now, poke the actual hardware */
-	for (i = 0; i < master->num_streamids; ++i) {
+	for (i = 0; i < cfg->num_streamids; ++i) {
 		u32 reg = SMR_VALID | smrs[i].id << SMR_ID_SHIFT |
 			  smrs[i].mask << SMR_MASK_SHIFT;
 		writel_relaxed(reg, gr0_base + ARM_SMMU_GR0_SMR(smrs[i].idx));
 	}
 
-	master->smrs = smrs;
+	cfg->smrs = smrs;
 	return 0;
 
 err_free_smrs:
@@ -1107,44 +1174,44 @@ err_free_smrs:
 }
 
 static void arm_smmu_master_free_smrs(struct arm_smmu_device *smmu,
-				      struct arm_smmu_master *master)
+				      struct arm_smmu_master_cfg *cfg)
 {
 	int i;
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
-	struct arm_smmu_smr *smrs = master->smrs;
+	struct arm_smmu_smr *smrs = cfg->smrs;
 
 	/* Invalidate the SMRs before freeing back to the allocator */
-	for (i = 0; i < master->num_streamids; ++i) {
+	for (i = 0; i < cfg->num_streamids; ++i) {
 		u8 idx = smrs[i].idx;
 		writel_relaxed(~SMR_VALID, gr0_base + ARM_SMMU_GR0_SMR(idx));
 		__arm_smmu_free_bitmap(smmu->smr_map, idx);
 	}
 
-	master->smrs = NULL;
+	cfg->smrs = NULL;
 	kfree(smrs);
 }
 
 static void arm_smmu_bypass_stream_mapping(struct arm_smmu_device *smmu,
-					   struct arm_smmu_master *master)
+					   struct arm_smmu_master_cfg *cfg)
 {
 	int i;
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
 
-	for (i = 0; i < master->num_streamids; ++i) {
-		u16 sid = master->streamids[i];
+	for (i = 0; i < cfg->num_streamids; ++i) {
+		u16 sid = cfg->streamids[i];
 		writel_relaxed(S2CR_TYPE_BYPASS,
 			       gr0_base + ARM_SMMU_GR0_S2CR(sid));
 	}
 }
 
 static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
-				      struct arm_smmu_master *master)
+				      struct arm_smmu_master_cfg *cfg)
 {
 	int i, ret;
 	struct arm_smmu_device *parent, *smmu = smmu_domain->root_cfg.smmu;
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
 
-	ret = arm_smmu_master_configure_smrs(smmu, master);
+	ret = arm_smmu_master_configure_smrs(smmu, cfg);
 	if (ret)
 		return ret;
 
@@ -1159,14 +1226,14 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 		if (smmu->features & ARM_SMMU_FEAT_STREAM_MATCH)
 			continue;
 
-		arm_smmu_bypass_stream_mapping(smmu, master);
+		arm_smmu_bypass_stream_mapping(smmu, cfg);
 		smmu = parent;
 	}
 
 	/* Now we're at the root, time to point at our context bank */
-	for (i = 0; i < master->num_streamids; ++i) {
+	for (i = 0; i < cfg->num_streamids; ++i) {
 		u32 idx, s2cr;
-		idx = master->smrs ? master->smrs[i].idx : master->streamids[i];
+		idx = cfg->smrs ? cfg->smrs[i].idx : cfg->streamids[i];
 		s2cr = S2CR_TYPE_TRANS |
 		       (smmu_domain->root_cfg.cbndx << S2CR_CBNDX_SHIFT);
 		writel_relaxed(s2cr, gr0_base + ARM_SMMU_GR0_S2CR(idx));
@@ -1176,7 +1243,7 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 }
 
 static void arm_smmu_domain_remove_master(struct arm_smmu_domain *smmu_domain,
-					  struct arm_smmu_master *master)
+					  struct arm_smmu_master_cfg *cfg)
 {
 	struct arm_smmu_device *smmu = smmu_domain->root_cfg.smmu;
 
@@ -1184,18 +1251,19 @@ static void arm_smmu_domain_remove_master(struct arm_smmu_domain *smmu_domain,
 	 * We *must* clear the S2CR first, because freeing the SMR means
 	 * that it can be re-allocated immediately.
 	 */
-	arm_smmu_bypass_stream_mapping(smmu, master);
-	arm_smmu_master_free_smrs(smmu, master);
+	arm_smmu_bypass_stream_mapping(smmu, cfg);
+	arm_smmu_master_free_smrs(smmu, cfg);
 }
 
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret = -EINVAL;
 	struct arm_smmu_domain *smmu_domain = domain->priv;
-	struct arm_smmu_device *device_smmu = dev->archdata.iommu;
-	struct arm_smmu_master *master;
+	struct arm_smmu_device *device_smmu;
+	struct arm_smmu_master_cfg *cfg;
 	unsigned long flags;
 
+	device_smmu = dev_get_master_dev(dev)->archdata.iommu;
 	if (!device_smmu) {
 		dev_err(dev, "cannot attach to SMMU, is it on the same bus?\n");
 		return -ENXIO;
@@ -1208,11 +1276,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	spin_lock_irqsave(&smmu_domain->lock, flags);
 	if (!smmu_domain->leaf_smmu) {
 		/* Now that we have a master, we can finalise the domain */
-		ret = arm_smmu_init_domain_context(domain, dev);
+		ret = arm_smmu_init_domain_context(domain, dev, device_smmu);
 		if (IS_ERR_VALUE(ret))
 			goto err_unlock;
-
-		smmu_domain->leaf_smmu = device_smmu;
 	} else if (smmu_domain->leaf_smmu != device_smmu) {
 		dev_err(dev,
 			"cannot attach to SMMU %s whilst already attached to domain on SMMU %s\n",
@@ -1223,11 +1289,11 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	spin_unlock_irqrestore(&smmu_domain->lock, flags);
 
 	/* Looks ok, so add the device to the domain */
-	master = find_smmu_master(smmu_domain->leaf_smmu, dev->of_node);
-	if (!master)
+	cfg = find_smmu_master_cfg(smmu_domain->leaf_smmu, dev);
+	if (!cfg)
 		return -ENODEV;
 
-	return arm_smmu_domain_add_master(smmu_domain, master);
+	return arm_smmu_domain_add_master(smmu_domain, cfg);
 
 err_unlock:
 	spin_unlock_irqrestore(&smmu_domain->lock, flags);
@@ -1237,11 +1303,11 @@ err_unlock:
 static void arm_smmu_detach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	struct arm_smmu_domain *smmu_domain = domain->priv;
-	struct arm_smmu_master *master;
+	struct arm_smmu_master_cfg *cfg;
 
-	master = find_smmu_master(smmu_domain->leaf_smmu, dev->of_node);
-	if (master)
-		arm_smmu_domain_remove_master(smmu_domain, master);
+	cfg = find_smmu_master_cfg(smmu_domain->leaf_smmu, dev);
+	if (cfg)
+		arm_smmu_domain_remove_master(smmu_domain, cfg);
 }
 
 static bool arm_smmu_pte_is_contiguous_range(unsigned long addr,
@@ -1549,8 +1615,7 @@ static int arm_smmu_domain_has_cap(struct iommu_domain *domain,
 
 static int arm_smmu_add_device(struct device *dev)
 {
-	struct arm_smmu_device *child, *parent, *smmu;
-	struct arm_smmu_master *master = NULL;
+	struct arm_smmu_device *smmu;
 	struct iommu_group *group;
 	int ret;
 
@@ -1559,35 +1624,8 @@ static int arm_smmu_add_device(struct device *dev)
 		return -EINVAL;
 	}
 
-	spin_lock(&arm_smmu_devices_lock);
-	list_for_each_entry(parent, &arm_smmu_devices, list) {
-		smmu = parent;
-
-		/* Try to find a child of the current SMMU. */
-		list_for_each_entry(child, &arm_smmu_devices, list) {
-			if (child->parent_of_node == parent->dev->of_node) {
-				/* Does the child sit above our master? */
-				master = find_smmu_master(child, dev->of_node);
-				if (master) {
-					smmu = NULL;
-					break;
-				}
-			}
-		}
-
-		/* We found some children, so keep searching. */
-		if (!smmu) {
-			master = NULL;
-			continue;
-		}
-
-		master = find_smmu_master(smmu, dev->of_node);
-		if (master)
-			break;
-	}
-	spin_unlock(&arm_smmu_devices_lock);
-
-	if (!master)
+	smmu = find_parent_smmu_for_device(dev);
+	if (!smmu)
 		return -ENODEV;
 
 	group = iommu_group_alloc();
@@ -1596,15 +1634,35 @@ static int arm_smmu_add_device(struct device *dev)
 		return PTR_ERR(group);
 	}
 
+	if (dev_is_pci(dev)) {
+		struct arm_smmu_master_cfg *cfg;
+		struct pci_dev *pdev = to_pci_dev(dev);
+
+		cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
+		if (!cfg) {
+			ret = -ENOMEM;
+			goto out_put_group;
+		}
+
+		cfg->num_streamids = 1;
+		cfg->streamids[0] = PCI_DEVID(pdev->bus->number, pdev->devfn);
+		dev->archdata.iommu = cfg;
+	} else {
+		dev->archdata.iommu = smmu;
+	}
+
 	ret = iommu_group_add_device(group, dev);
-	iommu_group_put(group);
-	dev->archdata.iommu = smmu;
 
+out_put_group:
+	iommu_group_put(group);
 	return ret;
 }
 
 static void arm_smmu_remove_device(struct device *dev)
 {
+	if (dev_is_pci(dev))
+		kfree(dev->archdata.iommu);
+
 	dev->archdata.iommu = NULL;
 	iommu_group_remove_device(dev);
 }
@@ -2048,6 +2106,11 @@ static int __init arm_smmu_init(void)
 		bus_set_iommu(&amba_bustype, &arm_smmu_ops);
 #endif
 
+#ifdef CONFIG_PCI
+	if (!iommu_present(&pci_bus_type))
+		bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
+#endif
+
 	return 0;
 }
 
