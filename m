From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 21:28:24 +0000
Subject: [PATCH RFC 31/46] imx-drm: remove imx-fb.c
In-Reply-To: <20140102212528.GD7383@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
Message-ID: <E1VypoW-0007Fb-8S@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx-fb.c doesn't need to be separate from imx-drm-core.c - all it is
doing is setting up the minimum and maximum sizes of the scanout
buffers, and setting up the mode_config function pointers.  Move the
contents into imx-drm-core.c and kill this file.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/Makefile       |    2 +-
 drivers/staging/imx-drm/imx-drm-core.c |   16 ++++++++++-
 drivers/staging/imx-drm/imx-fb.c       |   47 --------------------------------
 3 files changed, 16 insertions(+), 49 deletions(-)
 delete mode 100644 drivers/staging/imx-drm/imx-fb.c

diff --git a/drivers/staging/imx-drm/Makefile b/drivers/staging/imx-drm/Makefile
index 5239f908ceec..129e3a3f59f1 100644
--- a/drivers/staging/imx-drm/Makefile
+++ b/drivers/staging/imx-drm/Makefile
@@ -1,5 +1,5 @@
 
-imxdrm-objs := imx-drm-core.o imx-fb.o
+imxdrm-objs := imx-drm-core.o
 
 obj-$(CONFIG_DRM_IMX) += imxdrm.o
 
diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index 31bc8d9c49be..08e7837d6134 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -381,6 +381,10 @@ static void imx_drm_connector_unregister(
 	drm_mode_group_reinit(imxdrm->drm);
 }
 
+static struct drm_mode_config_funcs imx_drm_mode_config_funcs = {
+	.fb_create = drm_fb_cma_create,
+};
+
 /*
  * Main DRM initialisation. This binds, initialises and registers
  * with DRM the subcomponents of the driver.
@@ -406,8 +410,18 @@ static int imx_drm_driver_load(struct drm_device *drm, unsigned long flags)
 	 */
 	drm->irq_enabled = true;
 
+	/*
+	 * set max width and height as default value(4096x4096).
+	 * this value would be used to check framebuffer size limitation
+	 * at drm_mode_addfb().
+	 */
+	drm->mode_config.min_width = 64;
+	drm->mode_config.min_height = 64;
+	drm->mode_config.max_width = 4096;
+	drm->mode_config.max_height = 4096;
+	drm->mode_config.funcs = &imx_drm_mode_config_funcs;
+
 	drm_mode_config_init(drm);
-	imx_drm_mode_config_init(drm);
 
 	mutex_lock(&imxdrm->mutex);
 
diff --git a/drivers/staging/imx-drm/imx-fb.c b/drivers/staging/imx-drm/imx-fb.c
deleted file mode 100644
index 03a7b4e14f67..000000000000
--- a/drivers/staging/imx-drm/imx-fb.c
+++ /dev/null
@@ -1,47 +0,0 @@
-/*
- * i.MX drm driver
- *
- * Copyright (C) 2012 Sascha Hauer, Pengutronix
- *
- * Based on Samsung Exynos code
- *
- * Copyright (c) 2011 Samsung Electronics Co., Ltd.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-#include <linux/module.h>
-#include <drm/drmP.h>
-#include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
-#include <drm/drm_gem_cma_helper.h>
-#include <drm/drm_fb_cma_helper.h>
-
-#include "imx-drm.h"
-
-static struct drm_mode_config_funcs imx_drm_mode_config_funcs = {
-	.fb_create = drm_fb_cma_create,
-};
-
-void imx_drm_mode_config_init(struct drm_device *dev)
-{
-	dev->mode_config.min_width = 64;
-	dev->mode_config.min_height = 64;
-
-	/*
-	 * set max width and height as default value(4096x4096).
-	 * this value would be used to check framebuffer size limitation
-	 * at drm_mode_addfb().
-	 */
-	dev->mode_config.max_width = 4096;
-	dev->mode_config.max_height = 4096;
-
-	dev->mode_config.funcs = &imx_drm_mode_config_funcs;
-}
-- 
1.7.4.4
