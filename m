From: mbrugger@suse.com (Matthias Brugger)
Date: Wed, 13 Apr 2016 12:30:54 +0200
Subject: [PATCH 4/6] staging: fsl-mc: Use platform_msi_* infrastructure
In-Reply-To: <1460543456-11345-1-git-send-email-mbrugger@suse.com>
References: <1460543456-11345-1-git-send-email-mbrugger@suse.com>
Message-ID: <1460543456-11345-5-git-send-email-mbrugger@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthias Brugger <matthias.bgg@gmail.com>

The fsl-mc driver can't be build as a module because it uses msi_*
functions directly. Port the driver to use the platform_msi_*
infrastructure instead, to allow it to be build as a module.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 .../staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c |   5 +-
 drivers/staging/fsl-mc/bus/mc-allocator.c          |   9 +-
 drivers/staging/fsl-mc/bus/mc-msi.c                | 169 +--------------------
 drivers/staging/fsl-mc/include/mc-sys.h            |   3 +
 4 files changed, 14 insertions(+), 172 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c b/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
index 720e2b0..0eecb7e 100644
--- a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
@@ -25,7 +25,6 @@ static struct irq_chip its_msi_irq_chip = {
 	.irq_mask = irq_chip_mask_parent,
 	.irq_unmask = irq_chip_unmask_parent,
 	.irq_eoi = irq_chip_eoi_parent,
-	.irq_set_affinity = msi_domain_set_affinity
 };
 
 static int its_fsl_mc_msi_prepare(struct irq_domain *msi_domain,
@@ -86,7 +85,7 @@ int __init its_fsl_mc_msi_init(void)
 			continue;
 		}
 
-		mc_msi_domain = fsl_mc_msi_create_irq_domain(
+		mc_msi_domain = platform_msi_create_irq_domain(
 						 of_node_to_fwnode(np),
 						 &its_fsl_mc_msi_domain_info,
 						 parent);
@@ -113,7 +112,7 @@ void its_fsl_mc_msi_cleanup(void)
 	     np = of_find_matching_node(np, its_device_id)) {
 		struct irq_domain *mc_msi_domain = irq_find_matching_host(
 							np,
-							DOMAIN_BUS_FSL_MC_MSI);
+							DOMAIN_BUS_PLATFORM_MSI);
 
 		if (!of_property_read_bool(np, "msi-controller"))
 			continue;
diff --git a/drivers/staging/fsl-mc/bus/mc-allocator.c b/drivers/staging/fsl-mc/bus/mc-allocator.c
index 86f8543..b469c5a 100644
--- a/drivers/staging/fsl-mc/bus/mc-allocator.c
+++ b/drivers/staging/fsl-mc/bus/mc-allocator.c
@@ -487,7 +487,8 @@ int fsl_mc_populate_irq_pool(struct fsl_mc_bus *mc_bus,
 		    irq_count > FSL_MC_IRQ_POOL_MAX_TOTAL_IRQS))
 		return -EINVAL;
 
-	error = fsl_mc_msi_domain_alloc_irqs(&mc_bus_dev->dev, irq_count);
+	error = platform_msi_domain_alloc_irqs(&mc_bus_dev->dev, irq_count,
+					       fsl_mc_msi_write_msg);
 	if (error < 0)
 		return error;
 
@@ -514,7 +515,7 @@ int fsl_mc_populate_irq_pool(struct fsl_mc_bus *mc_bus,
 	}
 
 	for_each_msi_entry(msi_desc, &mc_bus_dev->dev) {
-		mc_dev_irq = &irq_resources[msi_desc->fsl_mc.msi_index];
+		mc_dev_irq = &irq_resources[msi_desc->platform.msi_index];
 		mc_dev_irq->msi_desc = msi_desc;
 		mc_dev_irq->resource.id = msi_desc->irq;
 	}
@@ -525,7 +526,7 @@ int fsl_mc_populate_irq_pool(struct fsl_mc_bus *mc_bus,
 	return 0;
 
 cleanup_msi_irqs:
-	fsl_mc_msi_domain_free_irqs(&mc_bus_dev->dev);
+	platform_msi_domain_free_irqs(&mc_bus_dev->dev);
 	return error;
 }
 EXPORT_SYMBOL_GPL(fsl_mc_populate_irq_pool);
@@ -553,7 +554,7 @@ void fsl_mc_cleanup_irq_pool(struct fsl_mc_bus *mc_bus)
 	res_pool->max_count = 0;
 	res_pool->free_count = 0;
 	mc_bus->irq_resources = NULL;
