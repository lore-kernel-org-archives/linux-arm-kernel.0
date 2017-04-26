From: rrichter@cavium.com (Robert Richter)
Date: Wed, 26 Apr 2017 16:38:13 +0200
Subject: [PATCH] iommu: Print a message with the default domain type created
Message-ID: <20170426143813.21225-1-rrichter@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are several ways the bypass mode can be enabled. With commit

 fccb4e3b8ab0 iommu: Allow default domain type to be set on the kernel command line

there is the option to switch into bypass mode. And, depending on
devicetree options, bypass mode can be also enabled. This makes it
hard to determine if direct mapping is enabled. Print message with the
default domain type case.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/iommu/iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3b67144dead2..ae84899dabd2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -586,7 +586,9 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 
 	trace_add_device_to_group(group->id, dev);
 
-	pr_info("Adding device %s to group %d\n", dev_name(dev), group->id);
+	pr_info("Adding device %s to group %d, default domain type %d\n",
+		dev_name(dev), group->id,
+		group->default_domain ? group->default_domain->type : -1);
 
 	return 0;
 
-- 
2.11.0
