From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 15 Aug 2016 17:17:07 -0700
Subject: [PATCH 01/14] rpmsg: Enable matching devices with drivers based on DT
In-Reply-To: <1471306640-29917-1-git-send-email-bjorn.andersson@linaro.org>
References: <1471306640-29917-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1471306640-29917-2-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make it possible to match rpmsg devices based on device tree node, in
addition to the id table. In some of these cases the rpmsg driver would
not have a id_table, so make this optional.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 4a4374cc6a59..495fa0a282d3 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -33,6 +33,7 @@
 #include <linux/wait.h>
 #include <linux/rpmsg.h>
 #include <linux/mutex.h>
+#include <linux/of_device.h>
 
 /**
  * struct virtproc_info - virtual remote processor state
@@ -175,11 +176,12 @@ static int rpmsg_dev_match(struct device *dev, struct device_driver *drv)
 	const struct rpmsg_device_id *ids = rpdrv->id_table;
 	unsigned int i;
 
-	for (i = 0; ids[i].name[0]; i++)
-		if (rpmsg_id_match(rpdev, &ids[i]))
-			return 1;
+	if (ids)
+		for (i = 0; ids[i].name[0]; i++)
+			if (rpmsg_id_match(rpdev, &ids[i]))
+				return 1;
 
-	return 0;
+	return of_driver_match_device(dev, drv);
 }
 
 static int rpmsg_uevent(struct device *dev, struct kobj_uevent_env *env)
-- 
2.5.0
