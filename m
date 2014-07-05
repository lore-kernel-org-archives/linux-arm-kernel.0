From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 05 Jul 2014 11:38:17 +0100
Subject: [PATCH RFC 05/15] drm/armada: use number of CRTCs registered
In-Reply-To: <20140705103724.GN21766@n2100.arm.linux.org.uk>
References: <20140705103724.GN21766@n2100.arm.linux.org.uk>
Message-ID: <E1X3NMH-0000A0-Jd@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the number of CRTCs registered to size the vblank arrays rather than
our own count.  Number CRTCs using this as well.  This permits us to
register CRTCs as components in the near future rather than as part of a
single device.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/armada/armada_crtc.c | 6 +++---
 drivers/gpu/drm/armada/armada_crtc.h | 3 +--
 drivers/gpu/drm/armada/armada_drv.c  | 4 ++--
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
index 9341a94cc906..4336dfd3585d 100644
--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -1050,8 +1050,8 @@ static int armada_drm_crtc_create_properties(struct drm_device *dev)
 	return 0;
 }
 
-int armada_drm_crtc_create(struct drm_device *dev, unsigned num,
-	struct resource *res, int irq)
+int armada_drm_crtc_create(struct drm_device *dev, struct resource *res,
+	int irq)
 {
 	struct armada_private *priv = dev->dev_private;
 	struct armada_crtc *dcrtc;
@@ -1075,7 +1075,7 @@ int armada_drm_crtc_create(struct drm_device *dev, unsigned num,
 	}
 
 	dcrtc->base = base;
-	dcrtc->num = num;
+	dcrtc->num = dev->mode_config.num_crtc;
 	dcrtc->clk = ERR_PTR(-EINVAL);
 	dcrtc->csc_yuv_mode = CSC_AUTO;
 	dcrtc->csc_rgb_mode = CSC_AUTO;
diff --git a/drivers/gpu/drm/armada/armada_crtc.h b/drivers/gpu/drm/armada/armada_crtc.h
index 0e952b271212..531a9b0bdcfb 100644
--- a/drivers/gpu/drm/armada/armada_crtc.h
+++ b/drivers/gpu/drm/armada/armada_crtc.h
@@ -72,8 +72,7 @@ struct armada_crtc {
 };
 #define drm_to_armada_crtc(c) container_of(c, struct armada_crtc, crtc)
 
-int armada_drm_crtc_create(struct drm_device *, unsigned, struct resource *,
-	int);
+int armada_drm_crtc_create(struct drm_device *, struct resource *, int);
 void armada_drm_crtc_gamma_set(struct drm_crtc *, u16, u16, u16, int);
 void armada_drm_crtc_gamma_get(struct drm_crtc *, u16 *, u16 *, u16 *, int);
 void armada_drm_crtc_disable_irq(struct armada_crtc *, u32);
diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index 58884d807e6c..add8b101fa9e 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -164,7 +164,7 @@ static int armada_drm_load(struct drm_device *dev, unsigned long flags)
 		if (irq < 0)
 			goto err_kms;
 
-		ret = armada_drm_crtc_create(dev, n, res[n], irq);
+		ret = armada_drm_crtc_create(dev, res[n], irq);
 		if (ret)
 			goto err_kms;
 	}
@@ -175,7 +175,7 @@ static int armada_drm_load(struct drm_device *dev, unsigned long flags)
 		goto err_kms;
 #endif
 
-	ret = drm_vblank_init(dev, n);
+	ret = drm_vblank_init(dev, dev->mode_config.num_crtc);
 	if (ret)
 		goto err_kms;
 
-- 
1.8.3.1
