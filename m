From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 25 Oct 2018 17:29:29 +0200
Subject: [PATCH RFC 05/11] staging: vchiq_arm: Fix camera device registration
In-Reply-To: <1540481375-15952-1-git-send-email-stefan.wahren@i2se.com>
References: <1540481375-15952-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1540481375-15952-6-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the camera driver isn't probed via DT, we need to properly setup DMA.

Fixes: 37b7b3087a2f ("staging/vc04_services: Register a platform device for the camera driver.")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c    | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index d7d7c2f0..778a252 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -49,6 +49,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/compat.h>
+#include <linux/dma-mapping.h>
 #include <soc/bcm2835/raspberrypi-firmware.h>
 
 #include "vchiq_core.h"
@@ -3588,6 +3589,21 @@ static const struct of_device_id vchiq_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, vchiq_of_match);
 
+static struct platform_device *
+vchiq_register_child(struct platform_device *pdev, const char *name)
+{
+	struct platform_device_info pdevinfo;
+
+	memset(&pdevinfo, 0, sizeof(pdevinfo));
+
+	pdevinfo.parent = &pdev->dev;
+	pdevinfo.name = name;
+	pdevinfo.id = PLATFORM_DEVID_NONE;
+	pdevinfo.dma_mask = DMA_BIT_MASK(32);
+
+	return platform_device_register_full(&pdevinfo);
+}
+
 static int vchiq_probe(struct platform_device *pdev)
 {
 	struct device_node *fw_node;
@@ -3653,9 +3669,7 @@ static int vchiq_probe(struct platform_device *pdev)
 		VCHIQ_VERSION, VCHIQ_VERSION_MIN,
 		MAJOR(vchiq_devid), MINOR(vchiq_devid));
 
-	bcm2835_camera = platform_device_register_data(&pdev->dev,
-						       "bcm2835-camera", -1,
-						       NULL, 0);
+	bcm2835_camera = vchiq_register_child(pdev, "bcm2835-camera");
 
 	return 0;
 
-- 
2.7.4
