From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Fri, 11 May 2018 20:06:16 +0100
Subject: [PATCH v2 15/40] iommu/of: Add stall and pasid properties to
 iommu_fwspec
In-Reply-To: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
Message-ID: <20180511190641.23008-16-jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add stall and pasid properties to iommu_fwspec, and fill them when
dma-can-stall and pasid-bits properties are present in the device tree.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/of_iommu.c | 12 ++++++++++++
 include/linux/iommu.h    |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 5c36a8b7656a..9b6b55f3cccd 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -204,6 +204,18 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 			if (err)
 				break;
 		}
+
+		fwspec = dev->iommu_fwspec;
+		if (!err && fwspec) {
+			const __be32 *prop;
+
+			if (of_get_property(master_np, "dma-can-stall", NULL))
+				fwspec->can_stall = true;
+
+			prop = of_get_property(master_np, "pasid-num-bits", NULL);
+			if (prop)
+				fwspec->num_pasid_bits = be32_to_cpu(*prop);
+		}
 	}
 
 	/*
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 933100678f64..bcce44455117 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -656,6 +656,8 @@ struct iommu_fwspec {
 	struct fwnode_handle	*iommu_fwnode;
 	void			*iommu_priv;
 	unsigned int		num_ids;
+	unsigned int		num_pasid_bits;
+	bool			can_stall;
 	u32			ids[1];
 };
 
-- 
2.17.0
