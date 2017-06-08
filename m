From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Thu, 8 Jun 2017 17:28:48 +0300
Subject: [PATCH v7 03/10] staging: fsl-mc: simplify couple of deallocations
In-Reply-To: <20170608142855.10455-1-laurentiu.tudor@nxp.com>
References: <20170608142855.10455-1-laurentiu.tudor@nxp.com>
Message-ID: <20170608142855.10455-4-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Simplify a couple of deallocations code paths. This also fixes these
checkpatch.pl false positives:
 "WARNING: kfree(NULL) is safe and this check is probably not required"

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---

Notes:
    -v7
      -rewrapped commit message

 drivers/staging/fsl-mc/bus/fsl-mc-bus.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
index 50eb415..7b48ade 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
+++ b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
@@ -420,15 +420,11 @@ bool fsl_mc_is_root_dprc(struct device *dev)
 static void fsl_mc_device_release(struct device *dev)
 {
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
-	struct fsl_mc_bus *mc_bus = NULL;
 
 	kfree(mc_dev->regions);
 
 	if (strcmp(mc_dev->obj_desc.type, "dprc") == 0)
-		mc_bus = to_fsl_mc_bus(mc_dev);
-
-	if (mc_bus)
-		kfree(mc_bus);
+		kfree(to_fsl_mc_bus(mc_dev));
 	else
 		kfree(mc_dev);
 }
@@ -559,10 +555,8 @@ int fsl_mc_device_add(struct dprc_obj_desc *obj_desc,
 
 error_cleanup_dev:
 	kfree(mc_dev->regions);
-	if (mc_bus)
-		kfree(mc_bus);
-	else
-		kfree(mc_dev);
+	kfree(mc_bus);
+	kfree(mc_dev);
 
 	return error;
 }
-- 
2.9.4
