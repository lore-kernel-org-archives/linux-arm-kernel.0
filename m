From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri,  7 Oct 2016 21:23:13 -0700
Subject: [PATCH 3/5] rpmsg: Support drivers without primary endpoint
In-Reply-To: <1475900595-8375-1-git-send-email-bjorn.andersson@linaro.org>
References: <1475900595-8375-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1475900595-8375-3-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some types of rpmsg drivers does not have a primary endpoint to tie
their existence upon, but wishes to create and destroy endpoints
dynamically, e.g. based on user interactions.

Allow rpmsg drivers to omit a driver callback to signal this case and
make the probe path not create a primary endpoint in this case.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/rpmsg_core.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 087d4db896c8..7561941ba413 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -347,27 +347,30 @@ static int rpmsg_dev_probe(struct device *dev)
 	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
 	struct rpmsg_driver *rpdrv = to_rpmsg_driver(rpdev->dev.driver);
 	struct rpmsg_channel_info chinfo = {};
-	struct rpmsg_endpoint *ept;
+	struct rpmsg_endpoint *ept = NULL;
 	int err;
 
-	strncpy(chinfo.name, rpdev->id.name, RPMSG_NAME_SIZE);
-	chinfo.src = rpdev->src;
-	chinfo.dst = RPMSG_ADDR_ANY;
+	if (rpdrv->callback) {
+		strncpy(chinfo.name, rpdev->id.name, RPMSG_NAME_SIZE);
+		chinfo.src = rpdev->src;
+		chinfo.dst = RPMSG_ADDR_ANY;
 
-	ept = rpmsg_create_ept(rpdev, rpdrv->callback, NULL, chinfo);
-	if (!ept) {
-		dev_err(dev, "failed to create endpoint\n");
-		err = -ENOMEM;
-		goto out;
-	}
+		ept = rpmsg_create_ept(rpdev, rpdrv->callback, NULL, chinfo);
+		if (!ept) {
+			dev_err(dev, "failed to create endpoint\n");
+			err = -ENOMEM;
+			goto out;
+		}
 
-	rpdev->ept = ept;
-	rpdev->src = ept->addr;
+		rpdev->ept = ept;
+		rpdev->src = ept->addr;
+	}
 
 	err = rpdrv->probe(rpdev);
 	if (err) {
 		dev_err(dev, "%s: failed: %d\n", __func__, err);
-		rpmsg_destroy_ept(ept);
+		if (ept)
+			rpmsg_destroy_ept(ept);
 		goto out;
 	}
 
@@ -388,7 +391,8 @@ static int rpmsg_dev_remove(struct device *dev)
 
 	rpdrv->remove(rpdev);
 
-	rpmsg_destroy_ept(rpdev->ept);
+	if (rpdev->ept)
+		rpmsg_destroy_ept(rpdev->ept);
 
 	return err;
 }
-- 
2.5.0
