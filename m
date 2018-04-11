From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Wed, 11 Apr 2018 12:55:10 -0600
Subject: [PATCH 2/2] iommu/arm-smmu: Add list of devices to opt out of DMA
 domains
In-Reply-To: <20180411185510.11594-1-jcrouse@codeaurora.org>
References: <20180411185510.11594-1-jcrouse@codeaurora.org>
Message-ID: <20180411185510.11594-3-jcrouse@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a list of compatible strings for devices that wish to opt out
of attaching to a DMA domain.  This is for devices that prefer to
manage their own IOMMU space for any number of reasons. Returning
ENOTSUPP for attach device will filter down and force
arch_setup_dma_ops() to not set up the iommu DMA ops. Later
the client device in question can set up and attach their own
domain.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 69e7c60792a8..09fa03a15f4f 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1187,6 +1187,15 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }
 
+/*
+ * This is a list of compatible strings for devices that wish to manage their
+ * own IOMMU space instead of the DMA IOMMU ops. Devices on this list will not
+ * allow themselves to be attached to a IOMMU_DOMAIN_DMA domain
+ */
+static const char * const arm_smmu_dma_blacklist[] = {
+	"qcom,adreno",
+};
+
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret;
@@ -1209,6 +1218,20 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (!fwspec->iommu_priv)
 		return -ENODEV;
 
+	/*
+	 * If this is the dfeault DMA domain, check to see if the device is on
+	 * the blacklist and reject if so
+	 */
+	if (domain->type == IOMMU_DOMAIN_DMA && dev->of_node) {
+		int i;
+
+		for (i = 0; i < ARRAY_SIZE(arm_smmu_dma_blacklist); i++) {
+			if (of_device_is_compatible(dev->of_node,
+				arm_smmu_dma_blacklist[i]))
+				return -ENOTSUPP;
+		}
+	}
+
 	smmu = fwspec_smmu(fwspec);
 	/* Ensure that the domain is finalised */
 	ret = arm_smmu_init_domain_context(domain, smmu);
-- 
2.16.1
