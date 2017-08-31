From: xieyisheng1@huawei.com (Yisheng Xie)
Date: Thu, 31 Aug 2017 16:20:38 +0800
Subject: [RFC PATCH 2/6] iommu/of: Add stall and pasid properties to
 iommu_fwspec
In-Reply-To: <1504167642-14922-1-git-send-email-xieyisheng1@huawei.com>
References: <1504167642-14922-1-git-send-email-xieyisheng1@huawei.com>
Message-ID: <1504167642-14922-3-git-send-email-xieyisheng1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Add stall and pasid properties to iommu_fwspec.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/of_iommu.c | 11 +++++++++++
 include/linux/iommu.h    |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 84fa6b4..b926276 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -209,6 +209,16 @@ static bool of_pci_rc_supports_ats(struct device_node *rc_node)
 			break;
 	}
 
+	if (dev->iommu_fwspec) {
+		const __be32 *prop;
+
+		if (of_get_property(np, "dma-can-stall", NULL))
+			dev->iommu_fwspec->can_stall = true;
+
+		prop = of_get_property(np, "pasid-bits", NULL);
+		if (prop)
+			dev->iommu_fwspec->num_pasid_bits = be32_to_cpu(*prop);
+	}
+
 	return ops;
 }
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 1c5a216..5f580de 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -387,6 +387,8 @@ struct iommu_fwspec {
 	void			*iommu_priv;
 	u32			flags;
 	unsigned int		num_ids;
+	unsigned long		num_pasid_bits;
+	bool			can_stall;
 	u32			ids[1];
 };
 
-- 
1.7.12.4
