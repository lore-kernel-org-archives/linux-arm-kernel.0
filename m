From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Mon, 27 Nov 2017 11:01:34 +0200
Subject: [PATCH] staging: fsl-mc: fix uninitialized variable use
Message-ID: <20171127090134.19125-1-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Fix this warning triggering on a powerpc build:
warning: 'error' may be used uninitialized in this function [-Wmaybe-uninitialized]

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/staging/fsl-mc/bus/fsl-mc-bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
index f84bc14..f15bab3 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
+++ b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
@@ -570,6 +570,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 	mc_dev->dev.release = fsl_mc_device_release;
 	mc_dev->dev.type = fsl_mc_get_device_type(obj_desc->type);
 	if (!mc_dev->dev.type) {
+		error = -ENODEV;
 		dev_err(parent_dev, "unknown device type %s\n", obj_desc->type);
 		goto error_cleanup_dev;
 	}
-- 
2.9.4
