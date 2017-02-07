From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Tue, 7 Feb 2017 08:15:23 -0600
Subject: [PATCH 03/10] staging: fsl-mc: add device release callback
In-Reply-To: <20170207141530.12979-1-laurentiu.tudor@nxp.com>
References: <20170207141530.12979-1-laurentiu.tudor@nxp.com>
Message-ID: <20170207141530.12979-4-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

When hot unplugging a mc-bus device the kernel displays
this pertinent message, followed by a stack dump:
    "Device 'foo.N' does not have a release() function,
     it is broken and must be fixed."
Add the required callback to fix and drop the now
uneeded explicit freeing.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/staging/fsl-mc/bus/fsl-mc-bus.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
index 7c6a43b..5963e98 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
+++ b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
@@ -419,6 +419,22 @@ bool fsl_mc_is_root_dprc(struct device *dev)
 	return dev == root_dprc_dev;
 }
 
+static void fsl_mc_device_release(struct device *dev)
+{
+	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
+	struct fsl_mc_bus *mc_bus = NULL;
+
+	kfree(mc_dev->regions);
+
+	if (strcmp(mc_dev->obj_desc.type, "dprc") == 0)
+		mc_bus = to_fsl_mc_bus(mc_dev);
+
+	if (mc_bus)
+		devm_kfree(mc_dev->dev.parent, mc_bus);
+	else
+		kmem_cache_free(mc_dev_cache, mc_dev);
+}
+
 /**
  * Add a newly discovered fsl-mc device to be visible in Linux
  */
@@ -460,6 +476,7 @@ int fsl_mc_device_add(struct dprc_obj_desc *obj_desc,
 	device_initialize(&mc_dev->dev);
 	mc_dev->dev.parent = parent_dev;
 	mc_dev->dev.bus = &fsl_mc_bus_type;
+	mc_dev->dev.release = fsl_mc_device_release;
 	dev_set_name(&mc_dev->dev, "%s.%d", obj_desc->type, obj_desc->id);
 
 	if (strcmp(obj_desc->type, "dprc") == 0) {
@@ -561,23 +578,11 @@ int fsl_mc_device_add(struct dprc_obj_desc *obj_desc,
  */
 void fsl_mc_device_remove(struct fsl_mc_device *mc_dev)
 {
-	struct fsl_mc_bus *mc_bus = NULL;
-
-	kfree(mc_dev->regions);
-
 	/*
 	 * The device-specific remove callback will get invoked by device_del()
 	 */
 	device_del(&mc_dev->dev);
 	put_device(&mc_dev->dev);
-
-	if (strcmp(mc_dev->obj_desc.type, "dprc") == 0)
-		mc_bus = to_fsl_mc_bus(mc_dev);
-
-	if (mc_bus)
-		devm_kfree(mc_dev->dev.parent, mc_bus);
-	else
-		kmem_cache_free(mc_dev_cache, mc_dev);
 }
 EXPORT_SYMBOL_GPL(fsl_mc_device_remove);
 
-- 
1.8.3.1
