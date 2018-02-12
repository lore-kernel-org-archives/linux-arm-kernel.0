From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Mon, 12 Feb 2018 18:33:51 +0000
Subject: [PATCH 36/37] iommu/arm-smmu-v3: Add support for PCI PASID
In-Reply-To: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
Message-ID: <20180212183352.22730-37-jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable PASID for PCI devices that support it.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 54 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index ace2f995b0c0..26935a9a5a97 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2608,6 +2608,52 @@ static void arm_smmu_disable_pri(struct arm_smmu_master_data *master)
 	master->can_fault = false;
 }
 
+static int arm_smmu_enable_pasid(struct arm_smmu_master_data *master)
+{
+	int ret;
+	int features;
+	u8 pasid_bits;
+	int num_pasids;
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(master->dev))
+		return -ENOSYS;
+
+	pdev = to_pci_dev(master->dev);
+
+	features = pci_pasid_features(pdev);
+	if (features < 0)
+		return -ENOSYS;
+
+	num_pasids = pci_max_pasids(pdev);
+	if (num_pasids <= 0)
+		return -ENOSYS;
+
+	pasid_bits = min_t(u8, ilog2(num_pasids), master->smmu->ssid_bits);
+
+	dev_dbg(&pdev->dev, "device supports %#x PASID bits [%s%s]\n", pasid_bits,
+		(features & PCI_PASID_CAP_EXEC) ? "x" : "",
+		(features & PCI_PASID_CAP_PRIV) ? "p" : "");
+
+	ret = pci_enable_pasid(pdev, features);
+	return ret ? ret : pasid_bits;
+}
+
+static void arm_smmu_disable_pasid(struct arm_smmu_master_data *master)
+{
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(master->dev))
+		return;
+
+	pdev = to_pci_dev(master->dev);
+
+	if (!pdev->pasid_enabled)
+		return;
+
+	pci_disable_pasid(pdev);
+}
+
 static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 				  struct arm_smmu_master_data *master)
 {
@@ -2728,6 +2774,11 @@ static int arm_smmu_add_device(struct device *dev)
 		master->ste.can_stall = true;
 	}
 
+	/* PASID must be enabled before ATS */
+	ret = arm_smmu_enable_pasid(master);
+	if (ret > 0)
+		master->ssid_bits = ret;
+
 	if (!arm_smmu_enable_ats(master))
 		arm_smmu_enable_pri(master);
 
@@ -2746,6 +2797,7 @@ static int arm_smmu_add_device(struct device *dev)
 err_disable_pri:
 	arm_smmu_disable_pri(master);
 	arm_smmu_disable_ats(master);
+	arm_smmu_disable_pasid(master);
 
 	return ret;
 }
@@ -2766,7 +2818,9 @@ static void arm_smmu_remove_device(struct device *dev)
 	arm_smmu_remove_master(smmu, master);
 
 	arm_smmu_disable_pri(master);
+	/* PASID must be disabled after ATS */
 	arm_smmu_disable_ats(master);
+	arm_smmu_disable_pasid(master);
 
 	iommu_group_remove_device(dev);
 	iommu_device_unlink(&smmu->iommu, dev);
-- 
2.15.1
