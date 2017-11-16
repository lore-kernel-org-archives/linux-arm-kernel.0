From: bharatku@xilinx.com (Bharat Kumar Gogada)
Date: Thu, 16 Nov 2017 14:19:36 +0000
Subject: [RFCv2 PATCH 31/36] iommu/arm-smmu-v3: Add support for PCI ATS
In-Reply-To: <20171006133203.22803-32-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-32-jean-philippe.brucker@arm.com>
Message-ID: <BLUPR0201MB150565029F9260A528739ACBA52E0@BLUPR0201MB1505.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

+static size_t
+arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
+			unsigned long iova, size_t size)
+{
+	unsigned long flags;
+	struct arm_smmu_cmdq_ent cmd;
+	struct arm_smmu_master_data *master;
+
+	arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
+
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(master, &smmu_domain->devices, list)
+		arm_smmu_atc_inv_master(master, &cmd);
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+
+	return size;
+}
+
 /* IOMMU API */
 static bool arm_smmu_capable(enum iommu_cap cap)  { @@ -2361,6 +2506,8 @@ static void arm_smmu_detach_dev(struct device *dev)
 		__iommu_process_unbind_dev_all(&smmu_domain->domain, dev);
 
 	if (smmu_domain) {
+		arm_smmu_atc_inv_master_all(master, 0);
+
In BIND flow, when VFIO_IOMMU_UNBIND is invoked invalidation is sent on allocated PASID for this application.
When vfio group fd is closed after UNBIND,  arm_smmu_detach_dev is invoked now invalidation is being sent on ssid zero.
Why  invalidation needs to be sent on ssid zero ?

Regards,
Bharat
