From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 05 Aug 2014 12:47:34 +0200
Subject: [PATCH 06/29] drivers: iommu: add notify about failed bind
In-Reply-To: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1407235677-26324-7-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for forwarding recently introduced
BUS_NOTIFY_DRVBIND_FAILED event to iommu groups. This lets us getting a
notify for failed device driver bind, so all the items done in
IOMMU_GROUP_NOTIFY_BIND_DRIVER event can be cleaned if the driver fails
to bind.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/iommu.c | 3 +++
 include/linux/iommu.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1698360..516e93a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -758,6 +758,9 @@ static int iommu_bus_notifier(struct notifier_block *nb,
 	case BUS_NOTIFY_UNBOUND_DRIVER:
 		group_action = IOMMU_GROUP_NOTIFY_UNBOUND_DRIVER;
 		break;
+	case BUS_NOTIFY_DRVBIND_FAILED:
+		group_action = IOMMU_GROUP_NOTIFY_DRVBIND_FAILED;
+		break;
 	}
 
 	if (group_action)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 20f9a52..f9fdae5 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -139,6 +139,7 @@ struct iommu_ops {
 #define IOMMU_GROUP_NOTIFY_BOUND_DRIVER		4 /* Post Driver bind */
 #define IOMMU_GROUP_NOTIFY_UNBIND_DRIVER	5 /* Pre Driver unbind */
 #define IOMMU_GROUP_NOTIFY_UNBOUND_DRIVER	6 /* Post Driver unbind */
+#define IOMMU_GROUP_NOTIFY_DRVBIND_FAILED	7 /* Driver failed to bind */
 
 extern int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops);
 extern bool iommu_present(struct bus_type *bus);
-- 
1.9.2