-	fsl_mc_msi_domain_free_irqs(&mc_bus_dev->dev);
+	platform_msi_domain_free_irqs(&mc_bus_dev->dev);
 }
 EXPORT_SYMBOL_GPL(fsl_mc_cleanup_irq_pool);
 
diff --git a/drivers/staging/fsl-mc/bus/mc-msi.c b/drivers/staging/fsl-mc/bus/mc-msi.c
index 3a8258f..ae62a71 100644
--- a/drivers/staging/fsl-mc/bus/mc-msi.c
+++ b/drivers/staging/fsl-mc/bus/mc-msi.c
@@ -16,33 +16,9 @@
 #include <linux/of_irq.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
-#include <linux/msi.h>
 #include "../include/mc-sys.h"
 #include "dprc-cmd.h"
 
-static void fsl_mc_msi_set_desc(msi_alloc_info_t *arg,
-				struct msi_desc *desc)
-{
-	arg->desc = desc;
-	arg->hwirq = (irq_hw_number_t)desc->fsl_mc.msi_index;
-}
-
-static void fsl_mc_msi_update_dom_ops(struct msi_domain_info *info)
-{
-	struct msi_domain_ops *ops = info->ops;
-
-	if (WARN_ON(!ops))
-		return;
-
-	/*
-	 * set_desc should not be set by the caller
-	 */
-	if (WARN_ON(ops->set_desc))
-		return;
-
-	ops->set_desc = fsl_mc_msi_set_desc;
-}
-
 static void __fsl_mc_msi_write_msg(struct fsl_mc_device *mc_bus_dev,
 				   struct fsl_mc_device_irq *mc_dev_irq)
 {
@@ -101,14 +77,13 @@ static void __fsl_mc_msi_write_msg(struct fsl_mc_device *mc_bus_dev,
 /*
  * NOTE: This function is invoked with interrupts disabled
  */
-static void fsl_mc_msi_write_msg(struct irq_data *irq_data,
-				 struct msi_msg *msg)
+void fsl_mc_msi_write_msg(struct msi_desc *msi_desc,
+			  struct msi_msg *msg)
 {
-	struct msi_desc *msi_desc = irq_data_get_msi_desc(irq_data);
 	struct fsl_mc_device *mc_bus_dev = to_fsl_mc_device(msi_desc->dev);
 	struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_bus_dev);
 	struct fsl_mc_device_irq *mc_dev_irq =
-		&mc_bus->irq_resources[msi_desc->fsl_mc.msi_index];
+		&mc_bus->irq_resources[msi_desc->platform.msi_index];
 
 	WARN_ON(mc_dev_irq->msi_desc != msi_desc);
 	msi_desc->msg = *msg;
@@ -119,52 +94,6 @@ static void fsl_mc_msi_write_msg(struct irq_data *irq_data,
 	__fsl_mc_msi_write_msg(mc_bus_dev, mc_dev_irq);
 }
 
-static void fsl_mc_msi_update_chip_ops(struct msi_domain_info *info)
-{
-	struct irq_chip *chip = info->chip;
-
-	if (WARN_ON((!chip)))
-		return;
-
-	/*
-	 * irq_write_msi_msg should not be set by the caller
-	 */
-	if (WARN_ON(chip->irq_write_msi_msg))
-		return;
-
-	chip->irq_write_msi_msg = fsl_mc_msi_write_msg;
-}
-
-/**
- * fsl_mc_msi_create_irq_domain - Create a fsl-mc MSI interrupt domain
- * @np:		Optional device-tree node of the interrupt controller
- * @info:	MSI domain info
- * @parent:	Parent irq domain
- *
- * Updates the domain and chip ops and creates a fsl-mc MSI
- * interrupt domain.
- *
- * Returns:
- * A domain pointer or NULL in case of failure.
- */
-struct irq_domain *fsl_mc_msi_create_irq_domain(struct fwnode_handle *fwnode,
-						struct msi_domain_info *info,
-						struct irq_domain *parent)
-{
-	struct irq_domain *domain;
-
-	if (info->flags & MSI_FLAG_USE_DEF_DOM_OPS)
-		fsl_mc_msi_update_dom_ops(info);
-	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
-		fsl_mc_msi_update_chip_ops(info);
-
-	domain = msi_create_irq_domain(fwnode, info, parent);
-	if (domain)
-		domain->bus_token = DOMAIN_BUS_FSL_MC_MSI;
-
-	return domain;
-}
-
 int fsl_mc_find_msi_domain(struct device *mc_platform_dev,
 			   struct irq_domain **mc_msi_domain)
 {
@@ -172,7 +101,7 @@ int fsl_mc_find_msi_domain(struct device *mc_platform_dev,
 	struct device_node *mc_of_node = mc_platform_dev->of_node;
 
 	msi_domain = of_msi_get_domain(mc_platform_dev, mc_of_node,
-				       DOMAIN_BUS_FSL_MC_MSI);
+				       DOMAIN_BUS_PLATFORM_MSI);
 	if (!msi_domain) {
 		pr_err("Unable to find fsl-mc MSI domain for %s\n",
 		       mc_of_node->full_name);
@@ -184,93 +113,3 @@ int fsl_mc_find_msi_domain(struct device *mc_platform_dev,
 	return 0;
 }
 
-static void fsl_mc_msi_free_descs(struct device *dev)
-{
-	struct msi_desc *desc, *tmp;
-
-	list_for_each_entry_safe(desc, tmp, dev_to_msi_list(dev), list) {
-		list_del(&desc->list);
-		free_msi_entry(desc);
-	}
-}
-
-static int fsl_mc_msi_alloc_descs(struct device *dev, unsigned int irq_count)
-
-{
-	unsigned int i;
-	int error;
-	struct msi_desc *msi_desc;
-
-	for (i = 0; i < irq_count; i++) {
-		msi_desc = alloc_msi_entry(dev);
-		if (!msi_desc) {
-			dev_err(dev, "Failed to allocate msi entry\n");
-			error = -ENOMEM;
-			goto cleanup_msi_descs;
-		}
-
-		msi_desc->fsl_mc.msi_index = i;
-		msi_desc->nvec_used = 1;
-		INIT_LIST_HEAD(&msi_desc->list);
-		list_add_tail(&msi_desc->list, dev_to_msi_list(dev));
-	}
-
-	return 0;
-
-cleanup_msi_descs:
-	fsl_mc_msi_free_descs(dev);
-	return error;
-}
-
-int fsl_mc_msi_domain_alloc_irqs(struct device *dev,
-				 unsigned int irq_count)
-{
-	struct irq_domain *msi_domain;
-	int error;
-
-	if (WARN_ON(!list_empty(dev_to_msi_list(dev))))
-		return -EINVAL;
-
-	error = fsl_mc_msi_alloc_descs(dev, irq_count);
-	if (error < 0)
-		return error;
-
-	msi_domain = dev_get_msi_domain(dev);
-	if (WARN_ON(!msi_domain)) {
-		error = -EINVAL;
-		goto cleanup_msi_descs;
-	}
-
-	/*
-	 * NOTE: Calling this function will trigger the invocation of the
-	 * its_fsl_mc_msi_prepare() callback
-	 */
-	error = msi_domain_alloc_irqs(msi_domain, dev, irq_count);
-
-	if (error) {
-		dev_err(dev, "Failed to allocate IRQs\n");
-		goto cleanup_msi_descs;
-	}
-
-	return 0;
-
-cleanup_msi_descs:
-	fsl_mc_msi_free_descs(dev);
-	return error;
-}
-
-void fsl_mc_msi_domain_free_irqs(struct device *dev)
-{
-	struct irq_domain *msi_domain;
-
-	msi_domain = dev_get_msi_domain(dev);
-	if (WARN_ON(!msi_domain))
-		return;
-
-	msi_domain_free_irqs(msi_domain, dev);
-
-	if (WARN_ON(list_empty(dev_to_msi_list(dev))))
-		return;
-
-	fsl_mc_msi_free_descs(dev);
-}
diff --git a/drivers/staging/fsl-mc/include/mc-sys.h b/drivers/staging/fsl-mc/include/mc-sys.h
index c5038cc..d69582a 100644
--- a/drivers/staging/fsl-mc/include/mc-sys.h
+++ b/drivers/staging/fsl-mc/include/mc-sys.h
@@ -41,6 +41,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
+#include <linux/msi.h>
 
 /**
  * Bit masks for a MC I/O object (struct fsl_mc_io) flags
@@ -107,6 +108,8 @@ int fsl_mc_io_set_dpmcp(struct fsl_mc_io *mc_io,
 			struct fsl_mc_device *dpmcp_dev);
 
 void fsl_mc_io_unset_dpmcp(struct fsl_mc_io *mc_io);
+void fsl_mc_msi_write_msg(struct msi_desc *msi_desc,
+			  struct msi_msg *msg);
 
 int mc_send_command(struct fsl_mc_io *mc_io, struct mc_command *cmd);
 
-- 
2.6.6
