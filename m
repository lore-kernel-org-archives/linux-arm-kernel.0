From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Tue, 27 Jun 2017 17:41:21 +0300
Subject: [PATCH v2 01/15] staging: fsl-mc: move comparison before strcmp() call
In-Reply-To: <20170627144135.15599-1-laurentiu.tudor@nxp.com>
References: <20170627144135.15599-1-laurentiu.tudor@nxp.com>
Message-ID: <20170627144135.15599-2-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Move comparison before the strcmp() in this if statement, and slightly
increase efficiency by not making the strcmp() each time the if gets
evaluated but only when the comparison is true.
This was suggested in a review comment.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
v2:
 - new patch

 drivers/staging/fsl-mc/bus/dprc-driver.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/dprc-driver.c b/drivers/staging/fsl-mc/bus/dprc-driver.c
index 80c080f..1765e2d 100644
--- a/drivers/staging/fsl-mc/bus/dprc-driver.c
+++ b/drivers/staging/fsl-mc/bus/dprc-driver.c
@@ -29,8 +29,9 @@ struct dprc_child_objs {
 static bool fsl_mc_device_match(struct fsl_mc_device *mc_dev,
 				struct dprc_obj_desc *obj_desc)
 {
-	return !strcmp(mc_dev->obj_desc.type, obj_desc->type) &&
-		mc_dev->obj_desc.id == obj_desc->id;
+	return mc_dev->obj_desc.id == obj_desc->id &&
+	       !strcmp(mc_dev->obj_desc.type, obj_desc->type);
+
 }
 
 static int __fsl_mc_device_remove_if_not_in_mc(struct device *dev, void *data)
-- 
2.9.4
