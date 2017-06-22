From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Thu, 22 Jun 2017 16:35:52 +0300
Subject: [PATCH 06/14] staging: fsl-mc: turn several exported functions static
In-Reply-To: <20170622133600.31694-1-laurentiu.tudor@nxp.com>
References: <20170622133600.31694-1-laurentiu.tudor@nxp.com>
Message-ID: <20170622133600.31694-7-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

They are never used outside the source they are implemented in and very
likely never will, so it's safe to make them static.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/staging/fsl-mc/bus/dprc-driver.c | 8 +++-----
 drivers/staging/fsl-mc/bus/fsl-mc-bus.c  | 5 ++---
 drivers/staging/fsl-mc/include/mc-bus.h  | 8 --------
 3 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/dprc-driver.c b/drivers/staging/fsl-mc/bus/dprc-driver.c
index ff65e70..8447961 100644
--- a/drivers/staging/fsl-mc/bus/dprc-driver.c
+++ b/drivers/staging/fsl-mc/bus/dprc-driver.c
@@ -220,8 +220,8 @@ static void dprc_add_new_devices(struct fsl_mc_device *mc_bus_dev,
  * populated before they can get allocation requests from probe callbacks
  * of the device drivers for the non-allocatable devices.
  */
-int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
-		      unsigned int *total_irq_count)
+static int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
+			     unsigned int *total_irq_count)
 {
 	int num_child_objects;
 	int dprc_get_obj_failures;
@@ -309,7 +309,6 @@ int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(dprc_scan_objects);
 
 /**
  * dprc_scan_container - Scans a physical DPRC and synchronizes Linux bus state
@@ -320,7 +319,7 @@ EXPORT_SYMBOL_GPL(dprc_scan_objects);
  * bus driver with the actual state of the MC by adding and removing
  * devices as appropriate.
  */
-int dprc_scan_container(struct fsl_mc_device *mc_bus_dev)
+static int dprc_scan_container(struct fsl_mc_device *mc_bus_dev)
 {
 	int error;
 	unsigned int irq_count;
@@ -356,7 +355,6 @@ int dprc_scan_container(struct fsl_mc_device *mc_bus_dev)
 	fsl_mc_cleanup_all_resource_pools(mc_bus_dev);
 	return error;
 }
-EXPORT_SYMBOL_GPL(dprc_scan_container);
 
 /**
  * dprc_irq0_handler - Regular ISR for DPRC interrupt 0
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
index 8725a5c..60b2a40 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
+++ b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
@@ -241,8 +241,8 @@ EXPORT_SYMBOL_GPL(fsl_mc_driver_unregister);
 /**
  * fsl_mc_get_root_dprc - function to traverse to the root dprc
  */
-void fsl_mc_get_root_dprc(struct device *dev,
-			  struct device **root_dprc_dev)
+static void fsl_mc_get_root_dprc(struct device *dev,
+				 struct device **root_dprc_dev)
 {
 	if (WARN_ON(!dev)) {
 		*root_dprc_dev = NULL;
@@ -254,7 +254,6 @@ void fsl_mc_get_root_dprc(struct device *dev,
 			*root_dprc_dev = (*root_dprc_dev)->parent;
 	}
 }
-EXPORT_SYMBOL_GPL(fsl_mc_get_root_dprc);
 
 static int get_dprc_attr(struct fsl_mc_io *mc_io,
 			 int container_id, struct dprc_attributes *attr)
diff --git a/drivers/staging/fsl-mc/include/mc-bus.h b/drivers/staging/fsl-mc/include/mc-bus.h
index aac062e..c1df433 100644
--- a/drivers/staging/fsl-mc/include/mc-bus.h
+++ b/drivers/staging/fsl-mc/include/mc-bus.h
@@ -70,11 +70,6 @@ struct fsl_mc_bus {
 #define to_fsl_mc_bus(_mc_dev) \
 	container_of(_mc_dev, struct fsl_mc_bus, mc_dev)
 
-int dprc_scan_container(struct fsl_mc_device *mc_bus_dev);
-
-int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
-		      unsigned int *total_irq_count);
-
 struct irq_domain *fsl_mc_msi_create_irq_domain(struct fwnode_handle *fwnode,
 						struct msi_domain_info *info,
 						struct irq_domain *parent);
@@ -91,9 +86,6 @@ void fsl_mc_init_all_resource_pools(struct fsl_mc_device *mc_bus_dev);
 
 void fsl_mc_cleanup_all_resource_pools(struct fsl_mc_device *mc_bus_dev);
 
-void fsl_mc_get_root_dprc(struct device *dev,
-			  struct device **root_dprc_dev);
-
 bool fsl_mc_is_root_dprc(struct device *dev);
 
 extern struct bus_type fsl_mc_bus_type;
-- 
2.9.4
