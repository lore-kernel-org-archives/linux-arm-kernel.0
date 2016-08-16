From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 15 Aug 2016 17:17:08 -0700
Subject: [PATCH 02/14] rpmsg: Name rpmsg devices based on channel id
In-Reply-To: <1471306640-29917-1-git-send-email-bjorn.andersson@linaro.org>
References: <1471306640-29917-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1471306640-29917-3-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By basing rpmsg device names on channel id we end up with human readable
device names in sysfs and debug logs.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 495fa0a282d3..c4bd89ea7681 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -136,14 +136,6 @@ rpmsg_show_attr(src, src, "0x%x\n");
 rpmsg_show_attr(dst, dst, "0x%x\n");
 rpmsg_show_attr(announce, announce ? "true" : "false", "%s\n");
 
-/*
- * Unique (and free running) index for rpmsg devices.
- *
- * Yeah, we're not recycling those numbers (yet?). will be easy
- * to change if/when we want to.
- */
-static unsigned int rpmsg_dev_index;
-
 static ssize_t modalias_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
@@ -531,8 +523,8 @@ static struct rpmsg_channel *rpmsg_create_channel(struct virtproc_info *vrp,
 
 	strncpy(rpdev->id.name, chinfo->name, RPMSG_NAME_SIZE);
 
-	/* very simple device indexing plumbing which is enough for now */
-	dev_set_name(&rpdev->dev, "rpmsg%d", rpmsg_dev_index++);
+	dev_set_name(&rpdev->dev, "%s:%s",
+		     dev_name(dev->parent), rpdev->id.name);
 
 	rpdev->dev.parent = &vrp->vdev->dev;
 	rpdev->dev.bus = &rpmsg_bus;
-- 
2.5.0
