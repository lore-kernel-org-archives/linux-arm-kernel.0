From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Fri, 15 May 2015 02:00:09 +0300
Subject: [RFC/PATCH 8/9] iommu: of: Handle IOMMU lookup failure with deferred
 probing or error
In-Reply-To: <1431644410-2997-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1431644410-2997-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1431644410-2997-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Failures to look up an IOMMU when parsing the DT iommus property need to
be handled separately from the .of_xlate() failures to support deferred
probing.

The lack of a registered IOMMU can be caused by the lack of a driver for
the IOMMU, the IOMMU device probe not having been performed yet, having
been deferred, or having failed.

The first case occurs when the device tree describes the bus master and
IOMMU topology correctly but no device driver exists for the IOMMU yet
or the device driver has not been compiled in. Return NULL, the caller
will configure the device without an IOMMU.

The second and third cases are handled by deferring the probe of the bus
master device which will eventually get reprobed after the IOMMU.

The last case is currently handled by deferring the probe of the bus
master device as well. A mechanism to either configure the bus master
device without an IOMMU or to fail the bus master device probe depending
on whether the IOMMU is optional or mandatory would be a good
enhancement.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/of_iommu.c | 16 +++++++++++++---
 drivers/of/device.c      |  2 ++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index b922ed4f9fb3..e98f19a3b740 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -170,8 +170,18 @@ struct iommu_ops *of_iommu_configure(struct device *dev,
 		np = iommu_spec.np;
 		ops = of_iommu_get_ops(np);
 
-		if (!ops || !ops->of_xlate || ops->of_xlate(dev, &iommu_spec))
+		if (!ops) {
+			const struct of_device_id *oid;
+
+			oid = of_match_node(&__iommu_of_table, np);
+			ops = oid ? ERR_PTR(-EPROBE_DEFER) : NULL;
+			goto err_put_node;
+		}
+
+		if (!ops->of_xlate || ops->of_xlate(dev, &iommu_spec)) {
+			ops = NULL;
 			goto err_put_node;
+		}
 
 		of_node_put(np);
 		idx++;
@@ -181,7 +191,7 @@ struct iommu_ops *of_iommu_configure(struct device *dev,
 
 err_put_node:
 	of_node_put(np);
-	return NULL;
+	return ops;
 }
 
 void __init of_iommu_init(void)
@@ -192,7 +202,7 @@ void __init of_iommu_init(void)
 	for_each_matching_node_and_match(np, matches, &match) {
 		const of_iommu_init_fn init_fn = match->data;
 
-		if (init_fn(np))
+		if (init_fn && init_fn(np))
 			pr_err("Failed to initialise IOMMU %s\n",
 				of_node_full_name(np));
 	}
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 3cb3f78a6d13..f4964ab21026 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -148,6 +148,8 @@ int of_dma_configure_ops(struct device *dev, struct device_node *np)
 		coherent ? " " : " not ");
 
 	iommu = of_iommu_configure(dev, np);
+	if (IS_ERR(iommu))
+		return PTR_ERR(iommu);
 	dev_dbg(dev, "device is%sbehind an iommu\n",
 		iommu ? " " : " not ");
 
-- 
2.3.6
