From: sricharan@codeaurora.org (Sricharan R)
Date: Mon, 25 Apr 2016 21:28:12 +0530
Subject: [RFC 7/9] drivers: iommu: Add a new add device api
In-Reply-To: <1461599894-1969-1-git-send-email-sricharan@codeaurora.org>
References: <1461599894-1969-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1461599894-1969-8-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Associating a master with an group happens when the master is added to the bus,
notified with BUS_ADD_DEVICE. But the iommu has to be ready before this
using early iommu registration and also master should have been added to the
iommu using xlate. So, when trying to get rid of the early registration and
using late probing for iommu devices to sort out the probing order, the newly
added api is meant to be called during the late probing to add the master
to iommu.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/iommu/iommu.c | 12 ++++++++++++
 include/linux/iommu.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index bfd4f7c..a0dd01f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -900,6 +900,18 @@ static int remove_iommu_group(struct device *dev, void *data)
 	return 0;
 }
 
+int iommu_bus_add_dev(struct device *dev)
+{
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	int ret = -ENODEV;
+
+	if (ops->add_device)
+		ret = ops->add_device(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_bus_add_dev);
+
 static int iommu_bus_notifier(struct notifier_block *nb,
 			      unsigned long action, void *data)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a5c539f..018cfc8 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -271,6 +271,7 @@ struct device *iommu_device_create(struct device *parent, void *drvdata,
 void iommu_device_destroy(struct device *dev);
 int iommu_device_link(struct device *dev, struct device *link);
 void iommu_device_unlink(struct device *dev, struct device *link);
+int iommu_bus_add_dev(struct device *dev);
 
 /* Window handling function prototypes */
 extern int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
