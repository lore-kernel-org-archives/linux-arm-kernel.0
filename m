From: sricharan@codeaurora.org (Sricharan)
Date: Wed, 9 Nov 2016 19:40:49 +0530
Subject: [PATCH 1/5] iommu: Allow taking a reference on a group directly
In-Reply-To: <3922e1f14d8ecb50440b2d9b0d1123f3c9307fc5.1478695557.git.robin.murphy@arm.com>
References: <3922e1f14d8ecb50440b2d9b0d1123f3c9307fc5.1478695557.git.robin.murphy@arm.com>
Message-ID: <000001d23a93$16c04ab0$4440e010$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>-----Original Message-----
>From: Robin Murphy [mailto:robin.murphy at arm.com]
>Sent: Wednesday, November 09, 2016 6:17 PM
>To: joro at 8bytes.org
>Cc: will.deacon at arm.com; sricharan at codeaurora.org; iommu at lists.linux-foundation.org; linux-arm-kernel at lists.infradead.org
>Subject: [PATCH 1/5] iommu: Allow taking a reference on a group directly
>
>iommu_group_get_for_dev() expects that the IOMMU driver's device_group
>callback return a group with a reference held for the given device.
>Whilst allocating a new group is fine, and pci_device_group() correctly
>handles reusing an existing group, there is no general means for IOMMU
>drivers doing their own group lookup to take additional references on an
>existing group pointer without having to also store device pointers or
>resort to elaborate trickery.
>
>Add an IOMMU-driver-specific function to fill the hole.
>
>Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>---
> drivers/iommu/iommu.c | 14 ++++++++++++++
> include/linux/iommu.h |  1 +
> 2 files changed, 15 insertions(+)
>
>diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>index 9a2f1960873b..b0b052bc6bb5 100644
>--- a/drivers/iommu/iommu.c
>+++ b/drivers/iommu/iommu.c
>@@ -552,6 +552,20 @@ struct iommu_group *iommu_group_get(struct device *dev)
> EXPORT_SYMBOL_GPL(iommu_group_get);
>
> /**
>+ * __iommu_group_get - Increment reference on a group
>+ * @group: the group to use, must not be NULL
>+ *
>+ * This function may be called by internal iommu driver group management
>+ * when the context of a struct device pointer is not available.  It is
>+ * not for general use.  Returns the given group for convenience.
>+ */
>+struct iommu_group *__iommu_group_get(struct iommu_group *group)
>+{
>+	kobject_get(group->devices_kobj);
>+	return group;
>+}
>+
>+/**

Acked-by: sricharan at codeaurora.org

Regards,
 Sricharan
