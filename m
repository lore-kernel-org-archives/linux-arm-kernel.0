From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 25 Jun 2015 17:52:28 +0200
Subject: [PATCH 2/2] arm/smmu: Make use of of_parse_phandle_with_var_args
In-Reply-To: <1435247548-32201-1-git-send-email-joro@8bytes.org>
References: <1435247548-32201-1-git-send-email-joro@8bytes.org>
Message-ID: <1435247548-32201-2-git-send-email-joro@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joerg Roedel <jroedel@suse.de>

The function of_parse_phandle_with_args() can only handle 16
args, but there are systems that require more (25 in my
case). So use the newly introduced function
of_parse_phandle_with_var_args() instead.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/arm-smmu.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 66a803b..da4d7ac 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -47,7 +47,7 @@
 #include "io-pgtable.h"
 
 /* Maximum number of stream IDs assigned to a single device */
-#define MAX_MASTER_STREAMIDS		MAX_PHANDLE_ARGS
+#define MAX_MASTER_STREAMIDS		128
 
 /* Maximum number of context banks per SMMU */
 #define ARM_SMMU_MAX_CBS		128
@@ -1699,7 +1699,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	struct arm_smmu_device *smmu;
 	struct device *dev = &pdev->dev;
 	struct rb_node *node;
-	struct of_phandle_args masterspec;
+	struct of_phandle_args *masterspec;
 	int num_irqs, i, err;
 
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
@@ -1758,15 +1758,19 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	masterspec = of_alloc_phandle_args(MAX_MASTER_STREAMIDS);
+	if (!masterspec)
+		return -ENOMEM;
+
 	i = 0;
 	smmu->masters = RB_ROOT;
-	while (!of_parse_phandle_with_args(dev->of_node, "mmu-masters",
-					   "#stream-id-cells", i,
-					   &masterspec)) {
-		err = register_smmu_master(smmu, dev, &masterspec);
+	while (!of_parse_phandle_with_var_args(dev->of_node, "mmu-masters",
+					   "#stream-id-cells", i, masterspec,
+					   MAX_MASTER_STREAMIDS)) {
+		err = register_smmu_master(smmu, dev, masterspec);
 		if (err) {
 			dev_err(dev, "failed to add master %s\n",
-				masterspec.np->name);
+				masterspec->np->name);
 			goto out_put_masters;
 		}
 
@@ -1811,6 +1815,9 @@ out_free_irqs:
 		free_irq(smmu->irqs[i], smmu);
 
 out_put_masters:
+
+	of_free_phandle_args(masterspec);
+
 	for (node = rb_first(&smmu->masters); node; node = rb_next(node)) {
 		struct arm_smmu_master *master
 			= container_of(node, struct arm_smmu_master, node);
-- 
1.9.1
