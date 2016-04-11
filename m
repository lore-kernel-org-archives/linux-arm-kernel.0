From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Mon, 11 Apr 2016 17:58:36 +0300
Subject: [PATCH v1 2/2] amba: Propagate match errors to the driver core
In-Reply-To: <1460386716-23262-1-git-send-email-georgi.djakov@linaro.org>
References: <1460386716-23262-1-git-send-email-georgi.djakov@linaro.org>
Message-ID: <1460386716-23262-2-git-send-email-georgi.djakov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, when we scan the bus for matching devices, we assume that
the clock controller is probed and available, but that might be not
always true. If the bus clock is unavailable, we just silently fail
to detect devices.

Handle this by propagating the errors up to the driver core, so that
it can retry the scan later.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/amba/bus.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index a32a43dbaccc..0d9a342a73f8 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -86,15 +86,21 @@ static int amba_read_periphid(struct amba_device *adev)
 
 	iounmap(tmp);
 
+	if (r < 0)
+		return r;
+
 	return adev->periphid ? 0 : -ENODEV;
 }
 
 static const struct amba_id *
 amba_lookup(const struct amba_id *table, struct amba_device *dev)
 {
-	int ret = 0;
+	int ret;
 
-	if (amba_read_periphid(dev))
+	ret = amba_read_periphid(dev);
+	if (ret < 0)
+		return ERR_PTR(ret);
+	if (ret)
 		return NULL;
 
 	while (table->mask) {
@@ -111,12 +117,17 @@ static int amba_match(struct device *dev, struct device_driver *drv)
 {
 	struct amba_device *pcdev = to_amba_device(dev);
 	struct amba_driver *pcdrv = to_amba_driver(drv);
+	const struct amba_id *id;
 
 	/* When driver_override is set, only bind to the matching driver */
 	if (pcdev->driver_override)
 		return !strcmp(pcdev->driver_override, drv->name);
 
-	return amba_lookup(pcdrv->id_table, pcdev) != NULL;
+	id = amba_lookup(pcdrv->id_table, pcdev);
+	if (IS_ERR(id))
+		return PTR_ERR(id);
+
+	return id != NULL;
 }
 
 static int amba_uevent(struct device *dev, struct kobj_uevent_env *env)
