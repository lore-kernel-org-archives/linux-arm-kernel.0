From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Thu,  1 Sep 2016 15:28:03 -0700
Subject: [PATCH v2 11/17] rpmsg: Split off generic tail of create_channel()
In-Reply-To: <1472768889-3906-1-git-send-email-bjorn.andersson@linaro.org>
References: <1472768889-3906-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1472768889-3906-12-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tail of create_channel() is common among all rpmsg backends, so
split it off from the virtio specific part to allow it to be extracted
to the rpmsg core.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- None

 drivers/rpmsg/virtio_rpmsg_bus.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 488fd93a290c..e1052622c6a2 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -120,6 +120,7 @@ static int virtio_rpmsg_trysendto(struct rpmsg_endpoint *ept, void *data,
 				  int len, u32 dst);
 static int virtio_rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src,
 					   u32 dst, void *data, int len);
+static int rpmsg_register_device(struct rpmsg_device *rpdev);
 
 /* sysfs show configuration fields */
 #define rpmsg_show_attr(field, path, format_string)			\
@@ -499,10 +500,22 @@ static struct rpmsg_device *rpmsg_create_channel(struct virtproc_info *vrp,
 
 	strncpy(rpdev->id.name, chinfo->name, RPMSG_NAME_SIZE);
 
+	rpdev->dev.parent = &vrp->vdev->dev;
+	ret = rpmsg_register_device(rpdev);
+	if (ret)
+		return NULL;
+
+	return rpdev;
+}
+
+static int rpmsg_register_device(struct rpmsg_device *rpdev)
+{
+	struct device *dev = &rpdev->dev;
+	int ret;
+
 	dev_set_name(&rpdev->dev, "%s:%s",
 		     dev_name(dev->parent), rpdev->id.name);
 
-	rpdev->dev.parent = &vrp->vdev->dev;
 	rpdev->dev.bus = &rpmsg_bus;
 	rpdev->dev.release = rpmsg_release_device;
 
@@ -510,10 +523,9 @@ static struct rpmsg_device *rpmsg_create_channel(struct virtproc_info *vrp,
 	if (ret) {
 		dev_err(dev, "device_register failed: %d\n", ret);
 		put_device(&rpdev->dev);
-		return NULL;
 	}
 
-	return rpdev;
+	return ret;
 }
 
 /*
-- 
2.5.0
