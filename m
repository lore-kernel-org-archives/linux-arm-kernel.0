From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Fri,  6 Oct 2017 14:31:40 +0100
Subject: [RFCv2 PATCH 13/36] iommu/of: Add stall and pasid properties to
 iommu_fwspec
In-Reply-To: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
Message-ID: <20171006133203.22803-14-jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add stall and pasid properties to iommu_fwspec, and fill them when
dma-can-stall and pasid-bits properties are present in the device tree.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/of_iommu.c | 10 ++++++++++
 include/linux/iommu.h    |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 50947ebb6d17..345286bfdbfc 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -204,6 +204,16 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 			if (err)
 				break;
 		}
+
+		if (!err && dev->iommu_fwspec) {
+			const __be32 *prop;
+			if (of_get_property(master_np, "dma-can-stall", NULL))
+				dev->iommu_fwspec->can_stall = true;
+
+			prop = of_get_property(master_np, "pasid-bits", NULL);
+			if (prop)
+				dev->iommu_fwspec->num_pasid_bits = be32_to_cpu(*prop);
+		}
 	}
 
 	/*
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a6d417785c7b..2eb65d4724bb 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -535,6 +535,8 @@ struct iommu_fwspec {
 	struct fwnode_handle	*iommu_fwnode;
 	void			*iommu_priv;
 	unsigned int		num_ids;
+	unsigned int		num_pasid_bits;
+	bool			can_stall;
 	u32			ids[1];
 };
 
-- 
2.13.3
