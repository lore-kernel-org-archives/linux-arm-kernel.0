From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Fri, 17 Nov 2017 15:38:34 +0200
Subject: [PATCH 10/10] staging: fsl-mc: use device_type instead of strcmp()
In-Reply-To: <20171117133834.4635-1-laurentiu.tudor@nxp.com>
References: <20171117133834.4635-1-laurentiu.tudor@nxp.com>
Message-ID: <20171117133834.4635-10-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Replace strcmp() based device type checks with the standard device
model type.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/staging/fsl-mc/bus/dprc-driver.c      |  4 ++--
 drivers/staging/fsl-mc/bus/fsl-mc-allocator.c | 20 ++++++++++----------
 drivers/staging/fsl-mc/bus/fsl-mc-bus.c       |  8 ++++----
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/dprc-driver.c b/drivers/staging/fsl-mc/bus/dprc-driver.c
index 28a6b87..131c715 100644
--- a/drivers/staging/fsl-mc/bus/dprc-driver.c
+++ b/drivers/staging/fsl-mc/bus/dprc-driver.c
@@ -593,7 +593,7 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
 	bool msi_domain_set = false;
 	u16 major_ver, minor_ver;
 
-	if (strcmp(mc_dev->obj_desc.type, "dprc") != 0)
+	if (!is_fsl_mc_bus_dprc(mc_dev))
 		return -EINVAL;
 
 	if (dev_get_msi_domain(&mc_dev->dev))
@@ -745,7 +745,7 @@ static int dprc_remove(struct fsl_mc_device *mc_dev)
 	int error;
 	struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_dev);
 
-	if (strcmp(mc_dev->obj_desc.type, "dprc") != 0)
+	if (!is_fsl_mc_bus_dprc(mc_dev))
 		return -EINVAL;
 	if (!mc_dev->mc_io)
 		return -EINVAL;
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c b/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
index f7fbebd..1000fb3 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
+++ b/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
@@ -14,11 +14,11 @@
 
 #include "fsl-mc-private.h"
 
-static bool __must_check fsl_mc_is_allocatable(const char *obj_type)
+static bool __must_check fsl_mc_is_allocatable(struct fsl_mc_device *mc_dev)
 {
-	return strcmp(obj_type, "dpbp") == 0 ||
-	       strcmp(obj_type, "dpmcp") == 0 ||
-	       strcmp(obj_type, "dpcon") == 0;
+	return is_fsl_mc_bus_dpbp(mc_dev) ||
+	       is_fsl_mc_bus_dpmcp(mc_dev) ||
+	       is_fsl_mc_bus_dpcon(mc_dev);
 }
 
 /**
@@ -43,7 +43,7 @@ static int __must_check fsl_mc_resource_pool_add_device(struct fsl_mc_bus
 
 	if (pool_type < 0 || pool_type >= FSL_MC_NUM_POOL_TYPES)
 		goto out;
-	if (!fsl_mc_is_allocatable(mc_dev->obj_desc.type))
+	if (!fsl_mc_is_allocatable(mc_dev))
 		goto out;
 	if (mc_dev->resource)
 		goto out;
@@ -105,7 +105,7 @@ static int __must_check fsl_mc_resource_pool_remove_device(struct fsl_mc_device
 	struct fsl_mc_resource *resource;
 	int error = -EINVAL;
 
-	if (!fsl_mc_is_allocatable(mc_dev->obj_desc.type))
+	if (!fsl_mc_is_allocatable(mc_dev))
 		goto out;
 
 	resource = mc_dev->resource;
@@ -442,7 +442,7 @@ int __must_check fsl_mc_allocate_irqs(struct fsl_mc_device *mc_dev)
 	if (irq_count == 0)
 		return -EINVAL;
 
-	if (strcmp(mc_dev->obj_desc.type, "dprc") == 0)
+	if (is_fsl_mc_bus_dprc(mc_dev))
 		mc_bus = to_fsl_mc_bus(mc_dev);
 	else
 		mc_bus = to_fsl_mc_bus(to_fsl_mc_device(mc_dev->dev.parent));
@@ -505,7 +505,7 @@ void fsl_mc_free_irqs(struct fsl_mc_device *mc_dev)
 
 	irq_count = mc_dev->obj_desc.irq_count;
 
-	if (strcmp(mc_dev->obj_desc.type, "dprc") == 0)
+	if (is_fsl_mc_bus_dprc(mc_dev))
 		mc_bus = to_fsl_mc_bus(mc_dev);
 	else
 		mc_bus = to_fsl_mc_bus(to_fsl_mc_device(mc_dev->dev.parent));
@@ -575,7 +575,7 @@ static int fsl_mc_allocator_probe(struct fsl_mc_device *mc_dev)
 	struct fsl_mc_bus *mc_bus;
 	int error;
 
-	if (!fsl_mc_is_allocatable(mc_dev->obj_desc.type))
+	if (!fsl_mc_is_allocatable(mc_dev))
 		return -EINVAL;
 
 	mc_bus_dev = to_fsl_mc_device(mc_dev->dev.parent);
@@ -604,7 +604,7 @@ static int fsl_mc_allocator_remove(struct fsl_mc_device *mc_dev)
 {
 	int error;
 
-	if (!fsl_mc_is_allocatable(mc_dev->obj_desc.type))
+	if (!fsl_mc_is_allocatable(mc_dev))
 		return -EINVAL;
 
 	if (mc_dev->resource) {
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
index aa935f3..f84bc14 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
+++ b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
@@ -442,10 +442,10 @@ static int fsl_mc_device_get_mmio_regions(struct fsl_mc_device *mc_dev,
 	struct device *parent_dev = mc_dev->dev.parent;
 	enum dprc_region_type mc_region_type;
 
-	if (strcmp(obj_desc->type, "dprc") == 0 ||
-	    strcmp(obj_desc->type, "dpmcp") == 0) {
+	if (is_fsl_mc_bus_dprc(mc_dev) ||
+	    is_fsl_mc_bus_dpmcp(mc_dev)) {
 		mc_region_type = DPRC_REGION_TYPE_MC_PORTAL;
-	} else if (strcmp(obj_desc->type, "dpio") == 0) {
+	} else if (is_fsl_mc_bus_dpio(mc_dev)) {
 		mc_region_type = DPRC_REGION_TYPE_QBMAN_PORTAL;
 	} else {
 		/*
@@ -520,7 +520,7 @@ static void fsl_mc_device_release(struct device *dev)
 
 	kfree(mc_dev->regions);
 
-	if (strcmp(mc_dev->obj_desc.type, "dprc") == 0)
+	if (is_fsl_mc_bus_dprc(mc_dev))
 		kfree(to_fsl_mc_bus(mc_dev));
 	else
 		kfree(mc_dev);
-- 
2.9.4
