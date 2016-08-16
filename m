From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 15 Aug 2016 17:17:13 -0700
Subject: [PATCH 07/14] rpmsg: Split off generic tail of create_channel()
In-Reply-To: <1471306640-29917-1-git-send-email-bjorn.andersson@linaro.org>
References: <1471306640-29917-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1471306640-29917-8-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tail of create_channel() is common among all rpmsg backends, so
split it off from the virtio specific part to allow it to be extracted
to the rpmsg core.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 1dc7a1149c51..5cadb75a225d 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -129,6 +129,7 @@ static int virtio_rpmsg_trysendto(struct rpmsg_endpoint *ept, void *data,
 				  int len, u32 dst);
 static int virtio_rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src,
 					   u32 dst, void *data, int len);
+static int rpmsg_register_device(struct rpmsg_device *rpdev);
 
 /* sysfs show configuration fields */
 #define rpmsg_show_attr(field, path, format_string)			\
@@ -583,10 +584,22 @@ static struct rpmsg_device *rpmsg_create_channel(struct virtproc_info *vrp,
 
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
 
@@ -594,10 +607,9 @@ static struct rpmsg_device *rpmsg_create_channel(struct virtproc_info *vrp,
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
