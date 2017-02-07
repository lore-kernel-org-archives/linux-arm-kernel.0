From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Tue, 7 Feb 2017 08:15:22 -0600
Subject: [PATCH 02/10] staging: fsl-mc: fix device ref counting
In-Reply-To: <20170207141530.12979-1-laurentiu.tudor@nxp.com>
References: <20170207141530.12979-1-laurentiu.tudor@nxp.com>
Message-ID: <20170207141530.12979-3-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Drop unneeded get_device() call at device creation
and, as per documentation, drop reference count
after using device_find_child() return.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/staging/fsl-mc/bus/dprc-driver.c | 1 +
 drivers/staging/fsl-mc/bus/fsl-mc-bus.c  | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-mc/bus/dprc-driver.c b/drivers/staging/fsl-mc/bus/dprc-driver.c
index 4e416d8..e4b0341 100644
--- a/drivers/staging/fsl-mc/bus/dprc-driver.c
+++ b/drivers/staging/fsl-mc/bus/dprc-driver.c
@@ -188,6 +188,7 @@ static void dprc_add_new_devices(struct fsl_mc_device *mc_bus_dev,
 		child_dev = fsl_mc_device_lookup(obj_desc, mc_bus_dev);
 		if (child_dev) {
 			check_plugged_state_change(child_dev, obj_desc);
+			put_device(&child_dev->dev);
 			continue;
 		}
 
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
index cc20dc4..7c6a43b 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
+++ b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
@@ -537,7 +537,6 @@ int fsl_mc_device_add(struct dprc_obj_desc *obj_desc,
 		goto error_cleanup_dev;
 	}
 
-	(void)get_device(&mc_dev->dev);
 	dev_dbg(parent_dev, "added %s\n", dev_name(&mc_dev->dev));
 
 	*new_mc_dev = mc_dev;
-- 
1.8.3.1
