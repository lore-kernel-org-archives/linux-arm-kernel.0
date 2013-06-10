From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 10 Jun 2013 23:23:42 +0200
Subject: [PATCH] drm: encoder_slave: respect of_node on i2c encoder init
Message-ID: <1370899422-1281-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current DRM slave encoder API conflicts with auto-registration of i2c client
when using DT probed clients. To allow DRM slave encoders passed by DT, this
patch adds a check to drm_i2c_encoder_init for a non-NULL .of_node on
i2c_board_info and calls an of_i2c helper to get the i2c client device
instead of registering a new device.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: David Airlie <airlied@linux.ie>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Darren Etheridge <darren.etheridge@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: dri-devel at lists.freedesktop.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/gpu/drm/drm_encoder_slave.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/gpu/drm/drm_encoder_slave.c b/drivers/gpu/drm/drm_encoder_slave.c
index 0cfb60f..36c0aa7 100644
--- a/drivers/gpu/drm/drm_encoder_slave.c
+++ b/drivers/gpu/drm/drm_encoder_slave.c
@@ -25,6 +25,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/of_i2c.h>
 
 #include <drm/drm_encoder_slave.h>
 
@@ -61,7 +62,10 @@ int drm_i2c_encoder_init(struct drm_device *dev,
 
 	request_module("%s%s", I2C_MODULE_PREFIX, info->type);
 
-	client = i2c_new_device(adap, info);
+	if (info->of_node)
+		client = of_find_i2c_device_by_node(info->of_node);
+	else
+		client = i2c_new_device(adap, info);
 	if (!client) {
 		err = -ENOMEM;
 		goto fail;
-- 
1.7.2.5
