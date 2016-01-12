From: shijie.huang@arm.com (Huang Shijie)
Date: Tue, 12 Jan 2016 10:15:05 +0800
Subject: [PATCH] iommu/arm-smmu: add a shortcut when the @dev_node is NULL
Message-ID: <1452564905-2662-1-git-send-email-shijie.huang@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a device is added to a bus, it will trigger the chain notifier hook,
such as iommu_bus_notifier. The find_smmu_for_device() can be called here.

In some cases, the @device_node can be NULL. For example, when the device
is one of the following:
    alarmtime, serial, rtc or snd_soc.

This patch adds a shortcut for the code when the @device_node is NULL.
In my juno-r1 board, the boot time can be faster by 0.004014s.

Signed-off-by: Huang Shijie <shijie.huang@arm.com>
---
 drivers/iommu/arm-smmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 59ee4b8..6724a46 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -506,6 +506,9 @@ static struct arm_smmu_device *find_smmu_for_device(struct device *dev)
 	struct arm_smmu_master *master = NULL;
 	struct device_node *dev_node = dev_get_dev_node(dev);
 
+	if (!dev_node)
+		return NULL;
+
 	spin_lock(&arm_smmu_devices_lock);
 	list_for_each_entry(smmu, &arm_smmu_devices, list) {
 		master = find_smmu_master(smmu, dev_node);
-- 
2.5.0
