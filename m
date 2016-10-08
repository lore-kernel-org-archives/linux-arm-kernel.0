From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri,  7 Oct 2016 21:23:12 -0700
Subject: [PATCH 2/5] rpmsg: Introduce a driver override mechanism
In-Reply-To: <1475900595-8375-1-git-send-email-bjorn.andersson@linaro.org>
References: <1475900595-8375-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1475900595-8375-2-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Similar to other subsystems it's useful to provide a mechanism to force
a specific driver match on a device, so introduce this.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/rpmsg_core.c | 3 +++
 include/linux/rpmsg.h      | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index b6ea9ffa7381..087d4db896c8 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -315,6 +315,9 @@ static int rpmsg_dev_match(struct device *dev, struct device_driver *drv)
 	const struct rpmsg_device_id *ids = rpdrv->id_table;
 	unsigned int i;
 
+	if (rpdev->driver_override)
+		return !strcmp(rpdev->driver_override, drv->name);
+
 	if (ids)
 		for (i = 0; ids[i].name[0]; i++)
 			if (rpmsg_id_match(rpdev, &ids[i]))
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index 452d393cc8dd..7ad6c205f110 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -64,6 +64,7 @@ struct rpmsg_channel_info {
  * rpmsg_device - device that belong to the rpmsg bus
  * @dev: the device struct
  * @id: device id (used to match between rpmsg drivers and devices)
+ * @driver_override: driver name to force a match
  * @src: local address
  * @dst: destination address
  * @ept: the rpmsg endpoint of this channel
@@ -72,6 +73,7 @@ struct rpmsg_channel_info {
 struct rpmsg_device {
 	struct device dev;
 	struct rpmsg_device_id id;
+	char *driver_override;
 	u32 src;
 	u32 dst;
 	struct rpmsg_endpoint *ept;
-- 
2.5.0
