From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 23 Sep 2016 14:11:00 +0100
Subject: [PATCH] iommu/arm-smmu: Work around ARM DMA configuration
Message-ID: <f52377644766e4fd5920b8981d9b77872defb436.1474635876.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 32-bit ARM DMA configuration code predates the IOMMU core's default
domain functionality, and instead relies on allocating its own domains
and attaching any devices using the generic IOMMU binding to them.
Unfortunately, it does this relatively early on in the creation of the
device, before we've seen our add_device callback, which leads us to
attempt to operate on a half-configured master.

To avoid a crash, check for this situation on attach, but refuse to
play, as there's nothing we can do. This at least allows VFIO to keep
working for people who update their 32-bit DTs to the generic binding,
albeit with a few (innocuous) warnings from the DMA layer on boot.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index c841eb7a1a74..3af7f8f62d0a 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1228,6 +1228,16 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		return -ENXIO;
 	}
 
+	/*
+	 * FIXME: The arch/arm DMA API code tries to attach devices to its own
+	 * domains between of_xlate() and add_device() - we have no way to cope
+	 * with that, so until ARM gets converted to rely on groups and default
+	 * domains, just say no (but more politely than by dereferencing NULL).
+	 * This should be at least a WARN_ON once that's sorted.
+	 */
+	if (!fwspec->iommu_priv)
+		return -ENODEV;
+
 	smmu = fwspec_smmu(fwspec);
 	/* Ensure that the domain is finalised */
 	ret = arm_smmu_init_domain_context(domain, smmu);
-- 
2.8.1.dirty
